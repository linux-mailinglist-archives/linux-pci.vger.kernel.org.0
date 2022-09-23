Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198BD5E7C56
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWNxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIWNxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85B13D1D8;
        Fri, 23 Sep 2022 06:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4D5617E6;
        Fri, 23 Sep 2022 13:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D4C433C1;
        Fri, 23 Sep 2022 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663941230;
        bh=slCg/Yn98CrX5wvXOGTCcVbdgvLG1JtKMBPOovTHD0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pASAel/SB5ZNZJx0vUnb8B+fBzLSvTJy9sOA+oOYZg0OkvqdjxU7lwTDx5Ya/vTIf
         tQnkStKHYU7y5UqkDuzC5Ztl1WfCjgFYcunq7X4BGRhSvRhObR4k1pwemfe9ZhhLCN
         XCghFP2WW4uEHtOw33L2AKq0afN4YDkFLrOqXbwZLUjBv7sgf5dApSKL0gKlrEFKMu
         kje4vEK3QM3Zz2AAaZWME5WVRRCWBS/RAXUL5Oo678rtzeTwexsN/sHtGJrYfmiCH3
         R+Q2fibAere6eHgG6jB3Qf8sVilwMKTCqMpOPrn0HeJTkUtTV4npLRxLlOmHxwzgvc
         zSo+OZKs8JbsQ==
Date:   Fri, 23 Sep 2022 08:53:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 0/14] Add iMX PCIe EP mode support
Message-ID: <20220923135348.GA1387145@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 02:06:46PM +0800, Richard Zhu wrote:
> i.MX PCIe controller is one dual mode PCIe controller, and can work either
> as RC or EP.
> This series add the i.MX PCIe EP mode support. And had been verified on
> i.MX8MQ EVK, i.MX8MM EVK and i.MX8MP EVK boards.
> In the verification, one EVK board used as RC, the other one used as EP.
> Use the cross TX/RX differential cable connect the two PCIe ports of these
> two EVK boards.
> 
> +-----------+                +------------+
> |   PCIe TX |<-------------->|PCIe RX     |
> |           |                |            |
> |EVK Board  |                |EVK Board   |
> |           |                |            |
> |   PCIe RX |<-------------->|PCIe TX     |
> +-----------+                +------------+
> 
> Main changes from v2 -> v3:
> - Add the i.MX8MP PCIe EP support, and verified on i.MX8MP EVK board.
> - Rebase to latest pci/next branch(tag: v6.0-rc1 plus some PCIe changes).

This doesn't apply cleanly on either v6.0-rc1 or my "next" branch.
It's best to base your branch on my "main" branch (currently v6.0-rc1)
because that's an unambiguous base that remains stable for the entire
cycle.

If your series actually *depends* on something that's already been
merged, specify that and include the SHA1 (not just something vague
like "latest pci/next" or "v6.0-rc1 plus some PCIe changes") so we can
figure out how to handle it.

Bjorn
