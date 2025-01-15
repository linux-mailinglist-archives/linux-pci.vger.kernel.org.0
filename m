Return-Path: <linux-pci+bounces-19885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AED2A122E5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BECA3A2D08
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7323F275;
	Wed, 15 Jan 2025 11:42:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71B248BB5;
	Wed, 15 Jan 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941345; cv=none; b=O4GrbhQw1+5tfcIfFt5iJpB/8Io/v61LwFaHZzmvUJKcyngJcRvOMUbPVuz2tk4bXlJS8+3q0d3cR3Vj+WtWiZRvfrJVHL8qnSHnBrFN32yovh0rhfd3oVqGh/xNKjim3B+J7/qGe8kg0tM3ZP0JDIj180CesAvF4+n8/ZMbx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941345; c=relaxed/simple;
	bh=ELJs6KSAk9xQhpVupr7ov/U89hmZ3QN8zl1/Nr+NF9c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1Q29rnpSIBFczs5eEU0QFY+xndtlClkILI7U7LewM67qDTfxWkHIA7wxo7/zVW3P5K1KZagBsyO1VGhKb+hrKd0agtD2fATKKxV/QG9L6dG5nlTkIPhdPb7Rgfeokcku78Zq7lf/KLs5llyduhmdhcldiH/u5ZqjObxiqb19I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY3w40Crhz6M4Qs;
	Wed, 15 Jan 2025 19:40:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D4B41400F4;
	Wed, 15 Jan 2025 19:42:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 12:42:20 +0100
Date: Wed, 15 Jan 2025 11:42:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 14/16] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <20250115114219.00003946@huawei.com>
In-Reply-To: <ede2efa6-1f67-466b-9f86-883b25092d2c@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-15-terry.bowman@amd.com>
	<20250114114927.000022ef@huawei.com>
	<ede2efa6-1f67-466b-9f86-883b25092d2c@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> >> index 8389a94adb1a..681e415ac8f5 100644
> >> --- a/drivers/cxl/core/trace.h
> >> +++ b/drivers/cxl/core/trace.h
> >> @@ -48,6 +48,34 @@
> >>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
> >>  )
> >>  
> >> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> >> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> >> +	TP_ARGS(dev, status, fe, hl),
> >> +	TP_STRUCT__entry(
> >> +		__string(devname, dev_name(dev))
> >> +		__string(host, dev_name(dev->parent))  
> > What is host in this case? Perhaps a comment.  
> host is a string initialized with value from dev_name(dev->parent). What
> kind of comment would you like to see here?
What is that parent in practice?  A port, an EP, a PCI device?

> 
> Regards,
> Terry



