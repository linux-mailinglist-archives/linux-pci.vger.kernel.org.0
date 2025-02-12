Return-Path: <linux-pci+bounces-21315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B24A3328D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2B0188529C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12920408D;
	Wed, 12 Feb 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkAMQcp1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9B202F68;
	Wed, 12 Feb 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399292; cv=none; b=tdYXVE6F7L+qA3CtoeWUcVkx7HL0ZEXRilPMepZ1h2nPkd01nLTZLKaT9Say7ww86dCiX0DN7ChpNIJwuydxESti7+HXBVZRM3GDSkgR2wXs5LKwIxCQYvPkZqqz2afyeAb+r6rXQWDfSsnCtdpAmwanZtySCTvOosBsFfXMVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399292; c=relaxed/simple;
	bh=/EyQTcmIM7aiXAGK890xTjnxKPcM/oracEWhG+HK8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S43iU7XT0EET47JZ0YRXTaYxySNmzeSY8wgg5SnO37Mze2p7ODvJIykK2oqsZKIUwpnEFSg/dWRq6qDWQNRjCtmyQueeAInG87eZIqpgBaZPwnCQXRP8xzlY1vRrWD0epaSS4O5t6KC0TjCxvlsXsgMwbhPkLkVE12tDnMMsqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkAMQcp1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739399291; x=1770935291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/EyQTcmIM7aiXAGK890xTjnxKPcM/oracEWhG+HK8qk=;
  b=KkAMQcp1qi9ifr//lD9PMJVBTXHjMPsin3vwpo9/m6oW6dloK2Euo/rP
   q00oAr+Zuj3lNBUhDZuJ9XLmWsuouWWs7IwJG+fTFDCZ/DmaFUnY4OA//
   8Kp6rZX2MX8Vu8x8JYGFjrlf6NRtKj4NoWR+v/5fpyQ03fTpunk5eNThZ
   nkSlZGny1scAfPpscgoMGmh5s5gZH+39aw3/91W0D7w8Gu+Zf34Qzb6nX
   crXGn8jEf57xBLXHlW4AmPdiOOCe72oy5mA+yAvJRLQ5gGsmCJkbYuFm0
   V6p4Deznsz39dZ2O54DWGTuy2c1A+EYNwytuLPZCyNFb2M6g5pB8ViCjM
   Q==;
X-CSE-ConnectionGUID: o9VUieeiTzCvjU1svKiYlA==
X-CSE-MsgGUID: s6Iud7FORD+WYCTWTxNRmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51067485"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="51067485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:28:10 -0800
X-CSE-ConnectionGUID: Lpbgfi5VQQWUwOqQ7obejw==
X-CSE-MsgGUID: RuAFF4fXR1mSm99+ay6QGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150125721"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:28:09 -0800
Date: Wed, 12 Feb 2025 14:28:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <Z60gdyVGJQSLRER9@aschofie-mobl2.lan>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-8-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:34PM -0600, Terry Bowman wrote:
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
> 
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is required because multiple Endpoints under a CXL
> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> once.

snip

> @@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {

With this change an update to cxl-test is needed.
This func was wrapped to make sure no mocked dports are sent to
cxl_dport_init_ras_reporting(). 

2c402bd2e85b ("cxl/test: Skip cxl_setup_parent_dport() for emulated dports")

This works for me:
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index af2594e4f35d..1252165bffba 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -299,13 +299,13 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
 
-void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (!ops || !ops->is_mock_port(dport->dport_dev))
-		cxl_dport_init_ras_reporting(dport, host);
+		cxl_dport_init_ras_reporting(dport);
 
 	put_cxl_mock_ops(index);
 }



snip to end

