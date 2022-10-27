Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5360F3F5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiJ0Jq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ0Jq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 05:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEA3B96E;
        Thu, 27 Oct 2022 02:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C58B8254D;
        Thu, 27 Oct 2022 09:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA8C433C1;
        Thu, 27 Oct 2022 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666864014;
        bh=+7SX1LnPKN1/wXvR/tBK033ffob3mgOmCQxzgkbhrhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIG08dG6smedSfGOwOT1Psq4HOR3qY1iENZ0Lq1lngvm1zsOqcxKfJNltlS86Zkkt
         FsFtIwGUcM/5BC/LrAtSgq7MKuDZB3fFdD0Yo9/KFwGnq0bmr8S6Tw5im3O1tRdWeA
         ACtqwPTohfKvRYFuTTGwGULmIW+QnmTWCqccx7DER47XxOt73HmJIXfDL/Uv1o5C5n
         9WdsrUH0J5khbHzVDV5xzXnFtbE/ZuPj5SZNwB3kcnUDBB3DtID/U4Ak7umvx1eI1u
         OpkKTK4lDhhxaAWULdn+lgRtX1CVOSE9E5HurRGfaedkPIMhxl2BNl+dFjMlqpBRcu
         Vsk8i/XjmGNRQ==
Date:   Thu, 27 Oct 2022 11:46:47 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Message-ID: <Y1pTh5fiN+/mKPrR@lpieralisi>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
 <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 09:31:37AM +0200, Michal Simek wrote:
> Hi,
> 
> On 10/25/22 08:52, Thippeswamy Havalige wrote:
> > The current Xilinx AXI PCIe Host Bridge driver uses generic PCIe
> > subsystem framework. This driver works on both Microblaze and Zynq
> > architecture based platforms.
> > 
> > The microblaze architecture specific code has unused PCIe host bridge
> > supported API's which are no longer needed.
> > 
> > This series of patch removes unused architecture specific
> > microblaze PCIe code.
> > 
> > Thippeswamy Havalige (13):
> >    microblaze/PCI: Remove unused early_read_config_byte() et al
> >      declarations
> >    microblaze/PCI: Remove Null PCI config access unused functions
> >    microblaze/PCI: Remove unused PCI bus scan if configured as a host
> >    microblaze/PCI: Remove unused PCI legacy IO's access on a bus
> >    microblaze/PCI: Remove unused device tree parsing for a host bridge
> >      resources
> >    microblaze/PCI: Remove unused allocation & free of PCI host bridge
> >      structure
> >    microblaze/PCI: Remove unused PCI BIOS resource allocation
> >    microblaze/PCI: Remove unused PCI Indirect ops
> >    microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU
> >      address to I/O port
> >    microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al
> >      declaration
> >    microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
> >    microblaze/PCI: Remove support for Xilinx PCI host bridge
> >    microblaze/PCI: Moving PCI iounmap and dependent code
> > 
> >   arch/microblaze/Kconfig                  |    8 -
> >   arch/microblaze/include/asm/pci-bridge.h |   92 ---
> >   arch/microblaze/include/asm/pci.h        |   29 -
> >   arch/microblaze/pci/Makefile             |    3 +-
> >   arch/microblaze/pci/indirect_pci.c       |  158 -----
> >   arch/microblaze/pci/iomap.c              |   36 +
> >   arch/microblaze/pci/pci-common.c         | 1067 ------------------------------
> >   arch/microblaze/pci/xilinx_pci.c         |  170 -----
> >   8 files changed, 37 insertions(+), 1526 deletions(-)
> >   delete mode 100644 arch/microblaze/pci/indirect_pci.c
> >   delete mode 100644 arch/microblaze/pci/pci-common.c
> >   delete mode 100644 arch/microblaze/pci/xilinx_pci.c
> > 
> 
> Why are you sending it again?

Michal,

it looks like you don't need anything from me or Bjorn on this series so
I shall drop it from the PCI queue and let you handle it.

If you need any help please let me know.

Thanks,
Lorenzo
