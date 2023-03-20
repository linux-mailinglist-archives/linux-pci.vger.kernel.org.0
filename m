Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511776C21BD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCTTmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCTTlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 15:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806925E2D
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 12:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB108614D7
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 19:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C9C433D2;
        Mon, 20 Mar 2023 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679340992;
        bh=eap1HTPMj0qSMwGcQ5vQsTCrGj2hNpkLfKrWX6CnlE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C8oP7P5tfQEjcUHJgmvqeULj2S35hgnfWFnZMuLzJUmqcAmeP/SgjlC8kI4QS8kCo
         1rmHORVOzhmhtH6cvGNeR1EfXV8Rpk/6L2fT7illXyFbjzy4RXAviXfpLb2lBstmzw
         3/cuh1JCdvxEsz3N2m4doLYGpDWYg2orkkmo50TXhRzobR36PjlCd39AAmY5AEekIQ
         yzhNBH/EbkdtmsqDYPbxVDjeFF3OXSztlA6w+gK8lEkVGr3QWRHCt+2XeLBT6jhWEK
         tlSXtbicnOf/rLCbH62+Rqo78m7/qh6eUeYA5Pqs4BpLMepC28YP1kDaIg4F4cZj3E
         550QnIutK/13g==
Date:   Mon, 20 Mar 2023 14:36:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230320193630.GA2301992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61016417794D1AF00963AEC3E2809@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 05:20:55PM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Monday, March 20, 2023 12:15
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; thomas@glanzmann.de;
> > Rafael J. Wysocki <rjw@rjwysocki.net>
> > Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X

Whatever you're using for email adds all these redundant headers to
every response...

> > On Mon, Mar 20, 2023 at 01:32:16AM +0000, Limonciello, Mario wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Friday, March 10, 2023 16:14
> > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > Cc: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Natikar, Basavaraj
> > > > <Basavaraj.Natikar@amd.com>; bhelgaas@google.com; linux-
> > > > pci@vger.kernel.org; thomas@glanzmann.de
> > > > Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
> > > >
> > > > On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> > > > > On 3/9/23 16:30, Bjorn Helgaas wrote:
> > > > > > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> > > > > > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > > > > > ...

> > it's important that the commit log is accurate and makes sense even to
> > people who don't know the internals of the device.
> > 
> > It *sounds* like what's happening is:
> > 
> >   - OS writes PMCSR to put device in D3hot
> >   - BIOS traps D0->D3hot transition via something like SMI and
> >     captures MSI-X state
> >   - Device enters D3hot
> >   - Device internal MSI-X state is lost
> >   - BIOS traps D3hot->D0 transition via SMI
> >   - Device enters D0
> >   - BIOS restores MSI-X state
> >   - OS resumes use of device
> > 
> > If that's what's happening, the fact that the device loses the
> > internal state in D3hot sounds like a *hardware* defect -- if you put
> > the device in a system without a BIOS, the D0->D3hot->D0 transitions
> > would not work as required by the PCIe spec.
> 
> Actually it's a controller integrated into the APU.
> 
> So any system you put this APU into has a BIOS.  Because it's a socketed
> APU people can very easily move it from one motherboard to another and one
> vendor may have the BIOS properly configuring but another might not.
>
> > We can call the fact that BIOS lacks the MSI-X save/restore a BIOS
> > defect, but the only reason BIOS would *need* that save/restore is
> > because of the underlying *hardware* defect.
> > 
> > If that's the case, I would expect a commit log something like this:
> > 
> >   The AMD [1022:15b8] USB controller loses some internal functional
> >   MSI-X context when transitioning from D0 to D3hot.  BIOS normally
> >   traps D0->D3hot and D3hot->D0 transitions so it can save and restore
> >   that internal context, but some firmware in the field lacks this
> >   workaround.
> 
> I wouldn't call it a workaround.  The hardware is doing exactly as it's
> intended for how the firmware programmed.

The whole point of the PCI spec is to build devices where standard
features like power management can be operated without device-specific
knowledge.  If we need device-specific code in BIOS or Linux, I'd say
that's a workaround.

Does this device set No_Soft_Reset?  If it does, when it receives a
config write to PMCSR that puts it in D3hot, followed by a config
write that puts it back in D0, it's supposed to return to D0 with no
additional software intervention required.  I think that also means no
BIOS intervention is required.

If it does not set No_Soft_Reset, pci_pm_reset() assumes that a
D0->D3hot->D0 transition resets the device.  We save and restore the
MSI-X Capability in that case, but we do NOT run the
DECLARE_PCI_FIXUP_RESUME_EARLY quirks.  I think that means MSI-X would
not work after a PM reset of this device.

Bjorn
