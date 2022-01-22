Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908D3496873
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 01:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiAVADm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 19:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbiAVADm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 19:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642809821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aefEVD0oDbi9BCum4auipnvA1/diJJHHIkQYBzVBBZI=;
        b=Ae35ABS7DZGBVeXvyrp4U36I8vKZrY5zJW9QK1Nnuj3Adp2KZs8t5PniLi3UwzhRoLMdyJ
        cci7O4Ri0y8ZagvGvH4gVOxZ4jjYRrQtT7JO3+sK3t74+ojUP/pNrGQ1nVHwVkXWO0stZQ
        pEh+hZLP8Ynq8pJ9bXc4h8k28kEr6ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-wTW0E5UYMHCNk_ko9vRzKA-1; Fri, 21 Jan 2022 19:03:38 -0500
X-MC-Unique: wTW0E5UYMHCNk_ko9vRzKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A487C83DD21;
        Sat, 22 Jan 2022 00:03:36 +0000 (UTC)
Received: from p1g2 (unknown [10.2.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D7F55F51;
        Sat, 22 Jan 2022 00:03:35 +0000 (UTC)
Date:   Fri, 21 Jan 2022 18:03:33 -0600
From:   Scott Wood <swood@redhat.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Paul McKenney <paulmck@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: vmd: Add indirection layer to vmd irq lists
Message-ID: <YetJ1ZYMVOEkblAM@p1g2>
References: <1572527333-6212-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572527333-6212-1-git-send-email-jonathan.derrick@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 31, 2019 at 07:08:53AM -0600, Jon Derrick wrote:
> With CONFIG_MAXSMP and CONFIG_PROVE_LOCKING, the size of an srcu_struct can
> grow quite large. In one compilation instance it produced a 74KiB data
> structure. These are embedded in the vmd_irq_list struct, and a N=64 allocation
> can exceed MAX_ORDER, violating reclaim rules.
[snip]
> ---
> Added Paul to make him aware of srcu_struct size with these options
> 
> v1->v2:
> Squashed the revert into this commit
> changed n=1 kcalloc to kzalloc
> 
>  drivers/pci/controller/vmd.c | 47 ++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)

Has there been any progress on this?  We're seeing a similar problem
in a PREEMPT_RT kernel with MAXSMP.

-Scott

