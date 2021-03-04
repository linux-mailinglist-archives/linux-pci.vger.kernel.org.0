Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B532D22D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhCDMBV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 4 Mar 2021 07:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbhCDMBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 07:01:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56507C061574
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 04:00:36 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmeU-0002Qy-MG; Thu, 04 Mar 2021 13:00:22 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmeP-0005IT-4s; Thu, 04 Mar 2021 13:00:17 +0100
Message-ID: <807b832828d95bc003e7caed63ff86b4f9ff6eaa.camel@pengutronix.de>
Subject: Re: [RFC PATCH 5/6] PCI: designware: Add SiFive FU740 PCIe host
 controller driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 04 Mar 2021 13:00:17 +0100
In-Reply-To: <34c2c3985443b23a75ce89c605c4b833bbafd134.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com>
         <34c2c3985443b23a75ce89c605c4b833bbafd134.1614681831.git.greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-03-02 at 18:59 +0800, Greentime Hu wrote:
[...]
> +static int fu740_pcie_probe(struct platform_device *pdev)
> +{
[...]
> +       /* Fetch reset */
> +       afp->rst = devm_reset_control_get(dev, NULL);

Please use
       afp->rst = devm_reset_control_get_exclusive(dev, NULL);	

regards
Philipp
