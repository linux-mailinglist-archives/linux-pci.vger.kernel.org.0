Return-Path: <linux-pci+bounces-36692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07DB91FC2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C013A26DE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70322E8B76;
	Mon, 22 Sep 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T7d0QJbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CD2E8B74;
	Mon, 22 Sep 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555311; cv=none; b=S7LtmA4Ov+0/FHGvTO8Mued7T2OUtE+DevLeDyPdbB4WaDXr928hz2tB3Q4pkZl+a/X4cnBhfU7S0pnVN/OzQzbH0eCfUGa7upd8a4rHu2aEcpLzYzTMsU8tPm7xDpUIHEhcK5OGSWcG5hQO9T3zHV8K3IGKTGrM+AGIagQ6nwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555311; c=relaxed/simple;
	bh=wmmR/+z+QsQGMtHaPL0yg8jT+B/kfgHKxxpjI87hzZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANahMbpY34q8RuP2Zi78KrF/kFqyJBviG4ht4RLqOT5/kgIQ1B/pTLdDNBU0vTF7AUz6ykpqhQ+QDaaHFisGHAuYOCxPGzBx+o5xhMmKd71hK1Oems/KwFVVbJre2+qNdqPZtBqeJxGGuG0ldZbmhfOqhjHJxKAh0jVv+c8dr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=T7d0QJbE; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cVnH74Snyz9syv;
	Mon, 22 Sep 2025 17:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758555300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFDDMAR85SuJgvV8n5YjG/JVQ1JyR0LrG+f32oAtf30=;
	b=T7d0QJbEOS09wtyCptmeP3a+4pgzxCQt+eLYJ/qSqMsAkHM2lI5osnhdGNkkk4DcwPyn4P
	pHo5CxIaVsziZ3cwwbacseU+vA6CZxutS/8uDbm6nlBVLYlo9d8P1FDkyGIb8S4bErAVPc
	fz1p0fdg+abXmB7tudc7fGIbHpQDyRfu/BaOnAXt9Hsi0fl5wSO9cNd7QfbS2QBs/ejTyV
	ohx1HDN7Q8hVBtMFxtx1eOZXBDvPZ/x7p8HrPBOtEzWRJEReYEPdsNipySptyxtgfB7A5Q
	Gc2QmhgJ3ARRBnmtIbysB3d6GsKGl/fmcbOPVj2Y2Kqcom6pBdLWmOLnlsRHGQ==
Message-ID: <cff1aa88-d5d0-4b06-9a0b-c39d5b70d0ca@mailbox.org>
Date: Mon, 22 Sep 2025 17:34:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
 <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
 <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: i5mtncn76bsbi9f6igbnjnbypgcrozmc
X-MBO-RS-ID: c731b648d64e4b13f54

On 9/22/25 12:53 PM, Geert Uytterhoeven wrote:

Hello Geert,

>>> My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
>>> one day, breaking your assumptions.  IMHO, the mechanism behind this
>>> config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
>>> Kconfig option for lockless config space accessors") looks very fragile
>>> to me: it is intended to be selected by an architecture, if "all" low
>>> level PCI configuration space accessors use their own serialization or
>>> can operate completely lockless.  Usually we use the safer, inverted
>>> approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
>>> do not adhere to the assumption.
>>> But perhaps I am missing something, and this does not depend on
>>> individual PCIe host drivers?
>>>
>>> Regardless, improving that is clearly out-of-scope for this patch...
>>
>> I could send a follow up patch which would add build-time assertion that
>> PCI_LOCKLESS_CONFIG must not be selected for this driver to work. Would
>> that be an option ?
> 
> Or simply just "depends on !CONFIG_PCI_LOCKLESS_CONFIG"?
> What do the PCIe maintainers think?
I send a patch in the meantime:

[PATCH] PCI: rcar-host: Add static assertion to check !PCI_LOCKLESS_CONFIG

