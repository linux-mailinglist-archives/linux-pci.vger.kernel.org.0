Return-Path: <linux-pci+bounces-29156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEDEAD0F31
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 21:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD6C16B46E
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32A1F09A5;
	Sat,  7 Jun 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i2ZLDNBY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FtQDDBJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425210E0;
	Sat,  7 Jun 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325693; cv=none; b=SHWwOjKinFaDaAzowCW7hJzPsv4i5/8kmPUD96KpGoL5kpvHuhFclQadjJSUI/zdHsYwmrIHFaapqBmX+5Z2p0CHjc5FIXYGi8sGh7o1yAzwwvYZqTqewwRj2cUrWaRbSrE5+IuGPPtY3Uz7e11DgrFKyWYEWNCk0/c4iFREpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325693; c=relaxed/simple;
	bh=NzbY2kpDrJH5m/WTJDJontOJDrPmXG/zsRgbkPywQ20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1UFSIyuSC01S3o3gx06UcsZc+QX3tsTc+ZzZxWgpqOKJzdx41uo63VDe2x7jeZJGjMPhQmtZ1PPt7RN1piIyerA3/JFrcc21FGJuKf410CXZCKP38B4Rl7tgkMlAKlI0xGa5WKXl6KjqLUWBm+ObfPShvmiXoueLC6SCt7nK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i2ZLDNBY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FtQDDBJb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bF7yd193xz9swm;
	Sat,  7 Jun 2025 21:48:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4+qbg4VKKcEc0U3nC8xRMAhLd7TNg+KH4tpuBORnbA=;
	b=i2ZLDNBY1FSdzQ7WiIVlTi80r8Kand1Bsafh7lhSzIHZGhRGfKrB6nJRRsgt+ksHpDS7hu
	Q6uHJD/DGV0wFKAByH2iTHYFGhHZJPPA0EZB9K/cEVQFRbCWBFCHLFOb5tB/qJYkBhZXdk
	hhHTk76ZFB7zb2JawNrsHBoVI7oPGe3MVCvIdi8dRmfJCSKVOEK5cYOnt3GfgJy/+R03UX
	enrkB7uOcrn002ilwboYukEGncNag0DvP/dI3ELXRr1DsP3Y8uH6dHtIN8h/6FcqMsB5mt
	6xGpeqYN6qm17rMAlUYeAWq+B0NP3kfDoilFT/sMZFMsWFjS6s/7NngzSZSZ6w==
Message-ID: <e4d82284-d6e3-49d0-856e-e347d9d0de55@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a4+qbg4VKKcEc0U3nC8xRMAhLd7TNg+KH4tpuBORnbA=;
	b=FtQDDBJbyUx0DnsjfGj2R/gJQ0dkSH0uBzfzH+8LZ2MvlReSEiXB7UtFq5d+8nIBgGgx+x
	oKD2VpFvk1ty3eNwtJ6OsUNg7GoalmXglRr8MvmNaAPBm1LqYguRH/G1RwjLbzFgz/d0vC
	9i2g92fqqxgcYOxyrErHPCTvFBCF2JhdxBJnwM/y/9jywPNwzvW5kGn53BU/rH7xC4/fhc
	jv7XclbHudvrC9pvV+OCGg4xND+QEceR9o3potBdaTmmhLhmnh/YEEPElmKh5UeTmlL4iv
	WvYFArsoCMhDF5qmO2XViQ3/DgtGQLp6EPUbjlJvoK8y+V8z2eLmtRRGmNAVsw==
Date: Sat, 7 Jun 2025 21:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Anand Moon <linux.amoon@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cjoza8k9ukqsd8hthc6b9ic7ttf1k4tp
X-MBO-RS-ID: dff85be7c5192f8ee3e

On 6/4/25 10:40 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> Thanks for your patch!
> 
> On Sat, 31 May 2025 at 00:55, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> Add the ability to enable optional slot clock into the pwrctrl driver.
>> This is used to enable slot clock in split-clock topologies, where the
>> PCIe host/controller supply and PCIe slot supply are not provided by
>> the same clock. The PCIe host/controller clock should be described in
>> the controller node as the controller clock, while the slot clock should
>> be described in controller bridge/slot subnode.
>>
>> Example DT snippet:
>> &pcicontroller {
>>      clocks = <&clk_dif 0>;             /* PCIe controller clock */
>>
>>      pci@0,0 {
>>          #address-cells = <3>;
>>          #size-cells = <2>;
>>          reg = <0x0 0x0 0x0 0x0 0x0>;
>>          compatible = "pciclass,0604";
>>          device_type = "pci";
>>          clocks = <&clk_dif 1>;         /* PCIe slot clock */
> 
> I assume this should be documented in
> dtschema/schemas/pci/pci-bus-common.yaml, too?
Patch posted:

https://lore.kernel.org/all/20250607194353.79124-1-marek.vasut+renesas@mailbox.org/

The rest is fixed in V3, thanks.

