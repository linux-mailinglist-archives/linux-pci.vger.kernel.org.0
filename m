Return-Path: <linux-pci+bounces-10783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF193BFD8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 12:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EBA283448
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57021198A29;
	Thu, 25 Jul 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coRtsRgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1F19750B;
	Thu, 25 Jul 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903017; cv=none; b=mfZtfi/klS/FQVVHrD33GIUZmRnqcZb/SHySELYr+JZT7xWQWh1xnK4M/VceEus6svximXMtNnFuoqLlJpn9r4sM00EKASow1LTi0+yrOYDehKfMu6SNL9ehDEtN2xYNPrKNZy6FQfDR/+510waK03mieNAY9gJJmbK9GiFNDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903017; c=relaxed/simple;
	bh=IpcvpKK2iFFzBNpD3ek8vo3FpVKJ7xN4ddiOZptwkfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sOUUqX6c17UUpSBZb3JosLMknl84jQoJ8tOF+4tCgLTBKp9YD91GNLgAmek4iHNXURMKp83KddTPUST2c+jstTY4Qjs8gG6HlC2aGJIBboGz5xENrUbTOmmnkDLPQsApWKpIHZVBCvRZe42QVGTY6bpd/J7OOW0sYPMG7LJcYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coRtsRgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB27C116B1;
	Thu, 25 Jul 2024 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721903016;
	bh=IpcvpKK2iFFzBNpD3ek8vo3FpVKJ7xN4ddiOZptwkfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=coRtsRgFTGUWQThKlpB8kVNGNfNCd5SHelIy8vHYboxBTQfGPpPVL0fPspJ7ccKT5
	 ayDKn1ORiqRcC+z0w6f5fUYpu4fpjJnohVGAeuvou68LYi4Xa8M92i4oDn36U4h+NV
	 HFr4p6JyPQ2b/6H3bO0bk01UyjPRs7XFZUw1f145dH7hlhLsWudpGMn4GVNPU3WFII
	 f3CARzMj88QAZJAf1MKsMlm9xr0KxBF8kHRrcFvIwBpc2H1Y4VVZeAOzwcEU5eUVeF
	 kFG+g+NrO0abnorkcDV/f4Rsg7jpdyLHKMqOcAyXhyTBp9DTA07rhWZsr0h3fPXIVY
	 YuhTJ+YCbF6KA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lpieralisi@kernel.org, kw@linux.com, 
 bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240715120936.1150314-2-s-vadapalli@ti.com>
References: <20240715120936.1150314-1-s-vadapalli@ti.com>
 <20240715120936.1150314-2-s-vadapalli@ti.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: mfd: syscon: Add
 ti,j784s4-acspcie-proxy-ctrl compatible
Message-Id: <172190301400.925833.12525656543896105526.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 11:23:34 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 15 Jul 2024 17:39:34 +0530, Siddharth Vadapalli wrote:
> The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
> SoC are used to drive the reference clock to the PCIe Endpoint device via
> the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
> obtain the regmap for the ACSPCIE_CTRL register within the System
> Controller device-tree node in order to enable the PAD IO Buffers.
> 
> The Technical Reference Manual for J784S4 SoC with details of the
> ASCPCIE_CTRL registers is available at:
> https://www.ti.com/lit/zip/spruj52
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible
      commit: d86ce301dcf715ea2d5147bb013a29f722bf5d0b

--
Lee Jones [李琼斯]


