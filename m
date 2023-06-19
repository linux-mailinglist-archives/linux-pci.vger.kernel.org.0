Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50AA7359F3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFSOpT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSOpS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 10:45:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A520A90;
        Mon, 19 Jun 2023 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687185917; x=1718721917;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EkDskaH4OoKjAPhDI/G9jXlv2y9BtYKSsvBIWeqjukU=;
  b=nE4o48R1atWhqNNTg+AtsdtomjvrYPhC1c+9wmgkQW2Lsu0ZUN2kanay
   pf8q5SNaCVJljf0heE+Z27mfjFAPW+YybWqq8aVfQ49UyN6rZPqhGkIg1
   c66wVKkVPUrKcqk6KlLbWY1RMPtiNsUJcuSUwtrreGv2DNl96wNWPZlkR
   lsBlEUAKbKAm5w6Qil4m4mH0ctkoPdRyv23V0vx7S3OzBx6xot18kIwTZ
   n8AEPVTF0Bepsit565kfQUzvIZcVeScKRhv8Xl+gtw6KjUNpeku8B/17a
   F6p86YVyTAIDI7MN8OgH5SEYONPWs1jtpgOuEpHzqfu/J8pXam/H/L+70
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="362185007"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="362185007"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 07:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="779064994"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="779064994"
Received: from amujtaba-mobl.ger.corp.intel.com ([10.252.61.238])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 07:45:11 -0700
Date:   Mon, 19 Jun 2023 17:45:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <20230616191056.GA30821@wunner.de>
Message-ID: <f6397fe9-bc77-fe1f-b941-f8aac91bea65@linux.intel.com>
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com> <20230517105235.29176-4-ilpo.jarvinen@linux.intel.com> <20230616191056.GA30821@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1224417959-1687185916=:1758"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1224417959-1687185916=:1758
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 16 Jun 2023, Lukas Wunner wrote:

> On Wed, May 17, 2023 at 01:52:29PM +0300, Ilpo Järvinen wrote:
> > Don't assume that the device is fully under the control of ASPM and use
> > RMW capability accessors which do proper locking to avoid losing
> > concurrent updates to the register values.
> > 
> > If configuration fails in pcie_aspm_configure_common_clock(), the
> > function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> > only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> > than the content of the whole LNKCTL registers. It aligns better with
> > how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> > code more obvious to understand.
> [...]
> > @@ -224,17 +223,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >  	if (!pcie_wait_for_retrain(parent))
> >  		return false;
> >  
> > -	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> > -	reg16 |= PCI_EXP_LNKCTL_RL;
> > -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > +	pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
> >  	if (parent->clear_retrain_link) {
> 
> This and several other RMW operations in drivers/pci/pcie/aspm.c
> are touched by commit b1689799772a ("PCI/ASPM: Use distinct local
> vars in pcie_retrain_link()") which got applied to pci/enumeration
> this week:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=enumeration&id=b1689799772a6f4180f918b0ff66e264a3db9796
> 
> As a result the $SUBJECT_PATCH no longer applies cleanly and needs
> to be respun.

Okay but I'm a bit lost which commit/head in pci repo I should now base 
this series because there's a conflict between pci/aspm and 
pci/enumeration which is not resolved in the repo because pci/enumeration 
hasn't advanced into pci/next yet. Any suggestion?


-- 
 i.

--8323329-1224417959-1687185916=:1758--
