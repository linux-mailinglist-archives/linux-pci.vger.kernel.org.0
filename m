Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F3735AD3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFSPKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjFSPKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 11:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC2F9;
        Mon, 19 Jun 2023 08:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A6260D17;
        Mon, 19 Jun 2023 15:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823DC433C0;
        Mon, 19 Jun 2023 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687187386;
        bh=GxkfFiD3FPUB0uLvuilF9gvjzRT76yd6Rs02FVbihhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o0VoNJf4eC1pSRDjQJk+s3aJUzAeS2Sr88XbW0kl+dXDsjO5Zj5JuqfG6vvufxAkp
         KI/ce6Fm33ihLFWVgwWDDu1XhLC7S2KS1QdvmIn6de333bSLKI28xrq3ip2lBU7Dhl
         YqxSDXlREeNzzzLiwIfV5sTc9WKk4pkxJJuXfWfixd0koeSGpFMn2Qy1LiNhgOtgJQ
         9CLB/pDxD2zz5sWkaE1ebCkt++0+dtclSoxPNHXlG0HUFmoNl7tzCNMOMVPqm/GJNW
         p0G+NsTKzpC+Fvx33uvrISHD8JuzCQUNGQgcBYFGqQhBs7hWXE1jQVClEC5/0jnrfJ
         t7+mGPfIh6MvQ==
Date:   Mon, 19 Jun 2023 10:09:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>,
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
Message-ID: <20230619150944.GA8560@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6397fe9-bc77-fe1f-b941-f8aac91bea65@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 05:45:06PM +0300, Ilpo Järvinen wrote:
> On Fri, 16 Jun 2023, Lukas Wunner wrote:
> > On Wed, May 17, 2023 at 01:52:29PM +0300, Ilpo Järvinen wrote:
> > > Don't assume that the device is fully under the control of ASPM and use
> > > RMW capability accessors which do proper locking to avoid losing
> > > concurrent updates to the register values.
> > > 
> > > If configuration fails in pcie_aspm_configure_common_clock(), the
> > > function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> > > only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> > > than the content of the whole LNKCTL registers. It aligns better with
> > > how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> > > code more obvious to understand.
> > [...]
> > > @@ -224,17 +223,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> > >  	if (!pcie_wait_for_retrain(parent))
> > >  		return false;
> > >  
> > > -	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> > > -	reg16 |= PCI_EXP_LNKCTL_RL;
> > > -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > > +	pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
> > >  	if (parent->clear_retrain_link) {
> > 
> > This and several other RMW operations in drivers/pci/pcie/aspm.c
> > are touched by commit b1689799772a ("PCI/ASPM: Use distinct local
> > vars in pcie_retrain_link()") which got applied to pci/enumeration
> > this week:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=enumeration&id=b1689799772a6f4180f918b0ff66e264a3db9796
> > 
> > As a result the $SUBJECT_PATCH no longer applies cleanly and needs
> > to be respun.
> 
> Okay but I'm a bit lost which commit/head in pci repo I should now base 
> this series because there's a conflict between pci/aspm and 
> pci/enumeration which is not resolved in the repo because pci/enumeration 
> hasn't advanced into pci/next yet. Any suggestion?

Generally speaking I prefer patches based on the PCI "main" branch
(usually -rc1) because I base topic branches on that.  If there are
conflicts with other pending material, it's great if you can mention
them, but I can resolve them when applying, so no need to repost just
for that.

Bjorn
