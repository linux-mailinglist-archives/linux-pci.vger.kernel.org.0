Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F755AB7C8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiIBRte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiIBRte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 13:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA15F2C9D;
        Fri,  2 Sep 2022 10:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DCC62223;
        Fri,  2 Sep 2022 17:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C4C433C1;
        Fri,  2 Sep 2022 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662140972;
        bh=GOSNtRWEY0DYm6BP44LdjM1cTRDgHCPLtmZEbPDLPik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHWKYkw6yIb+UI2eNRUngsCmD7q/Td5OnsfwFtyU+5Dh+lRM+vjZaow8hx8QdQE45
         bJlMdvKZ/VQBvGu4i6Xl15rMSnEaOVUu7V9eok5eWrmd2WLHjCFtCuF65otHQQVSPy
         zwqXBRm53/JjTRuh973hFznlavubMlT2Q/O1RhAfmFfoB3szOMHGQcbiJCXzVE0Xzy
         WR9l2HaG6nuHzvxu2uYkozRRmhC37p73SDjhCzxR74qzPa35jW09A8EtjgPSr0UCII
         LQcm1vv7IX++7P65SlslniXwFJROMYUbPpyBAjEakTbO1nTsLeGteu/G0kEoevorqE
         WGw2e5f0lMz3g==
Date:   Fri, 2 Sep 2022 23:19:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     a.fatoum@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        marcel.ziswiler@toradex.com, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v2] phy: freescale: imx8m-pcie: Fix the wrong order of
 phy_init() and phy_power_on()
Message-ID: <YxJCKEuuVvJRD7wF@matsya>
References: <1661928956-12727-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661928956-12727-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31-08-22, 14:55, Richard Zhu wrote:
> Refer to phy_core driver, phy_init() must be called before phy_power_on().
> Fix the wrong order of phy_init() and phy_power_on() here.
> Squash the changes into one patch to avoid the possible bi-section hole.
> 
> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c      | 6 +++---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 8 ++++----

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
