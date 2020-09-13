Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0ED267FF9
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMPmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 11:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgIMPmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 11:42:37 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79406207EA;
        Sun, 13 Sep 2020 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600011756;
        bh=+AQnrNs+bt6OPMxQAaU/ThdQdxOKXIJTdjIHm/+NAfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=toHeMFzusWpQRAn+8trRtp1M4QjKvlQSzNEtRsuZqiVPl2IvKqXAIo2JAC+m9F6Tp
         JEEevJkR9/YC54e2rsUt0q0le3TaBHAqcgbozgl+KaGr6GW0YdAQ1Co68p20WGIT7U
         oeaM2OQ9Y5FGLVBmHhc65vAczOU6z2a5o/UVOicQ=
Date:   Sun, 13 Sep 2020 10:42:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Message-ID: <20200913154235.GA1188391@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913050129.GA10736@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 13, 2020 at 07:01:29AM +0200, Lukas Wunner wrote:
> On Fri, Sep 11, 2020 at 06:09:36PM +0800, Huacai Chen wrote:
> > As Bjorn Helgaas said, portdrv can only be built statically (not as a
> > module), so the .remove() method in pcie_portdriver is useless. So just
> > remove it.
> 
> No, PCIe switches (containing upstream and downstream PCIe ports)
> can be hot-plugged and hot-removed at runtime.  Every Thunderbolt
> device contains a PCIe switch and is hot-pluggable.  We do want to
> clean up a hot-removed PCIe port properly.

Right, sorry, I was thinking only of driver unbinding, not of device
removal.  Sorry to have wasted your time.

> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -134,7 +134,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >  	return 0;
> >  }
> >  
> > -static void pcie_portdrv_remove(struct pci_dev *dev)
> > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> >  {
> >  	if (pci_bridge_d3_possible(dev)) {
> >  		pm_runtime_forbid(&dev->dev);
> > @@ -210,8 +210,7 @@ static struct pci_driver pcie_portdriver = {
> >  	.id_table	= &port_pci_ids[0],
> >  
> >  	.probe		= pcie_portdrv_probe,
> > -	.remove		= pcie_portdrv_remove,
> > -	.shutdown	= pcie_portdrv_remove,
> > +	.shutdown	= pcie_portdrv_shutdown,
> >  
> >  	.err_handler	= &pcie_portdrv_err_handler,
