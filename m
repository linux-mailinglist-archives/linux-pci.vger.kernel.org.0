Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E014D7FEC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 11:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiCNKfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbiCNKfa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 06:35:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CC08434A0;
        Mon, 14 Mar 2022 03:34:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21EB1042;
        Mon, 14 Mar 2022 03:34:20 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7323F99C;
        Mon, 14 Mar 2022 03:34:19 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, marek.vasut@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH v6 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
Date:   Mon, 14 Mar 2022 10:34:12 +0000
Message-Id: <164725399057.13052.7405723522140650308.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220312212349.781799-1-marek.vasut@gmail.com>
References: <20220312212349.781799-1-marek.vasut@gmail.com>
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

On Sat, 12 Mar 2022 22:23:48 +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
> 
> [...]

Re-built pci/rcar with this series, I shall ask Bjorn to pull it
again, we should be in time for v5.18.

[1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
      https://git.kernel.org/lpieralisi/pci/c/84b5761462
[2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception
      https://git.kernel.org/lpieralisi/pci/c/6e36203bc1

Thanks,
Lorenzo
