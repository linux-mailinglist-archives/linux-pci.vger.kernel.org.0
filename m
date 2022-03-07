Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897C4CFCD6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiCGL3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 06:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbiCGL2n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 06:28:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFDF36621B;
        Mon,  7 Mar 2022 03:10:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8680ED1;
        Mon,  7 Mar 2022 03:10:01 -0800 (PST)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6254A3F73D;
        Mon,  7 Mar 2022 03:10:00 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     shawnguo@kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        bhelgaas@google.com, l.stach@pengutronix.de
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Date:   Mon,  7 Mar 2022 11:09:53 +0000
Message-Id: <164665133421.20091.3372213554169695625.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
References: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
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

On Mon, 21 Feb 2022 14:33:56 +0800, Richard Zhu wrote:
> In the i.MX6QP sabresd board(sch-28857) design, one external oscillator
> is powered up by vgen3 and used as the PCIe reference clock source by
> the endpoint device.
> 
> If RC uses this oscillator as reference clock too, PLL6(ENET PLL) would
> has to be in bypass mode, and ENET clocks would be messed up.
> 
> [...]

I skipped patch(1) since we don't apply dts changes, those should
go via respective platform maintainers.

[2/2] PCI: imx6: Enable i.MX6QP PCIe power management support
      https://git.kernel.org/lpieralisi/pci/c/f81dd043ec

Thanks,
Lorenzo
