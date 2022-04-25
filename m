Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8995250DD6D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiDYKDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiDYKCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 06:02:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C61392;
        Mon, 25 Apr 2022 02:59:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CCBE1FB;
        Mon, 25 Apr 2022 02:59:30 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674F03F73B;
        Mon, 25 Apr 2022 02:59:28 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/4] PCI: mvebu: Slot support
Date:   Mon, 25 Apr 2022 10:59:22 +0100
Message-Id: <165088064982.13301.5330205874196950920.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220412094946.27069-1-pali@kernel.org>
References: <20220412094946.27069-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 12 Apr 2022 11:49:42 +0200, Pali Rohár wrote:
> This patch series add slot support to pci-mvebu.c driver.
> 
> Changes in v5:
> * Fix compile error due to wrong patch rebasing
> 
> Changes in v4:
> * Set 239 W when DT slot-power-limit-milliwatt is between 239 W and 250 W
> * Fix returning power limit value
> 
> [...]

Dropped patch [2] since it is not needed.

Applied to pci/power-slot, thanks!

[1/4] PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
      https://git.kernel.org/lpieralisi/pci/c/e8e7fbb6a3
[3/4] PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
      https://git.kernel.org/lpieralisi/pci/c/35662423fb
[4/4] PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
      https://git.kernel.org/lpieralisi/pci/c/0d5b8c2985

Thanks,
Lorenzo
