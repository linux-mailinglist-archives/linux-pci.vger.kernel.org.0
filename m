Return-Path: <linux-pci+bounces-43041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFFCBDAB2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 334FB3000B2D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEA330B38;
	Mon, 15 Dec 2025 12:00:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AC331A4D;
	Mon, 15 Dec 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800044; cv=none; b=gtYjvWdi0TEF3xClNuabKQ68WY6wJt7JeveeaXT9AwfJdIRd1hSOJAE7VHBuQxGzAAm2jnKoMzVZkKc5mpG0yGOMi9xcNBaaSc2MBXm6K2Ok7PXlre7eE4c0ah8RlCZODAzjdBMVlw80sN+gNlocbjIvvlZDlVJhTuKrI9pRrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800044; c=relaxed/simple;
	bh=uav6bp8113k/QpSrhYu+tSV451cM/ZHs3SgRcoV/PrQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNBw4gN6hyDuN47RzucMiyGxrlilhFZMYJqY826yujyxRhdLBTdC6cTO3o8jzZrgrLgyvtZvHjSXYCZma0qnbt8wTkbjnJ27SjfvGwMDbT/12ItTN918Zm/oLMUECfMKUpvXOfrgTAv4omL+wve/xZ1NuiFViR83j9BCsOFlwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVJXY15T9zJ4683;
	Mon, 15 Dec 2025 20:00:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3423C40539;
	Mon, 15 Dec 2025 20:00:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 12:00:38 +0000
Date: Mon, 15 Dec 2025 12:00:37 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release()
 confusion
Message-ID: <20251215120037.000053d7@huawei.com>
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
	<20251204022136.2573521-2-dan.j.williams@intel.com>
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

On Wed,  3 Dec 2025 18:21:31 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A device release method is only for undoing allocations on the path to
> preparing the device for device_add(). In contrast, devm allocations are
> post device_add(), are acquired during / after ->probe() and are released
> synchronous with ->remove().
> 
> So, a "devm" helper in a "release" method is a clear anti-pattern.
> 
> Move this devm release action where it belongs, an action created at edac
> object creation time. Otherwise, this leaks resources until
> cxl_memdev_release() time which may be long after these xarray and error
> record caches have gone idle.
 
> Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> dropped type-safety.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This change seems fine to me. The tear down occurs after unregistering the
edac device and as the repair is via sysfs in there we shouldn't have any
left over calls in flight.  Was an odd code pattern. Oops to missing this
in earlier review.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


