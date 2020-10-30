Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318B72A1070
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgJ3Vmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 17:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgJ3Vmg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 17:42:36 -0400
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B6720727;
        Fri, 30 Oct 2020 21:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604094156;
        bh=FLGiYQjqtVH2aslBOY7nSYcK0cB9crbhPXRL8Q0cq1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1wv2wLGN+g0K7oGs95DHFNZO5FFDG0V5jGwQCi5kB85WSeYFlOuC25m8IjUyhrMPD
         cjpNzF7+OJkAn7+aYtt3w2cFW8dNh0+RJddFBjGQO2e70Z/6wDSQEt4aGPRm+W54z4
         6r99VwLV+8eqPpftL5BIU1tBKMaLdhWL4VXhCEq4=
Date:   Fri, 30 Oct 2020 16:42:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     linux-pci@vger.kernel.org, "Boris V." <borisvk@bstnet.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajatxjain@gmail.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Always call pci_enable_acs() regardless of
 pdev->acs_cap
Message-ID: <20201030214234.GA606155@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028231545.4116866-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Wed, Oct 28, 2020 at 04:15:45PM -0700, Rajat Jain wrote:
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

Applied to for-linus for v5.10, thanks!

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
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
