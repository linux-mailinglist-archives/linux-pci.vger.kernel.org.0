Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440A866336E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 22:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjAIVqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 16:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjAIVqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 16:46:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D38F017
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 13:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B606144E
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 21:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F4C433EF;
        Mon,  9 Jan 2023 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300775;
        bh=PNLiI48kk2G02GNGw40Q61ObjU16YEJD27EpZKuoeI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DvSwcgc+Yw/rt3FBxfypWmJlHKt51XvMzC2BdABB62qtgIhYOJuQNW6Sh05Bjw+es
         aFPLPJ+OrOxSdavKTpNwK+yWwdPVIjouJb3Ikq/wckdgbKIklnXbgIpVrh/E7CO3mN
         aYsVF+wgioA73Q0wCSbyYA8zVaprpZ521quqzyv2lz8gHuvhTsaAI0u/uV9OZK/vgm
         Nkhx/UU2qWDoCzb0Cup58mVk+PtBlDrFtyeh/0JZgGjxAizlhSbsktjR7TsFlM2Uzl
         HOaBbW6fljBxU6Z4ICh7JP0NbHHn25YoCzyoRWaDsI9g7Ing82Ee1GMSbvz12tB22+
         Y0JhkYI86vxFA==
Date:   Mon, 9 Jan 2023 15:46:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] PCI: vmd: Fix boot failure when trying to clean up
 domain before enumeration
Message-ID: <20230109214613.GA1445262@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109125148.16813-1-adrianhuang0701@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can we make the subject line any more specific about what this patch
does?  Apparently this is really about avoiding accidental enablement
of the window because the base & limit can't be updated atomically?

On Mon, Jan 09, 2023 at 08:51:48PM +0800, Adrian Huang wrote:
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

  #define PCI_IO_BASE             0x1c
  #define PCI_PREF_LIMIT_UPPER32  0x2c
  #define PCI_ROM_ADDRESS1        0x38

  memset_io(base + PCI_IO_BASE, 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);

The memset does clear PCI_PREF_LIMIT_UPPER32 already, but I think
you're saying that PCI_PREF_MEMORY_BASE, PCI_PREF_MEMORY_LIMIT, and
PCI_PREF_BASE_UPPER32 are cleared first, so there is a time when the
prefetchable base is zero and the limit is non-zero, so the window is
enabled.

I would expect that to be a transient thing that you wouldn't be
likely to trip over, but you seem to see it consistently.

> This behavior causes that the content of PCI configuration space of VMD
> root ports is 0xff after invoking memset_io() in vmd_domain_reset():

Well, it doesn't actually change the content of config space, does it?
I assume these config accesses get routed the wrong place because the
window is enabled, and some PCI error like Unsupported Request is
getting turned into ~0?

I don't understand why this seems to be a stable state, though.

Seems sort of unexpected to me that config space would be in a
*prefetchable* window, but I guess that must be a VMD thing.

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
