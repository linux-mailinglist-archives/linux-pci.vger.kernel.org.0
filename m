Return-Path: <linux-pci+bounces-17708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807219E4809
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56470164CA6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47F19258E;
	Wed,  4 Dec 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te+miCR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0428684;
	Wed,  4 Dec 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352051; cv=none; b=XOjVZO3z/TPBLEqZHk/j4OGysRmj06E9AnqsoNl8GlJsQwArddF+XkAhBeN5oBu9j2ammWiQ8cDxh5fBTCFhRBKQZBMdFoX6K/sPYpKdBTtSEw/+8C3YC9mL2Y1gDKuykhcq/amkVMhwBlY5q4fUg044N5MCbC9sz2ntUTWDY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352051; c=relaxed/simple;
	bh=kjAckCbGRrl/rR6qqxmUx2ZugzdCLr4ZSVVL2cNMTWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TDq8X8IlmGOeWs6AFSSRATruZrhYUMX2tP/6Cnt75pWEGQs/Kh/CF49Zy2g1oOWvEf14F47dEcTFC0a/U45utoiuIsALs+1d7YNV70EYcz1TJ09xjt5yYFzo9Dn2soOXMRAkofDQmidSdiSQoMA0zm+f66OY8ltDz1RJ4qtaxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te+miCR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9782C4CECD;
	Wed,  4 Dec 2024 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733352051;
	bh=kjAckCbGRrl/rR6qqxmUx2ZugzdCLr4ZSVVL2cNMTWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Te+miCR2lBQ/WLVJDPmeTr741caSHbS7xhWrsQ5AlAweLPV5zCIw4M3gBlDCe57GK
	 1XpuPpqZ8tYQw+Vvy/mxoVWBdUKBD5Xv4Hik9Q9TOjersdssjraeb8y1YfJRQ1mC3g
	 1bB+YMJCnKURISynEyKf6Eg8SiVaSdcM3ULWaZMJpShl0h++J5M024fGNSuPdyzstH
	 1gcMT/Iigw2hcuKtd+mvL56IpBLHf0BpLG/gELJQ31aYOraZ/1/rC7ATPM2HAm9K37
	 O5XV8coG1H9TEVB4CQ3OBh8GzFaa/yCDIhr+5x5HfxfzrD2R2ZVxgg5EIG+YSjcw8f
	 8iaNgd9AngDGQ==
Date: Wed, 4 Dec 2024 16:40:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
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
Message-ID: <20241204224049.GA3023706@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb0d96d-0d11-99c2-a569-7c928e0ae4fe@quicinc.com>

On Wed, Dec 04, 2024 at 07:56:54AM +0530, Krishna Chaitanya Chundru wrote:
> On 12/4/2024 12:29 AM, Bjorn Helgaas wrote:
> > On Sun, Nov 17, 2024 at 03:30:20AM +0530, Krishna chaitanya chundru wrote:
> > > Enable the ECAM feature if the config space size is equal to size required
> > > to represent number of buses in the bus range property.
> > > 
> > > The ELBI registers falls after the DBI space, so use the cfg win returned
> > > from the ecam init to map these regions instead of doing the ioremap again.
> > > ELBI starts at offset 0xf20 from dbi.
> > > 
> > > On bus 0, we have only the root complex. Any access other than that should
> > > not go out of the link and should return all F's. Since the IATU is
> > > configured for bus 1 onwards, block the transactions for bus 0:0:1 to
> > > 0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
> > > link through ecam blocker through parf registers.

> > > +static bool qcom_pcie_check_ecam_support(struct device *dev)
> > > +{
> > > +	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct resource bus_range, *config_res;
> > > +	u64 bus_config_space_count;
> > > +	int ret;
> > > +
> > > +	/* If bus range is not present, keep the bus range as maximum value */
> > > +	ret = of_pci_parse_bus_range(dev->of_node, &bus_range);
> > > +	if (ret) {
> > > +		bus_range.start = 0x0;
> > > +		bus_range.end = 0xff;
> > > +	}
> > 
> > I would have thought the generic OF parsing would already default to
> > [bus 00-ff]?
> > 
> if there is no bus-range of_pci_parse_bus_range is not updating it[1],
> the bus ranges is being updated to default value in
> devm_of_pci_get_host_bridge_resources()[2]

Understood.  But qcom uses dw_pcie_host_init(), which calls
devm_pci_alloc_host_bridge(), which ultimately calls
of_pci_parse_bus_range() and defaults to [bus 00-ff] if there's no
bus-range in DT:

  qcom_pcie_probe
    dw_pcie_host_init
      devm_pci_alloc_host_bridge
        devm_of_pci_bridge_init
          pci_parse_request_of_pci_ranges
            devm_of_pci_get_host_bridge_resources(0, 0xff)
              of_pci_parse_bus_range

So the question is why you need to do that again here.

I see that qcom_pcie_probe() calls qcom_pcie_check_ecam_support()
*before* it calls dw_pcie_host_init(), so I guess that's the immediate
answer.

But this is another reason why I think qcom_pcie_check_ecam_support()
is kind of a sub-optimal solution here.

I wonder if we should factor the devm_pci_alloc_host_bridge() call out
of dw_pcie_host_init() so drivers can take advantage of the DT parsing
it does.  It looks like mobiveil does it that way:

  ls_g4_pcie_probe
    devm_pci_alloc_host_bridge
    mobiveil_pcie_host_probe

  mobiveil_pcie_probe
    devm_pci_alloc_host_bridge
    mobiveil_pcie_host_probe

> [1]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L193
> [2]https://elixir.bootlin.com/linux/v6.12.1/source/drivers/pci/of.c#L347

