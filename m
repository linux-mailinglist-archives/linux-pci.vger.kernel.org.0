Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD885A434E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiH2Gdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiH2Gdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 02:33:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4852E9DE
        for <linux-pci@vger.kernel.org>; Sun, 28 Aug 2022 23:33:52 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oSYL8-0003TH-DC; Mon, 29 Aug 2022 08:33:42 +0200
Message-ID: <e6d5f688-f4c3-6094-91f6-a160b601c07d@pengutronix.de>
Date:   Mon, 29 Aug 2022 08:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
To:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, vkoul@kernel.org,
        marcel.ziswiler@toradex.com, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
Content-Language: en-US
In-Reply-To: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 22.08.22 15:10, Richard Zhu wrote:
> Refer [1], phy_init() must be called before phy_power_on().
> This series used to fix the wrong order of the phy_init() and phy_power_on(),
> introduced by commit 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Tested on i.MX8MM EVK board when one NVME device is used.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/phy-core.c?id=v5.19-rc1#n233
> 
> [PATCH v1 1/2] PCI: imx6: Fix the wrong order of phy_init() and
> [PATCH v1 2/2] phy: freescale: imx8m-pcie: Fix the wrong order of

This introduces an intermittent breakage. Can you squash?

> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
