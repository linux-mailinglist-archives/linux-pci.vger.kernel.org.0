Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393DD7A0DD8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjINTKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjINTKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 15:10:08 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C41FD7
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 12:10:03 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9DD80100DE9D8;
        Thu, 14 Sep 2023 21:09:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 68CF24C6AB5; Thu, 14 Sep 2023 21:09:59 +0200 (CEST)
Date:   Thu, 14 Sep 2023 21:09:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230914190959.GB15568@wunner.de>
References: <20230914145332.GA5261@wunner.de>
 <20230914153303.GA30424@bhelgaas>
 <20230914190429.GA15568@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914190429.GA15568@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 09:04:29PM +0200, Lukas Wunner wrote:
> On Thu, Sep 14, 2023 at 10:33:03AM -0500, Bjorn Helgaas wrote:
> > dev->no_d3cold appears to be mainly an administrative policy knob
> > twidded via sysfs.
> 
> Actually the user space choice to disable D3cold is stored in a
> different flag called pdev->d3cold_allowed.
> 
> The fact that d3cold_allowed_store() indirectly modifies the
> no_d3cold flag as well looks like a bug that went unnoticed
> for a couple of years.  From a quick look, d3cold_allowed_store()
> should probably call pci_bridge_d3_update() instead of
> pci_d3cold_enable() / pci_d3cold_disable().  This was introduced by
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").
> Perhaps Mika can chime in whether this is indeed wrong.

Note that pci_dev_check_d3cold() checks both the no_d3cold flag
(which tells whether the *driver* disabled D3cold) and the d3cold_allowed
flag (which tells whether *user space* disabled D3cold).

Basically right now we allow user space to override the driver setting,
which feels unsafe.  (Does user space always know better than the driver
whether D3cold can safely be entered?  I don't think so.)

Thanks,

Lukas
