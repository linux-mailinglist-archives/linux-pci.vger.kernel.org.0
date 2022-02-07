Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDAC4AC890
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiBGSb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiBGSat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 13:30:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1CC0401D9;
        Mon,  7 Feb 2022 10:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC2160F62;
        Mon,  7 Feb 2022 18:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0F2C004E1;
        Mon,  7 Feb 2022 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644258648;
        bh=riWJPhQ/S3PZiHj8yuELdnUzcOi2A/0/xMXt32fuyfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bfT6YvD9jl0aO/52ZQpQlDFoHIG9ICGqozhjlUv6K+hT3JK6Sc3B22XwzO2T80AqS
         yhsCkFdBtgFcMdGGLvFrgYAX0X2hyDK28e2eX2dcaM1Fd4/auuLve9f30A5OyFd6Yn
         +c0Q6q8XyGnUrxvkwgKZjErBgjLQu/7LPeSzip0QrwkKANYbXfQueFkR2Td3s5ZNT/
         6hDRiQKX/YGf+jTah0gcIdsOdBcWqzjgcYNrY5TyRF0aCGRtsvG8qjGmUBEPHWsPZV
         +niPmkNmc1Eliih78yCfwxGdiDO1R/pzipvpcwKKOsJTrYESn8L6nax+e7+lM0J2/t
         I33AIqRs8zOkQ==
Date:   Mon, 7 Feb 2022 12:30:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port driver
Message-ID: <20220207183046.GA408682@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207041250.1658-4-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, possibly:

  PCI: xilinx-cpm: Add Versal CPM5 Root Port support

since you're adding support for a *device*, not for a *driver*.

On Mon, Feb 07, 2022 at 09:42:50AM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root port
> functioning at Gen5 speed.
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additional register bit
>   to enable and handle legacy interrupts.

s/Root port/Root Port/ to be consistent.
Add blank line between paragraphs.

Bjorn
