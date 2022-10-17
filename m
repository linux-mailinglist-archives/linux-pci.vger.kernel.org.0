Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D0600653
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJQFbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJQFbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 01:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADC49B6E;
        Sun, 16 Oct 2022 22:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11CDF60F2E;
        Mon, 17 Oct 2022 05:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CECC433C1;
        Mon, 17 Oct 2022 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665984674;
        bh=sO6545pDBaPqu6+Mn2bqfpIFfvQunPyQ2gJKDlsGsHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcrpWc6UvaFIr0BqUGoRxVCl4HW9/4t/oBBmVM4NudRKzTkgrb6Rud5WWZ+4GfpQI
         0V+hbxhKq74nxlOiWocNjeuwd3nPDiV66FH+mQZtgOgF3VXbB3DPgTth//buaQdgb6
         49x/i+X7ZGk4BUGklMS2ExE1IgU8rLplTH1qC2lGS55hoQR6Z3eKJy6EHi+YaL/MU0
         zVZ6jTMJxVFiJhlgksweBOqAYyp9vD61C6iqr77+eBLim+B93MR8SHW0uoTxWV10N8
         LVJBkrpjz6SxHae/OzG1uoHWX3O2oPTk3MZwJZERriaN1pssWpNB6h4fOjmNBlD22Z
         bfP9WJPrC8jLw==
Date:   Mon, 17 Oct 2022 11:01:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH RESEND v12 0/4] Add the iMX8MP PCIe support
Message-ID: <Y0zonrL8JFDQwW3o@matsya>
References: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13-10-22, 09:46, Richard Zhu wrote:
> Re-base to the pci-v6.1-changes of pci/next branch. 
> Update the cover-letter, and re-send the v12 patch-set.
> This series adds the i.MX8MP PCIe support and tested on i.MX8MP
> EVK board when one PCIe NVME device is used.
> 
> - i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
>   Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>   And share as much as possible codes with i.MX8MM PCIe PHY.
> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>   driver.

Applied, thanks

-- 
~Vinod
