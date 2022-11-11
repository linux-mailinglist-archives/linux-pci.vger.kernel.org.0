Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59814625842
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiKKK1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiKKK1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 05:27:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EA98;
        Fri, 11 Nov 2022 02:27:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5A61B82515;
        Fri, 11 Nov 2022 10:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3787AC433C1;
        Fri, 11 Nov 2022 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668162421;
        bh=NIKpSpHWlLy3T60+YotIDy3wX5KgU5OicTFFNaPOkFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibLA1W+pwsYEQ0vHTaOJwZR2is0QrWe8DpwuUYBWmZGDguyc6aIeqWGurz52H/2hw
         zrtNORx1azaDKxNLtYciHAOGRmsNLjS7yNX11PXfdCt3uDGNP6Mj9i8FW8kKAgpsMA
         T4361gvJ72SfLRN6l2UcTvB4rpv6Ct/L9hK7XS5vxk8OhSw/FeiEPRYYhWB5Nsdy+8
         EadjY82otDc8gNRBnFFSii/q/UyK7EcT7XAX145OX7V3i+DZOUkGXhq09C2Zd0wAsf
         PTZgezx8VfUFVd5FhCai4QSsJ1cFdJlRMDsVgem/Mbp6xl9ueL4Ob/oa0p04DlTIOo
         cI30JOpv7uZZA==
Date:   Fri, 11 Nov 2022 11:26:53 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Message-ID: <Y24jbQ5iLVnqVCJh@lpieralisi>
References: <20221014192730.GA3488778@bhelgaas>
 <6535ae14-3b09-3b17-d121-b75f433045fb@gmail.com>
 <CA+-6iNyiNLyMSsQtisDAqNF5_PNKzmAgbi11GDjFMP21naZHzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyiNLyMSsQtisDAqNF5_PNKzmAgbi11GDjFMP21naZHzw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 03:43:13PM -0400, Jim Quinlan wrote:
> On Thu, Nov 3, 2022 at 2:49 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 10/14/22 12:27, Bjorn Helgaas wrote:
> > > On Fri, Oct 14, 2022 at 03:16:35PM -0400, Jim Quinlan wrote:
> > >> On Thu, Oct 13, 2022 at 10:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >>> On Tue, Oct 11, 2022 at 02:42:10PM -0400, Jim Quinlan wrote:
> > >>>> Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
> > >>>> the Maximum Payload Size (MPS) are returned in one completion, and data for
> > >>>> PCIe read requests greater than the MPS are split at the specified Read
> > >>>> Completion Boundary setting.
> > >>>>
> > >>>> Set RCB_64B so that the Read Compeletion Boundary is 64B.
> > >>>
> > >>> s/Compeletion/Completion/
> > >>
> > >> Hi Bjorn,
> > >>
> > >> TIL that checkpatch.pl only flags misspelled words only if they match
> > >> its list of misspelled words.
> > >> I've modified my checkpatch.pl wrapper script to use aspell to better
> > >> address my typos.
> > >> At any rate, do you mind if I add some new commits for V3?
> > >
> > > Fine with me, I think Lorenzo will look at these again after v6.1-rc1
> > > is tagged this weekend.
> >
> > Lorenzo, any chance to get those patches reviewed and/or merged? Thanks!
> 
> Oops, I said I would add some commits but I don't have time right now.
>   Bjorn  or Lorenzo, could you review what is there and if you accept
> the commits can you please make the single spelling correction?  If
> not, I will correct the spelling along with any other requested
> changes.

I will fix the spelling, reviewing the patches now.

Lorenzo
