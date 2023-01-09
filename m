Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CF663230
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAIVFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 16:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbjAIVEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 16:04:47 -0500
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67408D5DD
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 12:58:06 -0800 (PST)
Message-ID: <9130d0c5-24f2-4112-32e0-3ebd3666d81c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673297881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfLWjYIUVBNu1VTEeB39UF39o6OrlTnutNeFOZX1vho=;
        b=ol3INUUKWyAWJ3bCvVGtRg6JLlGmm+Um9i2BNiARL/jnrIM3JwUdpNF/I9fVEBuUFbD/oh
        m2Ai8ZULxvCJyrWBZllcMscPSdGpzkg1KPpmbNFTUxSLYfLcd3s/VZwsJqhLDeBUjNMkaN
        MJvbKewsJBNEae6cUXbFpYPVtJfXZik=
Date:   Mon, 9 Jan 2023 13:57:57 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] PCI: vmd: Fix boot failure when trying to clean up
 domain before enumeration
To:     Adrian Huang <adrianhuang0701@gmail.com>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
References: <20230109125148.16813-1-adrianhuang0701@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20230109125148.16813-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>

On 1/9/2023 5:51 AM, Adrian Huang wrote:
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
> This behavior causes that the content of PCI configuration space of VMD
> root ports is 0xff after invoking memset_io() in vmd_domain_reset():
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
> ---
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
