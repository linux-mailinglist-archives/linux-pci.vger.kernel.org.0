Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F86EA690
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDUJJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjDUJJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 05:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4D1B1;
        Fri, 21 Apr 2023 02:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DBE664EAE;
        Fri, 21 Apr 2023 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B13CC433EF;
        Fri, 21 Apr 2023 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682068169;
        bh=VCPEu+xt9KicucItLEUpvnOVJheKg0NzwoZBIA+/Eyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnxCzY/fmW73ctJv/i0sjGtgquKsDr0J9kYzqljAwycgah/KuPkJWbTHWpZEHubc5
         aU+jg5FAPvueIcN5XWBgDfCogy31nqrc5KETCP9cHD4RUiXjySifgOsoiPvJyYPy++
         8o6BAePNG+p6ItB37BgOVvRzGa/p0io5EnQtLcW3dbtyln8r54A4Pd0HYMPqRfxIrk
         tUaxnBOf33LtlqJFhZm8XUQyYf+gRP2loZE6YN6hIkXNOO3a2nKtyQBj/gbnBpN33E
         BkYEPTh/FOI9OUa3T/C4NoeCCTA8NuaQP2oo6OoQwaVbwU7xCsevEYAsGsuzSHfcot
         HeFrTilNDwyXw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     tjoseph@cadence.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, nadeem@cadence.com,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Date:   Fri, 21 Apr 2023 11:09:22 +0200
Message-Id: <168206814625.77926.12605918077768300523.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315070800.1615527-1-s-vadapalli@ti.com>
References: <20230315070800.1615527-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Mar 2023 12:38:00 +0530, Siddharth Vadapalli wrote:
> The Link Retraining process is initiated to account for the Gen2 defect in
> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> is i2085, documented at:
> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> 
> The existing workaround implemented for the errata waits for the Data Link
> initialization to complete and assumes that the link retraining process
> at the Physical Layer has completed. However, it is possible that the
> Physical Layer training might be ongoing as indicated by the
> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> 
> [...]

Applied to controller/cadence, thanks!

[1/1] PCI: cadence: Fix Gen2 Link Retraining process
      https://git.kernel.org/pci/pci/c/eac223e85208

Thanks,
Lorenzo
