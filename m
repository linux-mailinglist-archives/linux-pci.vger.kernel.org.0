Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FF77F445
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349124AbjHQKY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348253AbjHQKYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 06:24:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74853213F;
        Thu, 17 Aug 2023 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692267874; x=1723803874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZyKtUMD9gZ0GFk5SzGG5YmdqE0RYJyeunkcNG4psLRQ=;
  b=hPbGP6qJFYna5j/ZI2/+JE9qGiDRza12oRHkIO/WYUV1b6lf+t3FgMzP
   WMy32fM6Fw2PwG6vLLyyumciXqaotWBdczTX3JtQjQ1/xlFVrAuTBSDkV
   t88rWZnCnduOVDyTk2iry/t1FrNgXT2LiINgkW0AkUSvCRobUMJ99Gnn8
   NQlpCfMZKsfU2FqW2jc81wDbwKCBH066loGpfuOlUYstukFgZPBmeea/2
   xb9O8+RBK9LT6ZIT60p5cK3mea8xqLSK3WXtSDgdbn77q5WiJJcJz6izP
   S/aePsuYIAUaFAM1ZnE+Na9x0/69i/8ir3daZF5g5apA82aIhaLBiswtX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362920566"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="362920566"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="728093501"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="728093501"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2023 03:24:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C6B3CDAB; Thu, 17 Aug 2023 13:24:30 +0300 (EEST)
Date:   Thu, 17 Aug 2023 13:24:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <20230817102430.GD3465@black.fi.intel.com>
References: <20230816051923.2287912-1-Sanath.S@amd.com>
 <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 06:48:35PM +0530, Sanath S wrote:
> Adding Mika.

Thanks!

> On 8/16/2023 10:49 AM, Sanath S wrote:
> > In the case of Thunderbolt, it contains a PCIe switch and one or
> > more hotplug-capable PCIe downstream ports where the daisy chain
> > can be extended.
> > 
> > Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> > System BIOS allocates a very minimal number of buses for bridges and
> > hot-plug capable PCIe downstream ports to enumerate the dock during
> > boot. Because of this, we run out of bus space pretty quickly when
> > more PCIe devices are attached to hotplug downstream ports in order
> > to extend the chain.
> > 
> > Before:
> >             +-04.0
> >             +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
> >             |                               +-01.0-[66]--
> >             |                               +-02.0-[67]--
> >             |                               +-03.0-[68]--
> >             |                               \-04.0-[69]--
> >             +-08.0

This is something the BIOS should be doing but for some reason it is
not on that particular system.

> > In case of a thunderbolt capable bridge, reconfigure the buses allocated

Thunderbolt

> > by BIOS to the maximum available buses. So that the hot-plug bridges gets
> > maximum buses and chain can be extended to accommodate more PCIe devices.
> > This fix is necessary for all the PCIe downstream ports where the daisy
> > chain can be extended.

This is necessary only when there is no proper BIOS allocation for the
resources.

> > After:
> >             +-04.0
> >             +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
> >             |                               +-01.0-[66-84]--
> >             |                               +-02.0-[85-a3]--
> >             |                               +-03.0-[a4-c0]--
> >             |                               \-04.0-[c1]--
> >             +-08.0
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000

Did you get confirmation that this actually solves the issue?

> > Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > ---
> >   drivers/pci/probe.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 8bac3ce02609..ab7e90ef2382 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >   	bool fixed_buses;
> >   	u8 fixed_sec, fixed_sub;
> >   	int next_busnr;
> > +	int start = bus->busn_res.start;
> > +	int end = bus->busn_res.end;
> >   	/*
> >   	 * Make sure the bridge is powered on to be able to access config
> > @@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> >   		broken = 1;
> >   	}
> > +	/* Reconfigure, If maximum buses are not allocated */
> > +	if (!pass && start != 0 && end != 0xff && subordinate != end) {
> > +		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",
> > +			 subordinate, end);
> > +		broken = 1;
> > +	}
> > +
> >   	/*
> >   	 * Disable Master-Abort Mode during probing to avoid reporting of
> >   	 * bus errors in some architectures.
