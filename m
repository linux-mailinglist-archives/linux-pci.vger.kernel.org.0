Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E066001D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAFMSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 07:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjAFMSt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 07:18:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49972D3D;
        Fri,  6 Jan 2023 04:18:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 713B861DBA;
        Fri,  6 Jan 2023 12:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63254C433D2;
        Fri,  6 Jan 2023 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673007527;
        bh=Od1zY9xL7NxWyj00jtBd/RVrDbPzE1UD3wQ0AX52PUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BkPrOPVlfS0ifboXTENp6hAS6CBD5ngIHhIQL9/pZudZjLp8mVcCj8NUmNG7UEfom
         OSqq3BF2l2gQg3KkDkkNo22QzYvxXb7l8865J9i3cWu7D8+kHzVrTWIE3ikUcBnaFg
         drgZLlRlaZ1GJhPxssfsXJnyrqTcih+lq2ipxl+dwSxru5hEqflx4qX69/UagzH31U
         7KUwV9E6XQ3H8lQtRAEjDVt/aPL0ElGAKXS6/Xsbeg+e78MIohP/9dW6kNkDfMpkq2
         mLFF7h7JXDFFJAnht91S6QQuMjVyEHDLJPwFM2NURInIO8i55KOMtkqNJZW46aYKmW
         l2Nx+nu0SBh1Q==
Date:   Fri, 6 Jan 2023 06:18:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     guo.ziliang@zte.com.cn
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn
Subject: Re: [PATCH] PCI: of: Warn if bridge base/limit region overlaps with
 system ram region
Message-ID: <20230106121845.GA1216249@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301061647338189934@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 06, 2023 at 04:47:33PM +0800, guo.ziliang@zte.com.cn wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> bridge base/limit(memory behind in lspci info, outbound pcie address/size)
> region is used to route outbound mem read/write transaction to ep. This
> base/limit region also may filter out inbound transactions which will
> result in inbound(eg: dma) transaction fail.
> 
> For example, if bridge base/limit is [0x20000000, 0x203fffff], system ram
> is [0x20000000, 0x27ffffff]. The inbound mapping is usually 1:1 equal
> mapping. When allocated system ram for inbound tansaction is 0x20004000
> (any in bridge base/limit), this inbound transactions will be filter out.
> 
> AER may report 'UnsupReq' on inbound mem read/write transactions if address
> is in this base/limit region, but not all pcie AER enabled or work well. We
> warn it also in host bridge pci address detection phase.

Is this a DT-specific thing?  It sounds like it should apply to PCI
bridges in general.

> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> ---
>  drivers/pci/of.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..82e09af6c638 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -314,6 +314,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> 
>  	dev_dbg(dev, "Parsing ranges property...\n");
>  	for_each_of_pci_range(&parser, &range) {
> +		int is_ram;
> +
>  		/* Read next ranges element */
>  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
>  			range_type = "IO";
> @@ -332,6 +334,18 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
> 
> +		/*
> +		 * bridge base/limit(memory behind) region may filter out inbound
> +		 * transactions which will result in inbound(eg:dma) fail of ep.
> +		 * AER may report it if enabled, we warn it also.
> +		 */
> +		is_ram = region_intersects(range.pci_addr, range.size,
> +					IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
> +		if (is_ram == REGION_INTERSECTS) {
> +			dev_warn(dev, "%#012llx..%#012llx bridge base/limit region overlaps with system ram, may result in inbound fail\n",
> +				 range.pci_addr, range.pci_addr + range.size - 1);
> +		}
> +
>  		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
>  		if (err)
>  			continue;
> -- 
> 2.15.2
