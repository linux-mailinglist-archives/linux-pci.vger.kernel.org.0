Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555077E7465
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 23:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjKIWbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 17:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjKIWbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 17:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21303C01;
        Thu,  9 Nov 2023 14:31:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E5DC433C7;
        Thu,  9 Nov 2023 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699569103;
        bh=eQIy8OzgMGafbmuvUdri4QU/WFfrf6FPeSAilMINH0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q8glFZzn6SgDHtlfhq4O6xZ0G/5GX0BOJrQpDVDffzybJ4BrRMTKYRlIJsMj5xwjT
         CvRd9e3A1krvDsPehYjyPzdoMlNcNaOvmHJrDn3zeV2vSqcRjlBw46e4uHr9G27k50
         0Wy8oWhT3vJ36hdmPRGhX8hDqP6Ez/vWN4x4AApNY5EpVbkY1XFRzeCwZcgQn67h42
         pMd+egpzqoAiIIq3Xn9qtCmG4Jj9kg+PqxzeN8jVgqj5mZS/QxFD7SRp2MvQHJ9Dzk
         /YqFRx9R5hstLYKjdc8rH6ItctwdvVWY6jaJBPDYy55IpPR4C/GiENrQ9OLW+lZ6sC
         3TsCS4An9a0YQ==
Date:   Thu, 9 Nov 2023 16:31:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20231109223140.GA494906@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNxKavvTthcpWeMTu5FfeqZhvMbALK1WwdRqQhivHJFWTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 09, 2023 at 05:06:15PM -0500, Jim Quinlan wrote:
> ...

> BTW, besides the RPi4, I haven't been able to find a Linux platform
> where I can do
> 
>         echo $POLICY > /sys/module/pcie_aspm/parameters/policy

This sounds like something we should fix.  What exactly happens?  I
think this should be handled at pcie_aspm_set_policy(), so:

  /sys/module/pcie_aspm/parameters/policy doesn't exist (seems
  unlikely)?

  Returns -EPERM (would indicate aspm_disabled)?

  Returns -EINVAL (would indicate $POLICY doesn't match anything in
  policy_str[])?

  Returns 0 with no action (would indicate $POLICY is the same as the
  current aspm_policy)?

> It seems that the FW/ACPI typically locks this down.  I did see a
> comment somewhere that
> said that the reason it was locked down is because too many devices
> cannot handle it.

Do you have any details about FW/ACPI locking this down?
aspm_disabled is set by the kernel "pcie_aspm=off" parameter (I assume
you're not referring to this), if the FADT has ACPI_FADT_NO_ASPM set,
or if a host bridge's _OSC is missing or failed (maybe [1] is the
comment you saw?)

These all *should* be unusual cases, so I'd be surprised if you're
tripping over one of these.  I would NOT be surprised if we had some
issue in pcie_config_aspm_link() or pcie_set_clkpm() that meant the
policy change didn't work as intended, though.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pci_root.c?id=v6.6#n617
  
