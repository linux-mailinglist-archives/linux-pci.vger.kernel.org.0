Return-Path: <linux-pci+bounces-39246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F20C04912
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082DF1A62A97
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C527E05F;
	Fri, 24 Oct 2025 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czpg3CWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB68279DC8
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288662; cv=none; b=pxmGxgWMQU84MpRQB+tgBMw92CEknqgtZufUy5psRVVBnSlhw+R2V8EDDQy7i71wMkp02th73XeuDmA1nOpe+2+0CIuEfdY6fL3s6r2nydgHBhdKjcgIUWuYfECTaEUrTVG/CLuiaoM2swD0QrJ2wmrmsxieLyimkV7fO8vw/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288662; c=relaxed/simple;
	bh=voQc1iIPvaxhEWT6e6mfx3O6/9fM0/h19VXuaWD8Y4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt5IFGG7pmu76+PzpF6ivP+KmeSRLeNUyBgSftrDVuToopEO837Y7A/K1UzZui8iMXFuW5Af0V6N6VLyLDMsloLJ99zmdq0SwTRyf07WC7odG0JpzLQhm3g34hNwfjXsYpVFll3/2Z15c6TyF7qX/xOdlT7vv90LlkhRcesXs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=czpg3CWK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so2569559a12.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761288658; x=1761893458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8F59In/k+8ei2zkGlaL3q/q77vUHa6w27HLET6WaYE0=;
        b=czpg3CWKVR3eICX1xFo+OFYvtfcpJ5eyn0RPVvg7OlBy0UUI0fBEhbs66SPui7lDAC
         8NtTX9yCQEBP1l/iuTrCAU2FRY0qQqgSwwE3pezY//x3VjKnLA9lfYdaqxggVg95DZeV
         EC8rhBfF9XeNZwxLoihrzIgZNug8VcL8lTP4wuQWWQB9AWKfRac1wYcDLqFU0iTMHL88
         r0dj9WaFeiZwZB/ZkKyO7H/uPBMDkLU6ZDvA6cFTzt4/4nRRmbjYzdTlT4ty9ibp82fB
         qu0E6CAszjgadyMl3ytEQSh4Bb5JJEhv11dojMXc2uXoZEIRoDjtRmr3K27g5MC5SonP
         vbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288658; x=1761893458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8F59In/k+8ei2zkGlaL3q/q77vUHa6w27HLET6WaYE0=;
        b=dnJYeDEgzaX1P6+vW829XfR9de4/XVTovpW0zOuMNR2MVcPTH9n6BDkhu3t7AEuXrE
         8lzJ+FHRMkzdaRt8BPTfFqMeFo1dKZdput9UJ6YLNvl4ahz9TBKhwI6xXhvBAseQHQ5u
         Iyl5lux+zaP0VIlyoRTndXPIj39nAUlYRXEmlsmqA1EZVWs95da88ySthThFSv5OePC7
         vBf5v/3zsvC0QE2pT74IKwZceu1sFcTlqWEmscw2FWkGSxeDWu9YfCKjI964F2fJYCLn
         FC98/cCv/YRAoIbIaglqVOuhlEJ8st8CSYCpTXyDvOCdunLPQsicqNhQzfSzeOuQYt2j
         TYZA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ub98QB8Ui2Lh1IjWWsBpg64lBEK/HGagiJ/ZNuR+8VR+peu4DeMKXWJyiDq96IRs3SeMvpxkXJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZZqryOZimOw50cBEhTcQvcziJF5T9TxD+h1InoFRIIuMl2TR
	Lp/+l6brjKCZYJujz7FVtetTp8urhd+OgqYmclilH6hTB+0QgysJ/GD3OnJwE4FkO8M19p0Bcsp
	Yw/DV1krmOIUEFtBB/2wlY30oX7KmUaCY6D1bRXrjlw==
X-Gm-Gg: ASbGncvNL6L0N6FSIs3zDoGcTGq8FO6xn4hzLOqx5CbQaB2Q0JObVyPPgj9EBPe04rd
	tL76oU2pctwWmDL82WpNF3QqWPcBpan+CqhzxwH7IrZmeGje5Qe0URN1bFx5ayH7unFezsfpoe1
	GnrCw4oe5WnIoQoXkQp9l8dN5FwrbLCxYHlsTnAwKh6aEyvPy8r/QRxaHKOSi895Q0ylwgHZIJ4
	ZC/O4VR0gTm/+6YKtTEmt9ciKbgtNOdKDBdO2B5SfmgTUh+WCJtCedhHQoPfpRPSBDkXIXknHby
	SOo2dza9u6knMEzvWfJtpcT/
X-Google-Smtp-Source: AGHT+IFrKI0fnvSTnqzVv2eOZk8CRKDkaNQMq0DdY2GKOZNOyoOZjJbKhzPd1r3nb8BGmGeYwlT0SutndW1RdmNyVBk=
X-Received: by 2002:a05:6402:2707:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-63c3c6384d1mr23734442a12.22.1761288658135; Thu, 23 Oct 2025
 23:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-4-vincent.guittot@linaro.org> <20251022190402.GA1262472@bhelgaas>
In-Reply-To: <20251022190402.GA1262472@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Oct 2025 08:50:46 +0200
X-Gm-Features: AS18NWAfJSavi43CTc998m6tiNTP5liY3Ukqcpz07ZOop2D3_BEhXOC5ja0TdFY
Message-ID: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > Add initial support of the PCIe controller for S32G Soc family. Only
> > host mode is supported.
>
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -406,6 +406,16 @@ config PCIE_UNIPHIER_EP
> >         Say Y here if you want PCIe endpoint controller support on
> >         UniPhier SoCs. This driver supports Pro5 SoC.
> >
> > +config PCIE_NXP_S32G
> > +     tristate "NXP S32G PCIe controller (host mode)"
> > +     depends on ARCH_S32 || COMPILE_TEST
> > +     select PCIE_DW_HOST
> > +     help
> > +       Enable support for the PCIe controller in NXP S32G based boards to
> > +       work in Host mode. The controller is based on DesignWare IP and
> > +       can work either as RC or EP. In order to enable host-specific
> > +       features PCIE_S32G must be selected.
>
> Reorder this so the menu item is sorted by vendor name.

Okay

>
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
>
> > +/* Link Interrupt Control And Status */
> > +#define PCIE_S32G_LINK_INT_CTRL_STS          0x40
> > +#define LINK_REQ_RST_NOT_INT_EN                      BIT(1)
> > +#define LINK_REQ_RST_NOT_CLR                 BIT(2)
>
> None of these are used; remove until you need them.

That's a mistake and should not be in there.

>
> > +/* PCIe controller 0 General Control 1 */
> > +#define PCIE_S32G_PE0_GEN_CTRL_1             0x50
> > +#define DEVICE_TYPE_MASK                     GENMASK(3, 0)
> > +#define DEVICE_TYPE(x)                               FIELD_PREP(DEVICE_TYPE_MASK, x)
>
> Not sure this adds much over just doing this:
>
>   #define DEVICE_TYPE   GENMASK(3, 0)
>
>   val |= FIELD_PREP(DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);

fair enough

>
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
>
> > +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
> > +{
> > +     u32 ddr_base_low = lower_32_bits(ddr_base_addr);
> > +     u32 ddr_base_high = upper_32_bits(ddr_base_addr);
> > +
> > +     dw_pcie_dbi_ro_wr_en(pci);
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> > +
> > +     /*
> > +      * Ncore is a cache-coherent interconnect module that enables the
> > +      * integration of heterogeneous coherent and non-coherent agents in
> > +      * the chip. Ncore Transactions to peripheral should be non-coherent
> > +      * or it might drop them.
> > +      * One example where this is needed are PCIe MSIs, which use NoSnoop=0
> > +      * and might end up routed to Ncore.
> > +      * Define the start of DDR as seen by Linux as the boundary between
> > +      * "memory" and "peripherals", with peripherals being below.
>
> Add blank lines between paragraphs.

okay

>
> > +      */
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
> > +                        (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
> > +     dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
> > +     dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +
> > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +     u32 val;
> > +
> > +     /* Set RP mode */
> > +     val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
> > +     val &= ~DEVICE_TYPE_MASK;
> > +     val |= DEVICE_TYPE(PCI_EXP_TYPE_ROOT_PORT);
> > +
> > +     /* Use default CRNS */
> > +     val &= ~SRIS_MODE;
> > +
> > +     s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
> > +
> > +     /* Disable phase 2,3 equalization */
> > +     s32g_pcie_disable_equalization(pci);
> > +
> > +     /*
> > +      * Make sure we use the coherency defaults (just in case the settings
> > +      * have been changed from their reset values)
> > +      */
> > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
>
> This seems sketchy and no other driver uses memblock_start_of_DRAM().
> Shouldn't a physical memory address like this come from devicetree
> somehow?

I was using DT but has been asked to not use it and was proposed to
use memblock_start_of_DRAM() instead

>
> > +     dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > +
> > +     /*
> > +      * Set max payload supported, 256 bytes and
> > +      * relaxed ordering.
> > +      */
> > +     val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > +     val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> > +              PCI_EXP_DEVCTL_PAYLOAD |
> > +              PCI_EXP_DEVCTL_READRQ);
> > +     val |= PCI_EXP_DEVCTL_RELAX_EN |
> > +            PCI_EXP_DEVCTL_PAYLOAD_256B |
> > +            PCI_EXP_DEVCTL_READRQ_256B;
> > +     dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>
> MPS and relaxed ordering should be configured by the PCI core.  Is
> there some s32g-specific restriction about these?

I will check with the team why they did that

>
> > +     /* Enable errors */
> > +     val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > +     val |= PCI_EXP_DEVCTL_CERE |
> > +            PCI_EXP_DEVCTL_NFERE |
> > +            PCI_EXP_DEVCTL_FERE |
> > +            PCI_EXP_DEVCTL_URRE;
> > +     dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>
> Enabling these errors doesn't really seem device-specific, and
> pci_enable_pcie_error_reporting() would enable all these.
>
> But that only happens with CONFIG_PCIEAER=y, and since this is
> DWC-based, you probably don't have standard interrupts for AER and
> CONFIG_PCIEAER isn't useful.  Someday we might have support for
> non-standard AER interrupts, but we don't have it yet.
>
> I guess you get platform-specific System Errors when any of these
> errors are detected (see PCIe r7.0, sec 6.2.6)?  What is the handler
> for these?

Same has above but I suspect we can remove it

>
> > +static int s32g_pcie_host_init(struct s32g_pcie *s32g_pp)
> > +{
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +     struct dw_pcie_rp *pp = &pci->pp;
> > +     int ret;
> > +
> > +     pp->ops = &s32g_pcie_host_ops;
> > +
> > +     ret = dw_pcie_host_init(pp);
> > +
> > +     return ret;
>
>   return dw_pcie_host_init(pp);

fair enough

>
> Not sure this is really worth a wrapper.

More feature will come but with init ops, i will put everything in probe for now

>
> > +static int s32g_pcie_get_resources(struct platform_device *pdev,
> > +                                struct s32g_pcie *s32g_pp)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +
> > +     s32g_pp->phy = devm_phy_get(dev, NULL);
> > +     if (IS_ERR(s32g_pp->phy))
> > +             return dev_err_probe(dev, PTR_ERR(s32g_pp->phy),
> > +                             "Failed to get serdes PHY\n");
>
> Add blank line here.

yes

>
> > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > +     if (IS_ERR(s32g_pp->ctrl_base))
> > +             return PTR_ERR(s32g_pp->ctrl_base);
>
> This looks like the first DWC driver that uses a "ctrl" resource.  Is
> this something unique to s32g, or do other drivers have something
> similar but use a different name?

AFAICT this seems to be s32g specific in the RM

>
> > +     pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> > +     if (IS_ERR(pci->dbi_base))
> > +             return PTR_ERR(pci->dbi_base);
>
> Isn't this already done by dw_pcie_get_resources()?

We needed dbi to be mapped before dw host init but this will not be
the case anymore with ops->init()

>
> > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +
> > +     if (!dw_pcie_link_up(pci))
> > +             return 0;
>
> Does something bad happen if you omit the link up check and the link
> is not up when we get here?  The check is racy (the link could go down
> between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> completely reliable.
>
> If you have to check, please add a comment about why this driver needs
> it when no other driver does.

dw_pcie_suspend_noirq returns an error and the suspend fails

I will add a comment
/*
 * If the link is not up, there is nothing to suspend and resume
 */

>
> > +     return dw_pcie_suspend_noirq(pci);
> > +}
> > +
> > +static int s32g_pcie_resume_noirq(struct device *dev)
> > +{
> > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > +     struct dw_pcie *pci = &s32g_pp->pci;
> > +
> > +     s32g_init_pcie_controller(s32g_pp);
>
> Odd that you need this.  Other drivers really don't do anything
> similar, probably because this could be done by the
> pci->pp.ops->init() call in dw_pcie_resume_noirq().

no reason, i misread the impact of init in dw_pcie_host_init()



>
> > +     return dw_pcie_resume_noirq(pci);
> > +}
>
> > +static const struct of_device_id s32g_pcie_of_match[] = {
> > +     { .compatible = "nxp,s32g2-pcie"},
>
> Add space before "}"
>
> > +     { /* sentinel */ },
> > +};

