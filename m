Return-Path: <linux-pci+bounces-16998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C849D0262
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C0DB237D9
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5729408;
	Sun, 17 Nov 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqfs5s6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0979F6;
	Sun, 17 Nov 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830446; cv=none; b=UaK6H4CGFCo8d5aJnrjVF654k1aP1hgvvop+Q3HgOMOgF66reaDUDuvOumecRKPaOSbHJ0FD2YdRrFxth3MNtlfkfmJbMAd6UhnlfWzws2VvPgLR/SAgMohZWEJNgCCuylYG68dEPSZrT+k24X9xtnKEFjFsdFm9Jy6dBpzLzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830446; c=relaxed/simple;
	bh=yG/Prvv2cW4FAbQIxSEqLgZUGZ3kv80l7NsNSnpg53M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY5a7g4NLGRWkDPP9uMPw+yVLKca778Jvir1FQhlnU4kQYytLwIwzoHU4qM6gzbWcPwd5hXACZvbhtt8jWp35F8hVOAlXSugnB2BgszWD14457Y/klwwXc6+loWLp9la8ILCqcuPKdx0cFGToArHKV7ayUZQmMm35gQUC3QvhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqfs5s6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB0FC4CECD;
	Sun, 17 Nov 2024 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731830445;
	bh=yG/Prvv2cW4FAbQIxSEqLgZUGZ3kv80l7NsNSnpg53M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gqfs5s6yPfPvpIR/sBXHis0a0AI5ejKOd74ZA3OIxcF77rHXSmvJu6tZGO5WjO2sp
	 VI8Ds5IkGhecdxwAIcTLz4Ii1blB06aUeab/Af7dijufr/PetogT+B1f3+IoC9doIP
	 3rBc/91TRUKN/Yysf1UEKuVllyeahSzksv5EiaLsZZhz+9Ly07mlMyl+OsTzRShHm5
	 X8V8KYQUq8Ck4WDOuIses5VrALQ7Vb1T6Gbdf8qWLXCGzJD6jL9tlTlV3bsKx4J4cG
	 gC65Sjr5DkIrvv2vzMS8kW9StasNCjgdW+gZm0GBTokQWSjJwjZBZ87GgML4RsUhhX
	 7CDgY4aUilWUA==
Message-ID: <8393e56d-8ba1-436d-ad97-ec44893d2f6f@kernel.org>
Date: Sun, 17 Nov 2024 17:00:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] PCI: rockchip-ep: Improve link training
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241115230319.GA2065576@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241115230319.GA2065576@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/24 08:03, Bjorn Helgaas wrote:
> On Thu, Oct 17, 2024 at 10:58:47AM +0900, Damien Le Moal wrote:
>> The Rockchip RK3399 TRM V1.3 Part2, Section 17.5.8.1.2, step 7,
>> describes the endpoint mode link training process clearly and states
>> that:
>>   Insure link training completion and success by observing link_st field
>>   in PCIe Client BASIC_STATUS1 register change to 2'b11. If both side
>>   support PCIe Gen2 speed, re-train can be Initiated by asserting the
>>   Retrain Link field in Link Control and Status Register. The software
>>   should insure the BASIC_STATUS0[negotiated_speed] changes to "1", that
>>   indicates re-train to Gen2 successfully.
> 
> Since this only adds code and doesn't change existing code, I assume
> this hardware doesn't automatically train to gen2 without this new
> software assistance?
> 
> So the effect of this change is to use gen2 speed when supported by
> both partners, when previously we only got gen1?

Yes. The host side has something similar as well.


-- 
Damien Le Moal
Western Digital Research

