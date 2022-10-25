Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FB60D521
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiJYUEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJYUED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 16:04:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA311A951;
        Tue, 25 Oct 2022 13:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9988B81EC9;
        Tue, 25 Oct 2022 20:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759C5C433C1;
        Tue, 25 Oct 2022 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666728240;
        bh=ydeW7eA2NXW+5grO0NpeP3U1RnuzRINX/JYx6xdDNJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/y6sBxBC/QTm/bKfHGdyAV72PYZcPBZjPPeJPC7JSSYsRIjZCNo2ukddtCYzfZml
         RIvad+xpLP5OBp9B3fYDudUrVHUKGB++0Oa2cbVaDxjmuyPKd/YD9uPpL/4CQ8c5hz
         LtM8I5yiXL9LiL/oSCQ0CR8OHRzsYuUaStw0syC6FreC6/LWMqdkVKbR1ZCObTolcF
         n2IGOIXEUcWyDh1ACd3NiOdJvEhFLvUB2BTUjOwCOlzVW36lUw9G8/sCj0dc1/Khj9
         RgRm3swgc8EeOs/68mD/Gvai5JagAmhmgd2Yk7c0TT/FcLAr9SCnbaprwxj5LmB7hA
         hj02jgP9H8LJw==
Date:   Tue, 25 Oct 2022 21:03:51 +0100
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
Subject: Re: [PATCH v2 0/4] PCI: Remove unnecessary <linux/of_irq.h> includes
Message-ID: <Y1hBJ+b4xmBRtrvF@spud>
References: <20221025185147.665365-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025185147.665365-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 01:51:43PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many host controller drivers #include <linux/of_irq.h> even though they
> don't need it.  Remove the unnecessary #includes.
> 
> v1: https://lore.kernel.org/all/20221019195452.37606-1-helgaas@kernel.org/
> 
> Changes from v1 to v2:
>   - Include <linux/irqdomain.h> explicitly in altera-msi and microchip,
>     which don't need <linux/of_irq.h> itself, but relied on it to include
>     <linux/irqdomain.h>
>   - Include <linux/irqdomain.h> explicitly in mvebu, which needs both it
>     and <linux/of_irq.h>
> 
> Bjorn Helgaas (4):
>   PCI: altera-msi: Include <linux/irqdomain.h> explicitly
>   PCI: microchip: Include <linux/irqdomain.h> explicitly
>   PCI: mvebu: Include <linux/irqdomain.h> explicitly
>   PCI: Remove unnecessary <linux/of_irq.h> includes

>  drivers/pci/controller/pcie-microchip-host.c | 2 +-

Hey Bjorn, actually did the build this time rather than visually
inspecting... For the microchip bits:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks!

