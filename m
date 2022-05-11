Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E94523368
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiEKMv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiEKMvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:51:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29EB46833A
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 05:51:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A3CED1;
        Wed, 11 May 2022 05:51:47 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D77273F66F;
        Wed, 11 May 2022 05:51:45 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Date:   Wed, 11 May 2022 13:51:39 +0100
Message-Id: <165227348638.11227.1444036865071474526.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220404081509.94356-1-francesco.dolcini@toradex.com>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
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

On Mon, 4 Apr 2022 10:15:09 +0200, Francesco Dolcini wrote:
> According to the PCIe standard the PERST# signal (reset-gpio in
> fsl,imx* compatible dts) should be kept asserted for at least 100 usec
> before the PCIe refclock is stable, should be kept asserted for at
> least 100 msec after the power rails are stable and the host should wait
> at least 100 msec after it is de-asserted before accessing the
> configuration space of any attached device.
> 
> [...]

Applied to pci/imx6, thanks!

[1/1] PCI: imx6: Fix PERST# start-up sequence
      https://git.kernel.org/lpieralisi/pci/c/a6809941c1

Thanks,
Lorenzo
