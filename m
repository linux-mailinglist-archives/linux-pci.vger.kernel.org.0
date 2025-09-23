Return-Path: <linux-pci+bounces-36822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD4B97CF7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3892E785F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 23:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4430F942;
	Tue, 23 Sep 2025 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k1oUZo7v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OianGu9j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A017A5BE;
	Tue, 23 Sep 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670958; cv=none; b=q/TcolVzlqa/a8fN6KpotChfSqBw27mMKBJlFdBAL+9RIc0gGZy/t3G4sMr5Gk1t/IAG8hIrZh8yLoCA3H/Bekmk/db98iB1QeDanoz3GvFk4XvwMnUBep+RrsSM9obkrFDsUUDFf5nPW3jSaJCkuC7SGSNCX/qFxlr8uZ0w/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670958; c=relaxed/simple;
	bh=zQbD8DNnhInHmxj6cJ/kQbwd1SEYY4Ub6EuQKSRTR9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BjTYwLL77G+asE6pTL8GxvhLlI0gqf4nW/dDndIj+3E767vAR+MvCoWF/0GMn0jJskh0FO7qKAWZQOWV1D60epb0IZ8S9IClAayq8I8eciLiLWQnydA95GNCDMg7dmCt4GeufTU/SCCTKid3kqLA0P91AOwCCEcy7pgFUCtf9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k1oUZo7v; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OianGu9j; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cWc391br4z9smg;
	Wed, 24 Sep 2025 01:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758670949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0tO2Xj2ANtxwUz+K9Ts0AqWNrmWxz9Ns88vd8fr+ts=;
	b=k1oUZo7vwaAYqHE2CEIx3dVHc4tk0T6oYNWU7yIYgdQz1zpAVwpck/PuRylQiamWRSEPd2
	xxmRf/QU/tFBANWR2qOCEw66GKIuKbimsi04I+pgbh2BhmjCua+wsIe7etD4owl5keueJE
	Rk2ZtTW0UinZ+3itlURW9GtKO3WBFAOaXekl9tJaT1YBM+izDu8hIYkrkIXsbUaCoU8X/4
	3ySpkGBiM59Nlg7fw3B8elyHPMkRTYTps6bvFjvRVRAcGS7Pbx0LZ9CM4JTJ1OVQu6FJCo
	3RygT9bAaneSr7UR6xPEAZ4epgaUysD7QrYa6x6c73wvIpAAvfr9sFaOAmt/IQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OianGu9j;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c1da4b74-0fd0-437a-88da-c31c681b6c5d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758670947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0tO2Xj2ANtxwUz+K9Ts0AqWNrmWxz9Ns88vd8fr+ts=;
	b=OianGu9jHaLhKjjXNf1fTjhbivWz7aNm/Y6mKQBB/7V3CswSDOAHWxrzpEkU2h0Id//Sk7
	17t6eboiPbGpQ2yfwf01wy0E9/gLD4qmg4lV1pqFrV+bP3LshOWUKbT7E53GYPVUdCPBIp
	U01Mau4bxeKZIQOd2S5+QoeuukRsTu60F6vNKQV64vlt0lZ9vtPWN/j8hF2W8OumyyCFwf
	yrIF9TV3r06qpbo9wqGsRtdIgX7vbMRIxRw/JcmL1jbDcZiiiiTi+BbZ6c+Ace6cq9RYum
	Fom7IQPEq6J1rrLWzVhgqHjFWL8VtJgEb1pVncP/Hrarhn/b5zcq0fnIsKu6cg==
Date: Wed, 24 Sep 2025 01:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
From: Marek Vasut <marek.vasut@mailbox.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
 <974b6f7f-e769-48ff-9bd9-0ed0c8f48b1e@mailbox.org>
Content-Language: en-US
In-Reply-To: <974b6f7f-e769-48ff-9bd9-0ed0c8f48b1e@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ffada4ad991afe6718a
X-MBO-RS-META: nwjtf1iw9sxucig7h1wrcutk8mbxmfut
X-Rspamd-Queue-Id: 4cWc391br4z9smg

On 9/22/25 5:48 PM, Marek Vasut wrote:

Hello Geert,

>>> +/*
>>> + * This driver can not function correctly without PCIe subsystem level
>>> + * config space access serialization. In case PCI_LOCKLESS_CONFIG is
>>> + * ever enabled on ARM, complain loudly so the driver can be updated
>>> + * accordingly.
>>> + */
>>> +static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
>>> +
>>>   struct rcar_msi {
>>>          DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>>>          struct irq_domain *domain;
>>
>> This causes a build failure when compile-testing, e.g. x86 allmodconfig.
>> Using "depends on !PCI_LOCKLESS_CONFIG" instead would avoid that,
>> but indeed has the disadvantage that it wouldn't complain loudly when
>> PCI_LOCKLESS_CONFIG would ever be enabled on ARM64...
> All right, let's also wait for input from PCI maintainers. It seems both 
> alternatives -- static_assert() and !PCI_LOCKLESS_CONFIG have their own 
> disadvantages, maybe there is a third option.

Maybe we can try with both.

-- 
Best regards,
Marek Vasut

