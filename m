Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D636288F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhDPTYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235362AbhDPTYf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 15:24:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B84B6137D;
        Fri, 16 Apr 2021 19:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618601050;
        bh=qHawK0oSTOLvJhEkLLbelkvEtYDRemD5y/71PvXJsow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i+nsE09tHA0GPcdM2/MeTaNM0szdQ0WdGtOryocd2mlqAtBAPS//L0i0bzZXsO8/u
         fkLV7Gvab0QGNzDId6j792QJPu/gog3Dicsi9l6jZFfqUa3Plj723IeLds1pJpEKyr
         6OgPJZied02D4CRJM27ck/2DbUH0P6noqZEX7ncjo7RzthjBNAzaObjGEgxy17r7VL
         +SzfZO2eKYv3O9Q0TMm2hz5GTNKJ/yfV2ONFoik610B/49nvK59V7cy8m7CfnUYsqV
         5lioX2gDeS8C6LthsG8R30YIzz9snIrCPJCSf5aLBXNxUvo3ks8yjt+OS6lELHHJwv
         0hfkytCmujThA==
Date:   Fri, 16 Apr 2021 14:24:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>
Subject: Re: [v9,2/7] PCI: Export pci_pio_to_address() for module use
Message-ID: <20210416192409.GA2744791@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413095257.GA21802@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 10:53:05AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Mar 24, 2021 at 10:09:42AM +0100, Pali Rohár wrote:
> > On Wednesday 24 March 2021 11:05:05 Jianjun Wang wrote:
> > > This interface will be used by PCI host drivers for PIO translation,
> > > export it to support compiling those drivers as kernel modules.
> > > 
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  drivers/pci/pci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 16a17215f633..12bba221c9f2 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4052,6 +4052,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
> > >  
> > >  	return address;
> > >  }
> > > +EXPORT_SYMBOL(pci_pio_to_address);
> > 
> > Hello! I'm not sure if EXPORT_SYMBOL is correct because file has GPL-2.0
> > header. Should not be in this case used only EXPORT_SYMBOL_GPL? Maybe
> > other people would know what is correct?
> 
> I think this should be EXPORT_SYMBOL_GPL(), I can make this change
> but this requires Bjorn's ACK to go upstream (Bjorn, it is my fault,
> it was assigned to me on patchwork, now updated, please have a look).

Yep, looks good to me, and I agree it should be EXPORT_SYMBOL_GPL().

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > >  
> > >  unsigned long __weak pci_address_to_pio(phys_addr_t address)
> > >  {
> > > -- 
> > > 2.25.1
> > > 
