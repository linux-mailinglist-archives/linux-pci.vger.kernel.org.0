Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43B4AC81B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiBGSBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbiBGR5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 12:57:07 -0500
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 09:57:04 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2903C0401EC;
        Mon,  7 Feb 2022 09:57:04 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D94412800985A;
        Mon,  7 Feb 2022 18:47:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BA79D28774D; Mon,  7 Feb 2022 18:47:03 +0100 (CET)
Date:   Mon, 7 Feb 2022 18:47:03 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Message-ID: <20220207174703.GA25761@wunner.de>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
 <YgC/NQFN7yOffKv3@lahna>
 <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YgE+g9JOJE6foThi@lahna>
 <BL1PR12MB51442184B407A747E4C487F1F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51442184B407A747E4C487F1F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 03:52:13PM +0000, Deucher, Alexander wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > The other option is to look for ACPI companion (ACPI_COMPANION()) of the
> > device. AFAICT dGPUs don't have one (as the BIOS does not know in advance
> > what will be connected to the hotplug ports) whereas internal does typically
> > have one.
> 
> Yeah, this is probably the right way to do this.

No, that doesn't work.  At least Apple represents the first few devices
in the Thunderbolt daisy-chain in the ACPI namespace, so IIUC you'd find
an ACPI companion for those but not for the remainder of the daisy-chain.
This is from a 2019/2020 MacBookPro16,1:

$ grep 'Device ' acpidump/mbp161/ssdt6.dsl
            Device (UPSB)
                Device (DSB0)
                    Device (NHI0)
                Device (DSB1)
                    Device (UPS0)
                        Device (DSB0)
                            Device (DEV0)
                        Device (DSB3)
                            Device (UPS0)
                                Device (DSB0)
                                    Device (DEV0)
                                Device (DSB3)
                                    Device (DEV0)
            ...

There's a *reason* why I introduced the is_thunderbolt flag,
there is no other reliable way to detect externally attached devices.

Thanks,

Lukas
