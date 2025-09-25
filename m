Return-Path: <linux-pci+bounces-36959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C33B9FAB2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655A716CC3C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F5285C99;
	Thu, 25 Sep 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cFH2JIgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B162857E0;
	Thu, 25 Sep 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808300; cv=none; b=pSpQ3vBfF7gdcpTvN7SDc1wASQTT0/FjwUu+xF65vOqB8LPieGRS+Ou3lPkaviAftfXIuV+iE40QrhTbPvcQwxlU2kOh2sPesJHnzOyKP33gdcehgPgyKuerakJuhenYePsCu2JQHCPFdbnfbQnbQ1XKm63/9fc6Geaez3jhTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808300; c=relaxed/simple;
	bh=7FOgkvPEVFvHSY6hM/MXtsvWwWlIh/rDe96Ph55s3+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVZiEbVYh+Qr8HsuZquceeWDSJa3us/XaP8H3/vpMY/XLLc1T7x17aJaADIq8Jx9L83ikTA1i5RzRXk39hHOFe++S0EoyviwUsf5QXJWztzCCn+pAWPqOBVH7oPQ/zYRQM8bomFD6lg8a88CgcGEUmcpb8aP5oCuqt39iassbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cFH2JIgg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cXZrR16t1z9t1q;
	Thu, 25 Sep 2025 15:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758808295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmBHdSzcnzvZsnXY5Q9rMzWlKRDhxC8ATS01bHnMLaM=;
	b=cFH2JIgg9T6q2pL4VcFHsDJgLtWj7ieoOtqlvAqvIiRlp7doyAcDgHVAqNe8kErSDjK4fD
	p8DIiAHu1iYwi/kg1CAQkvIozTp+ZhKyIvPhoTy46yzEzt07Y3H1JjfPkr6xLoqxNFBx7r
	s5TKZyDbgceeIQOHekzeHU/swEtto9DbY6FxxGa1zy9OT49m5jh61Y7P/AVz0TU3A0BYaJ
	xl/y0uC4Jt6+Nr1PYTzFyfkWfQtB2/7dmUjL6JQgx6jmYvaUt3ZWg4KuOVcgOZIIZ6DRwG
	ULR5UbUT3CpmUTWB9HFo6fERH5gMs4yvhNs8Lw+/zWY+4ZkLbpKpn4RgjK3ung==
Message-ID: <29ee0c03-d1d9-44f9-bdde-5c336459b097@mailbox.org>
Date: Thu, 25 Sep 2025 15:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>
 <ebcvi2mput6dyx5omlcvapjt6mwzrpq4h6c4o3kyfdxfrin35x@d75pxu652f6u>
 <85a97019-2f80-4104-b27a-6578612af1e4@mailbox.org>
 <mc5sglju5r7zubnnuzmnl6nf2t5xdz7x6rqbx26dnl5hzvnyhi@ydp767j7gqx5>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <mc5sglju5r7zubnnuzmnl6nf2t5xdz7x6rqbx26dnl5hzvnyhi@ydp767j7gqx5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 21d77f7660fcf8238b8
X-MBO-RS-META: jrqdj3j9gydzh1ru6f6cfw78wdqkneyi

On 9/24/25 6:00 AM, Manivannan Sadhasivam wrote:
> On Wed, Sep 24, 2025 at 05:34:55AM +0200, Marek Vasut wrote:
>> Hello Manivannan,
>>
>> On 9/24/25 5:25 AM, Manivannan Sadhasivam wrote:
>>> On Wed, Sep 24, 2025 at 01:46:18AM +0200, Marek Vasut wrote:
>>>> This driver can not function correctly without PCIe subsystem level
>>>> config space access serialization. In case PCI_LOCKLESS_CONFIG is
>>>> ever enabled on ARM, complain loudly so the driver can be updated
>>>> accordingly.
>>>>
>>>
>>> This limitation applies to almost all host controller drivers except those used
>>> on Intel platforms like VMD and Hyper-V. So this would require adding the
>>> Kconfig dependency for all those, not just for RCAR.
>>
>> Correct.
>>
>>> We could also add the dependency to the arch Kconfig, but there is still a
>>> possibility that if the driver is used on a platform selecting
>>> PCI_LOCKLESS_CONFIG, it would be broken silently. So adding the dependency to
>>> the individual drivers that suffer from the limitation seems to be the right
>>> thing to do.
>>
>> Would you like me to send a few more patches which add !PCI_LOCKLESS_CONFIG
>> into per-driver Kconfig entries, at least for drivers where I am sure they
>> suffer from this currently hypothetical issue ...
>>
> 
> Sure.
> 
>>> Also, I'm not in favor of adding static_assert with Kconfig dependency in place.
>> ... and drop the static assert ?
>>
>> Then the drivers would at least be marked accordingly.
> 
> Yes. Better than what we have currently.
This is now done in

[PATCH] PCI: controller: Mark controllers which cannot do lockless 
config access with !PCI_LOCKLESS_CONFIG

I hope I got all of them.

