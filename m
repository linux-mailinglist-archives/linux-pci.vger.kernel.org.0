Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A65236E8
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbiEKPP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiEKPPz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 11:15:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 162453CFD5;
        Wed, 11 May 2022 08:15:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06D6ED1;
        Wed, 11 May 2022 08:15:52 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5255D3F66F;
        Wed, 11 May 2022 08:15:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-rockchip@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/5] Enable rk356x PCIe controller
Date:   Wed, 11 May 2022 16:15:44 +0100
Message-Id: <165228194780.18099.431001983386428849.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
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

On Fri, 29 Apr 2022 08:38:26 -0400, Peter Geis wrote:
> This series enables the DesignWare based PCIe controller on the rk356x
> series of chips. We drop the fallback to the core driver due to
> compatibility issues. We reset the PCIe controller at driver probe to
> prevent issues in the future when firmware / kexec leaves the controller
> in an unknown state. We add support for legacy interrupts for cards that
> lack MSI support (which is partially broken currently). We then add the
> device tree nodes to enable PCIe on the Quartz64 Model A.
> 
> [...]

Applied to pci/dwc, thanks!

[1/5] dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
      https://git.kernel.org/lpieralisi/pci/c/931262e646
[2/5] PCI: rockchip-dwc: Reset core at driver probe
      https://git.kernel.org/lpieralisi/pci/c/431e7d2eec
[3/5] PCI: rockchip-dwc: Add legacy interrupt support
      https://git.kernel.org/lpieralisi/pci/c/e8aae154df

Thanks,
Lorenzo
