Return-Path: <linux-pci+bounces-35527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18387B4568B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 13:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42875A730D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FAD34A31B;
	Fri,  5 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tjMHMEP5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fd6PWDUK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20534575B;
	Fri,  5 Sep 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072302; cv=none; b=oM8w0+WWX25Zq3CSauWXwe168D6uMRk8lTgLak3VHdm4Dyjq2z59oeczfqGWqDzGBdeXGwkflHFeob5xNvJivhTAPrYtUwkbzz5XU83fVg776zI4LMTOHTMtD3EaKMl91ntp1UOCIKapWsKGTx4bPcpJXZnXbPqqGeLo+ptvrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072302; c=relaxed/simple;
	bh=ZPns/E0T+dL+fbNArdsQk5euEzuxkfVAOLBxozxBLY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffAmlwkByYVObMkx8rUdqpv4XEvPfa5tq4Q7xzgYqmce184emx3pNGd7qQflHZ2Smc53sUGsouC3A0CAKCJ9HAbo1K2T7uvZ12rFQb8o0Q9kzujzjAYWQHQ2wCHWnKzKE/w83RkeLTe2690fje8X5CP6BW8Q9rL/0GID9yxf3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tjMHMEP5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fd6PWDUK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cJDqt1s2Pz9tQX;
	Fri,  5 Sep 2025 13:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757072298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO0EsRZEsZcP3glGTAz2xEr89JP4xqyMOHjX8yMhfU8=;
	b=tjMHMEP5jtD7Y7v1SWnelqbrqikZaazajTVqtUBLfrSuD3na08IoA4uevPStplw4+R3Dxh
	Ce+zCDD+0meTF7A28bXdnvh82zzKaePNXfv+7GmWTZ6Jwstq9GympmleEiL+E55A2m4M00
	bR1kKrirbS9n/p8d+rxfvqhfBH0s3m5sDavFUTXn9y4WDx8OXhAjOEGZr+aXhNKEKCjZj5
	FoJoHG/cdo3jpAXJykL0fGWZVI1Ts8+JHXWm3GfnmMsFoq1BKr8FCOloMJKP4hXtCFsTR6
	X+CC+QGrHesTC4K5X4sTmlPSx62+o88Ah8/sJTkeJuYJt8dEnrKKfFrlm6MyKQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fd6PWDUK;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a63db205-ca63-436e-a63a-871bb527f5b7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757072296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO0EsRZEsZcP3glGTAz2xEr89JP4xqyMOHjX8yMhfU8=;
	b=fd6PWDUKhkiEQPjTH4128iuIO1lbba42e041TZxj7wsffkJxYzPzhFTYjnCihr67gSm0Oo
	Dr6eKkM593P/wendrOeboFCwc01+LzCFoPVEycHBpMHeHWZhRhC8v+cxX6Anmbnlk0Hs9n
	btBpVkERjxRl+hVVISewP3QMxzF69SI29qf46myEEwyYXqug6jXrYjjjCnEgrT/1fui+hD
	1D81Q2rONy0m5qEBW8JiWRK5SfOBeXwxTN0ruTjW6AU7egh1l6XbuHP2QYalWY6bP9PkGl
	XP5HJb5DgUSYTbQ820CrVCkkVLXQ+LzpqjEvjG5mtU0SUQ7Dk3sVvZBcXQzKrQ==
Date: Fri, 5 Sep 2025 13:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Wang Jiang <jiangwang@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org> <aLmGBYOVevP5hH0X@ryzen>
 <62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org>
 <1jjz2d4a5f.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1jjz2d4a5f.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 57dep6m3kpc71wh6mtfwmq93y3wuf7rz
X-MBO-RS-ID: eec7c26669da71c3eb0
X-Rspamd-Queue-Id: 4cJDqt1s2Pz9tQX

On 9/5/25 9:43 AM, Jerome Brunet wrote:

Hello Jerome,

>>> pci_epf_alloc_space() works like this:
>>> If the user requests a BAR size that is smaller than the fixed-size BAR,
>>> it will allocate space matching the fixed-size.
>>> As in most cases, having a BAR larger than needed by an EPF driver is
>>> still acceptable.
>>> However, if the user requests a size larger than the fixed-size BAR,
>>> as in your case, we will return an error, as we cannot fulfill the
>>> user's request.
>>> I don't see any alternative other than your/Damien's proposal above.
>>> Unfortunately, all EPF drivers would probably need this same change.
>>
>> It seems that pci-epf-ntb and pci-epf-vntb only use BAR0 (BAR_CONFIG) and
>> BAR0+BAR1 (BAR_CONFIG and BAR_DB) , so those should be OK on this
>> controller. NVMe EPF also seems to use only BAR0 and it specifically
>> handles fixed size BAR. It seems everything that is in the tree so far
>> managed to sidestep hitting fixed-size BAR4 problems on this hardware,
>> except for the test driver.
> 
> As it stands, a vNTB device needs 3 BARs minimum (CFG, DB and MW). The
> NTB one may get away with with 2 BARs, with DB and MW sharing one.

I clearly missed the MW, thanks for pointing this out.

> If you referring to Renesas about that BAR4, I did use it for vNTB.
> It is indeed not upstream ... yet [1]
> 
> I think it is possible to have vNTB on 2 BARs with some tweaks, putting
> CFG and DB on the same one.
> 
> [1]: https://lore.kernel.org/r/20250702-ntb-rcar-support-v3-2-4268d9c85eb7@baylibre.com

Nitpick, commit message, "Renesas R-Car Gen4" (Gen3 has a different PCIe 
controller) . Please CC linux-renesas-soc@vger.kernel.org on V3 , thank 
you !

-- 
Best regards,
Marek Vasut

