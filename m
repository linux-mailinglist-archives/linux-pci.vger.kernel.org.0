Return-Path: <linux-pci+bounces-44967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CAD255F5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F40E300B2A1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6335CBB4;
	Thu, 15 Jan 2026 15:28:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC292750ED;
	Thu, 15 Jan 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490919; cv=none; b=poO0F/IijDA8kEObcw8j2aL/o1B4V1HPIIq1KszeimpLQ80DlbPHG0Ayps92DCQzebHpKSwe1WdtTJlGc3cWPk/ijFFWrd1DZPooxARasN8VHYMG/7mnaYYXgEIBwgdcdctJo/eqiRb3B7armSavC3tRggJ9B6rNqOXdJilEkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490919; c=relaxed/simple;
	bh=9T9Pv2C5kuEn0v75x6Zf0A6NA+bc7HEMNOme53e3aaQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uqi46S+Dr3wFWwBQA/Xmy4Potstn9TSx0+jvQ0hBckSvWtwPfrthfGi6D0lVDf8rZJYYw1p6BW3qi7BR2HNiLOFNPZ5XFGqP/9jgQHRKeKoJYWnF/xebyQFTSNrJznoAHAxrqSMe8QNJs5pMuxhIcJ+HKTqgFva9ii3VPOe9Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsRhK4WWGzJ46DW;
	Thu, 15 Jan 2026 23:28:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AC5F40572;
	Thu, 15 Jan 2026 23:28:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 15:28:32 +0000
Date: Thu, 15 Jan 2026 15:28:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 24/34] cxl/port: Move endpoint component register
 management to cxl_port
Message-ID: <20260115152831.00001950@huawei.com>
In-Reply-To: <20260114182055.46029-25-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-25-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:45 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> In preparation for generic protocol error handling across CXL endpoints,
> whether they be memory expander class devices or accelerators, drop the
> endpoint component management from cxl_dev_state.
> 
> Organize all CXL port component management through the common cxl_port
> driver.
> 
> Note that the end game is that drivers/cxl/core/ras.c loses all
> dependencies on a 'struct cxl_dev_state' parameter and operates only on
> port resources. The removal of component register mapping from cxl_pci is
> an incremental step towards that.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


