Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29074B2A62
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbiBKQ2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:28:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbiBKQ2o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:28:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8E5BD1;
        Fri, 11 Feb 2022 08:28:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2CA3106F;
        Fri, 11 Feb 2022 08:28:42 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.37.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C553F70D;
        Fri, 11 Feb 2022 08:28:40 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: Introduce UniPhier NX1 PCI endpoint controller support
Date:   Fri, 11 Feb 2022 16:28:33 +0000
Message-Id: <164459688629.18091.18363501348451518147.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Thu, 10 Feb 2022 17:09:53 +0900, Kunihiko Hayashi wrote:
> This series includes the patches to add basic support for the PCI endpoint
> controller implemented in NX1 SoC.
> 
> This defines SoC-dependent data to distinguish existing functions and flags
> for Pro5 and NX1 SoCs.
> 
> Changes since v2:
> - Add .init(), .wait(), and has_gio to SoC-dependent data instead of
>   "is_legacy" flag
> - Rename uniphier_pcie_init_ep_legacy() with uniphier_pcie_pro5_init_ep()
> - Rename uniphier_pcie_init_ep() and uniphier_pcie_wait_ep() with
>   uniphier_pcie_nx1_init_ep() and uniphier_pcie_nx1_wait_ep()
> - Add Reviewed-by: lines
> 
> [...]

Applied to pci/uniphier, thanks!

[1/3] dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
      https://git.kernel.org/lpieralisi/pci/c/f28b24042b
[2/3] PCI: uniphier-ep: Add SoC data structure
      https://git.kernel.org/lpieralisi/pci/c/d41584ae86
[3/3] PCI: uniphier-ep: Add NX1 support
      https://git.kernel.org/lpieralisi/pci/c/892fdf15b8

Thanks,
Lorenzo
