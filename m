Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660965F548
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjAEUiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 15:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjAEUiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 15:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E067188;
        Thu,  5 Jan 2023 12:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 702B4B81BED;
        Thu,  5 Jan 2023 20:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D9FC433EF;
        Thu,  5 Jan 2023 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672951080;
        bh=L5VxgkUFER6QkVdf/LMsoHqeGZ5Ba0RcSnthq2tx6CQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ORD3e0Bi8yckVReN6lLmnQ4hy5V+8v1MVINtmnasuxgRRbE8ZzPHb8RPkbMPaOyDz
         6FW5L9CH6Q9dY7J8JBHgTYa3ImaTtGI1CD2fjhWVJgA/95Ol3FTRg0BSXhRj8PWqhu
         vYmAePfK98Bj5bNT/22yOjMlHg9sKS+RjIkP356VK+R0+hFI6tor1A/pIXgDggXgcz
         lLm9ON/r9gBM8YJjXrZh2GihTEKDGynOn8M2Fc9FwDoOYzB3TdvIR3DBBd+hSvGSG1
         Ebrz3IL/Jvf2eAXshBuhDtxRQUA+P+K7M/byGIrz5CrujBQCeusgxXblV6A5d8VR4a
         zT15AV2D3Lx6g==
Date:   Thu, 5 Jan 2023 14:37:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
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
Message-ID: <20230105203757.GA1166631@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608347C8A95717A8BEE3BF2DFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 07:58:47PM +0000, Luck, Tony wrote:
> > Definitely an ambiguity / conflict, but not sure it is a bug when you
> > look at from the perspective of how would an EFI runtime service use
> > ECAM/MMCONFIG space? 
> >
> > Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> > Memory Type Usage after ExitBootServices()"?
> >
> > s/This memory is not used by the OS./This memory is not used by the OS,
> > unless ACPI declares it for another purpose./
> 
> In the case of the EDAC driver there isn't any ACPI declaration.  It just does
> pci_get_device() to find the devices it needs to use with a lookup based on
> vendor-id and device-id.

The EDAC driver wouldn't have any ACPI stuff in it; it's just that
Linux is looking for ACPI info about the ECAM area.

I think the problem here is that the ECAM/MMCONFIG code checks to make
sure the ECAM space is reserved somewhere.  If it doesn't find a
reservation either in E820 [1] or by PNP0C01/PNP0C02 _CRS methods [2],
it decides it's not safe to use ECAM, which means we may only have the
old accessors that can only reach 256 bytes of config space.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/pci/mmconfig-shared.c?id=v6.1#n447
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/pci/mmconfig-shared.c?id=v6.1#n428
