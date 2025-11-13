Return-Path: <linux-pci+bounces-41085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA2C574B0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA934AE44
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EF34AAF9;
	Thu, 13 Nov 2025 11:52:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961033DEF4
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034776; cv=none; b=CnGJx7h1sgP1yA38El3NImuFBsk9vC+kF3z7mXx9XQO7spLLn9jN784xPDxBV44RE4qsesQ+Ochjy+V7bG9l1meMPirSwOqLj3jLsplOSnIoUOotWF8RjSPw6AHdNlJ4SFHc8pySMBA7yOXs5R20UpMvNdeOoA6OQClQX8d76dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034776; c=relaxed/simple;
	bh=9kcB6i14YutRu+dCUonWQXN0tUM/aM3h+rApxzWgCKs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq0B1n5PuxQr6Fak70FXn1wlnuW1uRuP+MR9MLeVq8y/0ZwXGD+FzeMx5WW0GAt2NPdHYHctbjxqinkyGtgCGQ1dl9HI1+mn3b1f+7GIarSkq3XCO3Mw+7Louof3t72Mn52ISakVw5YMTM0Jp6pZ6AvUJz5sXpc48kkrdOK8M2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6dtR1wVQzHnHB9;
	Thu, 13 Nov 2025 19:52:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A5E314038F;
	Thu, 13 Nov 2025 19:52:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 11:52:51 +0000
Date: Thu, 13 Nov 2025 11:52:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Alexey
 Kardashevskiy" <aik@amd.com>
Subject: Re: [PATCH v2 5/8] PCI/IDE: Initialize an ID for all IDE streams
Message-ID: <20251113115250.00003864@huawei.com>
In-Reply-To: <20251113021446.436830-6-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
	<20251113021446.436830-6-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 18:14:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe spec defines two types of streams - selective and link.  Each
> stream has an ID from the same bucket so a stream ID does not tell the
> type.  The spec defines an "enable" bit for every stream and required
> stream IDs to be unique among all enabled stream but there is no such
> requirement for disabled streams.
> 
> However, when IDE_KM is programming keys, an IDE-capable device needs
> to know the type of stream being programmed to write it directly to
> the hardware as keys are relatively large, possibly many of them and
> devices often struggle with keeping around rather big data not being
> used.
> 
> Walk through all streams on a device and initialise the IDs to some
> unique number, both link and selective.
> 
> The weakest part of this proposal is the host bridge ide_stream_ids_ida.
> Technically, a Stream ID only needs to be unique within a given partner
> pair. However, with "anonymous" / unassigned streams there is no convenient
> place to track the available ids. Proceed with an ida in the host bridge
> for now, but consider moving this tracking to be an ide_stream_ids_ida per
> device.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


