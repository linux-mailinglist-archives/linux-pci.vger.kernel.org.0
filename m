Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2F52BF7A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiERPyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiERPyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 11:54:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A99AC1CE624
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 08:54:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 595311042;
        Wed, 18 May 2022 08:54:39 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.4.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033103F93E;
        Wed, 18 May 2022 08:54:37 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: (subset) [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Date:   Wed, 18 May 2022 16:54:31 +0100
Message-Id: <165288925279.7950.90687082853412954.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
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

On Sun, 20 Feb 2022 20:33:28 +0100, Marek Behún wrote:
> here comes batch 5 of changes for Aardvark PCIe controller.
> 
> This batch
> - adds support for AER
> - adds support for DLLSC and hotplug interrupt
> - adds support for sending slot power limit message
> - adds enabling/disabling PCIe clock
> - adds suspend support
> - optimizes link training by adding it into separate worker
> - optimizes GPIO resetting by asserting it only if it wasn't asserted
>   already
> 
> [...]

Applied to pci/aardvark, thanks!

[03/18] PCI: aardvark: Add support for AER registers on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/06228c0ae2
[05/18] PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/bf8dd34079

Thanks,
Lorenzo
