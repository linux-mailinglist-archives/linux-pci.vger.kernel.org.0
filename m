Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E975FF415
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiJNT1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJNT1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 15:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC7C1C883D;
        Fri, 14 Oct 2022 12:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 467A061C0D;
        Fri, 14 Oct 2022 19:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608FEC433C1;
        Fri, 14 Oct 2022 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665775652;
        bh=5wLBaSBVsL3Q6oWlsel3CQETE/x5JNAR/PyXhuzelxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q0szqx9ExlrVz9ylhhqehOq9WsVUjPWAS13pB423zeRnjwfMf1s4DNoz3uCysYS8+
         3/xaEIcCP58qcHPwpQpPGfXlXq89C1K+K2n2yBI09L9Kmn6mmw/uDPkV4bu6+vSuO1
         ZojsJtYn7nM00qjd0xXJ5k3bKzO8PcrqatW27llad9xowupNLexnHRdEPzCMmX5C8U
         BdRaXzY+INWrDPs3CtIUxJoPhi0SwMPDDNoLb4pSGcAtxQzAFX/AzHSYZGulYMYypZ
         qAo6Nz1qCyclO0uRqzrMO/pOAUepTPqBjFslSgdkTtrvs7wUQUfbHv59i3h3dSQ+zq
         aQ6IgWbT+NqxQ==
Date:   Fri, 14 Oct 2022 14:27:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Message-ID: <20221014192730.GA3488778@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNw3Eotf29e=3=H2QZBEbbL8th9xrLRN8sUfcRMKQ1ML7w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 03:16:35PM -0400, Jim Quinlan wrote:
> On Thu, Oct 13, 2022 at 10:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Oct 11, 2022 at 02:42:10PM -0400, Jim Quinlan wrote:
> > > Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
> > > the Maximum Payload Size (MPS) are returned in one completion, and data for
> > > PCIe read requests greater than the MPS are split at the specified Read
> > > Completion Boundary setting.
> > >
> > > Set RCB_64B so that the Read Compeletion Boundary is 64B.
> >
> > s/Compeletion/Completion/
> 
> Hi Bjorn,
> 
> TIL that checkpatch.pl only flags misspelled words only if they match
> its list of misspelled words.
> I've modified my checkpatch.pl wrapper script to use aspell to better
> address my typos.
> At any rate, do you mind if I add some new commits for V3?

Fine with me, I think Lorenzo will look at these again after v6.1-rc1
is tagged this weekend.

Bjorn
