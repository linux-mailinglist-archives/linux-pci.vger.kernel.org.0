Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A147E680
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbhLWQk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 11:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbhLWQk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 11:40:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BAC061401;
        Thu, 23 Dec 2021 08:40:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C60061EFC;
        Thu, 23 Dec 2021 16:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFBCC36AE5;
        Thu, 23 Dec 2021 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640277656;
        bh=wLg/tBD/PjWGqRYN8osxxTH2d+iMjRJQa7SeHtuFGxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nI4CvWsrWH2IxtN5jTnse16OV9MonHlCu1WphHc+QYffIfNMzwMY3EDJpCbNiZnM2
         af0Gkg5JwKLlIaE344ypErBsl/y5kUYTnzhvbbGXKtR//isTRD8hvTRPeHAEDAdGJx
         6vui6Zk6aMdDFo5PVDgnUik6UyCLeQ6BNN98cHRg1I1dg2wW3MKhtSZoNzBxhlhjKP
         jRxqMJnvzzIkp1GZYQ9UiYS/32ioWuJhl3d79HwN8sDv5xUUDzUkKzs7ve4DSGoGW6
         qaMuUJaL3EGHajXMRwy4jXYoR9RnqvRMm8jOAEDfx8czN5FmVwrqWTev3PGo0sPtKa
         XG5rFu2RNZlsw==
Date:   Thu, 23 Dec 2021 10:40:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 16/23] PCI: mt7621: Make pci_ops static
Message-ID: <20211223164054.GA1269587@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H-nSTLiqgw4LxEPBiTGLh7L4n1mm4FbgOCdzCGxK5e47w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 07:04:32AM +0100, Sergio Paracuellos wrote:
> Hi Bjorn,
> 
> On Thu, Dec 23, 2021 at 2:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > mt7621_pci_ops is used only in this file.  Make it static.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index b60dfb45ef7b..4138c0e83513 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -148,7 +148,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
> >         return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
> >  }
> >
> > -struct pci_ops mt7621_pci_ops = {
> > +static struct pci_ops mt7621_pci_ops = {
> >         .map_bus        = mt7621_pcie_map_bus,
> >         .read           = pci_generic_config_read,
> >         .write          = pci_generic_config_write,
> > --
> > 2.25.1
> >
> 
> This one was already sent and added to Lorenzo's tree. See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/mt7621&id=8a0c1afb8560c2f64bcbdb559931f5ca8b83de87

Thanks, I dropped this one.

Bjorn
