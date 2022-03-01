Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10C14C911A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiCARIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiCARID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 12:08:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2014FBC;
        Tue,  1 Mar 2022 09:07:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA5EED1;
        Tue,  1 Mar 2022 09:07:21 -0800 (PST)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4829B3F73D;
        Tue,  1 Mar 2022 09:07:20 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
Date:   Tue,  1 Mar 2022 17:07:08 +0000
Message-Id: <164615441330.28960.10937638212220997224.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220219034604.603656-1-marek.vasut@gmail.com>
References: <20220219034604.603656-1-marek.vasut@gmail.com>
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

On Sat, 19 Feb 2022 04:46:03 +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
> 
> [...]

Applied to pci/rcar, thanks!

[1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
      https://git.kernel.org/lpieralisi/pci/c/de6b5097f5
[2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception
      https://git.kernel.org/lpieralisi/pci/c/9775965dba

Thanks,
Lorenzo
