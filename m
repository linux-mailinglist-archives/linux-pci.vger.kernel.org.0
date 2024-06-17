Return-Path: <linux-pci+bounces-8869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D659D90AE64
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6392883E8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD5197A64;
	Mon, 17 Jun 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gZNx1aN3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWQLmqdQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCF197A7B;
	Mon, 17 Jun 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628928; cv=none; b=tZei2aQabTNaBRnjlwbAfoU3N66ZbxXFwSIzdssr5UMBCpXnDBfupmarkNgmQOGgM5cV2QiBLLLPg/pR/wqjth34Rylz7IvVPOri83e1xpI3OZ2/P+QIngu3q3XSfozVZW8HVZD9o53UHyNLQk+h8AxZiiKrcJWZS1fOIRjA9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628928; c=relaxed/simple;
	bh=s1P+cSpKTj8BZqyqj2vwTLUtsKOK5cBIGKa9FQvunJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K8a48qlVx+zIjY+jEWIgHhRao8W8//8bOEZ15jgzw8cM4Rp0YnQ5lRXWCK21VvtW7Y25bLBLV6PDJ+nqcfypNxkEud4MMUjH5Vg5OTYBuVOmNZdAYxlhwOYWhtFy/Gn2xWVODssVQQZxecYPLoGeqKVkuwh96TxgSVJZFMOvM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gZNx1aN3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWQLmqdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718628924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKMZYNRqGwSwZfrS/4+Qt6hrUT2rGmKhu6Ikn633Hd0=;
	b=gZNx1aN30izMoUEmZ0j7HlMTD9mM2q4JHmYYVT1PnUv0QJbRiv5H+y4WaLMWk9lAiDebN8
	d9eNh1Fqd+pmsYXhnRw4x2G4CfsWb0l4rF+d3Fq4NNldJ1IUUySPTmqt/+yv1OFDnc4ySE
	exR1D9Ar0GyNt+fxVEJwhv1WG+2Kk9nkyZZojvh4gtcIqdc0ff2CpJ+ZjIk3eqSO7p7M0N
	lvYDs9/ZaDTPOKyL7xsXr3E8rINMByjRWAzgL15Luv5DVNPgef3gTcBh4GqTnj98EvASi3
	AUcyncTAeISza0E1gWIs9wB1GlGVbvpedNscLiD0mzDZcbuZDR/MtNAuu6mwjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718628924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKMZYNRqGwSwZfrS/4+Qt6hrUT2rGmKhu6Ikn633Hd0=;
	b=zWQLmqdQIhCQnBaGizXqI4QiMDjaexU7j8CgjsWhztv6T1xbtiQE4d4sUDdLqxBbcj28Dx
	o3GhpYsSMe5Hs7DQ==
To: Marc Zyngier <maz@kernel.org>, Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI
 mechanics
In-Reply-To: <86le36jf0q.wl-maz@kernel.org>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org>
Date: Mon, 17 Jun 2024 14:55:24 +0200
Message-ID: <87plsfu3sz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 15 2024 at 18:24, Marc Zyngier wrote:
> On Fri, 14 Jun 2024 11:23:53 +0100,
> Shivamurthy Shastri <shivamurthy.shastri@linutronix.de> wrote:
>>  static struct msi_domain_info mbi_pmsi_domain_info = {
>> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> -		   MSI_FLAG_LEVEL_CAPABLE),
>> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
>>  	.ops	= &mbi_pmsi_ops,
>>  	.chip	= &mbi_pmsi_irq_chip,
>>  };
>
> This patch doesn't do what it says. It simply kills any form of level
> MSI support for *endpoints*, and has nothing to do with any sort of
> "wire to MSI".
>
> What replaces it?

Patch 9/24 switches the wire to MSI with level support over. This just
removes the leftovers.


