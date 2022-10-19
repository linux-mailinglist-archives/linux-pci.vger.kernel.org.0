Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9760510F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJSULW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJSULU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF901ACAA9;
        Wed, 19 Oct 2022 13:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B77F3B82236;
        Wed, 19 Oct 2022 20:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D40C433C1;
        Wed, 19 Oct 2022 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666210276;
        bh=cxINFjC4l26JMWQCDS6yOnnhsiWltfRN4i3cz4+b7vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1ZMR3K24nseRo15MOP5rfNigW+Z7xZT29yurBVj0i8XMgxeJujD+PIICzNZIm6bN
         gyK4dHYnL1woYBdPMdyEToXjqNHDrW2LDxd3wWYhGDXgu42WH98mSb6PNGE0biVwoI
         NmL/FHqhwiOGE1mM2xnC6PMrXYmWjtf1ioNz6JDLPE8Y5e73BbnB6NW23Hrt0MK1e/
         +nKHkSBV5CS1gPpnn/eBnJUp5fsum7rA+C1TehSt0R/pHMPXztTW0k12Hfu1L95GIv
         +3fg3d6ThtT2fif5tCNG/VOG/010vzdu0WdMFtWVtPpP1GUcqnAcVjxl7mbvJEmMkE
         xq4VgOFK32PwA==
Date:   Wed, 19 Oct 2022 21:11:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <Y1BZ26pv9A0VFS/j@spud>
References: <20221019195452.37606-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019195452.37606-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 02:54:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many host controller drivers #include <linux/of_irq.h> even though they
> don't need it.  Remove the unnecessary #includes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

>  drivers/pci/controller/pcie-microchip-host.c | 1 -

LGTM...
Acked-by: Conor Dooley <conor.dooley@microchip.com>
