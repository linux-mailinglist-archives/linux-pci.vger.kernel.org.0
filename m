Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88F932C276
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhCCUyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:60674 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237866AbhCCFrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Mar 2021 00:47:39 -0500
IronPort-SDR: Jlw6WCclMiV864CqWOe8Ji9N6mGSJITDdGKJjC7U5hqe04oZB6R4KdxnA+1Tv1CJ0Nc8zwghmY
 tmODdrvxVJig==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174231269"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174231269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:46:42 -0800
IronPort-SDR: Jy2/ZtOPrOV2RWvjvCnwybzqF0ylE/Z/HNusSaa2NxPqaeUbbS1SOM/HsvGIlnrjDWijG0Nuhc
 7Kb79Qbz/Gig==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="367483582"
Received: from macorr1x-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.158.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:46:41 -0800
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Message-ID: <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com>
Date:   Tue, 2 Mar 2021 21:46:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/2/21 9:34 PM, Williams, Dan J wrote:
> [ Add Sathya ]
>
> On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
>> Overwriting the frozen detected status with the result of the link reset
>> loses the NEED_RESET result that drivers are depending on for error
>> handling to report the .slot_reset() callback. Retain this status so
>> that subsequent error handling has the correct flow.
>>
>> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
>> Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Just want to report that this fix might be a candidate for -stable.
Agree.

I think it can be merged in both stable and mainline kernels.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Recent DPC error recovery testing on v5.10 shows that losing this
> status prevents NVME from restarting the queue after error recovery
> with a failing signature like:
>
> [  424.685179] pcie_do_recovery: pcieport 0000:97:02.0: AER: broadcast error_detected message
> [  424.685185] nvme nvme0: frozen state error detected, reset controller
> [  425.078620] pcie_do_recovery: pcieport 0000:97:02.0: AER: broadcast resume message
> [  425.078674] pcieport 0000:97:02.0: AER: device recovery successful
>
> ...and then later:
>
> [  751.146277] sysrq: Show Blocked State
> [  751.146431] task:touch           state:D stack:    0 pid:11969 ppid: 11413 flags:0x00000000
> [  751.146434] Call Trace:
> [  751.146443]  __schedule+0x31b/0x890
> [  751.146445]  schedule+0x3c/0xa0
> [  751.146449]  blk_queue_enter+0x151/0x220
> [  751.146454]  ? finish_wait+0x80/0x80
> [  751.146455]  submit_bio_noacct+0x39a/0x410
> [  751.146457]  submit_bio+0x42/0x150
> [  751.146460]  ? bio_add_page+0x62/0x90
> [  751.146461]  ? guard_bio_eod+0x25/0x70
> [  751.146465]  submit_bh_wbc+0x16d/0x190
> [  751.146469]  ext4_read_bh+0x47/0xa0
> [  751.146472]  ext4_read_inode_bitmap+0x3cd/0x5f0
>
> ...because NVME was only told to disable, never to reset and resume the
> block queue.
>
> I have not tested it, but by code inspection I eventually found this
> upstream fix.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

