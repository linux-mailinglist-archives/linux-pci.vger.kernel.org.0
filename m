Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDEE5F5324
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJELH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJELH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 07:07:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8256AEB9;
        Wed,  5 Oct 2022 04:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A71C6B81D88;
        Wed,  5 Oct 2022 11:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E19FC433D6;
        Wed,  5 Oct 2022 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664968073;
        bh=yAcjCd8qA0PzpOonzfxU8FLI+ZPg/Daluyl3Ph2LnAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Igpm/Y2g7ACnv9Gf+/TLz/Y3zwmAx8CbG+OmnYVYEbH2g9v6+Zi5zVR5DHTKRA9xJ
         J9QFot3Sik6r44y8Gou+WufyVyiwom0r7BIMnefwoB/eIRT93poXZ0meWVSguJg2pY
         r280nvDXH4eXRq3N9or+Ep659lomKnxbmSlt2yHB6h9dn0ctN7rjwjeiykf9murJD2
         9nD5TBS1uXEkI02qChCQICeaGj0k/P1ZGqWls/LcCb70VahfXYVL5DpUDtMgbHKQcl
         KbcpERGJ477hZswNQjTE/e5iqImEimWoHga1jz4XLJM3VvprccsBK/C2mMreXW1bnf
         LTaSQhea5nF8A==
Date:   Wed, 5 Oct 2022 06:07:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/ASPM: Ignore L1 PM Substates if device lacks
 capability
Message-ID: <20221005110751.GA2275321@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5799dca0-5ad2-be44-ae79-e276bd7e0a8c@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 04, 2022 at 08:26:53PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 10/4/22 7:58 PM, Bjorn Helgaas wrote:
> > 187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
> > inadvertently removed a check for existence of the L1 PM Substates (L1SS)
> > Capability before reading it.
> > 
> > If there is no L1SS Capability, this means we mistakenly read PCI_COMMAND
> > and PCI_STATUS (config address 0x04) and interpret that as the PCI_L1SS_CAP
> > register, so we may incorrectly configure L1SS.
> > 
> > Make sure the L1SS Capability exists before trying to read it.
> > 
> > Fixes: 187f91db8237 ("PCI/ASPM: Remove struct aspm_register_info.l1ss_cap")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 4535228e4a64..f12d117f44e0 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -560,6 +560,9 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
> >  	u32 parent_l1ss_cap, child_l1ss_cap;
> >  	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
> >  
> > +	if (!parent->l1ss || !child->l1ss)
> > +		return;
> 
> I have noticed that l1ss state is initialized in pci_configure_ltr(). I am
> wondering whether it is the right place? Are L1SS and LTR related?

L1SS and LTR are definitely related -- LTR supplies information
that's needed for L1.2.

I'm not sure why pci_configure_ltr() is in probe.c and
pci_bridge_reconfigure_ltr() is in pci.c; maybe it would make
sense to put them both in aspm.c.  

Bjorn
