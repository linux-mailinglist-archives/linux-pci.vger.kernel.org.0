Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBC4C7D1A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 23:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiB1WO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiB1WO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 17:14:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE6C5586;
        Mon, 28 Feb 2022 14:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45884B8167C;
        Mon, 28 Feb 2022 22:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC48C340F1;
        Mon, 28 Feb 2022 22:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646086425;
        bh=cnDWJ0mUKsMIK/kUZBxrtwaDai/t/1pEAH68lPV8FNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g3J98SrFRq1BbJxPN1kJdH/0NbFXhkBE307szRWU7LmrbHX2s2cJ5zQ3v4x9DqVul
         W+UT8Tz7QZYUmLyHrBFi8AlchvPhAIsNb5N/t/1Vum4HNk2hB+M5oV3EPkQCL/YldK
         Yl1lpm9CV0w78mMuBs7wpXWCPyDYS8tFO9ylRSiAoaVrZIBgYz/Fvgxz8o2bG2gMGk
         SFSk5Az0KRyVF0mxmQZLvhhhRajROlVvK/8fDFVWhMxRoD8TO07Q8LkJUySVWRD90T
         lrt8hJFlJ3TW01ylg3BJslwJE+g9BnROM4YsHrUpbHVmWmLR9oT1VQBPyACxUK62w6
         +ISVACI6FIWZA==
Date:   Mon, 28 Feb 2022 16:13:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <20220228221344.GA529289@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157004F38E3FEFF046D9BE4E2019@BL1PR12MB5157.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 03:33:13PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> > 
> > On Fri, Feb 25, 2022 at 11:42:24AM -0600, Bjorn Helgaas wrote:
> > > That would just leave the "PCI_VSEC_ID_INTEL_TBT implies external-
> > facing"
> > > assumption above.  Not having a Thunderbolt spec, I have no idea how
> > > you deal with that.
> > 
> > You can download the spec here:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > w.usb.org%2Fsites%2Fdefault%2Ffiles%2FUSB4%2520Specification%2520202
> > 11116.zip&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Ca26e64
> > 7a4acf4e7681d308d9faa358fd%7C3dd8961fe4884e608e11a82d994e183d%7C0
> > %7C0%7C637816402472428689%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> > 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > amp;sdata=HSDqx%2BHzSnczTZxaBij8sgqvJSS8ajtjCzZd2CPSbR4%3D&amp;re
> > served=0
> > 
> > Inside the archive there is also the DVSEC spec with name "USB4 DVSEC
> > Version 1.0.pdf".
> 
> The spec has Host_Router_indication (bits 18-19) as meaning external facing.
> I'll respin the patch 3 for using that.

Thanks, please include the spec citation when you do.  And probably
the URL, because it's not at all obvious how the casual reader would
get from "is_thunderbolt" to a recent add-on to the USB4 spec.

Bjorn
