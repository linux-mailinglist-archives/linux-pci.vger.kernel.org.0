Return-Path: <linux-pci+bounces-19015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1E9FC14D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88641884B07
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDA212D60;
	Tue, 24 Dec 2024 18:38:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD417BED0;
	Tue, 24 Dec 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735065536; cv=none; b=fH+vxNaSPX/SLL/3wK9WyV4H4vdU2luS37ehPxsWCXQsuEQAfdGC13Z9nM7/35eJynGn8rR93n0n0HW/vljl1UypejNgrKb3PVWBZRuiSRMCOjH6RkOMdtBM2SCTMNNB4TBn60dGnSVDwsGUktpMMP/m79oVVRBB0aEZJe7tGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735065536; c=relaxed/simple;
	bh=78E+4bGWrla75QUQPRCSwkgsAf+roSZzHbFz6beyVJM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtmHjVFU3a2kc4sxXWcKFWH08o1jSQNMOgwyzWd2Ctv57s7dfHnrPiaaOzy01b7xFA75NAG76YlAU9s+0mavqUB1Oy19Vix/lObcC74dA/weIyHYVMOO+ZRSRD5raI5NFq0gpBCK4iX65RkVAyyJX4Hu8j+H0Ey797sMTUrgQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkDQ3BTyz6K614;
	Wed, 25 Dec 2024 02:38:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D4162140AE5;
	Wed, 25 Dec 2024 02:38:50 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:38:49 +0100
Date: Tue, 24 Dec 2024 18:38:46 +0000
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
Subject: Re: [PATCH v4 08/15] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <20241224183846.000064fd@huawei.com>
In-Reply-To: <20241211234002.3728674-9-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-9-terry.bowman@amd.com>
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

On Wed, 11 Dec 2024 17:39:55 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's Root Port. The same needs to be done for
> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> the endpoint and CXL Host Bridge.
> 
> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> sub-topology between the endpoint and the CXL Host Bridge. This function
> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> associated with this Port. The same check will be added in the future for
> upstream switch ports.
> 
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().
Could possibly do that as a precursor.

> 
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is necessary because endpoints under a CXL switch
> may share CXL Downstream Switch Ports or CXL Root Ports. Ensure the port
> registers are only mapped once.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

