Return-Path: <linux-pci+bounces-17588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3519E2CCB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E6B2B053
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C471FDE2C;
	Tue,  3 Dec 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ/rffnc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96331FDE26;
	Tue,  3 Dec 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252383; cv=none; b=PP9wciCgtJqzG2TUvt2AZTG41bSTLxADzu19jwUo0emGnTgaqZFkSgl/U6M4wGGpdW2s0H3megnGyUBPwTMQYTnIsqK30QByVz3HPKqwnddZ5quz7E/I47vdKibjCEx5cDeDICoseOkJ2it32gXx3chF5jnoQiH4r/pAhPxrVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252383; c=relaxed/simple;
	bh=zNkpo8H89tmms49Rp+rl0QDB/6wIVSL/SKuA8+xZqvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FUkkf39bHMsfwuQByrYfaEFpg3Zxjf9urxHwE5yFLfSzPU1jAJM7O0vVSsbKvu9tgWkgJp8dtqspZaiSeai1NHEEwZI7wI1c55Pde604cPh4lAQV0VGx18jpN7jkjhrs3ObaQrMrpkQN+POdrTaGG57eA3qMqgTdtDQKRyjVuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ/rffnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0101C4CECF;
	Tue,  3 Dec 2024 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252382;
	bh=zNkpo8H89tmms49Rp+rl0QDB/6wIVSL/SKuA8+xZqvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OJ/rffnc+chhzGjKiolyoS0CekuLEm/cMW1wHkJ24aQBuKF3/l8DQ2n47LAFwWHlr
	 xkAvtiNFfv+5Or16fQswtR2N3163Sh7O5yE+EaWEtQWz6UOCvY7a1JojYyifCQ4j9A
	 8XBkLaNuu1wW8O1TmbEBkPL2VmBrIveE13ewdtJ2PxsdeoRf+pZLsozwrSdqQiD7Qj
	 CfTLrxxtMaFsOsJMuEyD57AJCSsgcjzEUJCa9+yli6vVEmLaLKB5OM5kNLaLRW6f7y
	 Sq8evEJ2VglWRqjfUdHnuIR3OmnULg/400vNtjtzyD+AAq5D4tb2C/7ge/0d9BFRGL
	 kTu4wSF4Si4mQ==
Date: Tue, 3 Dec 2024 12:59:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com, mmareddy@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: qcom: Enable ECAM feature based on config size
Message-ID: <20241203185940.GA2910223@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-ecam-v1-3-6059faf38d07@quicinc.com>

On Sun, Nov 17, 2024 at 03:30:20AM +0530, Krishna chaitanya chundru wrote:
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property.
> 
> The ELBI registers falls after the DBI space, so use the cfg win returned
> from the ecam init to map these regions instead of doing the ioremap again.
> ELBI starts at offset 0xf20 from dbi.
> 
> On bus 0, we have only the root complex. Any access other than that should
> not go out of the link and should return all F's. Since the IATU is
> configured for bus 1 onwards, block the transactions for bus 0:0:1 to
> 0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
> link through ecam blocker through parf registers.

s/ecam/ECAM/
s/dbi/DBI/
s/IATU/iATU/ (Seems to be the convention?  Also below)
s/parf/PARF/ (I assume an initialism?)

Use conventional format for PCI bus addresses ... I assume "0:0:1"
means bus 0, device 0, function 1, which would normally be formatted
as "00:00.1" (also below).

> +static int qcom_pci_config_ecam_blocker(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u64 addr, addr_end;
> +	u32 val;
> +
> +	/* Set the ECAM base */
> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> +
> +	/*
> +	 * On bus 0, we have only the root complex. Any access other than that
> +	 * should not go out of the link and should return all F's. Since the
> +	 * IATU is configured for bus 1 onwards, block the transactions for
> +	 * bus 0:0:1 to 0:31:7 (i.e from dbi_base + 4kb to dbi_base + 1MB) from
> +	 * going outside the link.

s/IATU/iATU/ to match other usage.

Use conventional formatting of PCI bus/device/function addresses.

Unless the root bus number is hard-wired to be zero, maybe this should
say "root bus" instead of "bus 0"?

There is no architected presence of a PCIe Root Complex as a PCI
device.  Maybe this should say "the only device on bus 0 is the *Root
Port*"?

Or maybe there's a PCI device with some sort of device-specific
interface to Root Complex registers?  But if that were the *only*
device on bus 0, there would be no Root Port to reach other devices,
so this doesn't seem likely.

> +static bool qcom_pcie_check_ecam_support(struct device *dev)

Rename to be an assertion that can be either true or false, e.g.,
"ecam_supported".  "Check" doesn't hint about what true/false mean.

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource bus_range, *config_res;
> +	u64 bus_config_space_count;
> +	int ret;
> +
> +	/* If bus range is not present, keep the bus range as maximum value */
> +	ret = of_pci_parse_bus_range(dev->of_node, &bus_range);
> +	if (ret) {
> +		bus_range.start = 0x0;
> +		bus_range.end = 0xff;
> +	}

I would have thought the generic OF parsing would already default to
[bus 00-ff]?

> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (!config_res)
> +		return false;

Move of_pci_parse_bus_range() (if it's needed) down here so it's
together with the use of the results.  No point in calling it before
looking for "config".

> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
> +	if (resource_size(&bus_range) > bus_config_space_count)
> +		return false;
> +
> +	return true;
> +}

