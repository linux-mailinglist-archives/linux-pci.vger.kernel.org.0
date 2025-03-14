Return-Path: <linux-pci+bounces-23736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BEA61065
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251251880878
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD941FDE1B;
	Fri, 14 Mar 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsEjdjTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AC1FDA66;
	Fri, 14 Mar 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952924; cv=none; b=fw8PK4yoTDys1Rg+7F3FLdjVKxIK7uLFdvljLPUIBeNeK89nnFuS0HEVaacoUDyP1CMge9m9NeZkApM0VEJmYMEMk2VW1xsQEBztWht4HTUMVHXJHAN6Dl/BssE0zwq0LKeEsDFUHQpH7MLuFPeO2UHfKkjWtjYirkEqSExPvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952924; c=relaxed/simple;
	bh=tDRiCOmlmNgcaQNGx5zSIpYTAy20ivUwPHVm38I4HJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lajPRF1A/pG64yFKjuh4XsqPfvoFs6dhtUt8blZvxhiLl6DnD7ikhIzgo3co5HDBSM3B7zqke2JvZrgbX3Nlfp5Qfeh+5m3zr98LnYVb7oFDbEOaASeoUJeHPSjGbzNRK0ocEozB4vHLM7AmGLCzACFCFpFXXWuHcUji7IngI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsEjdjTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E0CC4CEE3;
	Fri, 14 Mar 2025 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952924;
	bh=tDRiCOmlmNgcaQNGx5zSIpYTAy20ivUwPHVm38I4HJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XsEjdjTp6T3jFtw9iCVpyrWfwrplgwOOgbHkxz59SBECzrRs0MG/jUk6Hqb+xXEnK
	 Qb1ze8pH2KAmI42D1f8GCytNbFYHTP7IWBeWF4f41jLtBepO81UabpqPfaE5JU0xGy
	 26H6Ry2C5x4HUn+cQJer2Pnht502N1NMSq1LdQl3gVV7tyJxLAZFGpz6VIC2E9uT8w
	 ynS9YjzOxSb8VVzRsoCMZlsyv1r/JuAKBlgqNwz6GK/cABoysHSA2UdFC9052UwxCz
	 Ia3BElGMKAMcYSu3tUCvEj20E+tjk+27D9ObYMkSTHjMI/514ALLs9DBxoaEG735fm
	 iv7E/SbZBX7rg==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20250312-en7581-pbus_csr-binding-v3-1-7bd9f00a25a4@kernel.org>
References: <20250312-en7581-pbus_csr-binding-v3-1-7bd9f00a25a4@kernel.org>
Subject: Re: (subset) [PATCH v3] dt-bindings: mfd: syscon: Add the pbus-csr
 node for Airoha EN7581 SoC
Message-Id: <174195292241.4020789.14863170560940675990.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 11:48:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 12 Mar 2025 09:32:15 +0100, Lorenzo Bianconi wrote:
> Introduce pbus-csr document bindings in syscon.yaml for EN7581 SoC.
> The airoha pbus-csr block provides a configuration interface for the PBUS
> controller used to detect if a given address is accessible on PCIe
> controller.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add the pbus-csr node for Airoha EN7581 SoC
      commit: b904243247d1acb0ebbd4978feb639441dc51fc1

--
Lee Jones [李琼斯]


