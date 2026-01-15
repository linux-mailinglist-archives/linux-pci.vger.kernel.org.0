Return-Path: <linux-pci+bounces-44972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44824D257C7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6111D300DCA9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50B35503E;
	Thu, 15 Jan 2026 15:44:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A37E2EB;
	Thu, 15 Jan 2026 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491883; cv=none; b=EN7DhvegmRcMJeJeiTlL1Wt7ab/vwNg4C2b3GMZntA0QEY9xUai/QN/g/5ww9LB2csXq6sjX+TCvwbCh9ud39pnD+2gSYvw7sJuvP6baFoYmmtCCsCduZpr8a1tnaL/kBRRDN2A37rdpjcmQi5RCMeuSHrnOClwQnTgsPdcV+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491883; c=relaxed/simple;
	bh=ct5HMc0px1ai/fmkf2d2a4C+FXS3iFSK7KqXvdu8imU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8bKTZoIrpmiV8rB5LEqgA+/RGNyqd5ycSU9lr0Ie7ogJtBZXBa784wlWsztzQvxdw5DAWRs2z7DNF+B/MBPpDw0oqplq99GttjbCwPV4du273ZnFbK3pL5d98YMcZhMN9Q5FW2YYb/eYwlZrIzCOPDb/ohUt5tKGs6TzaJbP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsS2n0XYGzHnH6P;
	Thu, 15 Jan 2026 23:44:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 37FE440570;
	Thu, 15 Jan 2026 23:44:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 15:44:38 +0000
Date: Thu, 15 Jan 2026 15:44:36 +0000
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
Subject: Re: [PATCH v14 29/34] cxl/port: Unify endpoint and switch port
 lookup
Message-ID: <20260115154436.00003d57@huawei.com>
In-Reply-To: <20260114182055.46029-30-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-30-terry.bowman@amd.com>
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

On Wed, 14 Jan 2026 12:20:50 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> In support of generic CXL protocol error handling across various 'struct
> cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
> port companions from endpoint PCIe device instances.
> 
> The end result is that upstream switch ports and endpoint ports can share
> error handling and eventually delete the misplaced cxl_error_handlers from
> the cxl_pci class driver.

Should mention that you are converting to kernel-doc.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> 

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

