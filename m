Return-Path: <linux-pci+bounces-41081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E36C57330
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6F357603
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A2299AA3;
	Thu, 13 Nov 2025 11:29:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1733B6D2
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033367; cv=none; b=R6zEfd4sp/lU4DFRn6T3rTg8BE/Z7WsLt0Tp2GE4jUrv1+52KauEhY0+3RJJRw6o2AwKDaa9c0tfneva/+cKRPM3V3XOicX73QIIafpH7r+PXzWnL2xGEWXcl76KqWukmsm/VJlAWKIh5kva4zyUh+vTs493oRplZ/dQVXlLreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033367; c=relaxed/simple;
	bh=h1A8KbP52e13WYR2WHgxGIGt+4osW6ow5F016C5qqEw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss8u35/n/Po9WJ5MiQHu0roW7U2sZ4gktO0qgxbl999AkNjZvwR0EaKpZV0Vvg7ZYl1El8lVkh+qITggoEU/Hw9kcwU1YXewfo2y+xWxN4QUwUncQXAqUhyctXNXEQTtDnpv+dxMN8AOjwr07QGKEGaFZrLre1ftOMXpuqNmDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6dMK3b3VzHnHCm;
	Thu, 13 Nov 2025 19:29:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BDF01402F1;
	Thu, 13 Nov 2025 19:29:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 11:29:21 +0000
Date: Thu, 13 Nov 2025 11:29:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] PCI/TSM: Drop stub for pci_tsm_doe_transfer()
Message-ID: <20251113112920.0000011f@huawei.com>
In-Reply-To: <20251113021446.436830-3-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
	<20251113021446.436830-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 18:14:40 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Just like pci_tsm_pf0_{con,de}structor(), in the CONFIG_PCI_TSM=n case there
> should be no callers of pci_tsm_doe_transfer().
> 
> Reported-by: Xu Yilun <yilun.xu@linux.intel.com>
> Closes: http://lore.kernel.org/aRFfk14DJWEVhC/R@yilunxu-OptiPlex-7050
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

