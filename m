Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3C4BFE2E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiBVQMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiBVQMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:12:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698D125CB0;
        Tue, 22 Feb 2022 08:11:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36379B81B5B;
        Tue, 22 Feb 2022 16:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C8EC340E8;
        Tue, 22 Feb 2022 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645546306;
        bh=tPHcG2vdwAjVfMszEDtyGTUBaKWeavojfMTme0Rscn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ3Xz8WjUlhH9p01XoZLlCwUI55NY9NHNCqbu3P08LPqNsjkwVFYIngPrRsOxVSbT
         axJ3j1jiC0CzyIKHFXr4c0pdGR7C02LiDYOc9ibdhdkduhjINAuC1XIMcUCKr6WgDD
         lkzXFYkfhh4s26mG/6UOVF2OQ689nb+pjhZyqvYSvk/5KKAUgI7wOLcgPR/YpYUDwm
         xh6vALYshMH62HIK/q8uMvvm5j/5FlGnLNq3x+G+i+kxUDh97n8tRsv/Dmnmodx1Y2
         xit9VtH9DJPW9cHsbxaKx0vLNh/oqYKB91Hwn4X7jnbwA1INQdUJVn94jChpQv/qs2
         0qspFaRoN5hgA==
Received: by pali.im (Postfix)
        id 5B817FDB; Tue, 22 Feb 2022 17:11:43 +0100 (CET)
Date:   Tue, 22 Feb 2022 17:11:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
Message-ID: <20220222161143.6ryghgtfmhnmhpmz@pali>
References: <20220222155030.988-1-pali@kernel.org>
 <164554589988.5595.5091384618177225445.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164554589988.5595.5091384618177225445.b4-ty@arm.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
> On Tue, 22 Feb 2022 16:50:18 +0100, Pali Rohár wrote:
> > This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
> > Vendor ID capability and PCIe extended capabilities. And then implement
> > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
> > registers, support for legacy INTx interrupts, configuration for X1/X4
> > mode and usage of new PCI child_ops API.
> > 
> > Changes in v4:
> > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
> > 
> > [...]
> 
> I can't apply dts changes, patch 12 should go via the arm-soc tree.

Gregory already wrote about this dts change:
https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
"So the easier is to let merge it through the PCI subsystem with the
other patches from this series."

Are there any issues with applying this dts change via pci tree?

> Applied the others to pci/mvebu, thanks.
> 
> [01/12] PCI: pci-bridge-emul: Re-arrange register tests
>         https://git.kernel.org/lpieralisi/pci/c/c453bf6f9b
> [02/12] PCI: pci-bridge-emul: Add support for PCIe extended capabilities
>         https://git.kernel.org/lpieralisi/pci/c/c0bd419732
> [03/12] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
>         https://git.kernel.org/lpieralisi/pci/c/3767a90242
> [04/12] dt-bindings: PCI: mvebu: Add num-lanes property
>         https://git.kernel.org/lpieralisi/pci/c/26b982ca83
> [05/12] PCI: mvebu: Correctly configure x1/x4 mode
>         https://git.kernel.org/lpieralisi/pci/c/2a81dd9fd9
> [06/12] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
>         https://git.kernel.org/lpieralisi/pci/c/e3e13c9135
> [07/12] PCI: mvebu: Add support for Advanced Error Reporting registers on emulated bridge
>         https://git.kernel.org/lpieralisi/pci/c/2b6ee04c0a
> [08/12] PCI: mvebu: Use child_ops API
>         https://git.kernel.org/lpieralisi/pci/c/c099c2a761
> [09/12] dt-bindings: PCI: mvebu: Update information about intx interrupts
>         https://git.kernel.org/lpieralisi/pci/c/0124989220
> [10/12] PCI: mvebu: Fix macro names and comments about legacy interrupts
>         https://git.kernel.org/lpieralisi/pci/c/d00ea94e62
> [11/12] PCI: mvebu: Implement support for legacy INTx interrupts
>         https://git.kernel.org/lpieralisi/pci/c/ec07526264
> 
> Thanks,
> Lorenzo
