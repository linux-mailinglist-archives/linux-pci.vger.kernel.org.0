Return-Path: <linux-pci+bounces-26083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FDA91916
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1065A3BE646
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5181D89E4;
	Thu, 17 Apr 2025 10:19:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA7225771;
	Thu, 17 Apr 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885144; cv=none; b=iOp/iQjAtbavDcNPrAsW9Qo1ViHxFs7r7ftaucohrIb7v03gCU3dq4KECoFbu3lKf9EI9ztRiU0tJB9g7ihTVzp/dzH1QMVyGvDKFjKj5+Tci88KBLZoE29ahb4KG9ejQugCuBqrDpJL9maqkBrTgoSSLzetguimQdRqklyqOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885144; c=relaxed/simple;
	bh=Bs7brK40Y35b1gKimKfCElNCrkod205joKJ4EkJTeBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU62+9kCCPok4i38ZjJiiu/9ctyG57tVegPhwayvujUmG6nmftkJhPyPhC+RDLCmXcwA7zvnFLYiL0KFSSuLzICrQkEgXCsdda21W2XuozhYttYEpJSJqSiPEzKmltws+Omy1zusKGCxc9doKiTBeQQY1/1oIW7VEFN+QPFrHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdYfV6ngQz6K9J5;
	Thu, 17 Apr 2025 18:14:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AD0421400F4;
	Thu, 17 Apr 2025 18:18:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 12:18:58 +0200
Date: Thu, 17 Apr 2025 11:18:57 +0100
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
Subject: Re: [PATCH v8 07/16] cxl/pci: Move existing CXL RAS initialization
 to CXL's cxl_port driver
Message-ID: <20250417111857.0000224c@huawei.com>
In-Reply-To: <20250327014717.2988633-8-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:08 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
> with CXL port management.
> 
> Additional CXL Port RAS initialization will be added in future patches to
> support CXL Port devices' CXL errors.
> 
> Move existing RAS initialization to the cxl_port driver. The cxl_port
> driver is intended to manage CXL Endpoint and CXL Switch Ports.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

Sorry for the interrupt nature of reviews on this. Crazy week.

Anyhow getting back to this series...

I'm not a fan of ifdefs in a c file.  Maybe we should consider
a port_aer.c and stubbing in the header as needed?

I think it ends up cleaner both in this patch and even more so later
in the series.

Jonathan

p.s. And now I need to run again.  I'll be back!

