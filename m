Return-Path: <linux-pci+bounces-26303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB8A94731
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D593A69FE
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC51E4110;
	Sun, 20 Apr 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKEcs2kw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49F1AF0BB;
	Sun, 20 Apr 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745137968; cv=none; b=mGlDQ54OXMWLvUWRrvbk74o2GVgyEsP7Q4Sg9o0bkqFVglUVA6xAShpAG6xrXJ0ftvs6s8TNOIuJU6vEsFoUGfdt8LWCFDiorCUHW0xP3gZKPmpi+aXGkDz07eO+9zVBKbFqF4vbkVUfJbijlsUdSNJvFHzxel7vJmsMQVmu3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745137968; c=relaxed/simple;
	bh=kAmsi9vTZz9AUiyiRwQ3MR3WqPY6jashPoegxjXEDQY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HPgpXKotjcmYvytJPpvn5/hLciwsAP7SPlDH0m/WuLQe71HJMn2a4Hg8x49hrEzdy1fa2a0HQp7l9djlWYi0Tzojtp5h/xm7RqWtQ3zHxV6jAS6SNCl9rLcxbF5fOc35JanUldORTrrNWsyTMcPWxfI5UasyvY+C1CJ3Gg5uPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKEcs2kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49FBC4CEE9;
	Sun, 20 Apr 2025 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745137967;
	bh=kAmsi9vTZz9AUiyiRwQ3MR3WqPY6jashPoegxjXEDQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKEcs2kwrzlBJsO7VUvTe2aQA8KXyJjyftpIOqKWU/GiO6ixfYLiIaZ94DYhOXl6g
	 Cu1rr4/wtzqQF9dDHu7oD1FAuQgfJIXpOkR8dXg9b6Rh6YPwCYHTh8Y8mHVaKjTBwN
	 8Nfzv8vp+dvRQeq533NVdSbKCI5OoHG6oU4vNmOWmMkVE4ty7r/GV8HfYKgs/9iztA
	 /MARa+CxO/Xt4icMksK9Cpp0y6q0fWB6FiqCDaYVokMf6DKzQVfCNqTtG43QbHDdtr
	 s4ehE/IvoAj8Ia2eXXnFMD3ROPv2FCo/rjGg2C4DtpxxhWz/VCW96yTd19CnUKsCvB
	 HH6WVi/McvbzQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u6Q6X-0075f9-1p;
	Sun, 20 Apr 2025 09:32:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Apr 2025 09:32:44 +0100
From: Marc Zyngier <maz@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne
 Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, Sven Peter
 <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 00/13] PCI: apple: Add support for t6020
In-Reply-To: <174507447951.53343.12422475035572217541.b4-ty@linaro.org>
References: <20250401091713.2765724-1-maz@kernel.org>
 <174507447951.53343.12422475035572217541.b4-ty@linaro.org>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <8be207b47f7e0f2d5e6381c74b0f4a6c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: manivannan.sadhasivam@linaro.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2025-04-19 15:59, Manivannan Sadhasivam wrote:
> On Tue, 01 Apr 2025 10:17:00 +0100, Marc Zyngier wrote:
>> As Alyssa didn't have the bandwidth to deal with this series, I have
>> taken it over. All bugs are therefore mine.
>> 
>> The initial series [1] stated:
>> 
>> "This series adds T6020 support to the Apple PCIe controller. Mostly
>>  Apple shuffled registers around (presumably to accommodate the larger
>>  configurations on those machines). So there's a bit of churn here but
>>  not too much in the way of functional changes."
>> 
>> [...]
> 
> Applied, thanks!
> 
> [01/13] PCI: apple: Set only available ports up
>         commit: 751bec089c4eed486578994abd2c5395f08d0302
> [02/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
>         commit: 6b7f49be74758a60b760d6c19a48f65a23511dbe
> [03/13] PCI: host-generic: Extract an ecam bridge creation helper from
> pci_host_common_probe()
>         commit: 03d6077605a24f6097681f7938820ac93068115e
> [04/13] PCI: ecam: Allow cfg->priv to be pre-populated from the root 
> port device
>         commit: f998e79b80da3d4f1756d3289f63289fb833f860
> [05/13] PCI: apple: Move over to standalone probing
>         commit: cf3120fe852f5a5ff896aa3b2b6a0dfd9676ac31
> [06/13] PCI: apple: Dynamically allocate RID-to_SID bitmap
>         commit: d5d64a71ec55235810b4ef8256c7f400b24d7ce8
> [07/13] PCI: apple: Move away from INTMSK{SET,CLR} for INTx and
> private interrupts
>         commit: 0dcb32f3e12e56f5f3bc659195e5691acbfb299d
> [08/13] PCI: apple: Fix missing OF node reference in 
> apple_pcie_setup_port
>         commit: 02a982baee109180da03bb8e7e89cf63f0232f93
> [09/13] PCI: apple: Move port PHY registers to their own reg items
>         commit: 5da38e665ad59b15e4b8788d4c695c64f13a53e7
> [10/13] PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
>         commit: 3add0420d2574344fc2b29d70cfde25bd9d67d47
> [11/13] PCI: apple: Use gpiod_set_value_cansleep in probe flow
>         commit: 484af093984c35773ee01067b8cea440c5d7e78c
> [12/13] PCI: apple: Abstract register offsets via a SoC-specific 
> structure
>         commit: 0643c963ed0f902e94b813fdcbf97cbea48a6d1a
> [13/13] PCI: apple: Add T602x PCIe support
>         commit: f80bfbf4f11758c9e1817f543cd97e66c449d1b4
> 
> I've fixed some trivial conflicts while applying. But please check the 
> end
> result to make sure I didn't mess up:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/apple

I did my own rebase and came up with similar resolutions. The result
booted on my M2-pro mini without issue, so it looks OK to me.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

