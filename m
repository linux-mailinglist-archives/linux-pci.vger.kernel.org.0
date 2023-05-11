Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5706FF89E
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjEKRhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjEKRhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:37:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F196EA1;
        Thu, 11 May 2023 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683826614; x=1715362614;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9apNON2HayPVUNwneb8oHhRTLdSk+kuKVsHWIPL5d58=;
  b=ApLnp+cG/htFQdEXZT/fu38YXR3c5QoNfsTkdvAiZwKOaMYVDGNEOigw
   2q8ox/E6NQv8dKN6+FwxRvBtOaOw2WtU+56LXo1dJFPX927inIbHAx/wr
   WjGKL+18DZqoXF6hsq1+75ElXAZ9pC45tIAIoVYYqOEAOIzknfrPz13IL
   5ntpHarIJkxquaJ7as8cX+1P+qJnb8gqS/LTWnP0Flx6SxQcbc8Z8AqR8
   thztGzXLLdaTlbnLI9yTfVR4ojjWqVPlp4O1V2mRNy7wz1p69pR027yJj
   f8i+IheF4EijfE7+ICPbI7aMfpX+tGDBvgeIMF06xBa9EqSiMdQLEPNZF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330932331"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="330932331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730463586"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730463586"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:35:51 -0700
Date:   Thu, 11 May 2023 20:35:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
In-Reply-To: <ZF0P2hedTFXPv8IK@bhelgaas>
Message-ID: <5140259d-4425-3166-438a-bc9fbbaa49f9@linux.intel.com>
References: <ZF0P2hedTFXPv8IK@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1704685674-1683825428=:1900"
Content-ID: <8185a32d-d6e3-5273-2777-a48ebb2f4a5a@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1704685674-1683825428=:1900
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <eaf4a3e3-e929-4154-99b5-f0e7a3c58625@linux.intel.com>

On Thu, 11 May 2023, Bjorn Helgaas wrote:

> On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> > A few places write LNKCTL and LNKCTL2 registers without proper
> > concurrency control and this could result in losing the changes
> > one of the writers intended to make.
> > 
> > Add pcie_capability_clear_and_set_word_locked() and helpers to use it
> > with LNKCTL and LNKCTL2. The concurrency control is provided using a
> > spinlock in the struct pci_dev.
> > 
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Thanks for raising this issue!  Definitely looks like something that
> needs attention.
> 
> > ---
> >  drivers/pci/access.c | 14 ++++++++++++++
> >  drivers/pci/probe.c  |  1 +
> >  include/linux/pci.h  | 17 +++++++++++++++++
> >  3 files changed, 32 insertions(+)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 3c230ca3de58..d92a3daadd0c 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -531,6 +531,20 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
> >  }
> >  EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> >  
> > +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> > +					      u16 clear, u16 set)
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&dev->cap_lock, flags);
> > +	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
> > +	spin_unlock_irqrestore(&dev->cap_lock, flags);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
> 
> I didn't see the prior discussion with Lukas, so maybe this was
> answered there, but is there any reason not to add locking to
> pcie_capability_clear_and_set_word() and friends directly?  
>
> It would be nice to avoid having to decide whether to use the locked
> or unlocked versions.  It would also be nice to preserve the use of
> PCI_EXP_LNKCTL directly, for grep purposes.  And it would obviate the
> need for some of these patches, e.g., the use of
> pcie_capability_clear_word(), where it's not obvious at the call site
> why a change is needed.

There wasn't that big discussion about it (internally). I brought both
alternatives up and Lukas just said he didn't know what's the best 
approach (+ gave a weak nudge towards the separate accessor so I went 
with it to make forward progress). Based on that I don't think he had a 
strong opinion on it.

I'm certainly fine to just use it in the normal accessor functions that 
do RMW and add the locking there. It would certainly have to those good 
sides you mentioned.

-- 
 i.
--8323329-1704685674-1683825428=:1900--
