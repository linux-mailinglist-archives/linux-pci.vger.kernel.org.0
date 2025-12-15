Return-Path: <linux-pci+bounces-43042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB6CBDBEB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 408F63050583
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81616244664;
	Mon, 15 Dec 2025 12:09:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C5315765;
	Mon, 15 Dec 2025 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800550; cv=none; b=R7lq+FK1q59ZqlC6srr9XSrQron0+lFDX1o38rgqBMj0ZK7ZoTdGdKGeVqFRjcmzh0D+yHhWlOi6mUGexLqNqu1q+6yNkSlwfQKndArLpUvDnDy1Fnfpm6PbsrV40KxgOyJzeZUfh7rOKFVHZ9EDeimu4SKighPaGaCKUYRsTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800550; c=relaxed/simple;
	bh=ETShSUhHG58begoEbQgBckMzdf+LLtT24b10xbZ8bD8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKVNp26exjLC1XiQdkWTnR5eWibYbPKYvrwKd9PyRYlcVgG4K82DqzJU7M1hb0AWT8nNQbbGw5vNgjS4mLmXERCxVxI9YjS/X7PUNMC9KlXpgC594pbJ+g083745ZD1cqfuZnagthut/FGsmS9mPSAzdN69IMeDdLCi3AjksqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVJkJ32BKzHnGcw;
	Mon, 15 Dec 2025 20:08:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F2CD40086;
	Mon, 15 Dec 2025 20:09:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 12:09:01 +0000
Date: Mon, 15 Dec 2025 12:08:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH 2/6] cxl/mem: Arrange for always-synchronous memdev
 attach
Message-ID: <20251215120859.0000198d@huawei.com>
In-Reply-To: <20251204022136.2573521-3-dan.j.williams@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
	<20251204022136.2573521-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  3 Dec 2025 18:21:32 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for cxl_mem_probe() to always run
> synchronous with the device_add() of cxl_memdev instances. I.e.
> cxl_mem_driver registration is always complete before the first memdev
> creation event.
> 
> At present, cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, however, that driver needs to perform driver
> specific initialization if CXL is available, or execute a fallback to PCIe
> only operation.
> 
> This synchronous attach guarantee is also needed for Soft Reserve Recovery,
> which is an effort that needs to assert that devices have had a chance to
> attach before making a go / no-go decision on proceeding with CXL subsystem
> initialization.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems fine to me as well. Even independent of the reasons that
drove this patch set I'm keen on the simpler mental model that synchronous
probing allows.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

