Return-Path: <linux-pci+bounces-7175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF54E8BE7BF
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E321F281C4
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AA1649BF;
	Tue,  7 May 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9J5t600"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B51635CF;
	Tue,  7 May 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096914; cv=none; b=Nob6eAHEb4f1cW6aNLTb8oIgMiaWhYIXLg/YRxcCjISi9RiV9HEESHaznQZ8x8IO1IbvPz8xRf/WUelsBmTQov0Tuj5YyHou6akBT4TNEscGL54Dyz8w4KbQlt4eNOnW+PaLfYXHUnOJs8OTa9AUq7P0ohoYsfE3kdIm177rg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096914; c=relaxed/simple;
	bh=gI67a6xryCcnkpSsoDWEUmaILOz0kViHVclTsm+/VAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDdyp5z/sVSns3y33qSXQkJUV+7ghC/Bv/OyqU+TtfvSr7D1H2jmaZw9HvVpONf83GmiOCb/ZKM5dM2wTFkGjnjnZVhsIv360Fm23NeiFV5yFMpYwu2eJorRaihVo+lOLsHLkxZJGCAP6pDaM86/MfwsDzZ3Crp+VA1nnUlREeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9J5t600; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE12C2BBFC;
	Tue,  7 May 2024 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715096914;
	bh=gI67a6xryCcnkpSsoDWEUmaILOz0kViHVclTsm+/VAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9J5t600DgWbX9Xkp9ZhW74uRsmKygOuMNhgNgFgGIs8UF8QeuVfvlbYczHQg6Rwo
	 pNCCsAqBQO7mHMA0biTYolBuYN7mguCEXiRrH543pNxfV6lbp5rbHNIl1kaRubV6kr
	 tFan6u8KZQ1QRfjyOO5t5VY0MQtZC5TXycdQhDIkHdfRhgYQPa5f9AgSuqeZJM0crX
	 ycuGZYPIzXA/oCgGS+/vvLsFEh3muKZLUOm7GVstIOOD2n0fBLau2PEemacHdAr2Ws
	 88GuxKmR8pIGHvYeYgj297Os+7+jYqGQ4Ltv8X0J6yLg71+nT4dJ8JP5sHxjCtAi/F
	 b3906vY54y88w==
Date: Tue, 7 May 2024 10:48:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Simon Xue <xxm@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Lin <jon.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 04/14] dt-bindings: PCI: rockchip-dw-pcie: Prepare for
 Endpoint mode support
Message-ID: <171509686127.528404.2616172017611002206.robh@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-4-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-4-a0f5ee2a77b6@kernel.org>


On Tue, 30 Apr 2024 14:01:01 +0200, Niklas Cassel wrote:
> Refactor the rockchip-dw-pcie binding to move generic properties to a new
> rockchip-dw-pcie-common binding that can be shared by both RC and EP mode.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../bindings/pci/rockchip-dw-pcie-common.yaml      | 111 +++++++++++++++++++++
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +----------------
>  2 files changed, 114 insertions(+), 90 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


