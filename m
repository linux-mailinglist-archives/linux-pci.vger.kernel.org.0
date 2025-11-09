Return-Path: <linux-pci+bounces-40647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A776C4386C
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 05:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283603ACD83
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 04:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C020FAB2;
	Sun,  9 Nov 2025 04:43:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B734D3A9;
	Sun,  9 Nov 2025 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663405; cv=none; b=bnSet/orPg+kBG0jCmKce4CevUK72BaIkUQ/knbUsWo7kT1QSc049Hv7RCVOTIjZJfnI9cTyu8gv3YTVK6KMs0cTRoCD1ZYUO0dvYRc3hAcHbSdIHDlQsLSVZjVE2p4u0BQqTJC3/O9r31D4s380M+FteRw/ojSEBzijDrOo41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663405; c=relaxed/simple;
	bh=J6B8ZdMlonKYuEyFFgpmUmH5fkMBCY1UBK1BL+6hz7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmLuyp0uhUopGur5ckER6lsd4Tsz2J4+G9Ca170tLbL3JD9mqo3Rm04bsUqNYHK2Fd9PxS7xupQeY0JrRsUQ6XLsHDznNGHbOlDyuPjSE4SxyNHowMJo3FMgp7hJD7d+7/iRG3L4fnVwNmnesKJMX6mrDMRYkam5//1YT+TcHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1762663347t2fca86ea
X-QQ-Originating-IP: V9Kbroh4xSX4Zqjajg/LaEFIkR0Xw+xFYpVOld+vU/I=
Received: from [IPV6:240f:10b:7440:1:d0bf:3b2d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Nov 2025 12:42:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16878913424154187079
Message-ID: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
Date: Sun, 9 Nov 2025 13:42:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aQ9FWEuW47L8YOxC@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MACXe2l6e7j9v35cxXlys+1EbRUY2ZBE36NcO09yuYiVtJbAsInfvNrA
	zMmVX6zUXnYROdeDt+E1WTwfghk3OchcYr8YfFMpRUB9ts46w2+N18QlspT7i0y6ev26W9K
	57k1yU15AOENuHgNYAbQcBjbh2S15otw60LYGzRHqWrbQXNMA/zsBq2Vhuryp7hA9J4Qp5o
	pIrwHftCO7W7cb1n+ND+5Px2FlT/cqY8SpJgFhV1KoZskrhE9AdScycDMvOX8uqgIt1IfPA
	saC59ujFHODGy1pdQpyj1rTUTNVSoOBrZuj874SXwuTuyHJ0JthYXIBBsFPwJpvc4JmPJcg
	wNqpJOPcaroctymNwOudq84nGCBplQ5KxQHGwDhG2nAiH6VSrLbSj6F6vTdy/wD+pMjgjMH
	x1K5FdKhC54qAXvYj3eyU3rcwhAMZXTrpBDnIKU2uunQk/0nNPnWt23gxZwZlgTvK63BTAJ
	0XfJNXBIL6oKht52IK+GwSr3mPk/9Bzk2QDiYpjEiQIcp6EVRhFeXLsJGbboVCVly2loSJt
	+tbqwvDCDI7nkoIAido+GwBagOS8YPxJ1dFLd8bRxOESzElgl0PTJQ+AUp4XmiF9uYWGYaq
	A9qlsIMWuOpPgMwVvaF4PQM4W/YmiuOKKSyGMRz8F45KHyUxwkMPcn/bY6bzBbmOaOAdXPz
	YIp28mEYiT4QLGEqBq3TARvZAtCOJ4fNhyThTjKez8yKWuJc0/e7o9o/qaqANrXGHYtVKgb
	MR1DA8KnhtchIkkmnsLwa3rdYZeCKSFtyJ5kmJrsdpy+cJNAPSi87g8/AzfKPAh8NbhBQNv
	EAe9ZmkStznHRw+XdFoclNKsH9h/dOctom+JIzFVRc9PVYFYseq1U+yWuKWdoLOx2O8w2Ml
	GnL8p1syI00/TjkJNTv9T1XOs5+4HPNVbMbtbTO+oacpCvYeM0rUhSv6NSn2C+k/JPo3oIb
	NeveftR5jrygw0UR0g1QGXFCxuAMNjaKWaAdq/VyN8rbf/aBnWMRwNjLz
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi Niklas,

On 11/8/25 22:27, Niklas Cassel wrote:
(snip)> (And btw. please test with the latest 6.18-rc, as, from 
experience, the
> ASPM problems in earlier RCs can result in some weird problems that are
> not immediately deduced to be caused by the ASPM enablement.)

Here is dmesg from v6.18-rc4:
  https://gist.github.com/RadxaNaoki/40e1d049bff4f1d2d4773a5ba0ed9dff

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 


