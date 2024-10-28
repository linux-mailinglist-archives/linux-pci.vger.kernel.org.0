Return-Path: <linux-pci+bounces-15482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E729B39D2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BDEB21820
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035C1DFDA8;
	Mon, 28 Oct 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="F6gb8mek"
X-Original-To: linux-pci@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07E1DF269;
	Mon, 28 Oct 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141941; cv=none; b=UE9kKO4ibte4gSAVebbJvCaML5DIH8Ld/5KrZWySIfePvBuovR2HdjGGDr5pSPrKXCrGnvexDhlYBopBVarRL6waQbdOvdZdz/9KbmvWSN8PFn4c5Rn47P+wTCB90W0+G0Zdu7dSkkvDgWUAjcRapY7Hi+6/dtK+moEmeDh9Yl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141941; c=relaxed/simple;
	bh=8WGafjVya077ILDXHhSSvM5YhVRBuyPpmORE/9ykOCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEMPJarT87n3laO+EVN4NLvJHkyT5incRHpOt/Ri0eXW/j9xPihNrBobFTz2l3r3P9thguCNT/EOZ6vTbR3H1PkABsgDp4TB8TQLipVxQfG0M+qAL2tL77JsrRN6hhRjEF0Wvr/6LrTnW9WnHZYMDm/V/VvLyA0Bdgw6Wjg5NjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=F6gb8mek; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 358858910C;
	Mon, 28 Oct 2024 19:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730141931;
	bh=xh/GaRY+S5pcuyrQRU2xRgm2fWL9H46nXW1L/svE3qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6gb8mektYwkf0MT4BocRTHfT9GteUxFyFg3u8umCoJxO+nXwbbCZZTpRwZR3ZNbD
	 ygxH1lt2tFgUhY8Qm9eMg3xgeZMFIAHa3bPlrI/ICmcn99WO8x8EVczGJJdrUjf2tZ
	 C1HZ1wk0fYSs1XICEEY4XDyNbpdikHIVqxabPnkoCLsmxfjLFXsNPMyESJJZAPWbq4
	 9HKd2Ru2lmtfsQLxpV/YXDw4BuOtw5Vwnztm5B8C7kI3d4u11ZYEYbHK2roS8+JeBG
	 v34DEM5EvddxMBlWkYf2wwPErhPOEMNIuulQEUuiPoSvXaSWuG5pznyazHV96MCSeL
	 /cWmJQfWPA5wQ==
Message-ID: <6b47cc49-dd3b-4c4f-827d-f9b3a8719eb9@denx.de>
Date: Mon, 28 Oct 2024 19:25:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20241012004857.218874-1-marex@denx.de>
 <ZwupHAAwTo5mDyyA@wunner.de> <52b90ab1-2759-45e9-ae86-3d3073a0add0@denx.de>
 <7ad59d82-8122-438e-9682-791816ab0366@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7ad59d82-8122-438e-9682-791816ab0366@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/28/24 6:52 PM, Wysocki, Rafael J wrote:
> On 10/26/2024 2:19 AM, Marek Vasut wrote:
>> On 10/13/24 1:03 PM, Lukas Wunner wrote:
>>> On Sat, Oct 12, 2024 at 02:48:48AM +0200, Marek Vasut wrote:
>>>> The pci_host_probe() does reallocate BARs for devices which start up 
>>>> with
>>>> uninitialized BAR addresses set to 0 by calling 
>>>> pci_bus_assign_resources(),
>>>> which updates the device config space content.
>>>>
>>>> At the same time, pci_pm_runtime_suspend() triggers pci_save_state() 
>>>> for
>>>> all devices which do not have drivers assigned to them to store current
>>>> content of their config space registers.
> 
> What exactly do you mean by "at the same time"?
I mean these two blocks of code run in parallel and likely race each other.

