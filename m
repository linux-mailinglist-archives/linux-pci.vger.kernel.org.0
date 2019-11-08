Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56419F44DA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHKnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 05:43:42 -0500
Received: from foss.arm.com ([217.140.110.172]:40264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKHKnm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 05:43:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1FD431B;
        Fri,  8 Nov 2019 02:43:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378B33F719;
        Fri,  8 Nov 2019 02:43:41 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:43:39 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: Re: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
Message-ID: <20191108104338.GG43905@e119886-lin.cambridge.arm.com>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
 <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 09:03:46PM +0000, Jingoo Han wrote:
> On 11/5/19, 10:44 PM, Dilip Kota wrote:
> > 
> > Utilize DesugnWare helper functions to configure Fast Training
> 
> Nitpicking: Fix typo (DesugnWare --> DesignWare)
> 
> If possible, how about the following?
> Utilize DesignWare --> Use DesignWare
> 
> Best regards,
> Jingoo Han
> 
> > Sequence. Drop the respective code in the driver.
> >
> > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>

With the changes suggested in this thread, you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> > ---
> >  drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> > index d00252bd8fae..02d93b8c7942 100644
> > --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> > +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> > @@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
> >  #define ACK_N_FTS_MASK			GENMASK(15, 8)
> >  #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
> >  
> > -#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
> > -#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
> > -
> >  /* ARTPEC-6 specific registers */
> >  #define PCIECFG				0x18
> >  #define  PCIECFG_DBG_OEN		BIT(24)
> > @@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
> >  	 * Set the Number of Fast Training Sequences that the core
> >  	 * advertises as its N_FTS during Gen2 or Gen3 link training.
> >  	 */
> > -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > -	val &= ~FAST_TRAINING_SEQ_MASK;
> > -	val |= FAST_TRAINING_SEQ(180);
> > -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +	dw_pcie_link_set_n_fts(pci, 180);
> >  }
> >
> >  static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
> > -- 
> > 2.11.0
> 
