Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAB73CC7F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjFXTDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFXTDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 15:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6461010A
        for <linux-pci@vger.kernel.org>; Sat, 24 Jun 2023 12:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED2D600E1
        for <linux-pci@vger.kernel.org>; Sat, 24 Jun 2023 19:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E4DC433C9;
        Sat, 24 Jun 2023 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687633392;
        bh=3yLec4OQwczkQ/kmMrEsOXE+LLwxkwLipHrOBu3vMcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1VwXEPMtzIaKC1DBEtpFHOmVTY3XKNb7US8u/G0+zLGjiSNjtX511ofFvhnIodi1
         8bAGG8hqKh4NrHmvmmHhO8uUdcisafeUnEQdBwxv3d/jk/x/sGk3UQ975TBGyre3n6
         ch0VFTumScrumDlLc0X+o/Vr8tzYfGkjqh/unyG4MWAkxQ2TXj/TzGt/mVIdDEo6/k
         OWfkmUIstx+cO7cFKg3AQc14CU8+MuW9oz90+STD8bEIckW/ROi33uAe/WR+rOyB8y
         loTwl+zbOYoqghwNw0pDJIDAYZDqwS23dh0XbbIX3YW178eXwEOJKVifpmPfeV41X8
         0blEmwhiuA5tw==
Date:   Sat, 24 Jun 2023 21:03:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     daire.mcnamara@microchip.com, conor.dooley@microchip.com,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/8] PCI: microchip: Remove cast warning for
 devm_add_action_or_reset() arg
Message-ID: <ZJc97GdtuFSAx1nf@kernel.org>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
 <20230614155556.4095526-3-daire.mcnamara@microchip.com>
 <20230624183428.GF2636347@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230624183428.GF2636347@rocinante>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 25, 2023 at 03:34:28AM +0900, Krzysztof Wilczyński wrote:
> [+CC Simon]
> 
> Hello,
> 
> > The kernel test robot reported that the ugly cast from
> > void(*)(struct clk *) to void (*)(void *) converts to incompatible
> > function type.  This commit adopts the common convention of creating a
> > trivial stub function that takes a void * and passes it to the
> > underlying function that expects the more specific type.
> 
> This is a nice change, but it seems it has been carried along a few other
> series and through their different revisions.  Simon also found the problem
> and addressed it independently per:
> 
>   https://lore.kernel.org/linux-pci/20230511-pci-microchip-clk-cast-v1-1-7674f4d4e218@kernel.org
> 
> However, we have a few other drivers where we could take care of this, per:
> 
> drivers/pci/controller/pcie-microchip-host.c
> 864-		return ERR_PTR(ret);
> 865-
> 866:	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
> 867-				 clk);
> 868-
> 
> drivers/pci/controller/dwc/pcie-keembay.c
> 170-
> 171-	ret = devm_add_action_or_reset(dev,
> 172:				       (void(*)(void *))clk_disable_unprepare,
> 173-				       clk);
> 174-	if (ret)
> 
> drivers/pci/controller/dwc/pci-meson.c
> 189-
> 190-	devm_add_action_or_reset(dev,
> 191:				 (void (*) (void *))clk_disable_unprepare,
> 192-				 clk);
> 193-
> 
> If neither you nor Simon has objections, I can send a small series to
> address these in a single take.  You could then drop this particular patch
> from v2 of this series, should you send a second revision at some point.

Hi Krzysztof,

Sure, that is fine my me.

My 2c worth, is that it would be nice to have a common
helper for these cases. But I don't feel strongly about it.
