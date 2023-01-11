Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060DD665FD5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAKP6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjAKP6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 10:58:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3165EB
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 07:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07DE0B81C67
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 15:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6325CC433EF;
        Wed, 11 Jan 2023 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673452715;
        bh=IfoLSJyUDbeZkBSc6nbVgDgXhbLN5ZkCLMtzDDdDXFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HfolJOCd2nv7XCDc1kdiC6FjH7octvOc8d0p7P1uJhykdh1y6pL237XA1KGUtiLia
         dmU1EncfqYD6LO3zOcDozzylX3LuwpIldKUQ8U4rSI+ncfjjo1hOu8XtMI+TMeWIHT
         D9DBgxrEV2zVpac8+dGhE6hkgrS4dNxhehHalFae2uqPCZSPlh57hR62O9o3CoiHj4
         mYLlx44Z443bTrnUJLUhyviTuH1qoGhftof25hfgcCbnJxrrmnUEkuXEk9luZ3OA2z
         xb6O+jt+5XnJ2SGuZslejXPyL56WdyXhFzg1cDqJCr+ggRg7L5Tk2rcxWHZ09Y41kd
         Lgvu0tI0E1wyA==
Date:   Wed, 11 Jan 2023 09:58:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH v2 1/1] PCI: vmd: Avoid acceidental enablement of window
 when zeroing config space of VMD root ports
Message-ID: <20230111155833.GA1668483@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111092911.8039-1-adrianhuang0701@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/acceidental/accidental/ in subject

On Wed, Jan 11, 2023 at 05:29:11PM +0800, Adrian Huang wrote:
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

I was thinking the problem was only between clearing
PCI_PREF_MEMORY_BASE and PCI_PREF_BASE_UPPER32, but that would be a
pretty small window, and you're seeing a lot of config accesses going
wrong.  Why is that?  Is there enumeration that races with this domain
reset?

I guess the same problem occurs with PCI_IO_BASE/PCI_IO_BASE_UPPER16,
but maybe there's no concurrent I/O port access?

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
> -- 
> 2.31.1
> 
