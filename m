Return-Path: <linux-pci+bounces-43044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A0CBDC41
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9937B302378A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258AB32D0E1;
	Mon, 15 Dec 2025 12:15:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D6314D2E;
	Mon, 15 Dec 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800926; cv=none; b=sKFaJXq9I9jyLbvLuZROHN7iZ7kAVbf46iHNnVKKHXCXTp1yKxde3MnVjrnbbIj9O420FE70DimEtT2f3RRC6I8H4zFxagrT03cxzLRUn8E34N5LQbqAmeZCFAP5+V17gXuQF3ls0lHIeInAycdX3V0BFsgiqLrGdWJK8Q8ph4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800926; c=relaxed/simple;
	bh=fAfH9yY3N+AZUTf5/gm/Ub/UpWf0zcEGf1G3x7pXO5Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofrXDrnnusVk/gIeaan1k+MKDKi6VPqr5IhEAV45tVTbDlnE6OEFRNlw/3O6vgF93+DpA1FnTnK2qxbFc6MvIH4FHZQjj3dEnllU3EQEsattlHBGlRgI3Bqgk8boblCTnV0Sd0CSixGd11d27VCIASUIxIBaPSF8BWqnZgt3FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVJsV2w1CzJ4685;
	Mon, 15 Dec 2025 20:14:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 75AA940539;
	Mon, 15 Dec 2025 20:15:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 12:15:19 +0000
Date: Mon, 15 Dec 2025 12:15:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH 5/6] cxl/mem: Drop @host argument to
 devm_cxl_add_memdev()
Message-ID: <20251215121518.000020dd@huawei.com>
In-Reply-To: <20251204022136.2573521-6-dan.j.williams@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
	<20251204022136.2573521-6-dan.j.williams@intel.com>
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

On Wed,  3 Dec 2025 18:21:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In all cases the device that created the 'struct cxl_dev_state' instance is
> also the device to host the devm cleanup of devm_cxl_add_memdev(). This
> simplifies the function prototype, and limits a degree of freedom of the
> API.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fair enough. I'm not hugely keen on a devm_ first parameter not
being the dev, but constraining that interface is probably worth
the small amount of thought this requires.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

