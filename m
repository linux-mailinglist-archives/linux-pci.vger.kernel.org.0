Return-Path: <linux-pci+bounces-10689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802C93AB41
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7421F233EA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148EC17547;
	Wed, 24 Jul 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKV+1CUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92502595;
	Wed, 24 Jul 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788478; cv=none; b=brWKW4V6Zy4IM+keAVOP+h0Y/aNS6E2JATLw0acZCDB9zTIhuHnRxnAhjBSmE/9qqIJwjpNpBvtpEhAvRis5g/0Z+6kq5v4eBZlVn+dU1z9tf+mWAuYMibCRMSKBId8rU5AHu6/6Uvpae6ElLPhwV0hWnhjTUrYrFR+pTs0VY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788478; c=relaxed/simple;
	bh=49sitEwGOYl2Q6OgN0ebMfQVcpJ3UCgVODMPWgNQFts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHz8nW28jxgVcEsScQTDvuJE1M9SbKT79Ay+p457byOKLMtgcOfMZNSH18JuWqHzkxgase8vW+xYio38yCoM10o9mZ90AoidyDv98MftC5L1tEqWjq2GQP5Fgb30cqe9Biu+1vsJyjHdi+MTtOr7DbOua8VdJgdv4mVo9Rv5hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKV+1CUm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721788476; x=1753324476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=49sitEwGOYl2Q6OgN0ebMfQVcpJ3UCgVODMPWgNQFts=;
  b=IKV+1CUmLyslmGUxuaTXxfPsPJUup9S0E/OhsIDgCVJjdwOfQlP/qa73
   iYjP+6s2MzJZub6dUIEcoRrz1zC9ZDdE2A6BWm3Yms+aUzty7axsb1kdW
   2x8f+VfVz+gyRvJYr5JqL8szDFFGmtt85QYy1Vy1GE56qa5Rgb0dc/0Cw
   UK+LQ/uuW1qL+5XBSGrqO1a7RFmbXxUkyW8rr2v+eC/G31nOZLgT/6EN3
   HizwHPIqviw65K215y62fRJbOwRILzoMGaKfraU89J2ikzTk0QIEt6uGQ
   zDNBdYD+kdV0ofdacbFLGv1Yk/NoqS7tr45zcTMJl6/mUgCFyu9pPiNcV
   A==;
X-CSE-ConnectionGUID: 37QoE+zzSVmZpgXtj5R5/Q==
X-CSE-MsgGUID: +N/6Sil8RauKi+I1Wp11Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="41969888"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="41969888"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:34:35 -0700
X-CSE-ConnectionGUID: AColBQhpQ86l10xKNojZNg==
X-CSE-MsgGUID: IlEoyNzDSjeNjljnKGjX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57550296"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.9.238]) ([10.124.9.238])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:34:34 -0700
Message-ID: <e5c1990b-8c40-4376-bd9f-3701bf4eab91@linux.intel.com>
Date: Wed, 24 Jul 2024 10:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Subject: PCI: Enable io space 1k granularity for intel
 cpu root port
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>, helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lkp@intel.com,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <20240712184849.GA330337@bhelgaas>
 <20240723080403.9764-1-zhoushengqing@ttyinfo.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240723080403.9764-1-zhoushengqing@ttyinfo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/23/2024 4:04 PM, Zhou Shengqing wrote:
>> I think this has potential.  Can you include a more complete citation
>> for the Intel spec?  Complete name, document number if available,
>> revision, section?  Hopefully it's publically available?
> Most of intel CPU EDS specs are under NDA. But you can refer to
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v2-datasheet-vol-2.pdf
> keyword:"EN1K".
>
>> + /*
>>> + * Per intel sever CPU EDS vol2(register) spec,
>>> + * Intel Memory Map/Intel VT-d configuration space,
>>> + * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
>>> + * bit 2.
>>> + * Enable 1K (EN1K):
>>> + * This bit when set, enables 1K granularity for I/O space decode
>>> + * in each of the virtual P2P bridges
>>> + * corresponding to root ports, and DMI ports.
>>> + */
>>> + while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
>> To be safe, "d" (the [8086:09a2] device) should be on the same bus as
>> "dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
>> which would be a different bus, and they presumably are not influenced
>> by the EN1K bit.
> I modified the code as follows, can you help me review it?
>
> /* Enable 1k I/O space granularity on the intel root port */
> static void quirk_intel_rootport_1k_io(struct pci_dev *dev)
> {
> 	struct pci_dev *d = NULL;
> 	u16 en1k = 0;
>
> 	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> 		return;
>
> 	/*
> 	 * Per intel sever CPU (ICX SPR GNR)EDS vol2(register) spec,
> 	 * Intel Memory Map/Intel VT-d configuration space,
> 	 * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
> 	 * bit 2.
> 	 * Enable 1K (EN1K):
> 	 * This bit when set, enables 1K granularity for I/O space decode
> 	 * in each of the virtual P2P bridges
> 	 * corresponding to root ports, and DMI ports.
> 	 */
> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> 		if (pci_domain_nr(d->bus) == pci_domain_nr(dev->bus)) {

Perhaps it is enough to check if the 0x09a2 VT-d and the rootport are on the smae bus
e.g. On my SPR, domain 0000

00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])

  
15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])

and if you check domain number only, they might sit on different bus, perhaps that
would make thing complex, could you make sure the VT-d is on the upstream bus of the
bridge ?

Thanks,
Ethan
  

> 			pci_read_config_word(d, 0x1c0, &en1k);
> 			if (en1k & 0x4) {
> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> 				dev->io_window_1k = 1;
> 			}
> 		}
> 	}
> }
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,	quirk_intel_rootport_1k_io);
>
> If you have a better method, please let me know. If there are no issues,
> I can submit a new patch.
>

