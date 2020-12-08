Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784E22D334C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgLHUQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 15:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbgLHUO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 15:14:26 -0500
Date:   Tue, 8 Dec 2020 12:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607453189;
        bh=q3WtZ7+3GFEm/pY2DmpaI8vQo/9kMR9V+MJjmPUSEh4=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=pMqfE1Zc2R5gtsRAAP1jz4Tx6de89EleUcU7lt+vC6fm+X+kgkFN30MxyYbwt1kl1
         ElEdxdjuBipAscfIB/Z3Bp6oGsL4YP07RoTF/hXcYKGTD0dXuEDgJWqr01/ai8u4dr
         YjcYHlL1TmnRuHEe+gd40p9mDN68BLG+P6c6FolAVQ/pjeoXfZ6k+FWAoIl8IwZQZp
         StGxvu0suBv2iMHsOh+nsW9JpGz9Z6+VxGUjyzHsAMqMb1fWVzt+io2/0hw63UymJ8
         EMclLan5jSwXHfcL06P7GUa+QsbW/XBtA6rGy/IAw++kyPGS+0D+TDyM7GkUicbNgC
         qhGoLb+ZFaHTA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201208184627.GA2393103@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 07:05:09PM +0100, Marek Vasut wrote:
> On 12/8/20 5:40 PM, Bjorn Helgaas wrote:

> > > +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> > > +	{ .compatible = "renesas,pcie-r8a7779" },
> > > +	{ .compatible = "renesas,pcie-r8a7790" },
> > > +	{ .compatible = "renesas,pcie-r8a7791" },
> > > +	{ .compatible = "renesas,pcie-rcar-gen2" },
> > > +	{},
> > > +};
> > 
> > Why do we need another copy of these, as opposed to doing something
> > with of_device_get_match_data(), e.g., like brcm_pcie_probe() does?
> 
> This is not a copy, but as subset of SoCs which are affected by this
> problem.

I know it's not a complete copy.  Many systems include flags like
"broken_l1" in their match_data.  Something like this:

  struct rcar_pcie_drvdata {
    int            (*phy_init_fn)(struct rcar_pcie_host *host);
    unsigned int   broken_l1:1;
  };

  static const struct rcar_pcie_drvdata rcar_init_h1_drvdata = {
    .phy_init_fn = rcar_pcie_phy_init_h1,
    .broken_l1 = 1,
  };

  static const struct rcar_pcie_drvdata rcar_init_gen2_drvdata = {
    .phy_init_fn = rcar_pcie_phy_init_gen2,
    .broken_l1 = 1,
  };

  static const struct rcar_pcie_drvdata rcar_init_gen3_drvdata = {
    .phy_init_fn = rcar_pcie_phy_init_gen3,
  };

  static const struct of_device_id rcar_pcie_of_match[] = {
    { .compatible = "renesas,pcie-r8a7779", .data = rcar_init_h1_drvdata },
    { .compatible = "renesas,pcie-r8a7790", .data = rcar_init_gen2_drvdata },
    { .compatible = "renesas,pcie-r8a7791", .data = rcar_init_gen2_drvdata },
    ...

> > > +static int __init rcar_pcie_init(void)
> > > +{
> > > +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > > +#ifdef CONFIG_ARM_LPAE
> > > +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > +				"asynchronous external abort");
> > > +#else
> > > +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > > +				"imprecise external abort");
> > > +#endif
> > > +	}
> > > +
> > > +	return platform_driver_register(&rcar_pcie_driver);
> > > +}
> > > +device_initcall(rcar_pcie_init);
> > > +#else
> > >   builtin_platform_driver(rcar_pcie_driver);
> > > +#endif
> > 
> > Is the device_initcall() vs builtin_platform_driver() something
> > related to the hook_fault_code()?  What would break if this were
> > always builtin_platform_driver()?
> 
> rcar_pcie_init() would not be called before probe.

Sorry to be slow, but why does it need to be called before probe?
Obviously software isn't putting the controller in D3 or enabling ASPM
before probe.

Bjorn
