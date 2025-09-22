Return-Path: <linux-pci+bounces-36694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3356FB920B5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D07F7A4DEF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C22ED870;
	Mon, 22 Sep 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tn0LHe/y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DeoDfLbQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BA24DCEF;
	Mon, 22 Sep 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556129; cv=none; b=CeB0mYmLwmlBPIbOoWoYC7M49NFd9xfPTrg4zX/EU5OUt5EXebt1WV4OwTeWxXfHrt8uBVhMpSom0T8fWyyr4pJOWIADJh4cuHvR4+UCzvyWNLStnNSU+exj6iV9zhSrVMOkZ4wBRzdEEXt0Cxd/ORmCDAkPboJdGM9xmBWDMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556129; c=relaxed/simple;
	bh=kBy0R6qsAf01w8d8qiO7eIAukjvrsyPyscspc7cKOsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZZZps/W83LgaFi8+PqhLB1P1tPZ1DF2d9i9vq/Y8vz/Kp6DFBEC7m8GnKqnrBhRAaBmOThzyuxJ09IKQaeisaW2iIVAhCBoggBsdLJ9c3IRX870GxCbhnvFS4G5wEVqFnxfsL9ERYQ+smdvkTh3wmsjXamfYdY55PkPgFytclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tn0LHe/y; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DeoDfLbQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cVnb14Q3sz9tLy;
	Mon, 22 Sep 2025 17:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758556125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5sibm9aKqkELGV5S3+do/9O9uWTDA7wayVwb+b4la8=;
	b=tn0LHe/y8tgn+h6jyaS6pAOtpiCf6IWGKFbOyCvizZkXq04DnoGWJO5UR6RXHkY+jtDVb4
	w1KLqSYyiz8/RSNliAnwx6BV9uokqZrunECRtCvzXodVKfc+hTI7BZXoQVRp2N7O/Vp+q4
	5MbLckX85tqMQm8sY7ixccLk3xkhWMOwhOl/2cZJtBxsOOaszRqLYggAtNStC40RSvS4nE
	48O3FKMszQX3i0elUdEnuJiqY0oQD7+Te96B+yS9f97GHiVmN9E7O4XFCwnMeS8p/r/iIg
	ZHkG17WL3cnhqaV3E0GaI5Fxd22KsJ3SgMNvQxu2Obd79dwwyVrsojC5nTZ3WA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DeoDfLbQ;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <974b6f7f-e769-48ff-9bd9-0ed0c8f48b1e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758556123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5sibm9aKqkELGV5S3+do/9O9uWTDA7wayVwb+b4la8=;
	b=DeoDfLbQVsfgLz52qytCsVpTrmezqE03QWwrljfq80vx8G6d0NQ8hrVIg57Oh5M3HP6NLQ
	w5yfmfbyGazNFzj+pH+L4CP02Pc1I+/QSgnhhnuZqf/bzxYORyg/HY5eBFA7/WqeSpPFmW
	16rq3aHxWm8eXQy/oeFasPWWKofIp4gYIgCSWKmqKYW6Fkiw3Y2y/jcoSKcgKNSefjDrHf
	5aR22ZAup9NJgZBFu+oOiA4hLg3POkeSTqAXvAJ2HJKYh8ieYzpMyrH6XXVzSJBShI/uk9
	jDGTv8N01LYNpxXmNDQsuI4vf62HfzS986OiXGS58BoWt1BdLV9jown8I19u3A==
Date: Mon, 22 Sep 2025 17:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 13124b8e7eb5f44b06d
X-MBO-RS-META: gohb74zqdcjunqh9z3xtx7whuwfk6y88
X-Rspamd-Queue-Id: 4cVnb14Q3sz9tLy

On 9/22/25 5:41 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Mon, 22 Sept 2025 at 17:34, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> This driver can not function correctly without PCIe subsystem level
>> config space access serialization. In case PCI_LOCKLESS_CONFIG is
>> ever enabled on ARM, complain loudly so the driver can be updated
>> accordingly.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pci/controller/pcie-rcar-host.c
>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>> @@ -35,6 +35,14 @@
>>
>>   #include "pcie-rcar.h"
>>
>> +/*
>> + * This driver can not function correctly without PCIe subsystem level
>> + * config space access serialization. In case PCI_LOCKLESS_CONFIG is
>> + * ever enabled on ARM, complain loudly so the driver can be updated
>> + * accordingly.
>> + */
>> +static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
>> +
>>   struct rcar_msi {
>>          DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>>          struct irq_domain *domain;
> 
> This causes a build failure when compile-testing, e.g. x86 allmodconfig.
> Using "depends on !PCI_LOCKLESS_CONFIG" instead would avoid that,
> but indeed has the disadvantage that it wouldn't complain loudly when
> PCI_LOCKLESS_CONFIG would ever be enabled on ARM64...
All right, let's also wait for input from PCI maintainers. It seems both 
alternatives -- static_assert() and !PCI_LOCKLESS_CONFIG have their own 
disadvantages, maybe there is a third option.

