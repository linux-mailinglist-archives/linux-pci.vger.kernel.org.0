Return-Path: <linux-pci+bounces-38180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE0BDD92C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AB91920E8A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870E31A065;
	Wed, 15 Oct 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Mz2JIfLy"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462231A059;
	Wed, 15 Oct 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518768; cv=none; b=j5AlNkEgWCiCb7Gt9cstxd2ZuSkm0Sj/AXaA2TBI+sRBCg0mB8NbkW1TtmU3v6UxBhxC9TgXzk4zkcIwQ+iNZUYwhSofbfbj7b3HHx+zMb+w9m1E305xuowpK8vNuU1p/miDD2fg6aAec0xftnqAx3HMB940kCVtgjnBCRMh8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518768; c=relaxed/simple;
	bh=FhSMyl4w4nMUmZ/ooeWLYdkz987VgtI9XmryqjAPbqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNkOImTLGrMRlbTvDVPX4nQ3JKSqWUn7wm/t26XMpNm/OW7IPd0FOAJjIrBZmjYS8i4goV8O8RnMXfd1mU//x28WpBvD4vg6X5Ly7hgW6Q3hoXB7dhMPb+7niw7w0CqyZa9cRH8Ras6jaMATJ2MoLLPy2SXLeR9EuSPAoQoe76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Mz2JIfLy; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 2639720112;
	Wed, 15 Oct 2025 08:59:19 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 1108B3E917;
	Wed, 15 Oct 2025 08:59:11 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id C406D40099;
	Wed, 15 Oct 2025 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1760518748; bh=FhSMyl4w4nMUmZ/ooeWLYdkz987VgtI9XmryqjAPbqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mz2JIfLy3mmf+zltTznP1Q+ZrFDQFmBEmsQCXapdoWGz38J/ImAuMFcolU7TYlnvj
	 y5zz17BA3j8BMwp03UpwjDFK8TuIJttqYBHrdbVKUA5rO47xViJPwRBrRvGGqLs2Vt
	 6ZoXfxeR+IrKf/1qOb1N0wcbbCsCBGwfOi6Fepj0=
Received: from [198.18.0.1] (unknown [223.76.243.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 487DE41420;
	Wed, 15 Oct 2025 08:59:02 +0000 (UTC)
Message-ID: <a8739f95-681c-406a-9f61-a1a171db99c5@aosc.io>
Date: Wed, 15 Oct 2025 16:58:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Add DWMAC glue driver for Motorcomm YT6801
To: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Frank <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
 Furong Xu <0x1207@gmail.com>, Xi Ruoyao <xry111@xry111.site>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251014164746.50696-2-ziyao@disroot.org>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20251014164746.50696-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C406D40099
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[kernel,netdev];
	FREEMAIL_TO(0.00)[disroot.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,gmail.com,armlinux.org.uk,nxp.com,linux.intel.com,csie.org,xry111.site,aosc.io];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[hua.aosc.io:server fail,jeffbai.aosc.io:server fail,xry111.xry111.site:server fail];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Yao,

在 2025/10/15 00:47, Yao Zi 写道:
> This series adds glue driver for Motorcomm YT6801 PCIe ethernet
> controller, which is considered mostly compatible with DWMAC-4 IP by
> inspecting the register layout[1]. It integrates a Motorcomm YT8531S PHY
> (confirmed by reading PHY ID) and GMII is used to connect the PHY to
> MAC[2].
> 
> The initialization logic of the MAC is mostly based on previous upstream
> effort for the controller[3] and the Deepin-maintained downstream Linux
> driver[4] licensed under GPL-2.0 according to its SPDX headers. However,
> this series is a completely re-write of the previous patch series,
> utilizing the existing DWMAC4 driver and introducing a glue driver only.
> 
> This series only aims to add basic networking functions for the
> controller, features like WoL, RSS and LED control are omitted for now.
> Testing is done on Loongson 3A5000 machine. Through a local GbE switch,
> it reaches 871Mbps (TX)/942Mbps (RX) on average,

We (along with Xi Ruoyao and Runhua He) tested this patchset against 
v6.18-rc1 on the following platforms featuring YT6801:

- Loongson XA61201 (LoongArch, Loongson 3A6000-HV)
- Loongson AC612A0_V1.1 (LoongArch, Loongson 3C6000/S)
- Loongson XB612B0_V1.1 (LoongArch, Loongson 3B6000)
- MECHREVO WUJIE14-GX4HRXL (x86-64)

With performance within expectation and S3/reboot working. Both ports 
work on those with two interfaces (AC612A0_V1.1 and XB612B0_V1.1). LED 
indicators do not seem to work properly at this moment, but this was 
already described in your original email.

With that:

Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Runhua He <hua@aosc.io>
Tested-by: Xi Ruoyao <xry111@xry111.site>

Best Regards,
Mingcong Bai

