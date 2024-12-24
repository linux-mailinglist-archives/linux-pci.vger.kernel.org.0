Return-Path: <linux-pci+bounces-19016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B739FC14F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312A61884E5B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC6212D60;
	Tue, 24 Dec 2024 18:41:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609417BED0;
	Tue, 24 Dec 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735065688; cv=none; b=NPSEAUgrVnPG/kBt8QAxn1aRgRNHuc5m9LtfE6z1a+vL2hSysfrgcr/h65TYjGJAosiSZH+1bx9DOIiTPYx3kFcob5g5HLo5GvSGw3l8eRUQMHsdxk9um6ql8MpFv6jJxjiedlCRC+8c1HTQrlgiZTzx8QD44t3Jz/9GhYtDBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735065688; c=relaxed/simple;
	bh=4GFEabpFyuBtp1NyOMT6FhbW87KImz1LMF/O2wQ+42w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvEj8Q++mPbvWdWNU9gV5xUbwHzPWsWFGMpN0E1Ce+8eTUHNItGwREFFNc58Aay0YHWARg5gAkXcZcGEf0xKHyIxokh0+vx2IEO+aDuO8Xr5RV3A4ssJm/GtP7Q4qjSkqQOLgKXBvshvMfGfGSTfJ05+T35ZlpMtl8CP/Nqxzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkGL4mb3z6L75g;
	Wed, 25 Dec 2024 02:40:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 52A3D140736;
	Wed, 25 Dec 2024 02:41:24 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:41:23 +0100
Date: Tue, 24 Dec 2024 18:41:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 09/15] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <20241224184121.000077fb@huawei.com>
In-Reply-To: <20241211234002.3728674-10-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-10-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 17:39:56 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping AER
> registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

