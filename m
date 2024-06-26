Return-Path: <linux-pci+bounces-9277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67596917C35
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2383828B6A8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736F16FF5F;
	Wed, 26 Jun 2024 09:13:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5316B391;
	Wed, 26 Jun 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393207; cv=none; b=Tv5uBdyIfXsvbLV5HjsAUnjUx0OkErES5BcxLgrZ/7wau4yUDNdblVym9YEDF1i7rvu4s4OOQ0cDaLfXTc8nHptKMhfgourruCEqPWaWkuetO/batwr6jn2N/RsBZhOKFHxiVJ2gwY6X26RKhsotsrJBr5BoelibCt4YoBU/w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393207; c=relaxed/simple;
	bh=vWHVjPy7vn1+keb19HWw4lK2BGwaUGedY3VudPOffi4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TGZ7VlYI/0jKJuxPkvIeApLswkGa/K7sxSLtcaVQTHc5AKJnDMxuTWsOEQM4bhsEZ4Tt85utx88UBNqVaqmDOGYK8PFC4UvnfPfHnLsw+XG38sjRCoZ0nKRJbKBYoZiqOuSSRtIW0F41upjkRJ9maCgNYQx8C/Y36A+Ti9qd0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W8G9G1G6Pz1j5pD;
	Wed, 26 Jun 2024 17:09:22 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E330714022F;
	Wed, 26 Jun 2024 17:13:21 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Jun 2024 17:13:20 +0800
Subject: Re: [patch V4 10/21] irqchip/mbigen: Remove
 platform_msi_create_device_domain() fallback
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<maz@kernel.org>, <anna-maria@linutronix.de>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <festevam@gmail.com>, <bhelgaas@google.com>,
	<rdunlap@infradead.org>, <vidyas@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <apatel@ventanamicro.com>,
	<kevin.tian@intel.com>, <nipun.gupta@amd.com>, <den@valinux.co.jp>,
	<andrew@lunn.ch>, <gregory.clement@bootlin.com>,
	<sebastian.hesselbarth@gmail.com>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <alex.williamson@redhat.com>, <will@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <jgg@mellanox.com>, <ammarfaizi2@gnuweeb.org>,
	<robin.murphy@arm.com>, <nm@ti.com>, <kristo@kernel.org>, <vkoul@kernel.org>,
	<okaya@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
	<mark.rutland@arm.com>, <shameerali.kolothum.thodi@huawei.com>,
	<yuzenghui@huawei.com>, <shivamurthy.shastri@linutronix.de>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.333333826@linutronix.de> <ZnrXRLtqrlXhY8oz@lpieralisi>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <628933bb-d3ae-e2a5-79f8-0c08d9363562@huawei.com>
Date: Wed, 26 Jun 2024 17:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZnrXRLtqrlXhY8oz@lpieralisi>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/25 22:42, Lorenzo Pieralisi wrote:
> On Sun, Jun 23, 2024 at 05:18:48PM +0200, Thomas Gleixner wrote:
> 
> [+Hanjun]

Thanks for let me know.

> 
> Hanjun, are you able to test this series (or find someone who can) and
> in particular mbigen changes on affected HW and report back here please ?

I tested on a Kunpeng920 ARM server (with this patch set on top of
6.10-rc3), which the mbigen interrupts are used by SoC PMU counters, I
can see that the PMU counters can generate overflow interrupts as
before, it works for me.

Thanks
Hanjun

