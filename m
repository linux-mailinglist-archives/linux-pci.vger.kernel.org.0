Return-Path: <linux-pci+bounces-40268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF5C32992
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2F4F5C4F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7934403F;
	Tue,  4 Nov 2025 18:15:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661233E37E;
	Tue,  4 Nov 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280113; cv=none; b=SSK65MPi//DPPhQxRtMsa3HtJiLm/RPZ4TqQBEr2e37CH2h9p63Orcj3rC4Tzl8Qezi+ChDi+DhiUDEs/NSWzo1/fWZftWjHYnUncy50wUeeVNhV0izDAol6KscK1Mpm3GxHbvborDhWFgY9qRIi/c4C/jTXqLUzC07lHKNHQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280113; c=relaxed/simple;
	bh=CV+o8GOzvR6XGgD3NENICogCDfbFme5Q0xgCrolFes8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmC46vVbH6IuRbP7/8Pen67px3TlPLRP7Q/mn9qGvQiL9iYD/huwKax5KoIU4WN/rwySFLCdpmS3i9gIyaJIZekROQlk2X/vNZJs+D69yE06EQpnk5UVCp8+NMsVFIyAIl0pvEA6aqYbfnenK/sEfO1uStH3jMDodvrv4wYTJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1Gjd5K7pz6L56g;
	Wed,  5 Nov 2025 02:11:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D0CD41402A4;
	Wed,  5 Nov 2025 02:15:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:15:06 +0000
Date: Tue, 4 Nov 2025 18:15:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 14/25] cxl/pci: Map CXL Endpoint Port and CXL
 Switch Port RAS registers
Message-ID: <20251104181505.00001bb4@huawei.com>
In-Reply-To: <20251104170305.4163840-15-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:54 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
> mapping to enable RAS logging. This initialization is currently missing and
> must be added for CXL RPs and DSPs.
> 
> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
> 
> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
> created and added to the EP port.
> 
> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
> Upstream Port's CXL capabilities' physical location to be used in mapping
> the RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


