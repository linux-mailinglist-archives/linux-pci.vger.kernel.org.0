Return-Path: <linux-pci+bounces-11700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690F953704
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598A528CC07
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B51ABEC8;
	Thu, 15 Aug 2024 15:21:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6F1AC427
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735294; cv=none; b=dFG+PdADUdEguutP+otaMbPnRWk49i9yEOHYbN/LWsj7VsCycvUqIpgw9UKNcdMPBVI9F7A6WdYL3y7/Jc0refSJmNi19NfBZ289TvYvzfJwdE9ugqjJkMbIucYuPrAf9N/ctrSufvB/A1VxnDpVvZMULW+gfE4SoDlmpQPOvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735294; c=relaxed/simple;
	bh=7Sg4mRJIrrPGtR8cl+cm63uElcG3JGhEYqtiTWvtzng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soG1pMLnTTT1NVoukyufjgWDANRQtFPhkDCc+SjdciE6/WYg7k2wamIFbGMg0T0x5SbU33HqMA+U5huaR4+fhzvCpJHjZlHKd+yKTW+GDxsdzADY9VXAiLMI8M0ArndmKJ/sPqVLcG4QkzCFoWykPOEFMaO6Dc6yYFiR5VQKzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl8071PmTz6D92M;
	Thu, 15 Aug 2024 23:18:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E22D9140119;
	Thu, 15 Aug 2024 23:21:27 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 16:21:27 +0100
Date: Thu, 15 Aug 2024 16:21:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 8/8] pci: use finer grain locking for bus protection
Message-ID: <20240815162126.00006cb7@Huawei.com>
In-Reply-To: <20240722151936.1452299-9-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-9-kbusch@meta.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:19:36 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The global rescan_remove lock has deadlocks during concurrent removals
> because it is used within interrupt handlers. Use a bus specific lock
> instead.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks reasonable to me. I'm not particularly confident on this one
so more eyes (plus testing) would be good.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan


