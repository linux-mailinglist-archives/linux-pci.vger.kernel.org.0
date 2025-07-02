Return-Path: <linux-pci+bounces-31273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0107AF5AEF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBBE189F30A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE22F49F9;
	Wed,  2 Jul 2025 14:18:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E872F0E42;
	Wed,  2 Jul 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465911; cv=none; b=kYIQAkL9KdmEkCM8F2g8oBcgGjUZ3SunaKNuiRQeyML0ZlfUxoedZRawLlJcuC0a51BksMKhqO4eSZ9Fl+OzZ7d0dCg8Jl8SQFZliu6lz3kTbDISuSTgde5O3iv3gpHB56x1sMmaM5NQwoRnAFw8WbPeV5x/7LwE0wtGZ3Nz8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465911; c=relaxed/simple;
	bh=fYtrJ/flpZB5djezcGz+i0agnUd0Vt/iniN5w9bt4p0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQVe/v0GyZYe+VBO3M3RpP7a7oN0Q7hyNYiis3kgrFktanEaVJYV+j0nVwVG/M+TkdhebpTDwa4LuJY74W1iIAQmofW8WgzW4ZBwrBwsVbC3HswpHl1LPVmvwgJNN9r5y+dcNnZOghl5UEH4LwPdlUrWjfeDxoHijmMfnOxNJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXMS75hxdz6L5GV;
	Wed,  2 Jul 2025 22:17:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D54BF140446;
	Wed,  2 Jul 2025 22:18:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 16:18:24 +0200
Date: Wed, 2 Jul 2025 15:18:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Sascha Bischoff <sascha.bischoff@arm.com>, Timothy Hayes
	<timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 00/31] Arm GICv5: Host driver implementation
Message-ID: <20250702151823.00007aec@huawei.com>
In-Reply-To: <86jz4tb14h.wl-maz@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
	<86jz4tb14h.wl-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Jun 2025 18:17:02 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Thu, 26 Jun 2025 11:25:51 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > Implement the irqchip kernel driver for the Arm GICv5 architecture,
> > as described in the GICv5 beta0 specification, available at:
> > 
> > https://developer.arm.com/documentation/aes0070
> > 
> > The GICv5 architecture is composed of multiple components:
> > 
> > - one or more IRS (Interrupt Routing Service)
> > - zero or more ITS (Interrupt Translation Service)
> > - zero or more IWB (Interrupt Wire Bridge)  
> 
> [...]
> 
> I think what is here is pretty solid, and definitely in a better shape
> than the equivalent GICv3 support patches at a similar point in the
> lifetime of the architecture.
> 
> For patches in this series except patch 18:
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> If this goes into 6.17 (which I hope), it'd be good to have this
> series on a stable branch so that we can take the corresponding KVM
> patches[1] independently if they are deemed in a good enough state.
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/20250627100847.1022515-1-sascha.bischoff@arm.com
> 

Agreed. Looks very clean to me.  All the stuff I had was trivial.
I'm only not giving tags (beyond the various field definition patches) because
I don't feel like I have yet spent enough time with the spec yet to be sure about
some aspects (and irq stuff always gives me a headache)  Anyhow for this stuff
my tags are hardly relevant.

As Arnd observed, for now this is very low risk so good to get it into next and
lined up for 6.17 even if a few buglets + fixes surface to go on top.

Jonathan

