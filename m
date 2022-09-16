Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C240A5BA810
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIPIV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPIVY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 04:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D14A4077;
        Fri, 16 Sep 2022 01:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F406290C;
        Fri, 16 Sep 2022 08:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E61FC433D6;
        Fri, 16 Sep 2022 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663316482;
        bh=dbtg1VkYcSH98eH1LXp4FuBWlKs7YoXiI6XVpWr2rB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOUxzKdEU7rgW5SA8OJPqpfk5OrodzUAUZnhGWz2y1KMZ7sCOWyb4z0hS+v/s7srn
         LMsOIbz2q/H7B8DPlHJXuN4xr90c4MyJvlUiOb8vsece1wHk4u/ugO6KEr0VkMAdJD
         /4g82w9BJSUyFZVnGqzWg9OWihMCOq8OAGEo2Tg9FSSLPEM69RQdQoYfpB9v6RZHIO
         SES1uxqcIh/oFb86GFEmccsFOVZQ0NlPRmA0lWkxha7JYjSSrb4Qg0wngTM6DVaDqk
         J9BDcZ+ww2+qC9qJRJsDHJlcLf6ZYgLBMH2IdBDqgiM4G2jGUiShURs8MMG6d5GhRD
         xcgOLFO82asvg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>, l.stach@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        p.zabel@pengutronix.de, bhelgaas@google.com, marex@denx.de,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev,
        shawnguo@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: Re: (subset) [PATCH v7 0/7] Add the iMX8MP PCIe support
Date:   Fri, 16 Sep 2022 10:21:14 +0200
Message-Id: <166331646343.2896318.11776848065564134926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
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

On Fri, 2 Sep 2022 16:57:59 +0800, Richard Zhu wrote:
> Based on the 6.0-rc1 of the pci/next branch.
> This series adds the i.MX8MP PCIe support and tested on i.MX8MP
> EVK board when one PCIe NVME device is used.
> 
> - i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
>   Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>   And share as much as possible codes with i.MX8MM PCIe PHY.
> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>   driver.
> 
> [...]

Applied to pci/dwc, thanks!

[7/7] PCI: imx6: Add i.MX8MP PCIe support
      https://git.kernel.org/lpieralisi/pci/c/81f66385ea1e

Thanks,
Lorenzo
