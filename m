Return-Path: <linux-pci+bounces-15616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6099B673A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CA41C219A7
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C0215F50;
	Wed, 30 Oct 2024 15:13:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978F21503F;
	Wed, 30 Oct 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301218; cv=none; b=eyqh1UOvIxa8bBucPlX9/5SGnwQLQyYNL1WSfkS7D7A9mhd8A7/Ooml6GQ7ZsINoaeL9xLQxrRrESrbj1KOFI2lXqnY+Z2HJSTHGPeC0TH8TL7w7wy/ssDDveBhzG8SgrXiqFGIb/LOdI1ZC1wegyfmzYREcS8VWRnvxeb2FXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301218; c=relaxed/simple;
	bh=IgNI8lgYFQbAt0dJNQpNKncmbTgA/OCnxxHvT/Lwx9Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9MzI+IcMOre4VObwGBRShcBLD2VxFro0jEzf8aNuFuXpUNfxTAwpwRILhoXrdB6iChxsLlZZg0vAMRisjrHRkMkybTnRnC+AHVnMYMdQ3cRnrVmOd+PiSHMUkDDVmYoKkul7OAhAqWu0oE5lyRw7aNFGJwRmXHk7y+qdxQJJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdr9j3MWvz6GDsD;
	Wed, 30 Oct 2024 23:08:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC7FD140498;
	Wed, 30 Oct 2024 23:13:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:13:31 +0100
Date: Wed, 30 Oct 2024 15:13:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 02/14] PCI/AER: Rename AER driver's interfaces to
 also indicate CXL PCIe port support
Message-ID: <20241030151330.00005e54@Huawei.com>
In-Reply-To: <20241025210305.27499-3-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-3-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
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

On Fri, 25 Oct 2024 16:02:53 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver already includes support for CXL restricted host
> (RCH) downstream port error handling. The current implementation is based
> on CXL1.1 using a root complex event collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
> handling.[1] The CXL PCIe port error handling will be added in a future
> patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

