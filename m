Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60B5250B5
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbiELOzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346172AbiELOzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:55:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DC22253A9F
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:55:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BB2106F;
        Thu, 12 May 2022 07:55:15 -0700 (PDT)
Received: from e123427-lin.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901B13F73D;
        Thu, 12 May 2022 07:55:14 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/2] PCI: vmd: IRQ domain assignment to sub devices
Date:   Thu, 12 May 2022 15:55:05 +0100
Message-Id: <165236729142.991.15360403180568817088.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
References: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
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

On Wed, 11 May 2022 02:57:05 -0700, Nirmal Patel wrote:
> Host OS fails to boot and DMAR errors were observed when interrupt
> remapping is enabled by intel_iommu because of the fact that VMD child
> devices are on different IRQ domain than all other PCI devices.
> Make sure VMD assigns proper IRQ domain to the child devices during
> device enumeration.
> 
> Nirmal Patel (2):
>   PCI: vmd: Assign VMD IRQ domain before enumeration
>   PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X
>     remapping if interrupt remapping is enabled by IOMMU.")
> 
> [...]

Applied to pci/vmd, thanks!

[1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
      https://git.kernel.org/lpieralisi/pci/c/886e67100b
[2/2] PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
      https://git.kernel.org/lpieralisi/pci/c/c94f732e80

Thanks,
Lorenzo
