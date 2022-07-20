Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA057BFE8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 00:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGTWIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 18:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC642AC1;
        Wed, 20 Jul 2022 15:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66195B8220F;
        Wed, 20 Jul 2022 22:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0374C341C7;
        Wed, 20 Jul 2022 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658354921;
        bh=6NPJbp8qd++ZJMzUvD/xwkV8ieUhuhN8noME2rFU4ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vImESz6H+FmCQBQFGg6RwGB1qUexGM88QKZgQo2j6EKPY9DUkTE6WFlJPsdKOsCWi
         tQgqkpnO/efA4PMFoBcERZacJUh+sxI/8da7uS/J3ZLjQBaH14ge3TBLfQ84Quu8N2
         Qa53LZ9RqK3fgLnWTzhKfjknNgTBxaZrDNSO/+m9rFQMvTj8DyA7FFqpKQIBhfOzlq
         1I3rb8cNi9M3B7g3A8kyb+fnHdVoocE9k42ZA9u6WalZammMd5HRfK/qiJu7Ei2KB0
         uxQfIc4IfRU2n7z27cZgp3L70A5knqsvG9bc0ifZ8OxsFfZY9lVJ/0gXMNTPo92m+d
         k4LfG3JnkObvg==
Date:   Wed, 20 Jul 2022 17:08:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] PCI: brcmstb: Add "refusal mode" to preclude
 PCIe-induced CPU aborts
Message-ID: <20220720220840.GA1663326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716222454.29914-4-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 06:24:50PM -0400, Jim Quinlan wrote:
> Our PCIe RC HW has an atypical behavior: if it does not have PCIe link
> established between itself and downstream, any subsequent config space
> access causes a CPU abort.  This commit sets a "refusal mode" if the PCIe
> link-up fails, and this has our pci_ops map_bus function returning a NULL
> address, which in turn precludes the access from happening.

> @@ -687,6 +688,19 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,

Oh, and I forgot to mention that brcmstb is one of the few drivers
that doesn't name these functions ".*_map_bus()".  It's helpful when
they all match a simple grep pattern.  Maybe a patch at the end could
fix this.
