Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10079EB25
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbjIMObf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbjIMObf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 10:31:35 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA191;
        Wed, 13 Sep 2023 07:31:30 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BEB8C2800C99A;
        Wed, 13 Sep 2023 16:31:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A3BCD902E; Wed, 13 Sep 2023 16:31:28 +0200 (CEST)
Date:   Wed, 13 Sep 2023 16:31:28 +0200
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
Message-ID: <20230913143128.GA29059@wunner.de>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
 <20230913042522.GB1359@wunner.de>
 <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 12, 2023 at 11:43:53PM -0500, Mario Limonciello wrote:
> On 9/12/2023 23:25, Lukas Wunner wrote:
> > There's already PCI_DEV_FLAGS_NO_D3, would it be possible to just
> > reuse that instead of adding another codepath for D3 quirks?
> > 
> 
> The root port can handle D3 (including wakeup) at runtime fine.
> Issue occurs only during s2idle w/ hardware sleep.

I see.

If this only affects system sleep, not runtime PM, what you can do is
define a DECLARE_PCI_FIXUP_SUSPEND_LATE() which calls pci_d3cold_disable()
and also define a DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY() which calls
pci_d3cold_enable().

And I think you can make those calls conditional on pm_suspend_no_platform()
to constrain to s2idle.

User space should still be able to influence runtime PM via the
d3cold_allowed flag (unless I'm missing something).

Thanks,

Lukas
