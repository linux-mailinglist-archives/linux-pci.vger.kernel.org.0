Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCCB633692
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 09:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKVIFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 03:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKVIFB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 03:05:01 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429621E12;
        Tue, 22 Nov 2022 00:04:59 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4F23D28011610;
        Tue, 22 Nov 2022 09:04:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 40428196CA; Tue, 22 Nov 2022 09:04:55 +0100 (CET)
Date:   Tue, 22 Nov 2022 09:04:55 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] PCI: hotplug: Add checks to avoid doing hotplug
 on PCIe Upstream Ports
Message-ID: <20221122080455.GA27182@wunner.de>
References: <5623410.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5623410.DvuYhMxLoT@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 07:13:15PM +0100, Rafael J. Wysocki wrote:
> PCIe Upstream Ports are not hotplug-capable by definition, but it turns out
> that in some cases, if the system is configured in a particularly interesting
> way, the kernel may be made attempt to operate an Upstream Port as a hotplug
> one which causes functional issues to appear.
> 
> The following 2 patches amend the code to prevent this behavior from occurring.

Both patches LGTM.

The spec reference for this change is PCIe r6.0.1 sec 7.5.3.2:

The Slot Implemented bit in the PCI Express Capabilities register
is only valid for Downstream Ports and undefined on Upstream Ports.

The Slot Capabilities / Control / Status registers are only operable
if the Slot Implemented bit is valid and set.  PCIe hotplug depends
on those registers.

(pcie_capability_reg_implemented() in drivers/pci/access.c returns false
for the Slot Capabilities / Control / Status registers unless the port
is a Root or Downstream Port.  Reads of those registers thus always
return 0.)

(Root Ports are Downstream Ports per the definition of "Downstream"
on page 94 of the PCIe r6.0.1 Base Spec.)

Thanks,

Lukas
