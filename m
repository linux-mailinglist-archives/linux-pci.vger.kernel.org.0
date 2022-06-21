Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1C553E7B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353377AbiFUW2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354522AbiFUW2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 18:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FED6316;
        Tue, 21 Jun 2022 15:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31EF46172C;
        Tue, 21 Jun 2022 22:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61DC3411C;
        Tue, 21 Jun 2022 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655850516;
        bh=CHL/ZNk1WKi/MdEl6nAc3XijgfsJIFJrnSoy21hNQQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=no1eTT9lcjS7OYXZilCOOGp0tWQ5GvoZIeQf3c2MQWd1CqKkJVMSqxxTVhJjQQ8Fn
         gFM02vn4mFm4f/KsmGfXmG9hKikAjPwaORkAfEVpOPQAesmWVCRgot0/BjVCQ7U/1c
         cixfiE7iv0a88DmniS2q2YuNbum1dJ9k5BC0aiehFzHkqRjfmOnIkn1ZqIa80KJWNt
         8xLW/2fbPPXAlSronfR9f1nRim0WVYIm9TXm0NR19x7h+lgCTZD4Tx84RitiYYp+ED
         tH2Ck+CZvMlpajIqxGU5ByGFttFhkvWykdRlmAmh9uEyFr5CVILmkqJwzhuJi2Ig76
         pebEuQKZlB9Yw==
Date:   Tue, 21 Jun 2022 17:28:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, michals@xilinx.com, robh@kernel.org
Subject: Re: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Message-ID: <20220621222834.GA1339138@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 05:06:51PM +0530, Bharat Kumar Gogada wrote:
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

This is the third "v5" posting:

  #1 Jun 16 https://lore.kernel.org/r/20220616124429.12917-1-bharat.kumar.gogada@xilinx.com
  #2 Jun 18 https://lore.kernel.org/r/20220618024459.7554-1-bharat.kumar.gogada@xilinx.com
  #3 Jun 21 https://lore.kernel.org/r/20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com

This makes things harder than necessary.

I commented on a couple things in #2, and you said you were going to
fix them, but they aren't fixed in #3.

It will also make things easier if you include the MAINTAINERS patch
in the same series.  There's no reason for it to be separate.

Can you please post a v6 with the updates?

Bjorn
