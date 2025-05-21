Return-Path: <linux-pci+bounces-28232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCFABFBFB
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836363B2714
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645222E3E1;
	Wed, 21 May 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r01JRbUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987D1A8403;
	Wed, 21 May 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847197; cv=none; b=gSceO4uzPqe6UsXznyRZUzoYxnKJj3gBlFQQt2pjytYriEnqcVwnkp3cuup0oq6cGik1vTQTD3HMHqYsFYERmTnYEkgPRz4Vahs+KGvJXE3oGQrx+A7QapVthXP2Rzf0XFpjmM/qPGPjaZOBT3dpOu1CvjdAn4ZY01Ooi/zviQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847197; c=relaxed/simple;
	bh=hYn0fJc3B185GRX9S0qOZAmJxBeIIFnTmv2WcGFR96A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsUxqXMcja87zaxFuFDp04X4M649yEaEWXgEdpTMrQnIKhEqwVGTHbkjwT5gL3+uu1+G2kS3lyfGHcLNRb9kTBkPafnM2cPSoXxmIijzPbSqhlCYszrLODkHEOqEARTPvEdRVryk1xpKbgM/8dJqk9GpSm3csnscbBDfKmOi9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r01JRbUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B3C4CEE4;
	Wed, 21 May 2025 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847196;
	bh=hYn0fJc3B185GRX9S0qOZAmJxBeIIFnTmv2WcGFR96A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r01JRbUEDS6u9IExFMpktm11lL6Vf/ma0GAI+TLjgeUJFFBMymJETjSi0JmDAVn3F
	 4Kxy/a7K1zK62DDst27AzZDKbIjPk5s/8EkcaWp75tLeUrSR6mqDOPl60FXDEUHGRa
	 i0BKQEwxrewCNcoWIOD7fWsRfEy1wmqzHF16zUHA9+WHhGOjyK1NhrTe3HyL0i3Fuu
	 X+gKRkjMBSDxCQsZcsUTdWg4lYKG8bLYpMqix1Pzj7ZKeX6+YreNcnMyWY6RRTXVoS
	 /YHS29yaYKWfJG0T0Ayly9an/vN7PBgJDTD9+LXpxS211nmb900bUxtpg+CYzMWxV9
	 4c5cLd2AcTCfQ==
Message-ID: <6bddf9bb-0c57-4823-bef1-e5bdf16ef5f7@kernel.org>
Date: Wed, 21 May 2025 12:06:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Lukas Wunner <lukas@wunner.de>, Denis Benato <benato.denis96@gmail.com>
Cc: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 aravind.iddamsetty@linux.intel.com
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com> <aC3XiuOPVYB2EX18@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aC3XiuOPVYB2EX18@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 08:39, Lukas Wunner wrote:
> On Tue, May 20, 2025 at 07:22:04PM +0200, Denis Benato wrote:
>> This is the very same exact kernel, minus the patch in question:
>> https://pastebin.com/rwMYgG7C
>>
>> Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
> 
> This log excerpt shows that the ASMedia Thunderbolt controller
> below the Intel Thunderbolt controller couldn't be enumerated
> on boot:
> 
> mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: broken device, retraining non-functional downstream link at 2.5GT/s
> mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: retraining failed
> 
> However, the Thunderbolt tunnel goes up and the devices are
> enumerated 24 seconds later:
> 
> mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Card present
> mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Link Up
> 
> Thanks,
> 
> Lukas

Are you suggesting that the training failure is why there was an error?

If so maybe that should be cleared when it does eventually train.

