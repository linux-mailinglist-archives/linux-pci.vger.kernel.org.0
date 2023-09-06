Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FC794200
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjIFRZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 13:25:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD01BCF;
        Wed,  6 Sep 2023 10:25:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83100C433C7;
        Wed,  6 Sep 2023 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694021102;
        bh=EsgPusO5EdsCzpzdBeCjyhX7ExG7A6ZCjf1GCZSV5sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PW8akcPROFzYnawVvMzQrcWGjSx2pO615gbZZuMYTcWzXxcTvb3QLGUbytZoQoyc0
         0LPyzBQ7Fl1VsC2LFO1kPQuv59SsEqXLjiNPtjX8pP4Zmp5r4tvWyGPc5Lubhm4+cs
         wr8ynjUlU/Vf0OOrcSWAxsp3mOU8YU8QzU6C75QSzPl4oqRIz4T4s/HAschxl/GXEe
         FTYQbd1rck3WtNYmIAJ2Xj23DyRqZpW7sC6syrVV/VH1uwo+JsdsSEf5q/REHg2WNS
         etqaXz4Xa2gWiomyPMcoz1a1SKv2BtGVlV/9vIXZsSa4o8vE/hGZmYH5RfAnA7hkWp
         Ml7VbTUYiXwbw==
Date:   Wed, 6 Sep 2023 12:25:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20230906172500.GA231799@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 30, 2023 at 02:37:07PM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.

> +	if (!pci_is_root_bus(bus)) {
> +		/* Checking whether the link is up is the last line of
> +		 * defense, and this check is inherently racy by definition.
> +		 * Sending a PIO request to a downstream device when the link is
> +		 * down causes an unrecoverable error, and a reset of the entire
> +		 * PCIe controller will be needed. We can reduce the likelihood
> +		 * of that unrecoverable error by checking whether the link is
> +		 * up, but we can't completely prevent it because the link may
> +		 * go down between the link-up check and the PIO request.
> +		 */

Looks fine to me.  If Lorenzo or Krzysztof thinks this is ready to go,
maybe they will tidy the comment above, i.e.,

  /*
   * Checking whether ...
