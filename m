Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898FB7E1E14
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKFKPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 05:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKFKPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 05:15:41 -0500
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7C6112;
        Mon,  6 Nov 2023 02:15:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id C80842062D;
        Mon,  6 Nov 2023 11:15:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Osev43khplb; Mon,  6 Nov 2023 11:15:33 +0100 (CET)
Received: from nucnuc.mle (ppp-88-217-64-136.dynamic.mnet-online.de [88.217.64.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 3A22920267;
        Mon,  6 Nov 2023 11:15:33 +0100 (CET)
Date:   Mon, 6 Nov 2023 11:15:27 +0100
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: mach-socfpga: PCIe Root IO TLP support for Cyclone V
Message-ID: <ZUi8v0GL/urin/Yj@nucnuc.mle>
References: <ZUDd04c7FXUeusxK@nucnuc.mle>
 <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd407621b4a64cebaf8a847b3ff1ad2e@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On Sun, Nov 05, 2023 at 11:20:03AM +0000, David Laight wrote:
> It isn't an ARM root complex ...
> I didn't think any of the Cyclone V had embedded arm cpu.
> I know some of the more recent Altera FPGA do, by the Cyclone V
> is pretty old now - although we are still using them in new cards.
> (Only as PCIe endpoints though.)

You are right, the root complex itself is (likely) not an ARM design.
I should have said "... unlike many other Root Complexes used in similar ARM CPU based SoCs ...".
The Cyclone V SoC sub-family of FPGAs features a dual core Cortex A9.
The "Cyclone V SoC Development Kit" is a development kit that exposes a readily usable PCIe root slot.

> If you are building the FPGA image then all the logic to convert the
> memory mapped slave cycles (into the fpga logic) is supplied as
> verilog source.

The CPU subsystem and the PCIe IP are hard IP in silicon and can not be altered.
They are connected via the FPGA logic, though, and I agree one approach could be to intercept their communication with custom HDL.
However, Linux uses the exact same PCIe hard IP registers required for IO TLPs to send Config TLPs.
Every TLP requires multiple accesses to multiple registers, so locking between FPGA logic and Linux transactions would be required.
I'm not saying that this is impossible, but I don't think it can be robust without a Linux software change.
A software only solution has the benefit of being available to all users of such an FPGA, without access to that special logic.

> I thought that all recent endpoints were required [1] to work with
> just memory BARs - even going back to the later PCI versions.
> So I'm surprised a PCIe endpoint need an IO BAR.

The AX99100 implements a so called "Legacy Endpoint" and is thus allowed to rely on support for IO space.
I guess this choice was made to stay driver-compatible to the PCI version, although I don't know the ancestry if this product.

Best regards, David
