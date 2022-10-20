Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9F60623F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJTNxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTNxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 09:53:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B51863FB;
        Thu, 20 Oct 2022 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666273995; x=1697809995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CezaQ6FZiRtuuhnBRuO3KdKRT5p4X9KJSGf6RIFTEQg=;
  b=vfFvKcEiJYym5gPmcMm+09rFNr2S032hz49W6DOBrMFVjvWmCAqmeWth
   ZQaITGLmOA96uRw64Bz8TUpSLkNpTk0bKxJztlpcXcYh3uN9ufK1PLM0q
   4OG+8pknKJN5j5LcoSCbRAKxn+kZzbwhPrE0257La0DCIaXDN+CG7D8p7
   haWey7bB/t0ltBM0pfBoQOPLvmvkPZZEksQf6IEWiUFMD85x0wffvyWdp
   96U9/FcEVRvj6cXbnSgHDqx52JMDyxbyN7StNHUT/EKWz2MrWQi0Ac0Ke
   yrudQbXIKMireez0RsHZWd8+KAUKYELv8+3fU1Nr+iMY3MFX8d5GxlypK
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="183149311"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2022 06:53:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 20 Oct 2022 06:53:09 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 20 Oct 2022 06:53:04 -0700
Date:   Thu, 20 Oct 2022 14:52:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <llvm@lists.linux.dev>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Toan Le <toan@os.amperecomputing.com>,
        <linux-riscv@lists.infradead.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ray Jui <rjui@broadcom.com>, <linux-tegra@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Michal Simek <monstr@monstr.eu>,
        <kbuild-all@lists.01.org>, Scott Branden <sbranden@broadcom.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <Y1FSsFKKJDzzrf8C@wendy>
References: <Y1D2ubkwXqwx9LWD@wendy>
 <20221020134547.GA94120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221020134547.GA94120@bhelgaas>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 08:45:47AM -0500, Bjorn Helgaas wrote:
> [+cc Pali, heads-up for trivial addition of <linux/irqdomain.h> to
> pci-mvebu.c]
> 
> On Thu, Oct 20, 2022 at 08:20:25AM +0100, Conor Dooley wrote:
> > On Thu, Oct 20, 2022 at 03:08:50PM +0800, kernel test robot wrote:
> > > Hi Bjorn,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > >> drivers/pci/controller/pcie-microchip-host.c:473:31: error: incomplete definition of type 'struct irq_domain'
> > >            struct mc_pcie *port = domain->host_data;
> > 
> > That's what I get for only visually inspecting the patch before Acking
> > it.. Un-ack I suppose.
> 
> No problem!
> 
> I think what happened is the pcie-microchip-host.c uses
> irq_domain_add_linear() so it needs <linux/irqdomain.h>, but it
> currently gets it via <linux/of_irq.h>, which it doesn't otherwise
> need.
> 
> I added a preparatory patch to include <linux/irqdomain.h> explicitly,
> but I haven't been able to cross-build either riscv or ia64 to verify
> this fix.  I'll wait a few days and post an updated series for the
> 0-day bot to test.

I saw you saying you couldn't find the config from LKP, FWIW a build
using riscv defconfig w/ CONFIG_PCIE_MICROCHIP_HOST=y fails for me
in the same way as lkp reports.
Otherwise, dump the patch in response to this and I'll give it a shot
later if you like?

HTH,
Conor.

> 
> Same situation for pcie-altera-msi.c.
> 
> pci-mvebu.c also relies on getting <linux/irqdomain.h> via
> <linux/of_irq.h>, but it actually depends on of_irq.h, so I'll just
> add an irqdomain.h include there.
> 
> Bjorn
> 
