Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB477700F50
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjELTcw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 15:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbjELTcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 15:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F78A76;
        Fri, 12 May 2023 12:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639EB65851;
        Fri, 12 May 2023 19:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6BDC433EF;
        Fri, 12 May 2023 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683919962;
        bh=ye+trGBgmUY14kZ8FLPEBVppgLLuN+PjVTfIXlSk+Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vb66SUhbONwl1eI0v7lcAbMQioZhxO87bACLRpIPc2hK4H7jAC4i3vLobzpSg1CAR
         M5wejopRJ9sATdxxtH6grjDivscH2IEtNvxQETuPH5RmiIJGhk+yuOy1QLHTVWb17z
         y0xc5bIyvq/UH4qx4SVzDT396kVDYLqEymrTSf5+z+SCik05yksneY7IJICHg2foAZ
         zuZa4KGU15BFDoXoDP5wNjVDJTOq1EZy7y3jWm/JwhsH8ZrGY0zBdJRoQQuCPBXUac
         rVfoxs092L37CgzsOpm1wJtQVmRtPdwFF0uw6+hhnC481R055CUe33ku5XabGtfibw
         pzwA8/VVKTacQ==
Date:   Fri, 12 May 2023 14:32:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <ZF6UWBd0x9LxAhoJ@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 11:57:25AM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> ... 

> +#include <linux/of_pci.h>
> +#include <linux/irqchip/chained_irq.h>

The trend seems to be to alphabetize the system includes above.

> +#include "pcie-xilinx-common.h"
> +
> +#include "../pci.h"

Put the pcie-xilinx-common.h include here, as you did for
pcie-xilinx-cpm.c:

  #include <linux/irqchip/chained_irq.h>

  #include "../pci.h"
  #include "pcie-xilinx-common.h"

pcie-xilinx.c has a very similar list of register definitions, which
makes me wonder why it can't share pcie-xilinx-common.h as well.

Obviously it would take a bit of rework since it uses BIT(x) instead
of just "x".  But you hide the "BIT()" inside IMR(), which is arguably
slightly obscure since the #define value is not a register mask:

> +#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)

I don't really care either way, but it seems like a possibly needless
difference.

Bjorn
