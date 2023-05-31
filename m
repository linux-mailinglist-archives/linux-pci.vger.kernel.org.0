Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F07718B20
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjEaUZA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjEaUYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 16:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44796101;
        Wed, 31 May 2023 13:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D678F63F0E;
        Wed, 31 May 2023 20:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53ADC433D2;
        Wed, 31 May 2023 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685564688;
        bh=7r8nK+oO+zadbfBQmkkb4fRHaIJIBVonKzfYO5BLeJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d1ewYAhFOgglzfl4VxYT6tvES1rLDUAGUGuYDf+vWFPrppA/pQmCxmrdqZ1EX/7NH
         n0G6IGEqqCNLCv7dMvLTTjozqwyVgqEFuHm1r/YPSTYnaL2hwTj430Nu6yRA7cI8XW
         CruOz9vwg6cp6Trv3cBsoC95rqTFU3PvOXdFNhJ6L2rWl/E6BnED05MzhnhJTy8qJl
         azmTRWs3q6iQA/o2B0RyNVabhgl7/FVohnSKVwjF4VhehsRTEZ5SWVtONVzFX0I9In
         R7GzTPZa8fzFWiKFXZnXjUolwBTwO4slzywzkHGRchdcG6ftqGNoC3dPHhirlEbav1
         TOmgKmqgTpD3A==
Date:   Wed, 31 May 2023 15:24:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <ZHetDo5PozWdtrxP@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531165819.phx7uwlgtvnt3tvb@skbuf>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Loongson folks, thread at
https://lore.kernel.org/r/20230521115141.2384444-1-vladimir.oltean@nxp.com]

On Wed, May 31, 2023 at 07:58:19PM +0300, Vladimir Oltean wrote:
> On Wed, May 31, 2023 at 11:56:02AM -0500, Bjorn Helgaas wrote:
> > What bad things happen without this patch?
> 
> It's in the commit title: probing the entire device (PCI device!!!) is
> skipped if function 0 has status = "disabled". Aka PCIe functions 1, 2, 3, 4, ...

I guess I should have asked "what bad things happen without this patch
and without the DT 'disabled' status"?

I think 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
was basically a workaround for Loongson making a device visible in PCI
config space when it shouldn't have been [1].

6fffbc7ae137 [2] means we pretend the PCI device doesn't exist if DT
status is "disabled".  If the device happens to be Function 0, that
means we don't look for any more functions.  I guess that doesn't
matter for Loongson.  But it does matter for this NXP platform, where
we don't want to use Function 0, but we *do* want to use other
Functions.

There are several PCIe things that are required to be in Function 0
(MPS, ASPM, IDE, CMA/SPDM, etc), at least in certain cases.

What would happen if instead of making pci_setup_device() fail (as
both 6fffbc7ae137 and this patch do, which means the device doesn't
even show up in "lspci"), we just prevent drivers from binding to it,
e.g., by making pci_device_probe() fail?  The device would then appear
in "lspci" and the PCI core would configure things as usual, but no
drivers would be able to claim it.

Bjorn

[1] https://lore.kernel.org/all/20221114074346.23008-1-liupeibao@loongson.cn/
[2] https://git.kernel.org/linus/6fffbc7ae137
