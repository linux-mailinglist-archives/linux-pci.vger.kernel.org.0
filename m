Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B373E73F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFZSMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjFZSMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 14:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22669198C;
        Mon, 26 Jun 2023 11:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9142D60F45;
        Mon, 26 Jun 2023 18:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1084C433C0;
        Mon, 26 Jun 2023 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687803117;
        bh=JPG51f1XhFtULkQDerp9DiZGlQrVYSlsBSy1mxXedhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TAa2ZQ44xVZDJRseHq5MiELnPsQmGcB90Yc0SE/38Ad7TsU4cGXMoq4oGNwa739bI
         6AGlr2U7O1A/RU30Wbt0TZngj1QBShlQTKHChgCBu2dRhx170CQi6ijDhxBGN88hSR
         uYUlr2CHQ5/dcMwRParzc5CORFzn/RQPQGLw5V09HZJVlTvOwWrLkdiiCm+Y9INMzj
         hnhjxauWWYmdr5VsCJEHWvGfd60z5ft4MMfTylFCXGC54JbDnSmViPjwy6Gc0m9Bpb
         Jvkv2tSQbHWh7VoCZCsdXPrqMbU5nHv649GivNBvvBxflLE/DLarxBeVP9kXwZj6q5
         YstjsLwePj7OQ==
Date:   Mon, 26 Jun 2023 13:11:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 2/5] PCI: Create device tree node for selected devices
Message-ID: <20230626181155.GA250405@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 26, 2023 at 10:34:05AM -0700, Lizhi Hou wrote:
> On 6/21/23 13:22, Bjorn Helgaas wrote:

>     Added an of_pci_make_dev_node() interface that can be used to create
>     device tree node for PCI devices.
> 
>     Added a PCI_DYNAMIC_OF_NODES config option. When the option is turned
> on,
>     the kernel will generate device tree nodes for PCI bridges
> unconditionally.
> 
>     Initially, the basic properties are added for the dynamically generated
>     device tree nodes which include #address-cells, #size-cells,
> device_type,
>     compatible, ranges, reg.

s/Added/Add/ (twice, mentioned before).

The commit log should say what the *patch* does, not what *you* did.

> > > @@ -501,8 +501,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
> > >   		 * to rely on this function (you ship a firmware that doesn't
> > >   		 * create device nodes for all PCI devices).
> > >   		 */
> > > -		if (ppnode)
> > > +		if (ppnode && of_property_present(ppnode, "interrupt-map"))
> >
> > Maybe this deserves a comment?  The connection between "interrupt-map"
> > and the rest of this patch isn't obvious to me.
> > 
> > Also, it looks like this happens for *everybody*, regardless of
> > PCI_DYNAMIC_OF_NODES, which seems a little suspect.  If it's an
> > unrelated bug fix it should be a different patch.
> 
> This is not a bug fix. The check will distinguish between device tree nodes
> automatically created for pci bridges by this patch with those created by a
> DT based system. With this patch, device tree nodes are created for pci
> bridges, thus ppnode here will be non-zero and we will break out of the
> loop. In order to still use pci_swizzle_interrupt_pin(), checking
> “interrupt-map” for ppnode is added here.
> 
> After thinking about this more, using “interrupt-map” property may not be
> correct for the cases where ppnode is not dynamically generated and it does
> not have “interrupt-map”. So, I would introduce a new property “dynamic” for
> pci bridge nodes generated dynamically. And change the code to: if (ppnode
> && of_property_present(ppnode, "dynamic")).
> 
> Does this make sense?

Makes a lot more sense to me than relying on some unrelated and
undocumented property.  Probably still would benefit from an #ifdef.

Rob might have an opinion on whether "dynamic" makes sense from a
DT perspective.

Bjorn
