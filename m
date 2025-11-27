Return-Path: <linux-pci+bounces-42194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45649C8DE25
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0BC834656C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0CF2BEC52;
	Thu, 27 Nov 2025 11:02:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFF2356A4;
	Thu, 27 Nov 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241373; cv=none; b=O15Vg5+RNdfd0tMxjQDpA2Xggke/o0QS3NFioWThUMB3axD4hJy9ckmPoiSuSE3KVy8+0yYq0nEFAy65rPi9GPuM4Irhz8kWKpMVhhNAek/Ej0iqtKFb3U8rXg3MfzPKI1653W4Ya6JQWpBvj/CSFUsUYafW4SCj1Sj/I3EpeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241373; c=relaxed/simple;
	bh=0EZFLajMnRy1K/X7IjiPEkyAWsdbPI3YV2msKspp04g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDURYHy8eKNAzIuGdKIYBARgW1wUy0/lECdiNVX/vhnj/YnMA0RykdWWpTSsC6tLHlBqLDbiYTsPfEl3Gv/7jXIuvn7IdTceGN6nV9o1N9xtRehmNFU4wZRHyBiCMXfwhw6dx03sLugtNxHWViMc1YZdRr1H4cuDrW99+sSDBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1764241347t78aa8971
X-QQ-Originating-IP: jkDH227WqUwOoFTBtC1hwDrWemoF+qI3vLMPnvs0/lI=
Received: from [IPV6:240f:10b:7440:1:c95a:801a ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Nov 2025 19:02:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10963241468344092550
Message-ID: <53C4D04AE30D7004+12cd5747-7bde-409d-bc02-fcf86a47cc44@radxa.com>
Date: Thu, 27 Nov 2025 20:02:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
 <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
 <F11F0D13437B012D+0c15c5ca-f64f-49f1-9ff5-26b88d59ff59@radxa.com>
 <aSgBLQ7rDOiEFhMB@ryzen>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aSgBLQ7rDOiEFhMB@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OccmtviHNKX2u/hDzkelu892qFg6Ta/bNe9+samL3hbR25KCdyfVGYXC
	2xToyATmGI1fKAE3y5vZ+XJ3XvDf7XuqB0vWff08cnLC/bzM7dILq7T0350SB7spAYhzup+
	eyrbw+8QV/zKk1SNzHfRdPOQobR2YmXAGg/0t1ODZExJO8HY4nNiJTfnJ+9G/LHN9UxhC7W
	bd1ly2J6U0aXuTwRvygezp3x2utFfadN8Kd3zAmPeBVG7YuwQZQl98I1JpVtP+UiKqAlogO
	TC2qTV5MwcrdNRBSY142ZKBAd9YpppAR5WyhsEAkcN+Y1YxUoUIyR44hvqpSYafSAD+N3Ri
	YKerjc0Whod3nt39M0pNRwD8co8lBYREgFdZQvyQTqTT4EGyuKo0CAdkoGCuyD0hMbZ3dP2
	Lngnw/I0OttdKmNIjvt9PXrT7R+kGYFzN05GoDugs+tL9N+2i+rlPEThAb3vhcaKc/YKsGT
	RQIIeAPou+cqNwQhKNgCLMa8fdlcauHQTqelFFfxa3pk0WUdeO2jX9+W9l7ak6FDBF+jf6i
	QIR3buth0yDC9IOCtYZCfkcH3/BufvxyWQGzdoBRjrUJpaR/MKtjz1xeA59TlFG+7BdwvM1
	cbuuyDYlKsL6hLqhHRv9vcWsG/hnsz5Ut8uEDLpKEDBLsWaUz3+cLK21UiengFLYoP4cV5V
	fb0w1vMVbyM8mvz+MKi32i50MONXNYUJGiKNg4bOZR1UIJa7w0iqkDHlIAKtKNr1MegRQyI
	hp0jxl5Xbnhgx3w15so3AxAxVJOfp0BF5l/uIvLk4EpTefdT+kpTbCb5WnMfUSc0fpYps2R
	HcX9M5hOQOvC/sbw9x3PUj0IBYF1om/Gnc8fN3Y0Ei7CfYjj/KEpbqKFq7WVCKKBqIONTwC
	IkFr7jB04WUitpawB2jEblYxBzKtucTjndvkni4aYi3UkgMK1lbfkpoFigVq01hONMLCCOE
	UquxMzIk6smmXgtW8CBiRwjH3zhpQER+OtKa5bvONnycDDg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Niklas,

On 11/27/25 16:43, Niklas Cassel wrote:
> Hello FUKAUMI Naoki,
> 
> On Thu, Nov 27, 2025 at 04:34:53PM +0900, FUKAUMI Naoki wrote:
>> Hi all,
>>
>> I'm very sorry, but my ROCK 5C appears to be unreliable. (It worked fine
>> with vanilla v6.13, so I thought it was fine.)
>>
>> I replaced it with another 5C (Lite), and now every method (Niklas's patch,
>> Shawn's patch, and applying patch 1 and 2) seems to work.
> 
> Could you please give us some more information.

Sorry for the confusion.

> Does the Rock 5C Lite have a PCIe switch?

ROCK 5C and 5C Lite use the same board design, only SoC is different, 
but there is no difference regarding PCIe functionality.

They have a PCIe 2.1 connector, and I've been testing a HAT with ASM2806 
via PCIe 2.1 connector.

> Does Rock 5C Lite work fine with the current code in mainline?
> (i.e. with bus enumeration when Link Up IRQ is triggered).

No, bus enumeration behind ASM2806 on ROCK 5C Lite (and any other 
RK358x-based boards I have) is not working with vanilla kernel.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 



