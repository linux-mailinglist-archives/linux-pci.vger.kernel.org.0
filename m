Return-Path: <linux-pci+bounces-40551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C7C3E5AA
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 04:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B8F3AAB54
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CF227599;
	Fri,  7 Nov 2025 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N/AjtPdW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m2412.xmail.ntesmail.com (mail-m2412.xmail.ntesmail.com [45.195.24.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90413D891;
	Fri,  7 Nov 2025 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486598; cv=none; b=aFYK4VISAStqmHkdIVTFLIssXym9RsOtHuKW71f9ZJ08bz1GTd+0VRNlx8lhWFOY5r31SoVGSD30vR8JkFq4fbdgz2Aeu6UD7UDq3fwIFgA2XM1MiD81IpOWjFC1+UsEm4XD6wNHbI57m78fktMIBOgSTW1lVdOJdsa9Cg2Gmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486598; c=relaxed/simple;
	bh=uhQp4XIMiDylw9wRBxbeocknEojR0/ndrfGwuOyRdX4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pF+VOv3j9sXPwhvExbxo1dQ71DPLPSzsyuzkhwjJw0tnfGOmLluRQ+OtJNizIVI0JSe90mmxBheSPnc192tSitiRU1mMdiguJvXM5fvQy5GIRs3WExyRvdhLaSsLdP2Pp1F6NFHTuXRHIzhHepCTlXETbd/D/NpYP1LK3riMauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N/AjtPdW; arc=none smtp.client-ip=45.195.24.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28b7d0bc4;
	Fri, 7 Nov 2025 11:01:05 +0800 (GMT+08:00)
Message-ID: <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
Date: Fri, 7 Nov 2025 11:01:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 Ye Zhang <ye.zhang@rock-chips.com>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aQ1c7ZDycxiOIy8Y@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5c42adf909cckunmd8a05e02f6b7ea
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIaTlYfTkwdH0JKSxgYSE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N/AjtPdWxmqb/pFSs6gykwYAJznoZ8eog/K1ggyHgiHswHpN2h06IuYOiipUjuL3fkrH9tNI7iUErn2M+xn58GJHlBeesAuUuwLcF7xohvnZc6VYwGmJh+ip2Ox71RepKsnJaUNoX4XVoE81ZYMa3tVHxJcOI2tPNeo7AAFKCxQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=zVsNu3y1SfXzBdfw48QrW2mnVPUuj41sgD9Q3ySf0jw=;
	h=date:mime-version:subject:message-id:from;

+ Ye Zhang

在 2025/11/07 星期五 10:43, Geraldo Nascimento 写道:
> On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
>> 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
>>> Hi Shawn, glad to hear from you.
>>>
>>> Perhaps the following change is better? It resolves the issue
>>> without the added complication of open drain. After you questioned
>>> if open drain is actually part of the spec, I remembered that
>>> GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
>>> so I decided to test with just GPIO_SINGLE_ENDED and it works.
> 
> Shawn,
> 
> I quote from the PCIe Mini Card Electromechanical Specification Rev 1.2
> 
> "3.4.1. Logic Signal Requirements
> 
> The 3.3V card logic levels for single-ended digital signals (WAKE#,
> CLKREQ#, PERST#, and W_DISABLE#) are given in Table 3-7. [...]"
> 
> So while you are correct that PERST# is most definitely not Open Drain,
> there's evidence on the spec that defines this signal as Single-Ended.
> 

This's true. But I couldn't find any user in dts using either
GPIO_SINGLE_ENDED or GPIO_OPEN_DRAIN for PCIe PERST#. I'm curious
how these two flags affect actual behavior of chips. Ye, could you
please help check it?

> Thanks,
> Geraldo Nascimento
> 


