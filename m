Return-Path: <linux-pci+bounces-36280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2909B59EBA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD845581F06
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AB32D5D0;
	Tue, 16 Sep 2025 16:58:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDE32D5D7
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041930; cv=none; b=HVLFo08EIFe8hrBK5AAMbcS/t5Mlzdb1w5vbcjNqswIyi1KpY9GLK5dJ908o/tZ8vBYz6/zQRFnqHA8XsFSZJZ9AO91WdDk6LZR9PxmzDu0fZElwfHcwK7mXqlVoExTQX0/dYPtS6la+1xsuKjOaG+6l4huA8zuXpGs3eXn6n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041930; c=relaxed/simple;
	bh=bHQ6aI2mmvQouH+/tAfvYb03+Rc0ZH6B20NRMqFTVJQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/AeIUmMmupE5GaoiI0oL8o6zhf+/oITpS0g8h1zISzwNQTckhit63OZDYg6c1zBrE2KR/4nDExaiQYCQSz7uEv4zPWZGE/tQlZIh+gRYV6O1v0VMB/mdt/PcC4T5E8nkedRBWwBhare48A84Fxi9BjfYhT2/tTUwGSnyXws/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR7Nq5P6sz6L4wn;
	Wed, 17 Sep 2025 00:57:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B4BD140137;
	Wed, 17 Sep 2025 00:58:46 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 18:58:45 +0200
Date: Tue, 16 Sep 2025 17:58:44 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>, "Samuel Ortiz"
	<sameo@rivosinc.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] device core: Introduce confidential device
 acceptance
Message-ID: <20250916175844.0000504f@huawei.com>
In-Reply-To: <20250827035259.1356758-4-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
	<20250827035259.1356758-4-dan.j.williams@intel.com>
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



> diff --git a/drivers/base/coco.c b/drivers/base/coco.c
> new file mode 100644
> index 000000000000..97c22d0e9247
> --- /dev/null
> +++ b/drivers/base/coco.c
> @@ -0,0 +1,96 @@

> +/**
> + * device_cc_accept(): Mark a device as accepted for TEE operation
> + * @dev: device to accept
> + *
> + * Confidential bus drivers use this helper to accept devices at initial
> + * enumeration, or dynamically one attestation has been performed.

once

> + *
> + * Given that moving a device into confidential / private operation implicates

I'm not sure what 'implicates' covers here.

> + * any of MMIO mapping attributes, physical address, and IOMMU mappings this
> + * transition must be done while the device is idle (driver detached).
> + *
> + * This is an internal helper for buses not device drivers.
> + */


