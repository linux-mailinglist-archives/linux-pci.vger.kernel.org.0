Return-Path: <linux-pci+bounces-23473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D3A5D6D2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65399177C94
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77F1E98EF;
	Wed, 12 Mar 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2C+OsRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC91E834B;
	Wed, 12 Mar 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763269; cv=none; b=hFTpwDIZDTV4jsKY348ib+uWSY3g5cOFwA0JF2j5pVXf3g9hCxzlw6Wt7Ho2bhNei1vdrvD0Ao5CwMiZ4esOy/mh1fDf2xpMwi1ZNOMB42q2qijDF+Iut6I8u3nDHKtOBon0wYJ+WdaL/8D37EAUGiLIU3tKU+ttsGz0oe+7Waw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763269; c=relaxed/simple;
	bh=xkX5hO3+T5vZpdAsfoZaLQBkb+ij52X34+ckdVAMjzQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mU1YRdUTiOjVI9rKiqEFGFi38TKos5ApyacOfUlurWw2XXgDnGW3xeFFjLlOeoF4eIlAAZLOwL6SXzWzyKJKyXZrJp2I4RjYhOL2R7HFVXPEYjiz1IahaYpLDYjROYZEMpRTp+N4rFWTQIwM6vxZkINr5qjmUnGTTB/pzSgvfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2C+OsRe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741763268; x=1773299268;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xkX5hO3+T5vZpdAsfoZaLQBkb+ij52X34+ckdVAMjzQ=;
  b=D2C+OsRei3bPFm195Fe5/jqsFQMrYDhCTuRhz/dUDWme1T2Xz6aboCha
   EdSBco4v29lYhiX4frzRHmrbaRvp8xhpA0/6DDE+caGbs/JlEm7UJJcXw
   8XTk9mi3hHnUnRXwiDKZHhJiOCd4HVxrY32Gragz28Gt5ZXiylsH8oWCD
   v0rZWCAeAN5s+SZziPx5yhFGeMvWivp51SPR+lN19dYpiWgCEAVeiaidW
   xFI3iY8F7KjQQuQ9i8lZ0aaDyEc10wbiMVr289BSRJSIjs0SM0O+u7Hlv
   2JAnjt1Skt3UZUoKa/GmHV73t3vZGvrPcabBPL13PgpCjq0T59Q1Cqxto
   Q==;
X-CSE-ConnectionGUID: ii/Fqg6cTfyfS8i0sj368w==
X-CSE-MsgGUID: xx5kjXguRf+zZ9JDrLTRhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43008859"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43008859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:07:47 -0700
X-CSE-ConnectionGUID: 8ncVAMK5TiK/y6V+rgmE6A==
X-CSE-MsgGUID: gi9Y5KxmQra4GmzB21WXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125179288"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.153]) ([10.124.240.153])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:07:41 -0700
Message-ID: <57dab191-6383-4d51-ba77-4d2cd62cc1da@linux.intel.com>
Date: Wed, 12 Mar 2025 15:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z9CEIlXoQJ-A0t-d@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z9CEIlXoQJ-A0t-d@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/12 2:42, Joerg Roedel wrote:
> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
>> +	/*
>> +	 * And if we do now see any replay calls, they would indicate someone
>> +	 * misusing the dma_configure path outside bus code.
>> +	 */
>> +	if (dev->driver)
>> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
> This warning triggers on my workstation (with an AMD IOMMU), any ideas?
> 
>   ------------[ cut here ]------------
>   reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
>   WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x10b/0x510
>   Modules linked in:
> 
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-iommu-next+ #1 1d691d7aebf343bde741cf4c8610d78a2ea2d2d9
>   Hardware name: System manufacturer System Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019
>   RIP: 0010:__iommu_probe_device+0x10b/0x510
>   Code: 68 00 74 28 48 8b 6b 50 48 85 ed 75 03 48 8b 2b 48 89 df e8 87 71 06 00 48 89 ea 48 c7 c7 90 dd 2c 8b 48 89 c6 e8 35 83 77 ff <0f> 0b 49 8b bd a8 00 00 00 e8 77 ab 85 ff 84 c0 0f 84 ad 01 00 00
>   RSP: 0018:ffffafba00047c58 EFLAGS: 00010282
>   RAX: 0000000000000000 RBX: ffffa00481301c10 RCX: 0000000000000003
>   RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
>   RBP: ffffa00480ffaee0 R08: 0000000000000000 R09: ffffafba00047ae8
>   R10: ffffa0135e93ffa8 R11: 0000000000000003 R12: ffffafba00047d18
>   R13: ffffffff8adac1a0 R14: 0000000000000000 R15: ffffa004802c5800
>   FS:  0000000000000000(0000) GS:ffffa0135ea00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffa00baca01000 CR3: 000000082b838000 CR4: 00000000003506f0
>   Call Trace:
>    <TASK>
>    ? __iommu_probe_device+0x10b/0x510
>    ? __warn.cold+0x93/0xf7
>    ? __iommu_probe_device+0x10b/0x510
>    ? report_bug+0xff/0x140
>    ? prb_read_valid+0x1b/0x30
>    ? handle_bug+0x58/0x90
>    ? exc_invalid_op+0x17/0x70
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? __iommu_probe_device+0x10b/0x510
>    ? __iommu_probe_device+0x10b/0x510
>    ? __pfx_probe_iommu_group+0x10/0x10
>    probe_iommu_group+0x28/0x50
>    bus_for_each_dev+0x7e/0xd0
>    iommu_device_register+0xee/0x260
>    iommu_go_to_state+0xa2a/0x1970
>    ? srso_return_thunk+0x5/0x5f
>    ? blake2s_update+0x68/0x160
>    ? __pfx_pci_iommu_init+0x10/0x10
>    amd_iommu_init+0x14/0x50
>    ? __pfx_pci_iommu_init+0x10/0x10
>    pci_iommu_init+0x12/0x40
>    do_one_initcall+0x46/0x300
>    kernel_init_freeable+0x23d/0x2a0
>    ? __pfx_kernel_init+0x10/0x10
>    kernel_init+0x1a/0x140
>    ret_from_fork+0x34/0x50
>    ? __pfx_kernel_init+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---

I saw the same issue on Intel platforms.

Thanks,
baolu

