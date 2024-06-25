Return-Path: <linux-pci+bounces-9216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B142916052
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 09:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B9B229A9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5869148305;
	Tue, 25 Jun 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mo1Xgvi7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TcXMfp1"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1251482F4;
	Tue, 25 Jun 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301632; cv=none; b=bS+A/s7HheuvlRdbyWA4g12OJxlVaWx+Hn1yp0ydwkN3uekwH6yv2a0oJYhvEyU9FjkZanqYT3a++Sj8Z/LRJJccnfr/XTzOOy8AG4xBBY7PeIjjeRovrWB9Sm2UqmSCraNAVovBD7366Ld2TKjNVbBJPS1bqy+8Zf1u+CFHJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301632; c=relaxed/simple;
	bh=E8J4naliqO+0Tgy0hxiqn7PnRLynzbqh98vX7SVYnmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=abRCehPurkXVEGGdp6SBRWS4PEAb1qu/RnEF/QbQoVlp5DvzHrAKNA5Clb4802jd1ctjv8Xij8dw+6w8gvsVgYAbWW+g34hvFC6uNWYBWnoVzAD5eyhhk15ORnImNCs3cUmn3YlMb1N2z5HPyiFRVbapPHks5pZ37g0AwoGbNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mo1Xgvi7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TcXMfp1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719301629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmc8MTuCh1XCrp70mw+LT/QclMruRuIsIjy/tVuxlrw=;
	b=mo1Xgvi7bxKmw3jZDLjqwirC327EDsQAiAq08xzB7VAlehA93FORjbUKpStmSa6CbKCbAy
	PC/UhoMw9UbSJyybkGK1t7bLTDdEZhC4iMJOCEgq4uVnf45hptoKPXYzuL/cH3X+W5Qkj3
	GVIv3rgU5QVMlfQAW1CF/yXRGsTLU/ts/YZMyC49d0YnTT4LQmp06a7dNkkMd9CpJV+QmT
	dnxgWM2NXzjEhzCQVuqD3FSyDXT8lDi4l24g7LjHTPc8UjblcPv+tRB5fp5m3SVmy6Ukt5
	iJviyFR1RTw71pRcWbay5i8QX6SktSXzL2sKq8bkQr9nXZ46xVVRcsMIi0eEbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719301629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmc8MTuCh1XCrp70mw+LT/QclMruRuIsIjy/tVuxlrw=;
	b=9TcXMfp10CwedtYwFQElarbStZO2GM/gZvs3ZJhbqzGtsFef7nID5+hZZ1mkVoUWVoy0bj
	Dqpir1j95KbgEQCA==
To: Marc Zyngier <maz@kernel.org>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
In-Reply-To: <86y16tiica.wl-maz@kernel.org>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org> <87plsfu3sz.ffs@tglx>
 <86h6drk9h1.wl-maz@kernel.org> <87h6dru0pb.ffs@tglx> <87ed8vu033.ffs@tglx>
 <86y16tiica.wl-maz@kernel.org>
Date: Tue, 25 Jun 2024 09:47:09 +0200
Message-ID: <8734p179c2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 08:37, Marc Zyngier wrote:
> On Mon, 17 Jun 2024 15:15:44 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> just install their special MSI write callback. I don't see any of those
>> setting up LEVEL triggered MSIs.
>> 
>> But then I'm might be missing something. If so can you point me please
>> to the usage instance which actually uses level signaled MSI?
>
> Good question. I'm pretty sure we had *something* at some point that
> used it, or that was planning on using it. I even vividly remember who
> was asking for this.
>
> But either that never really made it upstream, or they decided to move
> away from the kernel setting the MSI up and relied on firmware for
> that (which is fine as long as the device isn't behind an IOMMU).
>
> In the end, it begs the question of what we want to do with this
> feature.  I don't think it is a big deal to keep it around, but maybe
> we should plan for it to be retired. That's independent of this
> series, IMO.

I reworked the conversion so that it keeps it alive. We can remove it
later nevertheless :)

Thanks,

        tglx

