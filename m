Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7C65F849
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 01:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjAFArw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 19:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjAFArv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 19:47:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724A34D75;
        Thu,  5 Jan 2023 16:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78C5BB81C10;
        Fri,  6 Jan 2023 00:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF47C433D2;
        Fri,  6 Jan 2023 00:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672966067;
        bh=P+2+AzC0kgcf8Ejnbx73emGFErhkWbRZB+Khgy7JIKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tvvXHAydJg9BSxixZ+YUVG/7U9WaGQIAj4TRdAxz9fRiu/WqVrhvwkaGBLCTi1mBr
         reRIsUkt0Aik9EzSRq5IdyPQe5IIVjY9QrZrJO91fEFQF0T/8eHKn0VI8PoUdFQVhx
         IjfE5pSNFgXAI/56rCtUX9N1Vso4y1ozwvUlOyE/X4suPezNnPH5nCZ3MZY64U5K9+
         aPlwXfDnBnBNxDcpzp2cAW8IOt7omFYaO2aSuxg90oDJB4ZNkHh4CdRQrQk9ejfXGn
         Roe58xKBQ9ryt1JbDQFHuAiIobRjId6oxL0qGl4W1BK2tBSBVDELpokcLnfKNjnfMK
         kp0ZVlcyVCXcg==
Date:   Thu, 5 Jan 2023 18:47:44 -0600
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
        "Sun, Yunying" <yunying.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230106004744.GA1186792@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D724817B96F3B5EBA714FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 06, 2023 at 12:22:09AM +0000, Luck, Tony wrote:
> > ...and Dave, who reported that CXL enumeration was busted in -rc2, says
> > this patch fixes that. So you can also add:
> >
> > Tested-by: Dave Jiang <dave.jiang@intel.com>
> 
> Also seems good for my Broadwell/EDAC system.
> 
> Boot messages mentioning MMCONFIG are:
> 
> $ dmesg | grep MMCONFIG
> PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> PCI: not using MMCONFIG
> PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in ACPI motherboard resources or EFI

This part looks ok.

> PCI: MMCONFIG for 0000 [bus00-7f] at [mem 0x80000000-0x87ffffff] (base 0x80000000) (size reduced!)
> acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> acpi PNP0A08:02: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> acpi PNP0A08:03: fail to add MMCONFIG information, can't access extended configuration space under this bridge

But the rest of this still looks like a regression.  From your
previous dmesg log:

  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
  PNP0A03:00: host bridge to domain 0000 [bus ff]
  PNP0A03:01: host bridge to domain 0000 [bus bf]
  PNP0A03:02: host bridge to domain 0000 [bus 7f]
  PNP0A03:03: host bridge to domain 0000 [bus 3f]
  PNP0A08:00: host bridge to domain 0000 [bus 00-3e]
  PNP0A08:01: host bridge to domain 0000 [bus 40-7e]
  PNP0A08:02: host bridge to domain 0000 [bus 80-be]
  PNP0A08:03: host bridge to domain 0000 [bus c0-fe]

That MMCONFIG space should cover all those buses, but something is
going wrong.

I'll look at this more tomorrow.

Bjorn
