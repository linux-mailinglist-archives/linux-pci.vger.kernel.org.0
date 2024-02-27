Return-Path: <linux-pci+bounces-4075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD88688E6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8E01C21D64
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2252F90;
	Tue, 27 Feb 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmioxoRP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E32D04E;
	Tue, 27 Feb 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014691; cv=none; b=VDy/IGQHv/cGKNLnVFE17JwBO71FFnRmZ+yjRIl1X0tXI9Pj3RLopWJfpJ3olEObGBQIk30k9A/R3IKXIeeEokaxtD+GfKcw8ImgnliS4EsQ4c9+kFa8QvNYtKuOpc7nuSS+hlUaqFvrSEl8FzGKR4AMZ2UfhSG9DYS9pewncI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014691; c=relaxed/simple;
	bh=H3/TmucXlknlmGnXEBs63coRpmsQX8Q70R9XCdjhxaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro/zUOs+atL5rjCJXeQcIEMrgSMyXTQo/5UchDQMrtL2T5s7UbKEise5Zjn+GHfukMAMTzAzMY5ME3C4Od+U4Ey36SG85e2PcCNUBdiJE1CNJVEk+AtXU6nLpTReHVSpAjf45oNOj3BOQl0HrU5fN4OOlXc9FPl/51KWinvdAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmioxoRP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709014690; x=1740550690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H3/TmucXlknlmGnXEBs63coRpmsQX8Q70R9XCdjhxaU=;
  b=nmioxoRPBxtm0SsdnZPdSMgCFvkYlPWj77hf+syL3TzgkXmnIm+S76Jc
   UrfgjnglF9ZnGI2QAxy+DZrBoCB4zP+QZ05y7vSAF+OwfNt1FUlBMxo25
   Dc4G5KNB5FPTx8QLOXIMVtFBDi+URpFQiOZT2JNpzfd0VlR555/4adop5
   8UkmP+62brpcfTMEqDZukEaxZIw3OG/se+A3NdHR+jVlwxtwhde/kskom
   fDcH3ZDm+6c1NGgycEiLadRE6ki8kDFFmOzfuu/AJxvOAPYEsfM1zghwJ
   nHS3zYuKJhXm2ab2673vs68HTQQzXPKBk+gxL5KrwkpuMPftKTASysEG5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20784922"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20784922"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6893885"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:18:06 -0800
Message-ID: <89984f11-b84e-4da0-ab5b-f2048461aae0@linux.intel.com>
Date: Tue, 27 Feb 2024 14:18:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI/DPC: Clean up DPC vs AER/EDR ownership and
 Kconfig
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Matthew W Carlis <mattc@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240222221521.32159-1-helgaas@kernel.org>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240222221521.32159-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2024 6:15 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously we could request control of DPC without AER, which is illegal
> per spec.  Also, we could enable CONFIG_PCIE_DPC without CONFIG_PCIE_EDR,
> which is also illegal.  This series addresses both.

I have a question here, how to understand the relationship EDR & AER ?
somewhere EDR touches AER status without checking _OSC granted bits,
such as
    pci_aer_raw_clear_status(edev);

sometimes EDR calling AER with host->native_aer checked, like

pcie_do_recovery()
{
  ...
  if (host->native_aer || pcie_ports_native) {
		pcie_clear_device_status(dev);
		pci_aer_clear_nonfatal_status(dev);
	}
  ...
}

That is really confusing. could we do some cleanup to eliminate it ?
such as seperate AER code into common code and runtime part.


Thanks,
Ethan
  

>
> Bjorn Helgaas (3):
>    PCI/DPC: Request DPC only if also requesting AER
>    PCI/DPC: Remove CONFIG_PCIE_EDR
>    PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
>
>   drivers/acpi/pci_root.c   | 22 ++++++++++++----------
>   drivers/pci/pci.h         |  4 ++++
>   drivers/pci/pcie/Kconfig  | 14 ++++----------
>   drivers/pci/pcie/Makefile |  5 ++++-
>   drivers/pci/pcie/dpc.c    | 10 ----------
>   include/linux/pci-acpi.h  |  8 --------
>   6 files changed, 24 insertions(+), 39 deletions(-)
>

