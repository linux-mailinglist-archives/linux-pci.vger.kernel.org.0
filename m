Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B449576A59
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 01:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiGOXEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 19:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiGOXDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 19:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8129A
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 16:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B194061E51
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 23:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DBAC34115;
        Fri, 15 Jul 2022 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657926215;
        bh=WksLDzmsXPBPYWDGk8EE7x0uW0e4DLgfIVPStrDZQW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I+2r9XEIq6vJ9okFz6RDIgN0Phi1qbZ90Huf/3XIwFzV+A4NYL5UnujTBCl8ffp42
         SyQWf/qVsVIyGhF5rRRkgm/UnsZ4cJFlSkdp2VRwr5PrexhmVvTgo/bksi0QQMDuZK
         1uwyv6Cy3LcywG32p44ZWCA3ukZ36Dcx0n4wcOXZ3rdOeHYgZiHr72JljY++PxBvQV
         HXQHu+SzT9rvHc7ooZKrHxCEY1Xo6LwMrYr1UqysFXQ6YA1Ym0P7ZpaWvhQa8+Im0i
         JMYqVzl2YbHQ9QlAGCQorAg3a85SFkbPw53O/t5Q5Qx/MaLmrgiLn4Rfx2R3IY3Ght
         BzD2hVbabmShQ==
Date:   Fri, 15 Jul 2022 18:03:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     Zhiqiang.Hou@nxp.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linmq006@gmail.com
Subject: Re: Re: [PATCH] pci: controller: mobiveil: Hold reference returned
 by of_parse_phandle()
Message-ID: <20220715230333.GA1208797@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3302b8f5.15f.181ff2de1f8.Coremail.windhl@126.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 08:06:46AM +0800, Liang He wrote:
> At 2022-07-15 00:37:51, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
> >On Mon, Jul 04, 2022 at 02:26:08PM +0800, Liang He wrote:
> >> In ls_g4_pcie_probe(), we should hold the reference returned by
> >> of_parse_phandle() and use it to call of_node_put() for refcount
> >> balance.
> >> 
> >> Fixes: d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC driver for Layerscape SoCs")
> >> Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
> >> Signed-off-by: Liang He <windhl@126.com>
> >> ---
> >>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> >> index d7b7350f02dd..075aa487f92e 100644
> >> --- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> >> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> >> @@ -204,13 +204,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
> >>  	struct pci_host_bridge *bridge;
> >>  	struct mobiveil_pcie *mv_pci;
> >>  	struct ls_g4_pcie *pcie;
> >> -	struct device_node *np = dev->of_node;
> >> +	struct device_node *np = dev->of_node, *parse_np;
> >>  	int ret;
> >>  
> >> -	if (!of_parse_phandle(np, "msi-parent", 0)) {
> >> +	parse_np = of_parse_phandle(np, "msi-parent", 0);
> >
> >I don't understand what's going on here.  Where is "msi-parent"
> >actually used?  If we just need to know whether "msi-parent" exists,
> >can we use of_property_read_bool() instead?  Or can we call
> >of_parse_phandle() closer to where it is used?  
> 
> I think this code is used to check the existence of the device_node
> whose property is "msi-parent". of_property_read_bool() can only be
> used to check current device_node 'np'.
>
> If this is right, I think we can use a helper to make thing simple
> like this:
> 
> https://lore.kernel.org/all/20220712061417.363145-1-windhl@126.com/
> 
> If it is ok, I will prepare the helper in new version.

I dunno.  The helper in that patch has nothing ftgmac100-specific in
it, so if the helper is correct and useful, it seems like it should be
somewhere generic so we don't end up with a zillion copies of it.
Maybe Rob will chime in.

I just want drivers/pci/controller/* to deal with "msi-parent"
consistently.

dw_pcie_host_init() uses of_property_read_bool().

ls_g4_pcie_probe(), brcm_pcie_probe(), and iproc_pcie_msi_enable() use
of_parse_phandle().

It's not clear to me that these uses are fundamentally different and
need to use different interfaces.

> >> +	if (!parse_np) {
> >>  		dev_err(dev, "Failed to find msi-parent\n");
> >>  		return -EINVAL;
> >>  	}
> >> +	of_node_put(parse_np);
> >>  
> >>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> >>  	if (!bridge)
> >> -- 
> >> 2.25.1
> >> 
