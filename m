Return-Path: <linux-pci+bounces-33246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF696B1728A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3618C5200
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92D2D0C9E;
	Thu, 31 Jul 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="shMRVDlD"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650E2D0C8E;
	Thu, 31 Jul 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970072; cv=none; b=LYfuoVmTHGX9jp0WJ2Ob2Be5ND138DM6mqLa0vC5cHA124QA3ghkUqIkemD2U44g/rCU7En8kcZafkxBGfeeexlKGiw4mt5imWWvkbIRxV43hvp2EQ7/GtDNL6TRxxSF5UQxy7L0UbKlRzmuDqge627YMMZdnzfqvyIPuDR6fCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970072; c=relaxed/simple;
	bh=pj3aC20dqpakiKA6ZgS3vaIcin/v6Az6iBq72FwH/zQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5o57xKOTptpsnODK8Y7FTYq25txHhfcxDcJAAopIKQVZFZVJV2hXZj7n9mDO5QYQUXybxBgf5ki9bTkx+pXYDte2OQZIhdh/61PuFIk0R4qOHElYxebgomLckF7rVAXMliB8bU/o8qhxStpfLvvB1p1MfH1Che+SvOmzssTvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=shMRVDlD; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iGA/UgH2W0pMHmsp+0E6QOhX9myBE6eJ9WNUk5Puzrc=;
	b=shMRVDlDoF3V8szV+sIWA3THhr44mHr74IL8TEZDtYAchi7d7Tt7gJDU+aB9V+r6jl6ZOJoCh
	XJaKf9R77tDC3lWtQBAUkWCKiaSGgHo2HcYO278on0Kr27nDnoa6xptYv+T2au6vEzpfVLxan1z
	SSVrZI0xB5imxgweVbcJIPw=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bt9Wl2bjTzN0L1;
	Thu, 31 Jul 2025 21:52:51 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt9WB6Wq2z6L50W;
	Thu, 31 Jul 2025 21:52:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0A0F1402F4;
	Thu, 31 Jul 2025 21:54:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 15:54:20 +0200
Date: Thu, 31 Jul 2025 14:54:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven
 Price <steven.price@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc
 Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 23/38] coco: guest: arm64: Update arm CCA guest
 driver
Message-ID: <20250731145419.0000182f@huawei.com>
In-Reply-To: <20250731122948.GU26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-24-aneesh.kumar@kernel.org>
	<20250730152204.00006f79@huawei.com>
	<20250731122948.GU26511@ziepe.ca>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 31 Jul 2025 09:29:48 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Jul 30, 2025 at 03:22:04PM +0100, Jonathan Cameron wrote:
> > > -static void __exit arm_cca_guest_exit(void)
> > > -{
> > > -	tsm_report_unregister(&arm_cca_tsm_ops);
> > > +	return ret;  
> > 
> > 	return devm_add_action_or_reset()
> > 
> > Mind you, Jason probably won't like this ;)  
> 
> devm in a module __exit function? How ?
More coffee time... 

> 
> Jason


