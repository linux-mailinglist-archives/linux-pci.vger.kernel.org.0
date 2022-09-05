Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3325AC8CA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 04:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiIECaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Sep 2022 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIECaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 22:30:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC72A273;
        Sun,  4 Sep 2022 19:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1072B80E7E;
        Mon,  5 Sep 2022 02:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C23DC433D6;
        Mon,  5 Sep 2022 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662345003;
        bh=GUv3cHTZYqaziju52Y1+ZmSvfImbkNQ+/vGCkNqAPQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPOK8wqNjqiGe5RcB2YIIBjPuqgJdLiCYpaZTl4HnOFltcQGeIkVKuDhNxUFNsscH
         37dSe23yogr+Srpt1rh8ONmO1VY7EpW3xnAEAappoV0BRTqZ3kJxyV5x2apURHvvSZ
         +Yz7QvyQ2WXcqe7+jsJbc2TP13Krba8mhqMn/K4iPZE+uKX/Hk1VzVnifEG0biv/DD
         yRSQP0M0fITNi0uak5FOgWPwje1zy82OEmI3F7lJptfDP4bSaqTOsM7OyzfcpG+Kl6
         p9K9l36r3zBGS+Pj0Eg6qreTdy/w2Zy5078X87bVddWp1/dIizoYq4HTDhRqKiuUGK
         bE7EV7iK4djDg==
Date:   Mon, 5 Sep 2022 10:29:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v7 5/7] soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets
Message-ID: <20220905022956.GC1728671@dragon>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
 <1662109086-15881-6-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662109086-15881-6-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 04:58:04PM +0800, Richard Zhu wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Dessert the PHY reset when powering up the domain and put it back
> into reset when the domain is powered down.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks!
