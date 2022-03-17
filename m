Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2392E4DC215
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiCQJAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiCQJAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 05:00:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D7BD5FEE;
        Thu, 17 Mar 2022 01:58:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF6521476;
        Thu, 17 Mar 2022 01:58:43 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.43.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C2BE3F766;
        Thu, 17 Mar 2022 01:58:41 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, l.stach@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: imx6: Invoke the PHY exit function after PHY power off
Date:   Thu, 17 Mar 2022 08:58:37 +0000
Message-Id: <164750743037.11873.2696865290118879978.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com>
References: <1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Mar 2022 14:34:35 +0800, Richard Zhu wrote:
> To balance phy->init_count, invoke the phy_exit() after phy_power_off().
> 
> 

Applied to pci/imx6, thanks!

[1/1] PCI: imx6: Invoke the PHY exit function after PHY power off
      https://git.kernel.org/lpieralisi/pci/c/deaf7a2c2e

Thanks,
Lorenzo
