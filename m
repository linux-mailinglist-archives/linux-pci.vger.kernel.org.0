Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFA66A1DB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 19:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAMSUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 13:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAMSUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 13:20:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC427F9F9
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673633637; x=1705169637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dKEIjVu5osiNuHb4g1es3ir4PjSdgIs2uoQnlNtg3AI=;
  b=MzsiN+Wapt6rQplCk0/XTU2GK/yH02GIM5hhANPKAS+5TBimY3c9Qj2R
   o6L+krngKvQjt5mgi5ByBEiMI3FIF8J/+WDmce7C1b1aIRX4wV2xick2u
   hXYElrv/GmJ/YInOAjrtqUqZ+6L6tseM2Ovu3gqBuiqnRL880jr/gRZUS
   5d0fHX91BUWk9SWGZFvNxG9EH4cH/UhZMyBz76SD8cNt+F9hm1b1vxY4l
   so8g7HAcRhFmd5SU1vPeEov4BUbHJM/2ofPlNYLqujtXGF309O9C7QmZV
   GDq2hM3c0Ttl0MY+6Sp9/43Nbh9AAmRZuwAQonrhT4uUWeLvpSgDMAHgx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303754617"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="303754617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:13:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="658294224"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="658294224"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.96.31]) ([10.212.96.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:13:56 -0800
Message-ID: <a2eb0d95-7212-a716-1aa7-4e6c90e81c8b@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] PCI: vmd: Avoid acceidental enablement of window
 when zeroing config space of VMD root ports
To:     Adrian Huang <adrianhuang0701@gmail.com>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Adrian Huang <ahuang12@lenovo.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
References: <20230111092911.8039-1-adrianhuang0701@gmail.com>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230111092911.8039-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/11/2023 2:29 AM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
>
> Commit 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
> clears PCI configuration space of VMD root ports. However, the host OS
> cannot boot successfully with the following error message:
>
>   vmd 0000:64:05.5: PCI host bridge to bus 10000:00
>   ...
>   vmd 0000:64:05.5: Bound to PCI domain 10000
>   ...
>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: Invalidation Time-out Error (ITE) cleared
>
> The root cause is that memset_io() clears prefetchable memory base/limit
> registers and prefetchable base/limit 32 bits registers sequentially. This
> might enable prefetchable memory if the device disables prefetchable memory
> originally. Here is an example (before memset_io()):
>
>   PCI configuration space for 10000:00:00.0:
>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>   00 00 00 00 40 00 00 00 00 00 00 00 00 01 02 00
>
> So, prefetchable memory is ffffffff00000000-575000fffff, which is disabled.
> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>
>   The Prefetchable Memory Limit register must be programmed to a smaller
>   value than the Prefetchable Memory Base register if there is no
>   prefetchable memory on the secondary side of the bridge.
>
> When memset_io() clears prefetchable base 32 bits register, the
> prefetchable memory becomes 0000000000000000-575000fffff, which is enabled.
> This behavior (accidental enablement of window) causes that config accesses
> get routed to the wrong place, and the access content of PCI configuration
> space of VMD root ports is 0xff after invoking memset_io() in
> vmd_domain_reset():
>
>   10000:00:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev ff) (prog-if ff)
>           !!! Unknown header type 7f
>   00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ...
>   f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
>   10000:00:01.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port B (rev ff) (prog-if ff)
>           !!! Unknown header type 7f
>   00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ...
>   f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> To fix the issue, prefetchable limit upper 32 bits register needs to be
> cleared firstly. This also adheres to the implementation of
> pci_setup_bridge_mmio_pref(). Please see the function for detail.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216644
> Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> ---
> Changes since v1:
>   - Changed subject per Bjorn's suggestion
>
>  drivers/pci/controller/vmd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..e520aec55b68 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -526,6 +526,9 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>  				     PCI_CLASS_BRIDGE_PCI))
>  					continue;
>  
> +				/* Clear the upper 32 bits of PREF limit. */
> +				memset_io(base + PCI_PREF_LIMIT_UPPER32, 0, 4);
> +
>  				memset_io(base + PCI_IO_BASE, 0,
>  					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>  			}

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

