Return-Path: <linux-pci+bounces-35291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D83B3EEB2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C6D1A884AF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134D345733;
	Mon,  1 Sep 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5wZJk/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8F345722;
	Mon,  1 Sep 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755980; cv=none; b=GbxtzJB/GwYi1olI/orWnOZNgdGysOIF6YmYCm4EGr3RB/ydRO1wTiX+6VHNUh1ViVk5zFw+O0VsK5ouocRHgIfUgvXRVZAtF9gPjXHu58wOykF51jSnuj2azZ6cBZUstrx7wDDeENRG3OkrB5OGfBrC0uTwlhRcm4QaxD9Umss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755980; c=relaxed/simple;
	bh=NhV9B8K4cZUejZjeirB3GBztoD5Bg3AS6ut3OfnT9AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMGF3kwpqaOQaOwPCYep58E4VWEhHPQ59S49on0+vd4MOMeQ95Nj/Hax1bHK/+C8CLGSlIKbJarBknAV+im48RA5IUpuhqkEkB8pbueCuOut/Ctp3X45K/amMIJ0YpPDEbvUIbzcAo2M8KEzIeX3d08rf+eJsEOf9QEWGD1kZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5wZJk/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E3C4CEF0;
	Mon,  1 Sep 2025 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755980;
	bh=NhV9B8K4cZUejZjeirB3GBztoD5Bg3AS6ut3OfnT9AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5wZJk/wzC+HRZv29+XrUPvxvKisuswlqs+QR1ZxWu0+64+KeAC1NDg/fdKeCfUqN
	 qjOr+QIkUpNOF7aU3oCOaIHZpOtHwtd3UwWCdBDwyAICN2XZY1H38Ihqk93HLGc4Ao
	 cDq3na0OwyyQq7xQi2uLu3DoiA81jmP3x4sjGqOW+AHLPsf9QZxH2hKlgGqWhmtBDL
	 irE9U7+GbfbxX84+57i12kYQP54pKsVzCs1t9DILl/yoMSjbQRsXIGN8hbsKy4JzFH
	 0KzZ6FPAiwOIjcH6T6WStFQgwq0MvecB1nTyNyRLMTCf6QDGPTh0X5F4PCc8j9CPO8
	 aBcgV0E1cIW3Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: (subset) [PATCH v3 0/3] arm64: dts: qcom: Add PCIe Support for sm8750
Date: Mon,  1 Sep 2025 14:46:01 -0500
Message-ID: <175675595917.1796591.7933074887018259640.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Aug 2025 16:32:52 +0530, Krishna Chaitanya Chundru wrote:
> Describe PCIe controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe.
> 
> The qcom_pcie_parse_ports() function currently iterates over all available
> child nodes of the PCIe controller's device tree node. This includes
> unrelated nodes such as OPP (Operating Performance Points) nodes, which do
> not contain the expected 'reset' and 'phy' properties. As a result, parsing
> fails and the driver falls back to the legacy method of parsing the
> controller node directly. However, this fallback also fails when properties
> are shifted to the root port, leading to probe failure.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and controller node
      commit: 19f1395333f80479a3a5fce29e4c7a8255322a9c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

