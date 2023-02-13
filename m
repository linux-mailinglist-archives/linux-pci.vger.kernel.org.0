Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FB6953FA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 23:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBMWlz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 17:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWly (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 17:41:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E22005B;
        Mon, 13 Feb 2023 14:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EBB6132A;
        Mon, 13 Feb 2023 22:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D417C433EF;
        Mon, 13 Feb 2023 22:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676328112;
        bh=lCWhdGWdJVDH+Y4f5ktLjbLjEHPmLWLXjh/JJQy/v34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BRv4tVu19CIrCbvygc4VPkbFq1qb1QDniFwYI5DPCTSaSxf/04aE1dRqGEUVKyspx
         H0aE+9p2+0Yq5QGc4ESSfiAIf0SgLWgnL4/wkXMTzT+aibxS3+aezS+Z+a/vWJfm+4
         HATiBj38PBVfXZd2NauILPrsu0oEsTqDLdk91cNVE3Z3D59HmD+R7Of2FP88jIQOcZ
         napjdiuMN4WoLjEoCeTx+dr+43++ESL4q2AgYDNJMjXfDeaDZPKtlwJXztk3iudVz7
         6JbCRcCW+TdbUdR/ClpazliS1PHDsQlXE88Povry0C7nvDbOgB4D9NY2KzzXbGZtV4
         /xYSqgFhlgxRA==
Date:   Mon, 13 Feb 2023 16:41:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Fix dropping valid root bus resources with .end
 = zero
Message-ID: <20230213224150.GA2940509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0fcd5e86c74239be79c7cb03651c0fce31b515.1676036673.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 02:46:39PM +0100, Geert Uytterhoeven wrote:
> On r8a7791/koelsch:
> 
>     kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>     # cat /sys/kernel/debug/kmemleak
>     unreferenced object 0xc3a34e00 (size 64):
>       comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
>       hex dump (first 32 bytes):
> 	b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
> 	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       backtrace:
> 	[<fe3aa979>] __kmalloc+0xf0/0x140
> 	[<34bd6bc0>] resource_list_create_entry+0x18/0x38
> 	[<767046bc>] pci_add_resource_offset+0x20/0x68
> 	[<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390
> 
> When coalescing two resources for a contiguous aperture, the second
> resource is enlarged to cover the full contiguous range, while the
> first resource is marked invalid.  This invalidation is done by
> clearing the flags, start, and end members.
> 
> When adding the initial resources to the bus later, invalid resources
> are skipped.  Unfortunately, the check for an invalid resource considers
> only the end member, causing false positives.
> 
> E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and
> no longer registered with pci_bus_insert_busn_res() (causing the memory
> leak), nor printed:
> 
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>     -pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> 
> Fix this by only skipping resources where all of the flags, start, and
> end members are zero.
> 
> Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/resource for v6.3, thanks!

> ---
> Is there any side effect of not registering the root bus resource with
> pci_bus_insert_busn_res()?  This is the resource created by
> of_pci_parse_bus_range(), and thus affects any DT platforms using
> "bus-range = <0 0>".
> 
> Perhaps checking for "!res->flags" would be sufficient?
> 
> I wonder if this still causes memory leaks on systems where resources
> are coalesced, as the first resource of a contiguous aperture is no
> longer referenced? Perhaps instead of clearing the resource, it should
> be removed from the list (and freed? is it actually safe to do that?)?
>   - Bjorn thinks these would normally be freed via
>     __acpi_pci_root_release_info() (if the host bridge were
>     hot-removed), so probably not a leak since the invalidated resource
>     is still in the info->resources list and should be freed even though
>     it's been invalidated.
>   - Furthermore, Bjorn suspects it could probably be removed from the
>     list and freed here, and maybe even in the first loop when we
>     coalesce it, so we wouldn't have to check in the second loop.
> 
> However, let's fix one bug at a time? This has been dragging on for
> about half a year....
> 
> Apparently Johannes had identified the bug before, but didn't realize
> the full impact...
> https://lore.kernel.org/r/5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net/
> 
> v3:
>   - Actually the second resource is enlarged, and the first one is
>     invalidated,
> 
> v2:
>   - Add Tested-by, Acked-by.
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1779582fb5007cd1..5988584825482e9f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -996,7 +996,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	resource_list_for_each_entry_safe(window, n, &resources) {
>  		offset = window->offset;
>  		res = window->res;
> -		if (!res->end)
> +		if (!res->flags && !res->start && !res->end)
>  			continue;
>  
>  		list_move_tail(&window->node, &bridge->windows);
> -- 
> 2.34.1
> 
