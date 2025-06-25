Return-Path: <linux-pci+bounces-30626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D91AE84BA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 15:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88397AA48C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D92609FA;
	Wed, 25 Jun 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL9Xp+WK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9155260563;
	Wed, 25 Jun 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858191; cv=none; b=CYIVpCrQG3BxywTCL+cRA5dIgL3WPdCWvjsja2cwtkPtOWj0JaJn+p7X+JedF4CiUh1csWHspzv6bL+9/M8WhcfnPQ9T/Pengzh8UlkfaHTLO77dUaGCWr5V7kyBIZDRcaaXMUdZUoBdtYzDsUT90P60phVgGHAPFkOqFopxe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858191; c=relaxed/simple;
	bh=1XnOVUk2FHxr2/AMNsDMwgOAlwlX7mRmXj/UKnoVNGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fkj0sdZraLY4PdoxwzFHQ5Ecvad4nE0/Fz9EiqhDSOF2fgSxQNQE6BBgd4iwmP5zFbTOwoSF8Ul7kyXTDlU8RlKl7ugLoZTz9HmuEUg32P/pdpoW9RQexsB2L1sS9wHyexHWfp2SE+39+WlrqGO38z35Znpossaf2Mg0P2lG+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL9Xp+WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFDCC4CEEE;
	Wed, 25 Jun 2025 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750858191;
	bh=1XnOVUk2FHxr2/AMNsDMwgOAlwlX7mRmXj/UKnoVNGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WL9Xp+WKv90uVhgXxY6pmrgba9Ie/AiqM+WGlsv63ZFh9prR19mLn7slDOJu/vmbs
	 MnFavOPUHIzben83ZttjjVPbj91bIj6eF2Itwhxsi4reYmn9bb2qIEAKRjLb1uCvYN
	 j1DIToRLeHwHmG1Bqy+g+o7O0QfmsRBwTX41jAO6SVJ2XQDXxyCeO4Z5RQm8COlotj
	 K1R5Ou+0bJG8z0lgKskK0tRl/B2r2uH0lXj8IIq0zNSNVhq43dmE743lib3ppWU2vx
	 Z0wb4u3J3FM5bsl58wknhCwIxWGvR5zMThNWTlbvZQDADKnBBD2Aa/0z9WEbW+uP9L
	 AIUdieur8/RiA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Kevin Xie <kevin.xie@starfivetech.com>, Simon Xue <xxm@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>, Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Subject: Re: [PATCH v4 0/7] PCI: dwc: Do not enumerate bus before endpoint
 devices are ready
Message-Id: <175085818998.6505.2530660642460588895.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 07:29:49 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 25 Jun 2025 12:23:46 +0200, Niklas Cassel wrote:
> The DWC PCIe controller driver currently does not follow the PCIe
> specification with regards to the delays after link training, before
> sending out configuration requests. This series fixes this.
> 
> At the same time, PATCH 3/7 addresses a regression where a Plextor
> NVMe drive fails to be configured correctly. With this series, the
> Plextor NVMe drive works once again.
> 
> [...]

Applied, thanks!

[1/7] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
      commit: 817f989700fddefa56e5e443e7d138018ca6709d
[2/7] PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
      commit: bbc6a829ad3f054181d24a56944f944002e68898
[3/7] PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
      commit: c7eb9c5e1498882951b7583c56add0b77bfc162e
[4/7] PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
      commit: 15b6b243cc2b1017cf89e2477aa0b4e1a306a82a
[5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up
      commit: 80dc18a0cba8dea42614f021b20a04354b213d86
[6/7] PCI: Move link up wait time and max retries macros to pci.h
      commit: d7467bc72ce4e3f64062017d6c9ae3816e8a7b0e
[7/7] PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS
      commit: 470f10f18b482b3d46429c9e6723ff0f7854d049

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


