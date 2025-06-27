Return-Path: <linux-pci+bounces-30911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03786AEB3F8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B293BE4B9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487CC298249;
	Fri, 27 Jun 2025 10:12:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3321298242;
	Fri, 27 Jun 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019179; cv=none; b=qYq+baT7GpG41Boac5J6CHYLX+OSW6cttCWJ5/RyjMMtxncx61X9MH+xA/3fXXB8tgjxo7ySaYce0ySx9j+AzfUWoWiQkrLmnqxZmP3W18VMETcrvpTQD6/JqyxiyfHy/gxHxdkPkdyI1IlO7zwxK4iWPKZKiiYnZ/LwjaMJ3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019179; c=relaxed/simple;
	bh=ACT/+OHmISkipT0R7m3k8YttxXMJkOC/TqU0F57vO0o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlZhfdi9AtByXN5D5CaWxd98qI/R3gGx7q2uIC0HTpYhSjA4Df05ihHc8EWmgNTdDTfNnUVe6eODGscA45a2hFcEX1ZURQDLhnBRAYCRPH3lroZNAY5b7BP57InEGKeK3+xuddms0YeiyvcjffS7PKOFaBU5uEBqCuKLJF/183A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTBBV0GCKz6L5Dt;
	Fri, 27 Jun 2025 18:10:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 278C31402ED;
	Fri, 27 Jun 2025 18:12:48 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 12:12:47 +0200
Date: Fri, 27 Jun 2025 11:12:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver
 file
Message-ID: <20250627111244.00003dee@huawei.com>
In-Reply-To: <214c9b73-6e62-40c0-a805-56127269941a@linux.intel.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-5-terry.bowman@amd.com>
	<214c9b73-6e62-40c0-a805-56127269941a@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 16:42:09 -0700
Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> On 6/26/25 3:42 PM, Terry Bowman wrote:
> > The CXL AER error handling logic currently resides in the AER driver file,
> > drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
> > using #ifdefs.
> >
> > Improve the AER driver maintainability by separating the CXL specific logic
> > from the AER driver's core functionality and removing the #ifdefs.
> > Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
> > new file.
> >
> > Update the makefile to conditionally compile the CXL file using the
> > existing CONFIG_PCIEAER_CXL Kconfig.
> >
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > ---  
> 
> After moving the code , you seem to have updated it with your own
> changes. May be you split it into two patches.

Agreed. I think the changes are small but a direct code move followed
by cleanup (I think it's the mask and the comment update only?)
would be better.

Assuming you do that, for both resulting patches:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

