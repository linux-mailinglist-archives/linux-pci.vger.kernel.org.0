Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB807543BD9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiFHS57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFHS57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC7A456;
        Wed,  8 Jun 2022 11:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8771361BFD;
        Wed,  8 Jun 2022 18:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A935C34116;
        Wed,  8 Jun 2022 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654714676;
        bh=vLpG0kVD4GILkpMDJR4jVsJpyI+u2DE2pD2XOqo8TIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pgtQx0Gq9fRSLpeqru15gy6mdYtyqiJjS0RcmrCugcOvmbyw7KpQH5P5X2rguLpn+
         tGHObQqHJMtF2QXQNp2FNx/9dq1s9EuFkVkNeArqrqOMrDrKnTxYM4Ri97KAZVaCoR
         Km93EXcM2PFeqSy64/Ust3a9uikhJhimAcM5LQgkxMBT7bD6cL+f3OlaUef7cXp+X6
         +NTp+TpXgARM3sFYKjjHU3N83MptG2fa8d9Qd5MXJp7eustrWx40FPCG/VNtxtoQ3k
         uvgVG3QcxwUNATHD6tjNpxXNhgyS0nryeJ0/7+x9kWd4Cc4wrVZDXX5fKsg6hrAyIa
         cH0OOSRc0SPMw==
Date:   Wed, 8 Jun 2022 13:57:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Message-ID: <20220608185754.GA411026@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651801629-30223-8-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 09:47:08AM +0800, Richard Zhu wrote:
> To make it more reasonable, move the phy_power_on/phy_init callbacks to
> the proper places.
> - move the phy_power_on() out of imx6_pcie_clk_enable().
> - move the phy_init() out of imx6_pcie_deassert_core_reset().

I'm not sure what "make it more reasonable" is telling me.  In subject
line and commit log, please say something more specific than "the
proper places."  

It's probably more important to say where they are moving *to* than
where they're moving *out of*.

> In order to save power consumption, turn off the clocks and regulators when
> the imx6_pcie_host_init() return error.

Is the power savings the *reason* for this change?  I can't tell from
the commit log.
