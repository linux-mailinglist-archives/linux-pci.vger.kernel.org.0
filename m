Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA71B7EE2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgDXTaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDXTaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:30:10 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD95A2075A;
        Fri, 24 Apr 2020 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587756610;
        bh=QaWXr2oWtPWMdw0bfTG0RG9QMElIUw6uG1iNTqEcQP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yU4T3NuXKJSzFqNnh5ZE+IVrif5gAts0WvnOYkC9fcJl9GxBxv6CYAdmwUuHO45ij
         SYBGzYRStCtxEOwmGrv5G0VGo7/JwnWbXzYz1otZjm8BMZfDl3ofkmAc6zmSf3PPWw
         QV2u6ogb0JN7wSvWvZXnlAePz7BQJEd2FUEPlOa4=
Date:   Fri, 24 Apr 2020 14:30:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robherring2@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by
 default
Message-ID: <20200424193008.GA177667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422192957.6lwr3aig4a3dcynr@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 02:29:57PM -0500, Rob Herring wrote:
> On Tue, Apr 14, 2020 at 07:12:41PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Drivers should not be selected by default because that bloats the kernel
> > for people who don't need them.
> > 
> > Remove the "default y" for CONFIG_PCI_DRA7XX_HOST.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: linux-omap@vger.kernel.org
> > ---
> >  drivers/pci/controller/dwc/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 03dcaf65d159..ea335ee7ca8e 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -26,7 +26,6 @@ config PCI_DRA7XX_HOST
> >  	depends on OF && HAS_IOMEM && TI_PIPE3
> >  	select PCIE_DW_HOST
> >  	select PCI_DRA7XX
> > -	default y
> 
> Perhaps 'default y if SOC_DRA7XX'?

Good idea, I did that.
