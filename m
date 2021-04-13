Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10F35DBEB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhDMJxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 05:53:43 -0400
Received: from foss.arm.com ([217.140.110.172]:39512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243091AbhDMJxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 05:53:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AFE1106F;
        Tue, 13 Apr 2021 02:53:18 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB7B3F73B;
        Tue, 13 Apr 2021 02:53:15 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:53:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
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
Message-ID: <20210413095257.GA21802@lpieralisi>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
 <20210324030510.29177-3-jianjun.wang@mediatek.com>
 <20210324090942.kmhxnxzm7tz3ynuy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324090942.kmhxnxzm7tz3ynuy@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 10:09:42AM +0100, Pali Rohár wrote:
> On Wednesday 24 March 2021 11:05:05 Jianjun Wang wrote:
> > This interface will be used by PCI host drivers for PIO translation,
> > export it to support compiling those drivers as kernel modules.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >  drivers/pci/pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 16a17215f633..12bba221c9f2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4052,6 +4052,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
> >  
> >  	return address;
> >  }
> > +EXPORT_SYMBOL(pci_pio_to_address);
> 
> Hello! I'm not sure if EXPORT_SYMBOL is correct because file has GPL-2.0
> header. Should not be in this case used only EXPORT_SYMBOL_GPL? Maybe
> other people would know what is correct?

I think this should be EXPORT_SYMBOL_GPL(), I can make this change
but this requires Bjorn's ACK to go upstream (Bjorn, it is my fault,
it was assigned to me on patchwork, now updated, please have a look).

Thanks,
Lorenzo

> >  
> >  unsigned long __weak pci_address_to_pio(phys_addr_t address)
> >  {
> > -- 
> > 2.25.1
> > 
