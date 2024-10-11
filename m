Return-Path: <linux-pci+bounces-14263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A178999F00
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376B3285BDA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F420ADFF;
	Fri, 11 Oct 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL1dfOjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79A20ADF3;
	Fri, 11 Oct 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635160; cv=none; b=KVV2YoV1Bv4Ge9r+Y+Ge99b1axNHIzc3kyqEwVcUuz8CW9aZF2oEfJqfbT/jQazqdiiCVnJIn9CPcRtEQl+ij7JAggh1hnhA/5mcNq0amSuDTzMVkVWaRi4yGIrp+3XGE9XOV0IwVxJWvRU9K9AkbfwJl8fKh0DNpNBf2RY1H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635160; c=relaxed/simple;
	bh=L50c2V8W/RlzvTod6zS7Wvye+fgjpftpYkVsG3RMnD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGQnLDOxDpZSj7H3W33+3JrC80Kzn+9YZ54naxIvGVHWWa6uBcJCOKg7d+aLix9LFP3TLMDZt3j7RNjvFyBMmAhef9duVYGi+6jh55t8oEssNjKL5E7b1aGt2M5RPQ5g+5l03ig+T7aWd37NSjEGT520nj5oSq80ymEoGCUDcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL1dfOjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D554C4CEC3;
	Fri, 11 Oct 2024 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728635160;
	bh=L50c2V8W/RlzvTod6zS7Wvye+fgjpftpYkVsG3RMnD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KL1dfOjOCZgmtryrJRAb/xQiK/Rt7bUOYOh1c+m/DeyeMtEyn/FIlOBzsboqo1N8J
	 girR/BLuhyuqQg5zge8hM9ZY9s93a2RO5569JRtG7rY2f96N+Pqbc2dEg6GosBVS7w
	 R4Ue3DvBF+cSICmJTJsBav/LNRDWW4+RjUFXXcaLydiNbmG8VXzOL0TdOOJQeZDhBN
	 niI2eFtYbvO8TFbTfGl6Y3qNHjInn+EGt/I7D5/orjC/ajwQ3mgJP4FkYJXapZy2cV
	 Xuu+q9PwqphttjtuMorvJsqll4lmnIeIolDGMalwFgbU/b36JPJ3VcONMhopriXtol
	 Bn8o/8WXuJZ1Q==
Message-ID: <11cf07c7-08d6-425d-9590-1afab6d052d2@kernel.org>
Date: Fri, 11 Oct 2024 17:25:56 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] PCI: rockchip-ep: Refactor
 rockchip_pcie_ep_probe() MSI-X hiding
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-8-dlemoal@kernel.org>
 <20241010072512.f7e4kdqcfe5okcvg@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010072512.f7e4kdqcfe5okcvg@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 16:25, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:13PM +0900, Damien Le Moal wrote:
>> Move the code in rockchip_pcie_ep_probe() to hide the MSI-X capability
>> to its own function, rockchip_pcie_ep_hide_msix_cap(). No functional
>> changes.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Btw, can someone from Rockchip confirm if this hiding is necessary for all the
> SoCs? It looks to me like an SoC quirk.

All SoCs ? Are there several versions of the RK3399 ?
As far as I know, there is only one. This is unlike the designware IP block used
in the RK3588 which can also be found in other SoC and may have some variations
due to different synthesis parameters.

-- 
Damien Le Moal
Western Digital Research

