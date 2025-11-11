Return-Path: <linux-pci+bounces-40925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A0C4ED97
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610AB3A9117
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40D369969;
	Tue, 11 Nov 2025 15:43:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC812F7479;
	Tue, 11 Nov 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875827; cv=none; b=sD07qrsv5JUdZuXdGuLvY2yX2rkGWqrk+bP/g2TPvdsCkEN8Kzzn/qhiOf4Kwq1cZoORPqZccCH9zh7U6LzXBqkyT6GTiRgHHu7eZwgb6J7jaaaCiPm48a/CWGC/TTiS/9mdYTzmPWeAqCqkSiOoRxCITKoYwZ/B2A5qaQjgPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875827; c=relaxed/simple;
	bh=3sycy4wzLpo/QkHe5ysW7JWVGqoOwxBOkVNTup8L3SE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8Pm4A7MXa+na3Hbdr/EdVJbVARGf55rwS4PhNbsqaiSGH9Neb/jCAXPWTETcIe7fEQE8aboPTvD8GQc5vX3ww8SUiGOxAInEsplGiIqaTt+zMxmZ4fWs0e5iRUO8rr7qECkShNBd8UgeCsNBT9h7jf8O8NxCkwDqkMoXtzng/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5W5X6W9SzJ46Zq;
	Tue, 11 Nov 2025 23:43:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ECA1D140278;
	Tue, 11 Nov 2025 23:43:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:43:42 +0000
Date: Tue, 11 Nov 2025 15:43:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/6 v7] acpi/ghes: Add helper for CXL protocol errors
 checks
Message-ID: <20251111154340.00002a39@huawei.com>
In-Reply-To: <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
	<20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
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

On Tue,  4 Nov 2025 19:22:35 +0100
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Move the CPER CXL protocol errors validity check out of
> cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
> the serial number check only to CXL agents that are CXL devices (UEFI
> v2.10, Appendix N.2.13).
> 
> Export the new symbol for reuse by ELOG.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

