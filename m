Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199F54E963
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiFPSbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 14:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFPSbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 14:31:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA452B08;
        Thu, 16 Jun 2022 11:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BEF14CE26D1;
        Thu, 16 Jun 2022 18:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A60C34114;
        Thu, 16 Jun 2022 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655404270;
        bh=XQsdJm3k+6wDxXzjrjj+NnC+pOIZEuifFDCXmluDnxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aHJbRHYlC2yiScqm1hmKzjftQzUvUhSk3jqGP/wAPOn/d6cj5uHr/RXh5Y+T3siP0
         IMeYGA4ciOKkMxQjjDKBHiWRNVPrsToh9W5c1taLWRaJLT4zOHi05prwUSktSRtYU3
         1iU/+vDBIL9mVOeLNnOO9rHzyvB00PcxhjhzwTluwx3itxq1tfwkRO2arQdWrHF6+I
         JcajpHL9y5P/ggs5wxZxuOG2mTh1DgW22jHFfVbBoq7g5gymxO9AtlKB+z1zgJTJIO
         pqx6cCQYBcqzCyhHisws64+Et3Pop4k9ontkf1FRq40mjLqJQR85x5sx7OWZznJ87N
         ffJ8QFKsxZQYA==
Date:   Thu, 16 Jun 2022 13:31:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, michals@xilinx.com, robh@kernel.org
Subject: Re: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Message-ID: <20220616183108.GA1101056@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 06:14:27PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additonal register bit
>   to enable and handle legacy interrupts.
> 
> Changes in v5:
> - Added of_device_get_match_data to identify CPM version.
> 
> 
> Bharat Kumar Gogada (2):
>   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
>   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
> 
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 48 ++++++++++++--
>  drivers/pci/controller/pcie-xilinx-cpm.c      | 62 ++++++++++++++++++-
>  2 files changed, 103 insertions(+), 7 deletions(-)

Weren't you going to include a MAINTAINERS update here?

https://lore.kernel.org/r/BY5PR02MB6947C5B34801AD5F289127ABA5A69@BY5PR02MB6947.namprd02.prod.outlook.com

Maybe I missed it?

Thanks,
  Bjorn
