Return-Path: <linux-pci+bounces-13938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869A9925FD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 09:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BA2B22F1D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA416FF44;
	Mon,  7 Oct 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiX8jzr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54378433BE;
	Mon,  7 Oct 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285741; cv=none; b=Hj7VH2HynPFZXde4n0gzlSLajN71JAWm4DzWn4+5bjReHl3KF6qEE8fYyh8fW640d5a4VI4QzPAwmaecju+pQFy3yNUNmUTfyTPNCA73iPljsPGTCufV1Gi0a60n4qDNQCP/ipiZH7sAVXp7Q2Tb/w/TYNPchsb82+Z7udqUelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285741; c=relaxed/simple;
	bh=iVxdQvEmWNL3nXloUOyOwrqXBICnS72BJpw+hrB3JJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfzUUbd8BjIo3sUuHNeiohPJiQJjc1G2gmrVyZWidbMg41JUrJeghRWWhoPuKoqT3abOvh8c9fPz9gRZ/8EWPm5SZjJQXjrAMpFfiGSlmGsqkY7d9w2duW6rrkV+tdboSIiJmIRKGdRrC+2UKlDxaA2ZjmCDACr+xsyeNxGRGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiX8jzr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F19C4CEC6;
	Mon,  7 Oct 2024 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728285740;
	bh=iVxdQvEmWNL3nXloUOyOwrqXBICnS72BJpw+hrB3JJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YiX8jzr8MJKDsuWAVgwInPjqnUUPgBil/VOpc0wGNhFNmpn5LF71Q0XiB22Hcxoih
	 VuiBdDCOqE0/qhogG/bbIWJOlqfF1LXFO8TPmbxw//kJZpAoBLPFWJav7N/2Gyjuyk
	 u5esNr78tLea5DHP7TzZe+GTrknkshn1e5FjIoLtJ41yW2pGkgnE3Yu1NSTGFxJF4C
	 MwbkBoa6eaAfYoml2I3jIhCW3UMU/MET/f18nSqY1DeaVrGdEOk/UfuPAt8EXQaiJ2
	 r7WxKi6y9l8qjT2aAb3Ze1WiEZ9rb/vy34l8GmZfR9fQWnDnp7tFVJAhC6rNGi+gX2
	 IBOWxTDgmcZXw==
Message-ID: <1e85bd5c-a733-40e7-9606-b655c4ff3b6e@kernel.org>
Date: Mon, 7 Oct 2024 16:22:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 <20241007041218.157516-12-dlemoal@kernel.org>
 <o42ki5dwipmldcpnthpfoaltpmu7ffheq627ersrvjj73xkm6x@vkqjomiznstg>
 <179ed297-1d06-480d-8095-7212cbde2ab1@kernel.org>
 <64421c0c-1d48-421d-8841-859695b5046d@kernel.org>
 <ec728ac4-ef63-47a2-9058-5c038003418e@kernel.org>
 <e1e2c852-ff59-4450-9236-d954d7dc86f3@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e1e2c852-ff59-4450-9236-d954d7dc86f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 16:00, Krzysztof Kozlowski wrote:
>> I do not see reset-gpios being defined in the bindings (common, host and ep).
>> resets and reset-names are defined though but these have nothing to do with
>> #PERST control.
> 
> Bindings for all PCI devices. See pci-bus-common.yaml

Got it. But in this case, since ep-gpios is already defined for the RC host mode
controller, isn't it simpler to simply move that property to
rockchip,rk3399-pcie-common.yaml ?

I can of course instead re-use the reset-gpios property for the endpoint mode,
but that will need a bit more code in the driver.

Which way do you recommend ?

-- 
Damien Le Moal
Western Digital Research

