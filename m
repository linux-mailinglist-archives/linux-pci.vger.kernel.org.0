Return-Path: <linux-pci+bounces-7748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54AD8CC379
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73221C20E45
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8DDDBD;
	Wed, 22 May 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug8dRJXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E11AACB;
	Wed, 22 May 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389190; cv=none; b=ZpzbAPbCg/I+HBB54cm6ZJyAjnM0hpDvq5anyWpkEQ1Aw943I15b9eS0qfVyVy1/OGGOObtIRwiYh94YC2JNyxkSKkxu6hdbG1hJlbvtK0Ply7fWYR54gnsW7hXwfcQ1HDuBdVXOBxLVoScFt2i+QtHypFLyb7Yi1HXEaQ4Iq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389190; c=relaxed/simple;
	bh=dy7gr88adDgKpasKwsud6U16sjxUVBOaxRknrNm6xkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b36j9oT3e5n6yYOSDVbryElg4G13uzjxt1q1wsgY6Pb4Eu8P3Id+Clqox85s0OScTdh+ip3XXxZRHc46feRm9hjLojnKg2XTsZyzAvt0aF/UPereSgl55ZIM8O2QevJYaI6LyBsqaLR7Y8I/22gNLGVzCGvJm0zNOvqg3gemZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug8dRJXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A3C2BBFC;
	Wed, 22 May 2024 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716389190;
	bh=dy7gr88adDgKpasKwsud6U16sjxUVBOaxRknrNm6xkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ug8dRJXpVEckHEassENbn9ROMPkaAby/LMVqPorfy17UISPuh3VHELsvyxKDZCPYL
	 6W2m7UcOd66aR3hjGgOPXU6pFz5k7+ToOkDGXFHVTri4cnoi+34ngXqynrTvk29Oiz
	 FE0QVYfKqarUkcWeHrlArhIusHiCfLEb+f5cyrpez/UCIf74y6wlyygSPG00gpp2zE
	 u+Ou46NhRd1FnBO1W4uK0TdIEzWoHd8Cqwff25bM+8WHiK1CW/jl8KV3/VcCOzYxgI
	 J2MZ+xQy9XvhJtxDQoss7cuALRSx5lXn8K4eip0IT1IzjSgfYFT3Sfs+WaB1I3VL9a
	 syOaONQek/pCw==
Date: Wed, 22 May 2024 09:46:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Message-ID: <171638918647.3276613.2909691160973849874.robh@kernel.org>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
 <20240520145402.2526481-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520145402.2526481-2-sean.anderson@linux.dev>


On Mon, 20 May 2024 10:53:56 -0400, Sean Anderson wrote:
> Add phys properties so Linux can power-on/configure the GTR
> transcievers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v3:
> - Document phys property
> 
> Changes in v2:
> - Remove phy-names
> - Add an example
> 
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


