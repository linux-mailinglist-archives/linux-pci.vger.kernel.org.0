Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630966A167
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjAMSCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjAMSBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 13:01:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B90FC4;
        Fri, 13 Jan 2023 09:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAAE6225C;
        Fri, 13 Jan 2023 17:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42882C433F2;
        Fri, 13 Jan 2023 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632561;
        bh=/GVEUUP4mneSnkfi1l5t3SvPf2grhVDkhm+ADUOZSSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQeBHaXMo4Uk/lpbKxlqnYw4NsWX0pCjG1cQVCXsH4LnfMzh71XvmD4Gsjjwylsy/
         LV41D+ZF3biawMYobpadCEwVC+32G+lrY+boQkcOoL6SBgNCkvPrzMxTZsIaPrsBVO
         3JlEK+pTtiiQJs4rk5OjRVFoT+6+FvHEg4aOsks3NYcnEGF8zI10yxsyNqhhK6XKZ9
         x64sSj2jfYkXSehP6/vrti0vFyG6TGiUYnaSyNPFUhu2CiJByHtAqknChCumZKv3Jj
         apy1RxZ+PwYc5xdD2RL2kdWgQdIKcSqEiqrv0nvsNboJgSMdsbgRCwq4kw1uPxDzTK
         bypQTdQL2kFuA==
Date:   Fri, 13 Jan 2023 23:25:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     marex@denx.de, alexander.stein@ew.tq-group.com,
        lorenzo.pieralisi@arm.com, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH] phy: freescale: imx8m-pcie: Add one missing error return
Message-ID: <Y8GbLuI7pSar9P2y@matsya>
References: <1671433941-2037-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671433941-2037-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19-12-22, 15:12, Richard Zhu wrote:
> There should be one error return when fail to fetch the perst reset.
> Add the missing error return.

Applied, thanks

-- 
~Vinod
