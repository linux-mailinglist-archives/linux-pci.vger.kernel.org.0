Return-Path: <linux-pci+bounces-19017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE59FC151
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AAA162AF9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB64212D60;
	Tue, 24 Dec 2024 18:42:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63E17BED0;
	Tue, 24 Dec 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735065742; cv=none; b=KOuAZ1mZgPOuUlZa2k0i/mmQUxa6vDdFnVUSE56bbCfkvWviRuBOEbXeH912rfnURv1xjuj/cMtMDJ9oinLbh8XmpmQnkJbkSPHVPU0yRXMGAvpO6yuahnwTcgjAXhLyrbikBEtnXlq7vm8W6RVsOzNuIle26lFv4yZywh6T/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735065742; c=relaxed/simple;
	bh=QOjh6/IjjJ4JH48ixHDcnzQKpf4mP7Z8AHyxnX0teBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6i9MAxPsSOQOBUJR4cD2+jBqZr67qYeOhSp7Tv4rEZfvYmwNEiGsaCOCMwIqfPU8vC2SNw+aiVgA39iMf5j8mAgOduFNV9/3hPwHDfzeI4Njbrww+/+tPZyKlKIvYKn50kzIlZ3NQ759HBOQ2afVsMARwX8mgkVh5bfuOZ1w8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkJP1lLWz6K6NG;
	Wed, 25 Dec 2024 02:41:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4A3D140736;
	Wed, 25 Dec 2024 02:42:17 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:42:16 +0100
Date: Tue, 24 Dec 2024 18:42:15 +0000
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
Subject: Re: [PATCH v4 10/15] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <20241224184215.00003b5b@huawei.com>
In-Reply-To: <20241211234002.3728674-11-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-11-terry.bowman@amd.com>
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

On Wed, 11 Dec 2024 17:39:57 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL PCIe Port protocol error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port protocol errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

