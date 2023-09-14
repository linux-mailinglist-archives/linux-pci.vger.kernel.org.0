Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DC7A0DCB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbjINTEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjINTEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 15:04:35 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25C9B;
        Thu, 14 Sep 2023 12:04:30 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 874D630007934;
        Thu, 14 Sep 2023 21:04:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7B0C542AC06; Thu, 14 Sep 2023 21:04:29 +0200 (CEST)
Date:   Thu, 14 Sep 2023 21:04:29 +0200
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
Message-ID: <20230914190429.GA15568@wunner.de>
References: <20230914145332.GA5261@wunner.de>
 <20230914153303.GA30424@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914153303.GA30424@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 10:33:03AM -0500, Bjorn Helgaas wrote:
> dev->no_d3cold appears to be mainly an administrative policy knob
> twidded via sysfs.

Actually the user space choice to disable D3cold is stored in a
different flag called pdev->d3cold_allowed.

The fact that d3cold_allowed_store() indirectly modifies the
no_d3cold flag as well looks like a bug that went unnoticed
for a couple of years.  From a quick look, d3cold_allowed_store()
should probably call pci_bridge_d3_update() instead of
pci_d3cold_enable() / pci_d3cold_disable().  This was introduced by
commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").
Perhaps Mika can chime in whether this is indeed wrong.

Thanks,

Lukas
