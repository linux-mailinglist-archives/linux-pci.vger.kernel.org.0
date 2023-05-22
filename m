Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE09770BC05
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjEVLkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjEVLkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 07:40:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407EE91;
        Mon, 22 May 2023 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755608; x=1716291608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYy6wtuHtFxdH0WIH16DIjdET2alDruGePrJjTDQdjk=;
  b=nI8ZNFwm3Dh5XESTX82g7iCP0w1Ipp0x+5AqogkZdvmQU/wcUlCi6rYD
   PjWVNdyCocWN7AlZRFTxGSaFOLeFQGRDnLq5X4boQAu/3kvS77aQqOhyC
   h67rGiMljYgz+LPbCu//bF421XwnoSDFE42NCfEhzbpTL6Dy/fqGLePQw
   0WGuNBruguEZraxMcb7x+XQmyI+Grk5aBXCF4ncUGI1L4wNXrHTddHLo7
   GXOpjnz37UW+uEik18RGXJKYx+BXLxYoC6FBUp/cfPLq8D32t+KtcqHpB
   MJqByxfi4P1EVHsj/glI08DTWfykRlvtxpM6DmHx64vgtaiCZM5i6lfac
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="418603727"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="418603727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703470490"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703470490"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5E0CD1F1; Mon, 22 May 2023 14:40:08 +0300 (EEST)
Date:   Mon, 22 May 2023 14:40:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] PCI: Don't assume root ports from > 2015 are power
 manageable
Message-ID: <20230522114008.GK45886@black.fi.intel.com>
References: <20230517150827.89819-1-mario.limonciello@amd.com>
 <20230522055555.GI45886@black.fi.intel.com>
 <da80fb19-0b98-bf19-eea3-bc2cca2024f5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da80fb19-0b98-bf19-eea3-bc2cca2024f5@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 06:28:25AM -0500, Mario Limonciello wrote:
> On 5/22/23 00:55, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Wed, May 17, 2023 at 10:08:27AM -0500, Mario Limonciello wrote:
> > > Using an XHCI device to wakeup the system from s2idle fails when
> > > that XHCI device is connected to a USB-C port for an AMD USB4
> > > router.
> > > 
> > > Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
> > > suspend") all root port go into D3 during s2idle.
> > > When the root ports are in D3 over s2idle it's not possible for the
> > > platform firmware to properly identify the wakeup source.
> > > 
> > > Comparing registers between Linux and Windows 11 this behavior to put root
> > > ports into D3 at suspend is unique to Linux.  On an affected system
> > > Windows does not put the root ports into D3 over Modern Standby.
> > > 
> > > Windows doesn't put the root ports into D3 because root ports are not
> > > power manageable; they're missing _PRW and _S0W.
> > > 
> > > Linux shouldn't be assuming they support D3 just because they're newer
> > > than 2015, the ports should also be deemed power manageable.
> > > Add an extra check for this to ensure D3 isn't selected for such machines.
> > > 
> > > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/pci/pci.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 5ede93222bc1..3fe27aef09e6 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > >   		if (dmi_check_system(bridge_d3_blacklist))
> > >   			return false;
> > > +		if (!platform_pci_power_manageable(bridge))
> > > +			return false;
> > > +
> > 
> > We already call platform_pci_bridge_d3() few lines up. That function
> > should know whether "platform" supports D3 for the bridges, and I think
> > it actually calls acpi_device_power_manageable() that platform_pci_power_manageable()
> > ends up checking too.
> 
> It does, but it doesn't end up returning false if it doesn't support it.  It
> only returns true if it does.

Good point!

> I've tested this patch on two different failing platforms and it works now
> on both.

Okay LGTM then,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
