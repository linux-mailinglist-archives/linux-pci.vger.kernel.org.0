Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8693F4C7D6C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiB1Wdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 17:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiB1Wdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 17:33:32 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19C106CA6;
        Mon, 28 Feb 2022 14:32:50 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9468D100D9417;
        Mon, 28 Feb 2022 23:32:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 72198110CA; Mon, 28 Feb 2022 23:32:46 +0100 (CET)
Date:   Mon, 28 Feb 2022 23:32:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <20220228223246.GA11428@wunner.de>
References: <BL1PR12MB5157004F38E3FEFF046D9BE4E2019@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220228221344.GA529289@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228221344.GA529289@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 04:13:44PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 28, 2022 at 03:33:13PM +0000, Limonciello, Mario wrote:
> > > On Fri, Feb 25, 2022 at 11:42:24AM -0600, Bjorn Helgaas wrote:
> > > > That would just leave the "PCI_VSEC_ID_INTEL_TBT implies external-
> > > facing"
> > > > assumption above.  Not having a Thunderbolt spec, I have no idea how
> > > > you deal with that.
> > > 
> > > You can download the spec here:
[...]
> > > Inside the archive there is also the DVSEC spec with name "USB4 DVSEC
> > > Version 1.0.pdf".
> > 
> > The spec has Host_Router_indication (bits 18-19) as meaning external facing.
> > I'll respin the patch 3 for using that.
> 
> Thanks, please include the spec citation when you do.  And probably
> the URL, because it's not at all obvious how the casual reader would
> get from "is_thunderbolt" to a recent add-on to the USB4 spec.

PCI_VSEC_ID_INTEL_TBT is not mentioned at all in the USB4 spec,
hence there's no connection between "is_thunderbolt" and the USB4 spec.

It's a proprietary VSEC used by Intel and the only way to recognize
pre-USB4 Thunderbolt devices that I know of.  Its ID is also
different from the DVSEC IDs given in the above-mentioned spec.

Thanks,

Lukas
