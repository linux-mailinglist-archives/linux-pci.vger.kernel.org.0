Return-Path: <linux-pci+bounces-39427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA7C0DFBB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3791D34D033
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3428689B;
	Mon, 27 Oct 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpUatmzA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69523D289;
	Mon, 27 Oct 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571295; cv=none; b=O6SJPTl0WeqeRAZapICk6pxcfrSFlufrJcNKorjNo4IVx+7KVMgnky1Stp9x4vs5cDdba+7N4MjXbh/3VbaKJj/oXmYrTJlq6znckKVIH7ITvyyqW0LezMFUZioNzlMUuTJD2Zsqga8buwzmdA5h5K06YLoHXeFEluG5nnj899g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571295; c=relaxed/simple;
	bh=p1dZI6DmbusIRv3j5AzlxgAKY0Lnkm8edANP/6i32cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGMeKjwyY5kEX5czyMM89Etn7EO50q8tE3m7u0e08o28kZrH9m3APB6wQYd0nsBcG+8RrTxQyC+6W/t3sdpGFxoNAfQqEK3N2+EijnOz5SaF0KVqcDk7VvpdQ+9be/yGu75DBD73vEwQodJ4eA6gfYwBRuETyyKdEGfhq1UNY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpUatmzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B761AC4CEF1;
	Mon, 27 Oct 2025 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571295;
	bh=p1dZI6DmbusIRv3j5AzlxgAKY0Lnkm8edANP/6i32cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpUatmzA5yocogYbqU4D6PC0xo9JtRT42k5wdLrQt+MuR+ut5BhKPV74ozUp5TgRN
	 iV6d7RKcCg2f7kMpg+EqnEtOaBbmtlfe+cLCJb+V6v+mg/hbS2/qhCOBoHz0ditTRB
	 GtI1X8tZrUkKwdtHs0jbfQPwqr1THdeP9dl0djSEehHkHdM8ukpspjYQGfFHoA2+Rc
	 WitEoEpEAkLg5wRpymcVK0E5+spQdOk5LsDBfmM4u1/qGGUC+v0fbLurrYi/XPbQmp
	 EkS2F50OrJaI+mUl+neksvz9Q+4/4OCKeo2AQuqB9g6UShytqSS9EQrC+1BZaB/qGM
	 Gb3J5FTyjLyFg==
Date: Mon, 27 Oct 2025 18:51:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] Add PCIe support for Kaanapali
Message-ID: <o4o6tthwz4vz5uqqjv5c4cld6qhhrfa7xzotjd3qyz7gpoab5s@ki4nwe6us4zc>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>

On Wed, Oct 15, 2025 at 03:27:30AM -0700, Qiang Yu wrote:
> Describe PCIe controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe.
> 
> Changes in v2:
> - Rewrite commit msg for PATCH[3/6]
> - Keep keep pcs-pcie reigster definitions sorted.
> - Add Reviewed-by tag.
> - Keep qmp_pcie_of_match_table sorted.
> - Link to v1: https://lore.kernel.org/all/20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com/
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
> Qiang Yu (6):
>       dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible
>       dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Kaanapali compatible
>       phy: qcom-qmp: qserdes-txrx: Add complete QMP PCIe PHY v8 register offsets
>       phy: qcom-qmp: pcs-pcie: Add v8 register offsets
>       phy: qcom-qmp: qserdes-com: Add some more v8 register offsets
>       phy: qcom: qmp-pcie: add QMP PCIe PHY tables for Kaanapali

So this platform doesn't support nocsr PHY reset?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

