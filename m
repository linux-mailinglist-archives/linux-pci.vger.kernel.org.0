Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3A4CA251
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiCBKiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 05:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiCBKiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 05:38:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54BE0517CC;
        Wed,  2 Mar 2022 02:37:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF4D139F;
        Wed,  2 Mar 2022 02:37:24 -0800 (PST)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA33C3F70D;
        Wed,  2 Mar 2022 02:37:22 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting during resume
Date:   Wed,  2 Mar 2022 10:37:08 +0000
Message-Id: <164621741211.30934.17302961993458445211.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211226074019.2556-1-jszhang@kernel.org>
References: <20211226074019.2556-1-jszhang@kernel.org>
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

On Sun, 26 Dec 2021 15:40:19 +0800, Jisheng Zhang wrote:
> If the host which makes use of the IP's integrated MSI Receiver losts
> power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> register is always set as 0xffffffff incorrectly, thus the MSI can't
> work after resume.
> 
> Fix this issue by moving pp->irq_mask[ctrl] initialization to
> dw_pcie_host_init(), so we can correctly set the mask reg during both
> boot and resume.
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Fix integrated MSI Receiver mask reg setting during resume
      https://git.kernel.org/lpieralisi/pci/c/84edd0090e

Thanks,
Lorenzo
