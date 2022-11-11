Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CF625ED8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 16:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiKKP54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 10:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiKKP54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 10:57:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A825F3
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 07:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC3EAB82665
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 15:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D3C433D6;
        Fri, 11 Nov 2022 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668182271;
        bh=3RRxw1NSoegUs4mMPmKj0CjT58yMQ8td8Vg0aUE8fEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXwtX4WmbCgivtJXmSjSYlrUkoHrRnyHg/FYTRQgZoOVPBXJGtJbqhH/4sJdjtX8G
         9dJUcwajlpPR8LisbjvsyOCjUzwvINDQ96WQ974mVjIQbU3ZyBxTUuz5CCr2nCYmbw
         iXoT92Ju+7p8PSiVDCZjM/zW+WyiGKB2ROkuloyyCVNjMKEQbQOK92sdf5gFV48v3K
         +MwWyDgh5uc7VDJlJdpT5OC5RDFB+J9zW2EGUuH0MyfDIau7R/gwVBCXWWmuvO5x5t
         rN7dBV7u5M8mi7BwaYEFLe4OcEXo2lNTwLfwDX1NutQeGdGrh2NBDaoEqCQGsB2lCt
         w5GkY4wdv5I0A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Initialize PHY before deasserting core reset
Date:   Fri, 11 Nov 2022 16:57:46 +0100
Message-Id: <166818222626.230065.5220320291788502712.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101095714.440001-1-s.hauer@pengutronix.de>
References: <20221101095714.440001-1-s.hauer@pengutronix.de>
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

On Tue, 1 Nov 2022 10:57:14 +0100, Sascha Hauer wrote:
> When the PHY is the reference clock provider then it must be initialized
> and powered on before the reset on the client is deasserted, otherwise
> the link will never come up. The order was changed in cf236e0c0d59.
> Restore the correct order to make the driver work again on boards where
> the PHY provides the reference clock. This also changes the order for
> boards where the Soc is the PHY reference clock divider, but this
> shouldn't do any harm.
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: imx6: Initialize PHY before deasserting core reset
      https://git.kernel.org/lpieralisi/pci/c/ae6b9a65af48

Thanks,
Lorenzo
