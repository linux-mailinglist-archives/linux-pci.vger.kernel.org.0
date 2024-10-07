Return-Path: <linux-pci+bounces-13947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A987D99292D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9DF1F22FB5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAD1BA89C;
	Mon,  7 Oct 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2XM1BIz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322C1BAEC6;
	Mon,  7 Oct 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296767; cv=none; b=fcCJHhefcSoqjZ8EKjARown/xEFdiTDxNPcktKTyFDMP+9JUhOMrr6PMYOrKxjxatJUWs+/4HyH0/8XEaTx66fT69o9WlfktdxQtFwGsZK4ruh3g2Xl4W+821RuNryTpHEwGivBI15u6c5oWXxjbq8HFsRsvlW6tE2/60VnXuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296767; c=relaxed/simple;
	bh=x4sIbfqk5TN8dm10lhqSSvvMtyOM99SvhPSJNX174AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvFCjU7QtuKzqM1mJK9T4puu3ZBXwnKFrZB8BPQCe4Cw4n6aelS28ZvRCYSk0BgD//w2isUHfEW0aytbA9u9s30rmUWj+l42qONrZmyC5zzqySYgfN35orim9eBxtcy5eVGh2KQrjrXDNmWGCYNaPMvrLL9obEBDMHukTD0Bf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2XM1BIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75E9C4CEC6;
	Mon,  7 Oct 2024 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728296766;
	bh=x4sIbfqk5TN8dm10lhqSSvvMtyOM99SvhPSJNX174AA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j2XM1BIznolGgKKidb+9miWN3HrxXA9rORQ00/YAkhHRo5/LtgAMj9D7wrfwAYdDS
	 8gep9GMl1HmnuSQ/BgzJcICM3Stcj+ipADazTFo/JAyUNl8qydYNWvmxkXHjZ5D+dM
	 my+Os8TQ1sD0P/+BKGUjah9KKOKO+vADLHbEoKrsmR8q5Ze+LwXQAt/N8el2H3gmnD
	 EZ+Jo1NVsl4Bbd6FkCeI3OjLJUCnmkE5wSK/ZLqjHrR4YL2luYPmntFtTlXw3/wkfX
	 vD26cqRLq1+gnkBbEj1cdzC1KMuoYSXP5U6boO9pMe6j+mXR38jipBMotA0F44o9IH
	 Wh81iNKEYU+DQ==
Message-ID: <8296f547-7c09-48e0-82ac-49eb20e93d1d@kernel.org>
Date: Mon, 7 Oct 2024 19:26:03 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12]
To: Niklas Cassel <cassel@kernel.org>
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
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <ZwOxqvzBG4i_UGKc@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwOxqvzBG4i_UGKc@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 19:02, Niklas Cassel wrote:
> On Mon, Oct 07, 2024 at 01:12:06PM +0900, Damien Le Moal wrote:
>> This patch series is the second part of the former version 2 of the
>> patch series "Improve PCI memory mapping API". This second part is split
>> out as it deals solely with the rockchip/rk3399 PCI endpoint controller
>> driver.
> 
> Since this series depends on:
> [1] https://lore.kernel.org/linux-pci/20241007040319.157412-1-dlemoal@kernel.org/
> 
> I think that you should have added a link to that series in this cover letter,
> and more clearly state that this series depends on [1].

Indeed. I botched this cover letter :)
Will fix it in v2.

-- 
Damien Le Moal
Western Digital Research

