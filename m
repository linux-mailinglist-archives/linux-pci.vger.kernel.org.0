Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43495A235F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbiHZInX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiHZInI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 04:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32F1AF0E;
        Fri, 26 Aug 2022 01:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2562061D97;
        Fri, 26 Aug 2022 08:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07CBC433B5;
        Fri, 26 Aug 2022 08:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661503369;
        bh=f9rCle8MUuHrWBuriqQEAYyLqTTaXKIX/4G+WKekalc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8XpBKO/c2SqgP7OgMapol886WwD/tRHfcQrWPCfqpAOjdIgJSRRPiKL1onSeiF4k
         e1WUbBtMN/Mb3veFETj7rbIervebAokt6rHL/X0OtoKz4iHNyBppj1eDPld9oLF0bd
         WEJgO4fgVJlNt9UzYzhLS/J4G42v+cdYqzvu7fjLMsqhJfTdZvez3Cqu5I1Jyt/Xml
         X4q8u1qrCULUJ4GYnVJ16fJhAw4jfZuqyvT9UZW2NkgiOXmZpHw91ZBrN54fTyIKZC
         W1dk20OFG6KucjHwNAmeN4cKf2EyQu6JJTKxudQ4WaJzIV2MzS+e3BkhT8sNJgWBBv
         xWZjwxQj6EVjA==
Date:   Fri, 26 Aug 2022 10:42:41 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk, kw@linux.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 2/2] PCI: mvebu: add support for orion5x
Message-ID: <YwiHgd+9MygsMPzi@lpieralisi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-3-maukka@ext.kapsi.fi>
 <YweSGDN7rei2Ugwp@lpieralisi>
 <20220825160051.z52ak45apjcgf3sl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825160051.z52ak45apjcgf3sl@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 06:00:51PM +0200, Pali Rohár wrote:
> On Thursday 25 August 2022 17:15:36 Lorenzo Pieralisi wrote:
> > On Tue, Aug 02, 2022 at 08:34:23PM +0300, Mauri Sandberg wrote:
> > > Add support for orion5x PCIe controller.
> > > 
> > > There is Orion-specific errata that config space via CF8/CFC registers
> > > is broken. Workaround documented in errata documented (linked from above
> > > documentation) does not work when DMA is used and instead other
> > 
> > Linked to which documentation ?
> 
> Hello! Orion Errata document is linked from kernel doc:
> https://www.kernel.org/doc/html/latest/arm/marvell.html

Add a Link: tag to the patch, thanks.

Lorenzo
