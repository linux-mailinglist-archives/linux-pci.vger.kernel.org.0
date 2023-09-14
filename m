Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BA7A070C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjINORO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbjINORN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 10:17:13 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277E110
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 07:17:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EE0382800BC11;
        Thu, 14 Sep 2023 16:17:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E051950E35C; Thu, 14 Sep 2023 16:17:05 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:17:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230914141705.GA27051@wunner.de>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
 <20230913042522.GB1359@wunner.de>
 <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
 <20230913143128.GA29059@wunner.de>
 <76dfea89-e386-45e9-851c-8e87f9470c4f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76dfea89-e386-45e9-851c-8e87f9470c4f@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 11:36:49AM -0500, Mario Limonciello wrote:
> On 9/13/2023 09:31, Lukas Wunner wrote:
> > If this only affects system sleep, not runtime PM, what you can do is
> > define a DECLARE_PCI_FIXUP_SUSPEND_LATE() which calls pci_d3cold_disable()
> > and also define a DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY() which calls
> > pci_d3cold_enable().
> > 
> > And I think you can make those calls conditional on pm_suspend_no_platform()
> > to constrain to s2idle.
> > 
> > User space should still be able to influence runtime PM via the
> > d3cold_allowed flag (unless I'm missing something).
> 
> The part you're missing is that D3hot is affected by this issue too,
> otherwise it would be a good proposal.

I recall that in an earlier version of the patch, you solved the issue
by amending pci_bridge_d3_possible().

Changing the dev->no_d3cold flag indirectly influences the bridge_d3
flag (through pci_dev_check_d3cold() and pci_bridge_d3_update()).

If dev->no_d3cold is set on a device below a port, that port is
prevented from entring D3hot because it would result in the
device effectively being in D3cold.

So you might want to take a closer look at this approach despite
the flag suggesting that it only influences D3cold.

Thanks,

Lukas
