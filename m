Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571946959F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbhLFM2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 07:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhLFM2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 07:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F1EC061746;
        Mon,  6 Dec 2021 04:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2A361260;
        Mon,  6 Dec 2021 12:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F037C341C2;
        Mon,  6 Dec 2021 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638793494;
        bh=uyixaSob4Wksy6mAI4HQO4bfeCI5HAdK8TB5r7VhL+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9Q0kAy0bcvE/fn2YaFSAu5uHyhcGXIWuiUUkia/tXj/dO6wDA/1KVW8bIZFCXQ3G
         qbmDF+DT4IIBm0XSupRoTPzRBWSFbhR0FeSrpzLVGwTxhWM9xwEYY/iXqisfsyrUr+
         y/KBihlDQYi6COhB7/oZWc6yZXLXj+1PnsRCkkFqUuHQsGuycaVniqi4lgFlF0SvOO
         eNGVaScg5A0VrL1Hu+BjBq156Y8g2Og3Y6qTwhtA1Tcvty/eGoeVq4CND1GWO4uKZJ
         KlRmKg82sYv/H6OC3Eu4I/syWDSnZEl5HFXq3wCQNRs/p0qsuaYO+QARxXthmD7xng
         00pK6bIOEaE8w==
Received: by pali.im (Postfix)
        id 80E72F63; Mon,  6 Dec 2021 13:24:51 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:24:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Message-ID: <20211206122451.v4pci63ox3hntsw6@pali>
References: <20211124155944.1290-1-pali@kernel.org>
 <163879317819.3988.9390653012838076482.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163879317819.3988.9390653012838076482.b4-ty@arm.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 06 December 2021 12:19:57 Lorenzo Pieralisi wrote:
> On Wed, 24 Nov 2021 16:59:38 +0100, Pali Rohár wrote:
> > This patch series contains various fixes for pci-bridge-emul code.
> > This code is used only by pci-aardvark.c and pci-mvebu.c drivers.
> > 
> > Pali Rohár (6):
> >   PCI: pci-bridge-emul: Make expansion ROM Base Address register
> >     read-only
> >   PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
> >     space
> >   PCI: pci-bridge-emul: Add definitions for missing capabilities
> >     registers
> >   PCI: pci-bridge-emul: Fix definitions of reserved bits
> >   PCI: pci-bridge-emul: Correctly set PCIe capabilities
> >   PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
> > 
> > [...]
> 
> Applied to pci/bridge-emul, thanks!
> 
> [1/6] PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only
>       https://git.kernel.org/lpieralisi/pci/c/1c1a3b4d3e
> [2/6] PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space
>       https://git.kernel.org/lpieralisi/pci/c/7b067ac63a
> [3/6] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
>       https://git.kernel.org/lpieralisi/pci/c/faa3e547f4

Hello Lorenzo! This patch "PCI: pci-bridge-emul: Add definitions for
missing capabilities registers" is now in your two different branches:
pci/bridge-emul and pci/aardvark. Not sure if you want to have this same
patch on two places... So please check.

> [4/6] PCI: pci-bridge-emul: Fix definitions of reserved bits
>       https://git.kernel.org/lpieralisi/pci/c/a3ab28a2e3
> [5/6] PCI: pci-bridge-emul: Correctly set PCIe capabilities
>       https://git.kernel.org/lpieralisi/pci/c/0f7ba81700
> [6/6] PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
>       https://git.kernel.org/lpieralisi/pci/c/32051099e8
> 
> Thanks,
> Lorenzo
