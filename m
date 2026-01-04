Return-Path: <linux-pci+bounces-43977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6C9CF162B
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 22:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B8A93001012
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805726ED3E;
	Sun,  4 Jan 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jFrdP4FE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877F271448;
	Sun,  4 Jan 2026 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767563588; cv=none; b=I/72cojJJ0gLdQitRzYQ39a3fjmOPWAfpJifUp45T0yfLlTPDt4A4dhlxAUPDWU6+tYHYVRxtwJu64zYgq8rv+tit2a2rwfH8VaS4catOjOHEW+i1R4WAmvEcJTLdHtw3DKI7lC8ikC907y4VunglBFwSYmDh3jfuckwZ2IhyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767563588; c=relaxed/simple;
	bh=on8blvAzaMQU+la9G44LagH3TamZZotp6sMSVY4ItgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1SW6NzRKlrm2qPNt8b7lBuImcqRB/WEuL+4I6nGiwewOtfT3QvHqfe2x3JKc/583VJP2SJ18368AFOtE1WKKXGk/RpQIK4AUVOGbgUkElKusZjTwegpdhWyDxqvSB9Jo7rkHukmrIZhiVcxnWscNbz67caEJJI2LM36jkbw6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jFrdP4FE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dkrlM3hJQz9sxG;
	Sun,  4 Jan 2026 22:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767563583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YMDFpwLr1kyr69LUzeI3C7WeIPhGw0FJMoaI1I9RU8=;
	b=jFrdP4FEmu+/6gHtxilvlYUDyCpJK2DwLxqHPuNxFSN1kjl2IxMGrnGWsQhqHdUoFYHJ0i
	HGaQOkaWbrNC7XK3JYaCYUXBpdL1gDUWk2uOpJrMl23/2nkmhluLenTYxVnyCxcxzc8L1D
	fAMqp6+h7YvlSD29Mw7VFJYo8ls508wioi0a1oqVB329LEKBQyhOsCDIk/te+1diOP8jKy
	NloqIYFERi3ejDqMLUUDrfoJrhWNNKLLA9v9CTP/PmBkK8HhpCD7sPmd/mObh2A+ltB8MJ
	inrSKhUtcUQ9xmpSOPg/JFIfIqA+brAX6bAmF06x0CdE+K7elT6IxaVoh66wqA==
Message-ID: <1c5e028d-3362-4cb5-8469-0944bb6c6d1e@mailbox.org>
Date: Sun, 4 Jan 2026 22:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: controller: Mark controllers which cannot do
 lockless config access with !PCI_LOCKLESS_CONFIG
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian Bruel <christian.bruel@foss.st.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Inochi Amaoto <inochiama@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Mayank Rana <mayank.rana@oss.qualcomm.com>, Nam Cao <namcao@linutronix.de>,
 Rob Herring <robh@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250925135014.66865-1-marek.vasut+renesas@mailbox.org>
 <mxlpkktc34utdc6tr6apf4g5t3cdq6ckdbsern5s24t2bxlsva@e6e667l2wd2j>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <mxlpkktc34utdc6tr6apf4g5t3cdq6ckdbsern5s24t2bxlsva@e6e667l2wd2j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 040cdd0c77ba1a1f529
X-MBO-RS-META: 8dhnte56fqcsdrnzp7e8otfetj3ahfbk

On 10/17/25 12:33 PM, Manivannan Sadhasivam wrote:
> On Thu, Sep 25, 2025 at 03:49:45PM +0200, Marek Vasut wrote:
>> Add 'depends on !PCI_LOCKLESS_CONFIG' to controllers which cannot do config
>> access without PCI subsystem level spinlock.
> 
> May I know on what basis you have added the Kconfig dependency? Because, all
> non-x86 and um drivers are going to suffer from the race if PCI_LOCKLESS_CONFIG
> is selected. But you've only added the dependency to selected drivers.
Sorry for the late reply.

I added those !PCI_LOCKLESS_CONFIG to all controllers which I know are 
used on ARM/ARM64 where the locking is needed, to assure those systems 
won't accidentally have PCI_LOCKLESS_CONFIG=y which would break PCIe on 
them, and to indicate they require the !PCI_LOCKLESS_CONFIG is this is 
ever going to be enabled on non-x86 .

