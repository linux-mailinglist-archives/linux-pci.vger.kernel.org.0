Return-Path: <linux-pci+bounces-25295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05604A7C219
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68E71B6247E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63120D4E4;
	Fri,  4 Apr 2025 17:05:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632E21019E;
	Fri,  4 Apr 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786344; cv=none; b=ptd4VoXwjTUEUjdXWNOVi0o4RWVRh8bWV81pvvYJzFEVovocKkerMvjj3PJeabmwTfbgRc5WJzhySOVGZ4QAhvYx0mMbO7p0w7kycvpu1Sdzm68QWpX1P0HXkD3R4rbj0tb1cb8E0G3CSSBQIgeBru4COyIwQm0NTwWRYJdaanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786344; c=relaxed/simple;
	bh=KkqU4JppGhb3zMmUsaVRnvZjxOTggAwM2LhYTLgmj2M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo3qkWkFpqASYnrsNeR4jkvxovHzseKFrvR1C1I6sy8mO8IeR56PSgUOZ6rhSTH986yrwCz5kA0v3d++7LGniBAr8t4BBpkQnOK7GXab8PX+ekIHbc2fmumF3HJLapwdjpp0uru1nySSv9K8u9XsZtWcxYR9rUCHTzSb1tcPTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTlJQ2F9lz6K9GR;
	Sat,  5 Apr 2025 01:01:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E14A1402C7;
	Sat,  5 Apr 2025 01:05:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 19:05:38 +0200
Date: Fri, 4 Apr 2025 18:05:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 15/16] CXL/PCI: Enable CXL protocol errors during CXL
 Port probe
Message-ID: <20250404180537.000074fd@huawei.com>
In-Reply-To: <20250327014717.2988633-16-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-16-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:16 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL protocol errors are not enabled for all CXL devices at boot. These
> must be enabled inorder to process CXL protocol errors.
> 
> Export the AER service driver's pci_aer_unmask_internal_errors().
> 
> Introduce cxl_enable_port_errors() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

