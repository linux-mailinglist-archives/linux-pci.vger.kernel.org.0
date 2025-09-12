Return-Path: <linux-pci+bounces-36038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A93B55366
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE365B61863
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1C21A421;
	Fri, 12 Sep 2025 15:21:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB8212F89;
	Fri, 12 Sep 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690487; cv=none; b=Mdxr/G+IQ93t5Gd+5fi4XTUf5w+feFGQ6b65pi5gbJc0ss4AWcp2D36XRtaRb0B6Ci7LnDRfKnD1Q4dbz7DjE58lgpEXTXWSVlU3pwBim7pqB5i26EJKvXH7ISanzQ3DWxYao+4kxjcvJWXGj4Y2/Lu/oep9yEI9rrliUTyhaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690487; c=relaxed/simple;
	bh=XMWmPr2fhRCGjww/upZR2nzupjpcA9E+nhQqukBFBnI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7B606v0iTPf6lWvOP+YyCtVJwjDsBBsftryiEBOG0KtVofAoTf5azNeEfzL4kKO8LbCSAe5ONcVeusLhs1bLqvXuw8HE+scQdHeth2hCpjkK5rUEyhzWGIsV0FsTL5T7nqN/ja84MK7wtOxI5KZcU+orCOiEmRUiev3KwJ5shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNdM53H6Zz6L60m;
	Fri, 12 Sep 2025 23:17:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F10F1400F4;
	Fri, 12 Sep 2025 23:21:22 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 17:21:22 +0200
Date: Fri, 12 Sep 2025 16:21:21 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/16] cxl/core: Enable CXL.mem isolation
Message-ID: <20250912162121.0000484c@huawei.com>
In-Reply-To: <20250730214718.10679-7-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-7-Benjamin.Cheatham@amd.com>
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

On Wed, 30 Jul 2025 16:47:08 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Enable CXL.mem isolation during set up of CXL-capable PCIe Root Ports
> that have the capability. This capability is optional, so failure to
> enable isolation is not an error that should fail probe.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

> +static int cxl_dport_wait_for_rp_busy(void __iomem *reg)
> +{
> +	u32 status;
> +	int i = 4;
> +
> +	do {

readl_poll_timeout() in iopoll.h should work here.


> +		status = readl(reg + CXL_ISOLATION_STATUS_OFFSET);
> +		if (!(status & CXL_ISOLATION_STAT_RP_BUSY))
> +			return 0;
> +
> +		msleep(500);
> +	} while (--i);
> +
> +	return -ETIMEDOUT;
> +}

