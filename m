Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4997265F3AF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 19:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjAES3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 13:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjAES3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 13:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429E564DC;
        Thu,  5 Jan 2023 10:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D4361BD1;
        Thu,  5 Jan 2023 18:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBBCC433EF;
        Thu,  5 Jan 2023 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672943392;
        bh=iHaiS0GM2MGSXZ+IjKPLHBtGHmeOC5SlrukdUXCOrQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bnoWIP/vPhtNJvTZctVf/Jup3ayusP8RlZZ3dRmqzKU/OBPf9pChxfMr9wF6qrwX5
         ddZ7YQjRS+/9y3oHZ6wuJY51WeTjArJ49sP+hwIL5UtvlOpeZQkPE/vzTuYL/mDcRB
         niERtYU7lSU1o7g6TsxNA13B6V5Q73SFNJs3gNf+qSkECyf8qO/7sVlVPpiuau7haQ
         Ukc8Kk40QZyQgRw/bAZbjdZ6Tvd828talbNp847Ce2SRAQrgLNMC1MqT+Qm+CYNnaJ
         haZarSCy5BT7j7Ycnt/KBr3PjJhWJtlL57pFUeaj7qe2kzwh6Duyp0fOZiMFbK/IoP
         CrBsJr501lHCw==
Date:   Thu, 5 Jan 2023 12:29:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105182950.GA1158496@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083C504335B2DE1B31C440CFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 06:04:52PM +0000, Luck, Tony wrote:
> > Hi Tony, can you share a dmesg log?  Does it look like the same thing
> > Kan reported, where the ECAM space is reported only via an
> > EfiMemoryMappedIO region and is not otherwise reserved by firmware?
> 
> Attached are serial logs. "broken" is the one from v6.2-rc2, "revert" is the
> one with your commit reverted.
> 
> I don't see the string "ECAM" in either of them.

Yeah, "ECAM" is what the PCIe spec calls it, but Linux logging uses
"MMCONFIG".  Probably should change that.

Anyway, your dmesg log shows the same problem:

  DMI: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
  efi: Remove mem48: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
  [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
  PCI: not using MMCONFIG
  acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge

Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
firmware/kernel interface is as an EfiMemoryMappedIO region.

I think this is a firmware bug, but obviously we're going to have to
figure out a way around it.

Bjorn
