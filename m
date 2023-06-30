Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECF744414
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjF3Vtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 17:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjF3Vth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 17:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F33ABD;
        Fri, 30 Jun 2023 14:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A5B6181D;
        Fri, 30 Jun 2023 21:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F231DC433C8;
        Fri, 30 Jun 2023 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688161772;
        bh=nwvYl376FTCG3QHJncLs4AS9k0pbesWjAIyl6ONM498=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FVzDJFNo8Kfe1Y9U1al2N/AQc+AcvDWoTkJfYvvhwlm4KmN0lWaaOD6U4CQfg1Ckm
         ufOPr+9q4bPnek4s1RNLYQbAJ3Imq6sYNOT7RCib1TgHyJ/NnyibnKZ+xw1KgXmpQa
         b2M7gMU6srNlOzYcdTdRdURlyroyIJqacMBFhRhY9YB8VtFrC5Wi0WlTPQRIhm5pDO
         QUI2/fftob3UxY/madEfAop+mJzeIJSCyBmAWFXyAE9sApN16sEG5IUaGwAxcd8xDO
         sQuPB9cJ/GKnAPutMwlldZ59uROXrwGjzjy4+PjCpP+uPJzvpEwSEZlOtEGgKnKKLa
         3rEh4Jtx4X56Q==
Date:   Fri, 30 Jun 2023 16:49:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bharat.kumar.gogada@amd.com,
        michals@amd.com
Subject: Re: [PATCH V5 1/3] Move and rename error interrupt bits to a common
 header.
Message-ID: <20230630214930.GA496585@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092812.1592644-2-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject line needs to contain "PCI: " and the driver name.
The subject line also should not end with a period.
It looks like some of these interrupt bits are not errors.

Mentioned previously at https://lore.kernel.org/r/ZF6SHJ44s4OqPYj4@bhelgaas

Suggest this instead:

  PCI: xilinx-cpm: Move interrupt bit definitions to common header

On Wed, Jun 28, 2023 at 02:58:10PM +0530, Thippeswamy Havalige wrote:
> Move and rename error interrupt bit macros to a common header file for
> code reusability.

Suggest this:

  Rename Xilinx interrupt bit definitions so they are not
  CPM-specific.  Move the definitions to pcie-xilinx-common.h where
  they can be shared between pcie-xilinx-cpm and the new xilinx-xdma
  driver.

> Move common linux header files for reusability.

This sentence is redundant and should be removed.

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>

Bjorn
