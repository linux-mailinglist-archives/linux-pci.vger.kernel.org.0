Return-Path: <linux-pci+bounces-8873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E390B345
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C110D1C22ECC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9013EFE0;
	Mon, 17 Jun 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwWxSTLV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLQf55do"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D693A8D8;
	Mon, 17 Jun 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633748; cv=none; b=QswOZlXozH8dCiTE0lnz3i9qT6FRmH2sN++Xayi2sPoHolCrsrPHzGbXDhFI4gZfKrWxX4Fcg9rnC9Y8g4T+GBTiht95UyNkgWha2OIIq2aQz/oHkqjJpjJIfsoCOQV+ObsmhW87Dmp6Kn05t0E1GR05RFplQw04VomFts3Dd6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633748; c=relaxed/simple;
	bh=FMIRM+ikIspzilRHxp740oHKv8WJwo5bCUHb91TRtrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Afi6/eDDoqr+wPFIj0jrkVXZHjqA++RHkvQS/V4HLtSn10qxDFNv1Y2TNkYIeZosOTKiB/ygotTz5wT9JS8Hwr70xfibXxAw3G1cTq8Uai49cbKEAde6gXK46lAhM46/E1HS9Rkr8ONZRYGNgyFOsBoWBaait/4v+TQdEtYTOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwWxSTLV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLQf55do; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718633745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtM+S9Ap9GQsni5A3sYdh6Yhl8y511eo5WwG1zoVyA=;
	b=cwWxSTLVBpJEwfoYlroCSQWqEqqX8FlkC7glJ6n751jR0P0e4gFOxJInsLm1pqNMVsXvhE
	SrDAKpU3mAGW2p1RTRpE+9jySnyz4i0wPiJ6KDJQMne/hxJfqmn8hB5mXRNKT8QZyMXMPT
	sTkT5DhTLObuemQcRPZGIjeYT9IEiHv9DolKbGxtz2MEQTmKZw20ivmiAZOtE/4FStnHRD
	OMIivyg3+JM7YNUwDbBIaZ2x2eKbhfNUUYdhBtZwdU1sZjS8U62tx8wbUcrnJn3/VsFJNW
	BJR48n+k/t7fza5gSGRJucd1mxT5Bf9MLbr/BmPH7Y48eeOagejzdQhde1/0OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718633745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBtM+S9Ap9GQsni5A3sYdh6Yhl8y511eo5WwG1zoVyA=;
	b=sLQf55do2taqLUJxYEl35PnJjUl4YtverHodM//296JALc3vv/W7j57P2cEyyRJvrrg1E8
	bL3wrKdA5ew69TAQ==
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
In-Reply-To: <87h6dru0pb.ffs@tglx>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
 <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
 <86le36jf0q.wl-maz@kernel.org> <87plsfu3sz.ffs@tglx>
 <86h6drk9h1.wl-maz@kernel.org> <87h6dru0pb.ffs@tglx>
Date: Mon, 17 Jun 2024 16:15:44 +0200
Message-ID: <87ed8vu033.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 17 2024 at 16:02, Thomas Gleixner wrote:
> On Mon, Jun 17 2024 at 14:03, Marc Zyngier wrote:
>> Patch 9/24 rewrites the mbigen driver. Which has nothing to do with
>> what the gic-v3-mbi code does. They are different blocks, and the sole
>> machine that has the mbigen IP doesn't have any gic-v3-mbi support.
>> All they have in common are 3 random letters.
>>
>> What you are doing here is to kill any support for *devices* that need
>> to signal level-triggered MSIs in that driver, and nothing to do with
>> wire-MSI translation.
>>
>> So what replaces it?
>
> Hrm. I must have misread this mess. Let me stare some more.

Ok. Found my old notes.

AFAICT _all_ users of platform_device_msi_init_and_alloc_irqs():

        ufs_qcom_config_esi()
        smmu_pmu_setup_msi()
        flexrm_mbox_probe()
        arm_smmu_setup_msis()
        hidma_request_msi()
        mv_xor_v2_probe()

just install their special MSI write callback. I don't see any of those
setting up LEVEL triggered MSIs.

But then I'm might be missing something. If so can you point me please
to the usage instance which actually uses level signaled MSI?

Thanks,

        tglx

