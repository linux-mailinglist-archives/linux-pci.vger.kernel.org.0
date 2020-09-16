Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473726BBF6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 07:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPFsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 01:48:23 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:44017 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 01:48:23 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BFF4828004EDC;
        Wed, 16 Sep 2020 07:48:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 875701FBF; Wed, 16 Sep 2020 07:48:20 +0200 (CEST)
Date:   Wed, 16 Sep 2020 07:48:20 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] pcie hotplug doesn't work with kernel 4.19
Message-ID: <20200916054820.GA853@wunner.de>
References: <CAMGffEmrP21e_sgE8C49och1QEABTK4Fh8aVgH8qsyT9t8EJ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmrP21e_sgE8C49och1QEABTK4Fh8aVgH8qsyT9t8EJ4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 04:15:15PM +0200, Jinpu Wang wrote:
> We are testing PCIe nvme SSD hotplug, it works out of box with kernel 5.4.62,
> dmesg during the hotplug:
[...]
> But with kernel 4.19.133, pcieport core doesn't print anything, is
> there known problem with kernel 4.19 support for pcie hotplug, do we
> need to backport some fixes from newer kernel to make it work?

No known problem.  Please open a bug on bugzilla.kernel.org and attach
full dmesg output for 5.4.62 and 4.19.133, as well as lspci -vv output.
You may want to add the following to the kernel command line:

ignore_loglevel log_bug_len=10M "dyndbg=file drivers/pci/* +p"
pciehp.pciehp_debug=1


> [  683.218554] pcieport 0000:16:00.0: pciehp: Slot(0-3): Card present
> [  683.218555] pcieport 0000:16:00.0: pciehp: Slot(0-3): Link Up
> [  683.271702] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> command 0x17e1 (issued 73280 msec ago)
> [  686.301874] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> command 0x13e1 (issued 3030 msec ago)
> [  686.361894] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
> command 0x13e1 (issued 3090 msec ago)

Those timeouts look suspicious.  Perhaps the hotplug controller
claims to support Command Completed Support, but in reality does not?


> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> CONFIG_HOTPLUG_PCI_CPCI=y
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
> CONFIG_HOTPLUG_PCI_SHPC=y
> CONFIG_HOTPLUG_PCI_PCIE=y

You may not need ACPI_IBM, CPCI, SHPC.

Thanks,

Lukas
