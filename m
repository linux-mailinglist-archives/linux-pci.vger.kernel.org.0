Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C19773F2F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHHQoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjHHQn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A4212D
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED529624BD
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 11:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4241BC433C7;
        Tue,  8 Aug 2023 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691492563;
        bh=hOrjnmBvHRWa/gPz43eRdywRQ0atmS0NAUDdlupwrb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eA5Fz53PZedXwnRszgxstlozvYRwB9J+jxgXTpdqkaSQXclxq+a8yHT3bnuYO5oyJ
         39ERNWmUSYkRX/Ln52APmjlzKGB7xc5Ov57aKcgMwj9bcu1pc9RE6fUG+/C/V5NLqo
         rDdrPUETe88mZFCVZ0MRmZkQ6kLNbJG1Lts1zLhZBW+eMDYzK8x02oj21CAiWZ5BuT
         SaVz7lqnAqBqgxpf+GJCHtWrQfEwHPfnkpqK/Qw8+CsVQolElhZvzZNmg7gsgXfFi7
         wNCae1Z1fwB0pXcf2jjmS/f0lDwpMiWVLScASe53yrEOd70o5Y0FvY1YUaa3NucjgO
         FawkjA74nvpvw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     conor.dooley@microchip.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        linux-pci@vger.kernel.org, daire.mcnamara@microchip.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 0/7] PCI: microchip: Fixes and clean-ups
Date:   Tue,  8 Aug 2023 13:02:37 +0200
Message-Id: <169149233963.79399.5232296870054239065.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
References: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 28 Jul 2023 14:13:54 +0100, daire.mcnamara@microchip.com wrote:
> This patch series contains fixes and clean-ups for the Microchip PolarFire SoC PCIe driver
> 
> These patches are extracted from the link below to separate them from the outbound and inbound
> range handling which is taking considerable time.
> Link: https://lore.kernel.org/linux-riscv/20230111125323.1911373-1-daire.mcnamara@microchip.com/
> 
> Resending with correct e-mail address list
> 
> [...]

Applied to controller/microchip, thanks!

[1/7] PCI: microchip: Correct the DED and SEC interrupt bit offsets
      https://git.kernel.org/pci/pci/c/6d473a5a2613
[2/7] PCI: microchip: Enable building driver as a module
      https://git.kernel.org/pci/pci/c/2e245bc8a2ab
[3/7] PCI: microchip: Align register, offset, and mask names with hw docs
      https://git.kernel.org/pci/pci/c/4d6bf4c49578
[4/7] PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
      https://git.kernel.org/pci/pci/c/d1d6a0c9e79c
[5/7] PCI: microchip: Clean up initialisation of interrupts
      https://git.kernel.org/pci/pci/c/4f0b91247f78
[6/7] PCI: microchip: Gather MSI information from hardware config registers
      https://git.kernel.org/pci/pci/c/1abb722888fd
[7/7] PCI: microchip: Re-partition code between probe() and init()
      https://git.kernel.org/pci/pci/c/bac406c34fbc

Thanks,
Lorenzo
