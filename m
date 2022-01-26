Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0D49C143
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 03:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiAZCZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 21:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiAZCZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 21:25:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B4C06173B;
        Tue, 25 Jan 2022 18:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC04BB81B99;
        Wed, 26 Jan 2022 02:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC13C340E7;
        Wed, 26 Jan 2022 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163932;
        bh=6vFEuX4LHodp+DBl+knwGxVrfdfuwDNczYuijuE+GKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYk7blm65frnmUjGPY3H413Wt3Hrx/v2SdHo3GFnMYLjnIftPa7CHekjrF2wrYSCc
         Lq2rtawGeTiz6qBAh0oAT5A+zl6B5UhqUUit4Y+BqCk3bEQk6JyPkdfpphrn6Bu/Hk
         BqXoSp/NBj3rqSaTvsfcIArndEqzL88l+gjOvoeZN9zyxhjaOPBzjYw8HSJGbZYkKe
         Q027+agSIVjtkcuK5LWIzB+YWVlaIZ/MvHARpOVKb03pkUCmVuprkg3kn7EyhMFGi6
         dcHJ5m+KSwuY03ITvg5JQsPlRWQFF8bvVZYc5BYj47QvgRdjn1gy73nCcDHd4cdVfa
         +8Dpg940MG5AQ==
Date:   Wed, 26 Jan 2022 10:25:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 4/8] arm64: dts: imx8mm: Add the pcie phy support
Message-ID: <20220126022524.GB4686@dragon>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-5-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-5-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 04:02:34PM +0800, Richard Zhu wrote:
> Add the PCIe PHY support on iMX8MM platforms.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
