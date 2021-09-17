Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4440FDDF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhIQQaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 12:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhIQQaI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 12:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D155160555;
        Fri, 17 Sep 2021 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896126;
        bh=RRE6NMda31/dIqqeP4g2Zg1MqUaKnLsM3Ro/I9LVt3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IBbNMhquNK9liwy6lIWmdPIXzOZVsmIh3XmUdeu0OCTs9jMQRFZj4wNKUIerdiVKo
         mBMDO993ITGHINd9RLo1DY66iD3VOGkNh0ua2l7uUucIPa9VgX2bJ3+P0Wr0K7/+HG
         og0S6Mz5MOJn7XReD5EeUMdc7TA2gihk25XztwGh86GImWJqlCB0TDSX67KV04NaMv
         p0osTnLc/lTsOfpedLQ+EjMmJ/gAqIX/e1CLxFaP52jp3kxgAwF0cddgUxqB22Gld3
         JCAGcSeUs7Bd1NpgzoHU2PijOf49moRGDvKEylzevEZ2zsFtcDoaQ8cwiS5GKTUyN4
         Jjblai00CbORg==
Date:   Fri, 17 Sep 2021 11:28:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "hch@lst.de" <hch@lst.de>, Konrad Wilk <konrad.wilk@oracle.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: only build xen-pcifront in PV-enabled
 environments
Message-ID: <20210917162844.GA1722208@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7f6c9b-215d-b593-8056-b5fe605dafd7@suse.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/only/Only/ in subject

On Fri, Sep 17, 2021 at 12:48:03PM +0200, Jan Beulich wrote:
> The driver's module init function, pcifront_init(), invokes
> xen_pv_domain() first thing. That construct produces constant "false"
> when !CONFIG_XEN_PV. Hence there's no point building the driver in
> non-PV configurations.

Thanks for these bread crumbs.  xen_domain_type is set to
XEN_PV_DOMAIN only by xen_start_kernel() in enlighten_pv.c, which is
only built when CONFIG_XEN_PV=y, so even I can verify this :)

> Drop the (now implicit and generally wrong) X86 dependency: At present,
> XEN_PV con only be set when X86 is also enabled. In general an
> architecture supporting Xen PV (and PCI) would want to have this driver
> built.

s/con only/can only/

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v2: Title and description redone.
> 
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -110,7 +110,7 @@ config PCI_PF_STUB
>  
>  config XEN_PCIDEV_FRONTEND
>  	tristate "Xen PCI Frontend"
> -	depends on X86 && XEN
> +	depends on XEN_PV
>  	select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>  	default y
> 
