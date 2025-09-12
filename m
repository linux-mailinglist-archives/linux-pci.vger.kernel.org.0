Return-Path: <linux-pci+bounces-36039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16951B55341
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0571D67A38
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0C222560;
	Fri, 12 Sep 2025 15:25:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5892FDC5F;
	Fri, 12 Sep 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690720; cv=none; b=W01Fn9FbvphkfuB6VbSN2UWNFEBItpHEsqvvI2M6h6OeZrgw8PHXBYgo2A3yLTb+CvqgZBv3QQvn9AHHWw7v3YWjWb5vHH/wzL2e4e707gGA81PHonNvyg7OjMBOrsMUGReHBxN+xqrgFztFZ5vn1AD755lKevRDs/AQBgraGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690720; c=relaxed/simple;
	bh=W3jsCQaIEFKjVqD3LQIG4lGer3X9DaizojWjKa4rgIs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiuijRDWyEJAPN0JIFpnTVXta2QkF6Qj0HvwSro3LwNdkM7XEz3ORir0Cf3q0s/aMGQHLFNHaTRmZI9FQzSoOqXNsKroeGBBdtMlHorYjSjIkQZlD08uiYdE/5oMS/fcZCAAn5rU3RTSp0AAPz7K6syqsPUyvAI28X/XIBJYAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNdRY1hpTz6L5jm;
	Fri, 12 Sep 2025 23:20:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B8FA1400F4;
	Fri, 12 Sep 2025 23:25:14 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 17:25:14 +0200
Date: Fri, 12 Sep 2025 16:25:12 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/16] cxl/core: Set up isolation interrupts
Message-ID: <20250912162512.00005794@huawei.com>
In-Reply-To: <20250730214718.10679-8-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-8-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 16:47:09 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Register a CXL isolation interrupt handler as part of cxl_dport set up.
> Only CXL-capable PCIe Root Ports have CXL.mem isolation interrupt support.
> The interrupts are left masked and will be unmasked in a later commit.
> 
> A CXL-capable PCIe Root Port that has CXL.mem isolation support and no
> interrupt support will have any isolation support enabled. If
> isolation were enabled without interrupts CXL.mem transactions could
> return poisoned data. This could cause data/system corruption if left
> unhandled, so the capability is left disabled in this case.
> 
> CXL endpoint drivers can add an isolation handler for a device through
> the isolation_handler member of struct cxl_dev_state. If this handler
> is not present, the system will panic. If the handler opts to not panic
> (i.e. returns "CXL_ERR_NONE"), the endpoint driver is charged with
> maintaining system reliability (cleaning up CXL memory, disabling device
> state, etc.).
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>


>  /**
>   * cxl_dport_enable_isolation - Enable CXL Isolation for a CXL dport. This is
>   * an optional capability only supported by PCIe Root Ports.
> - *
Make the edit on original patch if you want to get rid of this line.

> + * @host: Host device for @dport
>   * @dport: CXL-capable PCIe Root Port
>   *
>   * Returns 0 if capability unsupported, or when enabled.
>   */



