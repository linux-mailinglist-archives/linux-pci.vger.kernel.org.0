Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581972A0EA3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgJ3T0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbgJ3TZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 15:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604085937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5K8ioMNJi7ug8Tna6/Sd7VRFlYsPBbnw3ukoeZdkzas=;
        b=btV53mrHvetmnQw0TNEYa1JcJtAoURzouU6DBULBrp9U6AT/eX7mATeOzMwWoB4iSQjJaD
        3HRRNOr4pDdWv/OWyDgF9U97liYI7jFzYYgD2ePXwcYFdcgtSA9fTU0DJPPT/g0mNqtgKz
        wk6SqY1OT1ZVK1l+cksQeEswpEUIm5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-tESazvaGOmiGsPe2VM6yCg-1; Fri, 30 Oct 2020 15:25:33 -0400
X-MC-Unique: tESazvaGOmiGsPe2VM6yCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 616612FD06;
        Fri, 30 Oct 2020 19:25:31 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBA425DA2A;
        Fri, 30 Oct 2020 19:25:30 +0000 (UTC)
Date:   Fri, 30 Oct 2020 13:25:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     linux-pci@vger.kernel.org, "Boris V." <borisvk@bstnet.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, rajatxjain@gmail.com
Subject: Re: [PATCH] PCI: Always call pci_enable_acs() regardless of
 pdev->acs_cap
Message-ID: <20201030132530.59bd8b9a@w520.home>
In-Reply-To: <20201028231545.4116866-1-rajatja@google.com>
References: <20201028231545.4116866-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Oct 2020 16:15:45 -0700
Rajat Jain <rajatja@google.com> wrote:

> Some devices may have have anomalies with the ACS cpability structure,
> and they may be using quirks to support ACS functionality via other
> registers. For such devices, it is important we always call
> pci_enable_acs() to give the quirks a chance to enable ACS in other ways.
> 
> For Eg:
> There seems a class of Intel devices quirked with *_intel_pch_acs_*
> functions, that do not expose the standard ACS capability structure. But
> these quirks help support ACS on these devices using other registers:
> pci_quirk_enable_intel_pch_acs() -> doesn't use acs_cap to enable ACS
> 
> This has already been taken care of in the quirks, in the other direction
> i.e. when checking if the ACS is enabled or not. So no need to do
> anything there.
> 
> Reported-by: Boris V <borisvk@bstnet.org>
> Fixes: 52fbf5bdeeef ("PCI: Cache ACS capability offset in device")
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..ab398226c55e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3516,8 +3516,13 @@ void pci_acs_init(struct pci_dev *dev)
>  {
>  	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>  
> -	if (dev->acs_cap)
> -		pci_enable_acs(dev);
> +	/*
> +	 * Attempt to enable ACS regardless of capability because some rootports
> +	 * (e.g. the ones quirked with *_intel_pch_acs_*) may not expose
> +	 * standard rootport capability structure, but still may support ACS via
> +	 * those quirks.
> +	 */
> +	pci_enable_acs(dev);
>  }
>  
>  /**

Much needed regression fix for v5.9:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

