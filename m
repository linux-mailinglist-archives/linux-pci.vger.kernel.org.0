Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5778C96C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjH2QPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 12:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbjH2QOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 12:14:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7C1AE;
        Tue, 29 Aug 2023 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693325682; x=1724861682;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CWbT+PuWCNmRpPKaOz8yZTIyoxhZcqGd0gZTyF/EEK8=;
  b=YCL2aXaxixgjl9T1Eymhrlqn4EhLZxaXRMzRFP3kzLm2xeWMCKbKKFem
   1TAUMJkhsxMVR2pkPdLeMpWzG5i+lNczThClOQ6mNttLuKfUh+TGaqD5Z
   fm6y9M8Emyf7FTYOUa7PlE3eGeHlRww0Msb5GJyhMUXFMyZc4Mx8mx14c
   skIs9S6xoPspH+JAfqQCLp3ZjMW3w4xLrjA35B9NZTyAzGRM9JRxbybaT
   bBBqKrzbN3NndAJJuQy2Klqc0s5mn0QWPgHraN15vdY8/ibHF6GztCJRE
   wiSe+uhdvPZhy6LRkTfQu/H770qdkAx/Wwts+/Dsgd35uiPWwBQc9gPiy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372822420"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372822420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="804178706"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="804178706"
Received: from tgodea-mobl.ger.corp.intel.com ([10.251.214.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:14:39 -0700
Date:   Tue, 29 Aug 2023 19:14:36 +0300 (EEST)
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
In-Reply-To: <CAL_JsqLELe91os89A1bOG+RPQpdFz0u_SyHx19zhkU19sPH7jg@mail.gmail.com>
Message-ID: <743fadf9-34d9-ca25-bdd6-f69bd922c3ec@linux.intel.com>
References: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com> <20230827133705.12991-8-ilpo.jarvinen@linux.intel.com> <CAL_JsqLELe91os89A1bOG+RPQpdFz0u_SyHx19zhkU19sPH7jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1260880413-1693325681=:1757"
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

--8323329-1260880413-1693325681=:1757
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Aug 2023, Rob Herring wrote:

> On Sun, Aug 27, 2023 at 8:37 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > Instead of a if condition with a line split, use the usual error
> > handling pattern with a separate variable to improve readability.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/controller/pci-xgene.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> > index 887b4941ff32..b7f338de160b 100644
> > --- a/drivers/pci/controller/pci-xgene.c
> > +++ b/drivers/pci/controller/pci-xgene.c
> > @@ -163,9 +163,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
> >                                     int where, int size, u32 *val)
> >  {
> >         struct xgene_pcie *port = pcie_bus_to_port(bus);
> > +       int ret;
> >
> > -       if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
> > -           PCIBIOS_SUCCESSFUL)
> > +       ret = pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val);
> > +       if (ret != PCIBIOS_SUCCESSFUL)
> 
> Long term I think we want to replace these error codes with standard
> linux ones.

This series is preparatory work for this very goal you stated!

> As PCIBIOS_SUCCESSFUL is 0, I would change this to just:
> 
> if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val))
>     return PCIBIOS_DEVICE_NOT_FOUND;

I'm not so sure about this suggestion as it will overwrite the original 
error code (like the current approach unfortunately also does). To me it 
would seem more appropriate is to return the original error code instead. 
But more discussion is needed before making such changes to values these 
functions return. (And there are plenty of similar examples besides this 
one.)


-- 
 i.

--8323329-1260880413-1693325681=:1757--
