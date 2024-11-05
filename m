Return-Path: <linux-pci+bounces-16083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8C9BD7B3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 22:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727F2283F58
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D921217A;
	Tue,  5 Nov 2024 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpTsH1qX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A91383;
	Tue,  5 Nov 2024 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842422; cv=none; b=QAgj92uhsWihc/rvmnhyjm5rOBNgb1h5wxo4F9gGfnaq5Rz9o9SBzQOGrS47KeGCmNxCswQY9DdCJOMJJ/dZLJPJLaPgCEZw+8zD96wBP7/TENE/mSwbPKezb72nREtq0YH0bG1KNNsXEa0BVByKnwn7+6hquGGr5FfDw8Kyj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842422; c=relaxed/simple;
	bh=gmEfvmYRrOEhveo9TzLIdRgKJt2TtDdbk0WfhRNwuI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TNWAnCVMlZYJAXCKi0KHGZQHSUCFz7SlEYdr7eLI4J+AlHEmjCY68Tu729cm4OtGrzNJonzY91aitm4k+NOMSDa/ug9YTUR0oqdB4jH9OYjKdH4bjZ4VAWAO8TMa0UBRYZTJbAyAXH9Et9+wAZFYWvQYY/zA9moY97vRCiduRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpTsH1qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE83C4CECF;
	Tue,  5 Nov 2024 21:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730842421;
	bh=gmEfvmYRrOEhveo9TzLIdRgKJt2TtDdbk0WfhRNwuI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LpTsH1qXgUEO/6AX3Gjk6Gez6UQYdz2/PVOr2RWndY80oROZTmtVVLyukEQQ77FkS
	 KZdPmSwEsWysVQqbIbK3pfo3x3WeJztIjavT9TKoFMAxuSnYN1vLhLfunkCgNhOGFs
	 8rHH+ay6kDRpx4WPWuexRXrXypaAWMx7HQO+GZ9Lry6Oovht9hYbKFeeJWBtRl7WE4
	 qfsTLJIVzIX3mMhTk1J2Vq5a6MPp3oEdBsGgyJ6mDjuE7PGEFxDdjQ7AIFxjAj1Syp
	 G3cBczYSaetEPKeLpDib+9v1H0fpvLSLhg/Snmui41Dqpk+Vmr0oE6oWM5f5q9W1xM
	 wbdONkM9kF1Tw==
Date: Tue, 5 Nov 2024 15:33:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20241105213339.GA1487624@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>

[+cc Jim, Krishna, Vidya, Shashank]

On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> PCIe controller driver.

> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c

> +#define PCIE_EQ_PRESET_01_REG		0x100
> +#define PCIE_VAL_LN0_DOWNSTREAM		GENMASK(6, 0)
> +#define PCIE_VAL_LN0_UPSTREAM		GENMASK(14, 8)
> +#define PCIE_VAL_LN1_DOWNSTREAM		GENMASK(22, 16)
> +#define PCIE_VAL_LN1_UPSTREAM		GENMASK(30, 24)
> ...

> +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> +{
> ...

> +	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> +	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> +	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> +	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> +	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);

This looks like it might be for the Lane Equalization Control
registers (PCIe r6.0, sec 7.7.3.4)?

I would expect those values (0x47, 0x41) to be related to the platform
design, so maybe not completely determined by the SoC itself?  Jim and
Krishna have been working on DT schema for the equalization values,
which seems like the right place for them:

https://lore.kernel.org/linux-pci/20241018182247.41130-2-james.quinlan@broadcom.com/
https://lore.kernel.org/r/77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.com

Maybe that would be applicable here as well?  It would at least be
nice to use a common #define for the Lane Equalization Control
register offset from the capability base.

Although I see that no such #define exists in pci_regs.h, so I guess
there's nothing to do here yet.

The only users of equalization settings I could find so far are:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-tegra194.c?id=v6.11#n832
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom-common.c?id=v6.12-rc1#n11
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-mediatek-gen3.c?id=v6.12-rc1#n909

Bjorn

