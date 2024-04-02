Return-Path: <linux-pci+bounces-5573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06543896008
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9AA1F23A7E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36D41C7F;
	Tue,  2 Apr 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDClBlzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701451E531;
	Tue,  2 Apr 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100199; cv=none; b=B3RMe/x3dEocBSDOZYCQnGPhAWk+e3QYF1uU0ugLcIE7StIJwGjZjOBh26qr0eSXss5Ko//zkE6qD9gNS3MpdR5pxSiqtbwvV53mKj7hxZm+6ksUJBZLEJPh+4YsHykiJKDO96shoddbMY23rFinZmMW6622xVBVj7oKx6hydMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100199; c=relaxed/simple;
	bh=MeLS86YdjnIzGiuXPd5GfJyCavX2wucsvi48OLJIDeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiRAvTD76kdlt0d9dl93DQx2/b17VmXiyeWUL7w5vp3NjcYoc/aSsuXCHGnIt0+BrzGW0MZLgBa5yOIrUydevu1zY74rH7Ei7VztfvRPZiBhUp20S8P7GPM+hv2F1iv/CIesCmovoLJO02l0hG5dEBUov5XdN2831TaXYvRto84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDClBlzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F930C433C7;
	Tue,  2 Apr 2024 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712100199;
	bh=MeLS86YdjnIzGiuXPd5GfJyCavX2wucsvi48OLJIDeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iDClBlzz9+EtddVYkNAHFxMOaJoQnATld9xN8+G7AiRLrW7spNjrDNZM/uicl1gNC
	 /4s+WZzVoGUN+ZuUz4LGB4ROWhXkjWQizKYDFkZf+cAe1AKNQFgXsDfosJpa0agVxB
	 M5o8dcwAboK6CVcg9uHI7lQ/hN/0aWqMXTdhsK+mcGDXMyKCtQ523hcjTqPEkkJzt2
	 QsW3JK5SlE5/vyEPltNDECa01GNs189lB/+aCOMZHnHE45q1l/ZlMzWKwP0ybKiXww
	 MK/AsqJ5mpzh8pdRZ12QUp3pV5t8X8m/qbI2RMyDqYR6uPKZIcqHoIE91YuDIw/zuD
	 gU/YCoT6iYU9A==
Message-ID: <992dcef1-00d3-456c-b3ee-253ab475f0cf@kernel.org>
Date: Wed, 3 Apr 2024 08:23:15 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-18-dlemoal@kernel.org>
 <b020b74e-8ae1-448a-9d47-6c9bb13735f9@linaro.org>
 <c75cb54a-61c7-4bc3-978e-8a28dde93b08@kernel.org>
 <518f04ea-7ff6-4568-be76-60276d18b209@linaro.org>
 <49ecab2e-8f36-47be-a1b0-1bb0089dab0f@kernel.org>
 <57d5d6ea-5fef-423c-9f85-5f295bfa4c5f@linaro.org>
 <80c4c37b-8c5c-4628-a455-fcccfc3b3730@kernel.org>
 <be2a0fa0-9d5d-45c3-810a-56d6924c8891@kernel.org>
 <65b6329a-643c-4adf-9137-281964865d51@linaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <65b6329a-643c-4adf-9137-281964865d51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 03:10, Krzysztof Kozlowski wrote:
>> Thinking more about this, I think moving the ep-gpios description to the common
>> schema is the right thing to do given that the driver uses common code between
>> RC and EP to get that property. But if that is not acceptable, I can rename it
>> and get that property in the controller EP mode initialization code. That will
>> be add a little more code in the driver.
> 
> I forgot that it is actually the same hardware, so if host has
> "ep-gpios" already then EP mode should have the same property. Common
> schema is good idea.

OK. But this will conflict with the patch you sent to add the missing maxItem.
Is that patch a fix or is it for 6.10 ? If it is the former, I can wait for
next week to rebase on rc3 and avoid a conflict.

> 
> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research


