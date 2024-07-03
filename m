Return-Path: <linux-pci+bounces-9726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002C9262B9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2BA1F213AD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AC179675;
	Wed,  3 Jul 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3Cm4nvH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eJG6eVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7717967E;
	Wed,  3 Jul 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015095; cv=none; b=XD2wKv+LEOgFoB082mSqJrsGegQmEIVPQFps9Mlzp3T9kjNE9kluxaG1+8tJiZYnHubxMP0D+BKfT6QNdELsvrUvzCqUlhgFRDlZCGCVX3xesxqo60e340Wc/IBZZFleCAvf0Hnsr8IuEh3r/1sOYN981IwTcrTbX6DCflbY6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015095; c=relaxed/simple;
	bh=OdshmpORQMYpCC6qB5pVVvAkKlcM+d2gSY4qJSAambM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hs2Mot4g50Ubt9AJ8xdS9j9qbzFk+AbF44KDOSPJ8JU50JjS6kVpx8/vYjqGsLWM04djmmYK0OuY4S2g8xubr2+dRIu0xG684Z4p7tyyG9+qoQn1uleyggcXHEnk2t23s2IAM7yATvNvCCkT/VtM812eGk8Xgu5zVZlAIThjoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3Cm4nvH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eJG6eVh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720015090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XH6QO9JWwoOujTbpUhp4MtAndneXDiax3/mdKKqKVh8=;
	b=H3Cm4nvH0sZJLdpeNsPM46kZmY+PMMqdr7J7bMPA/ljr0rKhMjs1LGw5SLeL/rDhvA1TvN
	WQWhsZNCHZoH5nJvFIPh8BOgNLAmvZFVi77QvgOmOsCupxFe/nyXHF9lc3L1TEx1PfBoIH
	gKA7sV7OqOT+noR5yEiGoETpiFs49i3Pa/EPiMWwq5mJ5uHDaaNekqQERaJvKNdRTwX6jo
	7hDHi/3La0+pTTeSzfIGDcGRkG53LiJrq5/bHQMvW5DxFFTCGj5wdY+YnHy49Yj5JdfmsW
	D0PuRS8JRGUDL7OEUErKmVa4+CDaq52tnB80Ng/DFhqWtqpgenKHQ4uXe9j0sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720015090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XH6QO9JWwoOujTbpUhp4MtAndneXDiax3/mdKKqKVh8=;
	b=0eJG6eVhjeCS0NJ1TEK/AjCh1Xn0NeiVV0hoL31PGn+AusmRI46YQ6cVkkz5Kxtu+17MSc
	37VDZxT9w+Q9+LBw==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, nm@ti.com, kristo@kernel.org, vkoul@kernel.org,
 okaya@kernel.org, agross@kernel.org, andersson@kernel.org,
 mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com, shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 02/21] irqchip: Provide irq-msi-lib
In-Reply-To: <ZoKCd5t5yoMkee0a@lpieralisi>
References: <20240623142137.448898081@linutronix.de>
 <20240623142234.840975799@linutronix.de> <ZoKCd5t5yoMkee0a@lpieralisi>
Date: Wed, 03 Jul 2024 15:57:48 +0200
Message-ID: <871q4ay3vn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 01 2024 at 12:18, Lorenzo Pieralisi wrote:
> On Sun, Jun 23, 2024 at 05:18:34PM +0200, Thomas Gleixner wrote:
>> +bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>> +			       struct irq_domain *real_parent,
>> +			       struct msi_domain_info *info)
>> +{
>> +	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
>> +
>> +	/*
>> +	 * MSI parent domain specific settings. For now there is only the
>> +	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
>> +	 * possible to stack MSI parents. See x86 vector -> irq remapping
>> +	 */
>> +	if (domain->bus_token == pops->bus_select_token) {
>> +		if (WARN_ON_ONCE(domain != real_parent))
>> +			return false;
>> +	} else {
>> +		WARN_ON_ONCE(1);
>> +		return false;
>> +	}
>> +
>> +	/* Parent ops available? */
>> +	if (WARN_ON_ONCE(!pops))
>
> We have already dereferenced pops above, we should move this warning
> before we dereference it (ie checked devmsi-arm-v4-2 too - branch same
> comment applies there too).

Oops. Yes.

