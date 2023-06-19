Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0E735BEC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjFSQHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjFSQHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 12:07:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528F95;
        Mon, 19 Jun 2023 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687190820; x=1718726820;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m+jbbq5rQUt/MAZUXn1lznCro4VPPLa6sXO1lMHLgpQ=;
  b=HR+6NxKUK7lkuJnFdGcHIFgaRcExmLhAyNFmKKRcfKOcPhn+POQh1R+M
   AWyK50awYFJao7O2WtNQ9Z0LLwJzQdDyLssuv3gNVkNZam0gAgmgbZHXy
   OaOu/HGi7nndkuvU0HlQMxux/hmIGXgY7d4BPB9/KyMz+8x9xG+SqUDm3
   WUA4igxOY2J8q6EuYQWQdsEfbm7WnNiqNcZi9aI+zsQmaraTeTsfuntRc
   ug0pT2Z65DOGGM/ZIjKTymP1dSW0pKIm8Zu39CLtDOjgqbrgyiFkG0ew1
   I++1nI8UnzSC9WiV3Qrhj9QeNl+73qgFtXc0fqqAUVTCf8lYJ5Teqj0+u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339278072"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="339278072"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 09:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="707938021"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="707938021"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.252.61.238])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 09:06:53 -0700
Date:   Mon, 19 Jun 2023 19:06:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?ISO-8859-15?Q?Stefan_M=E4tje?= <stefan.maetje@esd.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Shaohua Li <shaohua.li@intel.com>,
        Thomas Renninger <trenn@suse.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 3/9] PCI/ASPM: Use RMW accessors for changing LNKCTL
In-Reply-To: <20230619150944.GA8560@bhelgaas>
Message-ID: <987455-5d85-ecf1-145c-694b3de96340@linux.intel.com>
References: <20230619150944.GA8560@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1360604632-1687190818=:1758"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1360604632-1687190818=:1758
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 19 Jun 2023, Bjorn Helgaas wrote:

> On Mon, Jun 19, 2023 at 05:45:06PM +0300, Ilpo Järvinen wrote:
> > On Fri, 16 Jun 2023, Lukas Wunner wrote:
> > > On Wed, May 17, 2023 at 01:52:29PM +0300, Ilpo Järvinen wrote:
> > > > Don't assume that the device is fully under the control of ASPM and use
> > > > RMW capability accessors which do proper locking to avoid losing
> > > > concurrent updates to the register values.
> > > > 
> > > > If configuration fails in pcie_aspm_configure_common_clock(), the
> > > > function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> > > > only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> > > > than the content of the whole LNKCTL registers. It aligns better with
> > > > how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> > > > code more obvious to understand.
> > > [...]
> > > > @@ -224,17 +223,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> > > >  	if (!pcie_wait_for_retrain(parent))
> > > >  		return false;
> > > >  
> > > > -	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> > > > -	reg16 |= PCI_EXP_LNKCTL_RL;
> > > > -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > > > +	pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
> > > >  	if (parent->clear_retrain_link) {
> > > 
> > > This and several other RMW operations in drivers/pci/pcie/aspm.c
> > > are touched by commit b1689799772a ("PCI/ASPM: Use distinct local
> > > vars in pcie_retrain_link()") which got applied to pci/enumeration
> > > this week:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=enumeration&id=b1689799772a6f4180f918b0ff66e264a3db9796
> > > 
> > > As a result the $SUBJECT_PATCH no longer applies cleanly and needs
> > > to be respun.
> > 
> > Okay but I'm a bit lost which commit/head in pci repo I should now base 
> > this series because there's a conflict between pci/aspm and 
> > pci/enumeration which is not resolved in the repo because pci/enumeration 
> > hasn't advanced into pci/next yet. Any suggestion?
> 
> Generally speaking I prefer patches based on the PCI "main" branch
> (usually -rc1) because I base topic branches on that.  If there are
> conflicts with other pending material, it's great if you can mention
> them, but I can resolve them when applying, so no need to repost just
> for that.

Just to confirm I'm understanding this correctly... Am I supposed to send
a patch whose changelog description and diff do not agree?? (The diff 
will still modify pcie/aspm.c if it's main-based and the description 
refers to something more generic as per Lukas' request since the code got 
moved into pci.c in the enumeration branch).


-- 
 i.

--8323329-1360604632-1687190818=:1758--
