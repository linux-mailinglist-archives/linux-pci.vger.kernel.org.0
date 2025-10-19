Return-Path: <linux-pci+bounces-38662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522BFBEDF8E
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB118955DD
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587DF21B9F1;
	Sun, 19 Oct 2025 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXbvxIEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533333EC;
	Sun, 19 Oct 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760858057; cv=none; b=TDRDWSzq4SushEuQa/1/U1TdWIHaKSHt7eW+u25Z+vbvUmBRIOuxQvEalGgBzStz6y0aCWsbY1n2SjSVtdur0AoOWlQp3DNnYHJHBMwd6S5G8j4bXXBDhzfaLaEOrGgr9iUhvv8IPxQCw46UkiQOnc6oMNhiBDoeccvffGnfuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760858057; c=relaxed/simple;
	bh=2nGgPtY4Ugv6e9sF68izBoIQBy4az/v5XFZMXzm2HB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZWAIvJqfvuFSxA9bvxLPLEthVD/KFj5OmYRijrGrwafmEy+7D/VWDVxxyAHHW0R3AeZyC0G6pYOVE6dMYODvVtZvTY2I1onBsFKyolbFFBKjHP47dGB8vtZ2e56jinobtyXkiPR++lIBwgvZQtVsCjFb3byemCQ6NUTr6FR01aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXbvxIEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2ACC4CEF1;
	Sun, 19 Oct 2025 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760858056;
	bh=2nGgPtY4Ugv6e9sF68izBoIQBy4az/v5XFZMXzm2HB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SXbvxIEXPKRI613TniiG2RcR+Fh76LrNUArBK/vENB2XXSPc7B97Omhkx4+ynMvTR
	 Y7divWxy5GLASYtT13CduBFYovVVGw4SsJuK7lADx7Hcc1O9y/SBj16NIoHvU6rzmy
	 Pe9K7EqAwgsjkh3+O3Q7iNu3rotNcNckDL3xH9W4ZiPZhdtAEM0OWz2vFQQh8ReTZP
	 r/DvY8iWSDGDPWMhCGeb5pqpYc8Mka8tPzmYls61wpim7VaYX+ekiceW8Sk+GswMRi
	 dstjSCDu6Zjc41WkjpxWEePuYix0KDdyjlKWUZaUDZHQRNjCRfOIyjEWNzVcg4K9am
	 TZQVQLRJDLYLQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/6] Add PCIe support for Kaanapali
Message-Id: <176085804731.13415.14186283722551024103.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 12:44:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 15 Oct 2025 03:27:30 -0700, Qiang Yu wrote:
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
> [...]

Applied, thanks!

[1/6] dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible
      commit: bc427cd81b2a42be41be87c976cdc847f44353bf

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


