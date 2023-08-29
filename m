Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B367E78C99B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjH2QYL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjH2QYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 12:24:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F0D7;
        Tue, 29 Aug 2023 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693326241; x=1724862241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q0QB0bTU4rFXo4+LlKiDQejCgiGZ6OUh6E4S3vd8bQo=;
  b=io7cNvnTlKG57Pn2d8ZN5nAI8YwOpTCCFVbamtBv0SC2ufEbG3L2WhkZ
   ux2qwOMtl9arhXzEeq4w7mI1GyUramJAU5miIVCEWIYIqrE7DM327fCV7
   FGkFRH0EU7N38SVVIU0J0bNY6qZn6z9sqXF7TIQwXm0rBpfTfrimTp8Zv
   4tNHxu2RONdSb3qW4HGrsa6QuwQUgfXZ1JvWVO5T1LugJqjbmypBMeB9S
   cHSeEEEBj5fPHK9u3NxypwFYF9/NsG07LVwGFKB4u9UgpG6/i9tITMiqu
   Ago1yjmmVRQN1rgIVfHqNNqFn7LlID29c2LcQ6qZvk+hyZOVEfFBFvCnm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355740023"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355740023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688562707"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="688562707"
Received: from tgodea-mobl.ger.corp.intel.com ([10.251.214.174])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:23:55 -0700
Date:   Tue, 29 Aug 2023 19:23:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] PCI: xgene: Do PCI error check on own line
In-Reply-To: <743fadf9-34d9-ca25-bdd6-f69bd922c3ec@linux.intel.com>
Message-ID: <31622354-2510-d942-ebf6-59bd1d44f868@linux.intel.com>
References: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com> <20230827133705.12991-8-ilpo.jarvinen@linux.intel.com> <CAL_JsqLELe91os89A1bOG+RPQpdFz0u_SyHx19zhkU19sPH7jg@mail.gmail.com> <743fadf9-34d9-ca25-bdd6-f69bd922c3ec@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1634065993-1693326238=:1757"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1634065993-1693326238=:1757
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Aug 2023, Ilpo Järvinen wrote:

> On Tue, 29 Aug 2023, Rob Herring wrote:
> 
> > On Sun, Aug 27, 2023 at 8:37 AM Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > Instead of a if condition with a line split, use the usual error
> > > handling pattern with a separate variable to improve readability.
> > >
> > > No functional changes intended.
> > >
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/controller/pci-xgene.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> > > index 887b4941ff32..b7f338de160b 100644
> > > --- a/drivers/pci/controller/pci-xgene.c
> > > +++ b/drivers/pci/controller/pci-xgene.c
> > > @@ -163,9 +163,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
> > >                                     int where, int size, u32 *val)
> > >  {
> > >         struct xgene_pcie *port = pcie_bus_to_port(bus);
> > > +       int ret;
> > >
> > > -       if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
> > > -           PCIBIOS_SUCCESSFUL)
> > > +       ret = pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val);
> > > +       if (ret != PCIBIOS_SUCCESSFUL)
> > 
> > Long term I think we want to replace these error codes with standard
> > linux ones.
> 
> This series is preparatory work for this very goal you stated!
> 
> > As PCIBIOS_SUCCESSFUL is 0, I would change this to just:
> > 
> > if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val))
> >     return PCIBIOS_DEVICE_NOT_FOUND;
> 
> I'm not so sure about this suggestion as it will overwrite the original 
> error code (like the current approach unfortunately also does). To me it 
> would seem more appropriate is to return the original error code instead. 
> But more discussion is needed before making such changes to values these 
> functions return. (And there are plenty of similar examples besides this 
> one.)

Actually, it looks in this case I could do that transformation safely now
since pci_generic_config_read32() can only return either 
PCIBIOS_DEVICE_NOT_FOUND or PCIBIOS_SUCCESSFUL so it won't alter anything.

-- 
 i.

--8323329-1634065993-1693326238=:1757--
