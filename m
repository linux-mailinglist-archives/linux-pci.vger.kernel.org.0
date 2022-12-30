Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4662865978B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiL3LWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 06:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiL3LWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 06:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB291AA3D;
        Fri, 30 Dec 2022 03:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1152608C1;
        Fri, 30 Dec 2022 11:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F67C433D2;
        Fri, 30 Dec 2022 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672399355;
        bh=fXGX+rVN/2M3LX+qEmoSlls8HDkI0APVmNRSO9nEZYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqbDqN10WTtYRybV3WGvvakdF9k2Jp+c5eFcC1t7F6I/UpBHCj7Eb3Bpeahn14dCM
         P9LfENqp5mfTZEJoRltznE27I985gapulfIbcqm2sImJ5tUPiJT/hmGBoQAkr75f4d
         3VOXGKc4fiqrwIG4qltvIw7zkWRTZp2I0ucphPeXJuobvIx5K9TNY86dzjSCBbeIId
         Vgq24pf6pm1C3AVbtx1mrDVUS40y7u0HhxBwEZM7v9XBjMUmJdLFgd5QCWYQkHMPnj
         gD837S5sZeEnmzkF1n0xqk03zCxMHgycHHvGYGs4tbHjSR1a5xoKeJBGZY17ehhYhV
         WDYCf7gaOZP4Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: switchtec: Trivial cleanups
Date:   Fri, 30 Dec 2022 12:22:29 +0100
Message-Id: <167239933784.745134.2151976451267200665.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216162126.207863-1-helgaas@kernel.org>
References: <20221216162126.207863-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 16 Dec 2022 10:21:24 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Simplify switchtec_dma_mrpc_isr() slightly and return the right
> copy_to_user() error code from switchtec_dev_read().
> 
> Bjorn Helgaas (2):
>   PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
>   PCI: switchtec: Return -EFAULT for copy_to_user() errors
> 
> [...]

Applied to pci/switchtec, thanks!

[1/2] PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
      https://git.kernel.org/lpieralisi/pci/c/1a810b9bb681
[2/2] PCI: switchtec: Return -EFAULT for copy_to_user() errors
      https://git.kernel.org/lpieralisi/pci/c/fbc855bce49e

Thanks,
Lorenzo
