Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD9779525
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjHKQv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHKQv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 12:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427D2D78;
        Fri, 11 Aug 2023 09:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E5A66D06;
        Fri, 11 Aug 2023 16:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C6BC433C8;
        Fri, 11 Aug 2023 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772686;
        bh=YSX5UobIdU8VrcDfUp1Fm8UQla0lNaAdeT7xjx65AcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hL4zqPol8Fqt4WWp08foT18yup+VTVYBBmviYvTxvkwrH6xbLzjdAOuyScf9cath8
         +HKXyLKcWbKk5CFF77kD2yUQCAezllrfsxLnaL/OXuZNXZv/0sRB3i2o8zs4emaERi
         3ML/PX0+k7A2KM79lJXxWS1xG+y++bNeUWCwNZ/ANd2hQS78x2f0Z5UKSXyRYfxwc8
         CORmrGc1OnesvNlAg+1SUtc+uDZF9jRC5bXsTych2uXF3ZITDOH/c2AdtNEwP3gs6U
         smr3E+ppKgggnPIyhktTKVYm/PjcRSdoF+E1Jza2izpCGlW0i/6y06EWUtFiVROjt8
         gobNWw3X/6Lig==
Date:   Fri, 11 Aug 2023 11:51:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to
 accommodate 256 buses
Message-ID: <20230811165124.GA76405@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201F56A30348C2E861C72D58B10A@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 05:07:09AM +0000, Havalige, Thippeswamy wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > On Thu, Aug 10, 2023 at 05:50:02PM +0530, Thippeswamy Havalige wrote:
> > > Our controller is expecting ECAM size to be programmed by software. By
> > > programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to
> > > 16MB ECAM region which is used to detect 16 buses, so by updating
> > > "NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to
> > > 256MB ECAM region to detect 256 buses.
> > 
> > What happens when your DT has the smaller size and the kernel configures
> > the larger size? Seems like you could have an ABI issue.
>
> - Here we are enabling hardware to support maximum buses. In this
> case kernel can enumerate up to device tree exposed ECAM size.  We
> will not face any issue.

So IIUC, if you have a DT with the smaller size and you boot a kernel
that includes this change, nothing will break, but the kernel will
only be able to use 16 buses.

Conversely, if you have a DT with the larger size and boot a kernel
that does not include change, nothing will break, but the kernel will
still only be able to use 16 buses.

Probably worth capturing this in the commit log somehow, especially
the first case.

> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > > ---
> > > changes in v3:
> > > - Remove unnecessary period at end of subject line.
> > > changes in v2:
> > > - Update this changes in a seperate patch.
> > > ---
> > >  drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > index d8a3a08be1d5..b51501921d3b 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > @@ -126,7 +126,7 @@
> > >  #define E_ECAM_CR_ENABLE		BIT(0)
> > >  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
> > >  #define E_ECAM_SIZE_SHIFT		16
> > > -#define NWL_ECAM_VALUE_DEFAULT		12
> > > +#define NWL_ECAM_VALUE_DEFAULT		16
>  - Agreed, ll fix it in next patch.
> > Not really a meaningful name. It doesn't explain what '16' means.
> > 
> > >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> > >  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> > > @@ -165,7 +165,6 @@ struct nwl_pcie {
> > >  	u32 ecam_size;
> > >  	int irq_intx;
> > >  	int irq_misc;
> > > -	u32 ecam_value;
> > >  	struct nwl_msi msi;
> > >  	struct irq_domain *legacy_irq_domain;
> > >  	struct clk *clk;
> > > @@ -674,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> > >  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
> > >
> > >  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> > > -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> > > +			  (NWL_ECAM_VALUE_DEFAULT <<
> > E_ECAM_SIZE_SHIFT),
> > >  			  E_ECAM_CONTROL);
> > >
> > >  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> > > @@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device
> > *pdev)
> > >  	pcie = pci_host_bridge_priv(bridge);
> > >
> > >  	pcie->dev = dev;
> > > -	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
> > >
> > >  	err = nwl_pcie_parse_dt(pcie, pdev);
> > >  	if (err) {
> > > --
> > > 2.17.1
> > >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
