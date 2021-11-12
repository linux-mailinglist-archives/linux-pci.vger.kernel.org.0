Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12344DF35
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 01:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhKLAj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 19:39:59 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39779 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhKLAj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 19:39:59 -0500
Received: by mail-ed1-f46.google.com with SMTP id r12so30832613edt.6;
        Thu, 11 Nov 2021 16:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1tUfUsW9yxfyVmNsT2W35onz8Yo0bOTMnqcIJ1wUhc=;
        b=upgF0pyrzwrtnYQhtNoozMC5Pjm1NmKLw6E/irGmVtifAzM/vTD7I5XdS4qhMU57o3
         j+Aoeti8yydKQwbJVTkorjr4C9Omt1wFSPL9ztBrxw73YPGGEXJwBmDhkRbc//XM7Kjo
         gs/hZpHwCpQXtMEryTkzZ1QJxtF6AvM3r6ZlWX/RFyfnA5qRw3+ySr1dxm0rh5wUdh4R
         oplB7bsBX6I13f87VjT5l+Kt+QSzCzcrwx91e0rF8UrTz0s0ythOcZIkW3heFwk4yBYV
         Vok4Rmn259yh4OZeVkNdKYKUBruEUViwOSI74rG8j95zwME7f6CigVRRQ5KquipYUUi5
         xJWQ==
X-Gm-Message-State: AOAM530jXCwJwstOB/X053nzdrjznijzpF8YFnKUOKpWJ/Lm4QypdAI1
        zgScrmsIQEkXJXzwH1A1z6c=
X-Google-Smtp-Source: ABdhPJwPnxK6FC4BIfe/lkhIF828ja5edt407OTCenhE6XVpenIhvw+b0OdNEv6X6UuF4fuzGcyDiw==
X-Received: by 2002:a50:f08b:: with SMTP id v11mr15560307edl.96.1636677427655;
        Thu, 11 Nov 2021 16:37:07 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h6sm794056edz.40.2021.11.11.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:37:07 -0800 (PST)
Date:   Fri, 12 Nov 2021 01:37:05 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCHv5 6/6] PCI: layerscape: Add power management support
Message-ID: <YY23MeAa0U/r4lbO@rocinante>
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
 <20210407030948.3845-7-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407030948.3845-7-Zhiqiang.Hou@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> +/* PF Message Command Register */
> +#define LS_PCIE_PF_MCR		0x2c
> +#define PF_MCR_PTOMR		BIT(0)
> +#define PF_MCR_EXL2S		BIT(1)
> +
> +/* LS1021A PEXn PM Write Control Register */
> +#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
> +#define PMXMTTURNOFF		BIT(31)
> +#define SCFG_PEXSFTRSTCR	0x190
> +#define PEXSR(idx)		BIT(idx)
> +
> +/* LS1043A PEX PME control register */
> +#define SCFG_PEXPMECR		0x144
> +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> +
> +/* LS1043A PEX LUT debug register */
> +#define LS_PCIE_LDBG	0x7fc
> +#define LDBG_SR		BIT(30)
> +#define LDBG_WE		BIT(31)

A small nitpick: a consistent capitalisation of "control" and "debug", and
"register" in the comments above.

[...]
> +static void ls_pcie_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +{
> +	if (pcie->big_endian)
> +		return iowrite32be(val, pcie->lut_base + off);
> +
> +	return iowrite32(val, pcie->lut_base + off);
> +
> +}

Surplus newline above after the return statement.

[...]
> +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +{
> +	if (pcie->big_endian)
> +		return iowrite32be(val, pcie->pf_base + off);
> +
> +	return iowrite32(val, pcie->pf_base + off);
> +
> +}

Surplus newline above after the return statement.

[...]
> +static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val |= PF_MCR_PTOMR;
> +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +				 val, !(val & PF_MCR_PTOMR), 100, 10000);
> +	if (ret)
> +		dev_info(pcie->pci->dev, "poll turn off message timeout\n");
> +}

Would this dev_info() be more of a warning or an error?  A timeout is
potentially a problem, correct?

[...]
> +static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	if (!pcie->scfg) {
> +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> +		return;
> +	}
> +
> +	/* Send Turn_off message */
> +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> +	val |= PMXMTTURNOFF;
> +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> +
> +	mdelay(10);

We often, customary, document why a particular mdelay() is needed.  You
also did this in other part of the code, so perhaps adding a note here (and
everywhere else) would be nice for keeping the consistency.

[...]
> +static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val |= PF_MCR_EXL2S;
> +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +				 val, !(val & PF_MCR_EXL2S), 100, 10000);
> +	if (ret)
> +		dev_info(pcie->pci->dev, "poll exit L2 state timeout\n");
> +}

Similarly to the question above: is this timeout something more severe and
would warrant a warning or an error here instead?

[...]
> +static void ls1021a_pcie_exit_from_l2(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> +	val |= PEXSR(pcie->index);
> +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> +
> +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> +	val &= ~PEXSR(pcie->index);
> +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> +
> +	mdelay(1);

Aside of documenting this mdelay() here, if possible, would 1 be enough?
Everywhere else you seem to use 10 consistently.

> +
> +	ls_pcie_retrain_link(pcie);
> +}
> +static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)

Missing newline above to separate code blocks.

> +{
> +	u32 val;
> +
> +	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_WE;
> +	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_SR;
> +	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_SR;
> +	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_WE;
> +	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	mdelay(1);

See comment above.

[...]
> +static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	u32 index[2];
> +	int ret;
> +
> +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "fsl,pcie-scfg");
> +	if (IS_ERR(pcie->scfg)) {
> +		ret = PTR_ERR(pcie->scfg);
> +		dev_err(dev, "No syscfg phandle specified\n");
> +		pcie->scfg = NULL;
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
> +					 index, 2);
> +	if (ret) {
> +		pcie->scfg = NULL;
> +		return ret;
> +	}
> +
> +	pcie->index = index[1];
> +
> +	return 0;
> +}

Just an idea: what about using goto for error handling?

(...)
	if (IS_ERR(pcie->scfg)) {
		ret = PTR_ERR(pcie->scfg);
		dev_err(dev, "No syscfg phandle specified\n");
		goto error;
	}

	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
					 index, 2);
	if (ret)
		goto error;

	pcie->index = index[1];

	return 0;

error:
	pcie->scfg = NULL;
	return ret;
}

Not necessarily better or worse compared with your version, so it would be
more of a matter of personal preference here.

> +static int ls_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val;
> +	int ret;
> +
> +	if (!ls_pcie_pm_check(pcie))
> +		return 0;
> +
> +	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
> +
> +	/* 10ms timeout to check L2 ready */
> +	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
> +				 val, LS_PCIE_IS_L2(val), 100, 10000);
> +	if (ret) {
> +		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
> +		return ret;
> +	}

The error message above could be improve to be more like an error stating
that something failed and such, as currently it looks like a debug message,
unless it was intended as such.

[...]
> +static int ls_pcie_resume_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	if (!ls_pcie_pm_check(pcie))
> +		return 0;
> +
> +	ls_pcie_set_dstate(pcie, 0x0);
> +
> +	pcie->drvdata->pm_ops->exit_from_l2(pcie);
> +
> +	dw_pcie_setup_rc(&pci->pp);
> +
> +	/* delay 10 ms to access EP */
> +	mdelay(10);
> +
> +	ret = ls_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
> +		return ret;
> +	}

A small nitpick: error messages that are directed at end users should have
a little more context than just the function name.

	Krzysztof
