Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B44DC230
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiCQJCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCQJCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 05:02:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 265761D08C4;
        Thu, 17 Mar 2022 02:01:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42551476;
        Thu, 17 Mar 2022 02:01:24 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.43.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222053F766;
        Thu, 17 Mar 2022 02:01:23 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        l.stach@pengutronix.de
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present
Date:   Thu, 17 Mar 2022 09:01:18 +0000
Message-Id: <164750763778.14330.2374977117097314236.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
References: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
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

On Thu, 24 Feb 2022 11:06:53 +0800, Richard Zhu wrote:
> The CLKREQ# signal is an open drain, active low signal that is driven
> low by the remote Endpoint device. But it might not be driven low if no
> Endpoint device is connected.
> 
> On i.MX8MM PCIe, phy_init() may fail and system boot may hang if no
> Endpoint is connected to assert CLKREQ#.
> 
> [...]

Applied to pci/imx6, thanks!

[1/1] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present
      https://git.kernel.org/lpieralisi/pci/c/45514f78c6

Thanks,
Lorenzo
