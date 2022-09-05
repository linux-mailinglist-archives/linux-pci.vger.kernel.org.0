Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A55AC8D3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiIECd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Sep 2022 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIECd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 22:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E922C132;
        Sun,  4 Sep 2022 19:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B12A60F3C;
        Mon,  5 Sep 2022 02:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04097C433C1;
        Mon,  5 Sep 2022 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662345205;
        bh=SZNeueOviL5nKj7BJ/+AUY1Pi5Q6OG1O7EOPOkTCWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg/p57B4dNTvp6LEJCSEWpVFxU29ieochHfl/DEkZooyvllkTCgFzHgP6ohxWiaAb
         x4mvt/HqOb5PvdCbhCuBlOZXoEbcZbxOWtPwQNt0CxXTOHgY0rQeqPnwNFfZ+tjo4B
         2QQnjQAghdnaKfche9KAD5gHh+Ru25xbOMZ6UqIj3S3jrBuFm0wzNO3Gfx6hnsiY+7
         oH9GJqNSS2If2SO+UNVF9KwK5a4rs3bUXPOKxnJI+YUhpjzimbxK3MI7X7OS4LjIAY
         5KMMjxVMSQ965pZMwwZ29v6n/1M12c2U2XvK89QHxEDdIJuI7KhUBx0B51/qKTl5gG
         170/2k0jR4XIA==
Date:   Mon, 5 Sep 2022 10:33:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v7 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Message-ID: <20220905023318.GE1728671@dragon>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
 <1662109086-15881-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662109086-15881-4-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 04:58:02PM +0800, Richard Zhu wrote:
> Add PCIe support on i.MX8MP EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks!
