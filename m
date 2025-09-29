Return-Path: <linux-pci+bounces-37190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AFBA8FBD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081721C185B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B62FFF8D;
	Mon, 29 Sep 2025 11:15:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA328725E;
	Mon, 29 Sep 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144535; cv=none; b=uDz7qsT0YORHjZJ8i4VgyPMDL8wKRjoEzmYsyHos43T+qQejjUJaK7P0iUg5yJsKolTR7+aJW025xklxV8NtsnW1mePtqfrgAVMjnahm/qJG+MNMeMzzkrfORYPbrr4wFewNFz4bSkLmpaw3/iSIW0L44+bldHvFr4Mw9sEveeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144535; c=relaxed/simple;
	bh=waEi+Nfz9fjr9CKj2hctsnOPaIBMu5fy0ormLrMhEto=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGQ6pcLW0H/xpf97rKUiiTynHYeonQU4bV0MbGIRK2hIARJt8EK69oagVshL56uCvWhs0AVkDSubHdNlRUfPvmcHCzOAQSRQ4/8mDIfET/dhU7mmT8MN/Afin5CnahBDSppiwO/cTWNcGPRMWTNT6xMRej9x6K26k8cizRFnRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZz826hlGz6L4xc;
	Mon, 29 Sep 2025 19:13:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 333E9140133;
	Mon, 29 Sep 2025 19:15:30 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 12:15:29 +0100
Date: Mon, 29 Sep 2025 12:15:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v4 0/3] PM: runtime: Auto-cleanup macros for runtime PM
Message-ID: <20250929121525.00001775@huawei.com>
In-Reply-To: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 26 Sep 2025 17:40:29 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> Hi All,
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/12763087.O9o76ZdvQC@rafael.j.wysocki/
> 
> which was an update of
> 
> https://lore.kernel.org/linux-pm/6204724.lOV4Wx5bFT@rafael.j.wysocki/
> 
> that superseded both
> 
> https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> 
> and
> 
> https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/
> 
> It follows the Jonathan's suggestion to use ACQUIRE()/ACQUIRE_ERR()
> instead af raw CLASS() to make the code somewhat cleaner.
> 
> Thanks!

Looks excellent to me.  I've already been pointing a few people at this
in driver reviews, so I expect to see a lot of adoption in IIO (and elsewhere).
That RPM_TRANSPARENT handling is particularly nice.

With the tweaks you've already called out.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Given timing, if this ends up as a next cycle thing please could we have
an immutable branch?  If it is going to make the merge window then no need.

Thanks,

Jonathan

