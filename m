Return-Path: <linux-pci+bounces-25062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63904A77927
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF723A964E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E31F130B;
	Tue,  1 Apr 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i3vlB+BU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E286353;
	Tue,  1 Apr 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504927; cv=none; b=NKRic1w1Ijssr11yr+8sMWWHLs271reawDVdq2KW0bqNnyL2VmHCM7T8oOfd2Q7bI4e0zQ15fzcA8XUcOtnc8Sm4XRY04bAhji6P7n1c16aD9zTc9VSrOnWF1mquyQ1z0CuK0OtqeZ8Th2dkmD3AU7mqpei/LtF4UY2Hm+vLiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504927; c=relaxed/simple;
	bh=z2WSV4DlWcLPlyFbtutl1o1PrtF6Re6sVS35e/QuNHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5bV3Eozy4ILzjJgLGjFj6wXqDZeTjfoQyWZvcr6oZ6HIkXx9fW3xZkZgNpV+fKiOpkolOevWAYdJUs1olVBDJQHUWcxcxsmhY+H7H4v/CjMbGFtDmg7bT8KZBU4raDug8TNpIWcxH0qq10JwILN6N6Ir3RVsIMLyOV8w51kXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i3vlB+BU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZRlJh4CLCz9vLr;
	Tue,  1 Apr 2025 12:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743504916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLorxfawL86gg2F0j4j9NdXyKB8vOPzbGPbfhg6XtTk=;
	b=i3vlB+BUBdIW+HJlb1QX1OsRPtMkKNXmYaJ6lS2LjLNfIrZY+7e2fD4WJ6hZmB/Mx8/MWO
	I0QtIOYjGwP3bqeJXf4+L8VWfchRaO3/3tnoBcuUNfMh9eBypBoDARlzuRRr0NMwq48PaT
	2LYD3CDEkSIhMNDpWDLDqKk3ZpEQuo3xeSzRU3EiGMuEGo7UssKrX1AXON1+4VZPrBBYM6
	coylh8qZU1NX9MZF3c3I9xThLc4Cvsef62nMzfzr/t1CsShKyIRSfCtkJMgyevdcDSf36M
	/VssBue1vxqPzqz25JsMhoZgIuylCsGUZ4v0fe6ynR3TeNgfvGDWO+pYdRFQSA==
Message-ID: <43a1986e-3ccd-4fd5-9dcf-9ad945a99293@mailbox.org>
Date: Tue, 1 Apr 2025 12:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H
 Sparrow Hawk board support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84sk?=
 =?UTF-8?Q?i?= <kw@linux.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
 Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUx31WHW+fUP0Qbfs-Si2+cLmxC=YRUKWvSudn7CBZ4Fg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUx31WHW+fUP0Qbfs-Si2+cLmxC=YRUKWvSudn7CBZ4Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0780a5cab02defaccda
X-MBO-RS-META: xj3qjesq94bd8gfmzt53ziqwbmtebsmm

On 4/1/25 11:49 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

>> +               spi0 = &rpc;
> 
> Do you need the spi0 alias?

Yes, it is used by U-Boot to enumerate SPI controllers.

The rest is fixed in V2, thanks !

-- 
Best regards,
Marek Vasut

