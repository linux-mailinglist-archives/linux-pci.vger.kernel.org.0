Return-Path: <linux-pci+bounces-4764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E0879D82
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 22:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9516D280C02
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E4142636;
	Tue, 12 Mar 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot4A0ElF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B016FF3B;
	Tue, 12 Mar 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279098; cv=none; b=X06aTlGWZOYhENmqQ9TYrRFXGTYPqQM29WSj+cNlNc4DDB3A4NhcG23n1hEK5BBRs37z8G6FDaOCV5FytpT/DSehAcU355LGrUabe/uAhX6hdjb5XjkjcresjDEILfT770JJ7zT1Q8sorJbqlb3bxskVZqJH1nJm/fGtENfdkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279098; c=relaxed/simple;
	bh=TeHuMfRVF73VXvD8LVUGV65bfdXmB7UAtQdrGlMoo/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thj7lue989KoGl64DI5VJ6poAhNMelh14daKyfb7qro4Cwdbz8GrRUE0clPhGKBkamDzQudPCSgtXN8z36im+IZX3U0Id+RbvKbjL68gEBBquLJCIi219R2jMq+BgmxQU0fnQb12Q0rmo3CEOzlpwkleHPvNqwt847OUqfIMThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot4A0ElF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710279097; x=1741815097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TeHuMfRVF73VXvD8LVUGV65bfdXmB7UAtQdrGlMoo/8=;
  b=Ot4A0ElFWHzP7tMPQM0A7BG7bmqZ3EETW8kztvcIdekrraXKsi9fvP0r
   kfpSk1tS1IxRDVPyYJeX1/xL4esIM5X0Y+Egd8r+qO9WFae6lT508ocJe
   9lKH1VQnvxrUwvw3y/o9jkzEnV9UAWG/z2C4Vj/QgyNM2XkGRh4PsIcuK
   ZmmxFkBgD+9p2OYpEd24W4jpQPcY4jEYwo7iwQVsnn9V8zR5ZUy8VPZRl
   URfpHbGhOD2aWWtt3wx2OF0LxUE7pfTaBmgU6PHtOR/vYzyafCtDbEead
   qSfN9hXd2IcnAriFu1jcqF0mzI/eUEq4uiVMb9K+R5L0+LmADhsUF8cG6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8829620"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8829620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16326316"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.101.145]) ([10.212.101.145])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:31:35 -0700
Message-ID: <d43fe460-8097-4a9d-8cdc-817aabe4590c@intel.com>
Date: Tue, 12 Mar 2024 14:31:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] PCI: Add Secondary Bus Reset (SBR) support for CXL
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com
References: <20240311204132.62757-1-dave.jiang@intel.com>
 <ZfAIPSy8uih74ZkK@wunner.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZfAIPSy8uih74ZkK@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/24 12:46 AM, Lukas Wunner wrote:
> On Mon, Mar 11, 2024 at 01:39:52PM -0700, Dave Jiang wrote:
>> Patch 1:
>> Add check to PCI bus_reset path for CXL device and return with error if "Unmask
>> SBR" bit is set to 0. This allows user to realize that SBR is masked for this
>> CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
>> setpci, then the bus_reset will proceed.
> 
> So is the point of patch 1 only to inform the user that the SBR has
> no effect?  Or does the SBR have any negative side effects that you
> want to avoid (e.g. due to the config space save/restore)?
> 
> If you only want to inform the user, then this functionality could
> live in a ->reset_prepare() callback exposed by the cxl subsystem
> and the pci subsystem wouldn't have to be touched at all.

Patch 1 is to inform the user that SBR has no effect. The user needs to be informed via direct errno feedback that reset is masked and isn't going to happen. In this [1] response, I believe Bjorn wanted pci_reset_function() to fail. ->reset_prepare() is only helpful if the cxl_pci driver is loaded. CXL mem devices can be programmed by the BIOS and be active without CXL driver being loaded. Also, cxl_pci only picks up PCI_CLASS_MEMORY_CXL. So other CXL devices would not be managed by this driver.

[1]: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/


> 
> Thanks,
> 
> Lukas

