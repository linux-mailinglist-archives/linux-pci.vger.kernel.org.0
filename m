Return-Path: <linux-pci+bounces-21472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6FA361DA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61F017169B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBDA262D23;
	Fri, 14 Feb 2025 15:34:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916B266B7D;
	Fri, 14 Feb 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547280; cv=none; b=YKOkq9jmBlANb0t+6Qg+v61tJjiUrXirAd30C8poAPWn9IexH3HMW59TBGZfLX6vr0I0x7ys9CcyocdIWY0dBohJqxoteyDAHaGtpp4zgbgHU1Aqvi/wmcgnmJg8qq9amdNvC2G8X6+2nMgjjmeLthkCp4CQsvdgCHxotFcb/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547280; c=relaxed/simple;
	bh=GsFGi6rSs0icSle4cE22kTLVvnu4fk3vRmVo4qXm/E8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Byl4uqjA5y4kqdeLEFrWRKV+y8MeAeJzbVfDB/+tERtoUrt90WedItLm5RRyz0iL9NWo13FEMsgByWH8OL+Vz6u8ZD91NO1ZKnqmLNtCu1rzgr7E94n8S8XMxe6ZCm2ZWTePnhSDEjVoIxXrsefYQ5nNPIgLkWFqc9H7S5VPTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvbcc0vkDz6L58H;
	Fri, 14 Feb 2025 23:31:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EDAE2140B38;
	Fri, 14 Feb 2025 23:34:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:34:34 +0100
Date: Fri, 14 Feb 2025 15:34:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <20250214153432.00005bbb@huawei.com>
In-Reply-To: <67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
	<20250211192444.2292833-14-terry.bowman@amd.com>
	<67aea897cfe55_2d1e294ca@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Feb 2025 18:21:11 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Terry Bowman wrote:
> > The CXL drivers use kernel trace functions for logging Endpoint and
> > Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> > is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> > Upstream Switch Ports.
> > 
> > Introduce trace logging functions for both RAS correctable and
> > uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> > the CXL Port Protocol Error handlers to invoke these new trace functions.
> > 
> > Examples of the output from these changes is below.
> > 
> > Correctable error:
> > cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> > 
> > Uncorrectable error:
> > cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'  
> 
> Oh, so this solves the problem I was worried about earlier where it
> looked like protocol errors only got notified if the event was a memdev.
> I still think it would be worthwhile to make this one unified
> trace-event rather than multiple.

I'd go with a 'maybe'.  Absolutely would have made sense if this
had been the intent from the start.  Now we are going to end
up with at least some tracepoint fields that are mutually exclusive.
E.g. Switch ports aren't going to want to set memdev.
Might be easier to just keep them separate.  However this will get
messier anyway when type 2 devices come along.

Jonathan

> 


