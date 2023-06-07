Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34F725CDF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbjFGLRq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 7 Jun 2023 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjFGLRn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 07:17:43 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EF2111;
        Wed,  7 Jun 2023 04:17:25 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so1765334a12.0;
        Wed, 07 Jun 2023 04:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136643; x=1688728643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAdye/bk1h2dIXos4Zo0jp3AibrW3ouux0Tr4Db9GAM=;
        b=ZksJmvmtGtQM4I1ltSZ4j4ezElTmQeg4i1HwkS00tcO5qcg/zyWYiityz5DD0jZuJt
         SwdkA2o2PnuJtwQiCy1QEOkOZriWEjFJFVz5xPWjAg1tTv/2mMf+ikXfYjzs4zuwOlA+
         7din0WKKmJqPw4KzcXE/PSf3doFDEVqIA6PdbvvKIlOBLgnVV9LVr440MEjOcjiNTsPE
         egZFrjerQLR5oPGnb+YChD9ypnBSFIR0wwmjw3IzUQqmNSAHzkuKxcwLom4cF3Ul2XoY
         uEwkMR8qQLXo04ZQnlB6unrtNZe3SC+5J/h0ezeIxPpPgVKZdGspR0sB7vnVf9FC6nLG
         3EMw==
X-Gm-Message-State: AC+VfDxu5itY3NWgjWfnbpgnme3yeZ9qaSnYJ0ViLLiplwIKNFjtvmKa
        tG9qpTAsLfngT4WJdFnrkpKSzwRIGEG+yu+Gnp8=
X-Google-Smtp-Source: ACHHUZ5DIcEt0d2n6c8SIyFLi/GqVaUxL5U6bOfuVIEvp31nKrxyH26E8oVp7xnDiLb/OSg1KAiRN6hLQkRP190F26c=
X-Received: by 2002:a17:906:1ce:b0:976:50a4:ac49 with SMTP id
 14-20020a17090601ce00b0097650a4ac49mr4930349ejj.6.1686136643281; Wed, 07 Jun
 2023 04:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230606195847.GA1142401@bhelgaas> <1d920ce5-8279-65e9-db6b-7cc8a9cb4779@amd.com>
In-Reply-To: <1d920ce5-8279-65e9-db6b-7cc8a9cb4779@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Jun 2023 13:17:10 +0200
Message-ID: <CAJZ5v0jqxGnQTHqS2TynLQb5H9we=dxOMH696wgSKrJNYgSVUw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 6, 2023 at 10:26 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/6/2023 2:58 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 06, 2023 at 02:40:45PM -0500, Limonciello, Mario wrote:
> >> On 6/6/2023 2:23 PM, Bjorn Helgaas wrote:
> >>> On Tue, Jun 06, 2023 at 11:23:21AM -0500, Mario Limonciello wrote:
> >>>> ASMedia PCIe GPIO controllers fail functional tests after returning from
> >>>> suspend (S3 or s2idle). This is because the BIOS checks whether the
> >>>> OSPM has called the `_REG` method to determine whether it can interact with
> >>>> the OperationRegion assigned to the device.
> >>>>
> >>>> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
> >>>> code on the availability of an operation region.
> >>>>
> >>>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> >>>> state of PCI devices.
> >>>>
> >>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>> v1->v2:
> >>>>    * Handle case of no CONFIG_ACPI
> >>>>    * Rename function
> >>>>    * Update commit message
> >>>>    * Move ACPI calling code into pci-acpi.c instead
> >>>>    * Cite the ACPI spec
> >>> Thanks for the spec reference (s/APCI/ACPI/ and add the revision if
> >>> you rev this (r6.5 is the latest, AFAIK) if you rev this).
> >>>
> >>> I don't see text in that section that connects S3 with _REG.  If it's
> >>> there, you might have to quote the relevant sentence or two in the
> >>> commit log.
> >> I don't think there is anything the spec connecting this
> >> with S3.  At least from my perspective S3 is the reason
> >> this was exposed but there is a deficiency that exists
> >> that _REG is not being called by Linux.
> >>
> >> I intend to re-word the commit message something to the
> >> effect of explaining what _REG does and why _REG should be
> >> called, along with citations.
> >>
> >> Then in another paragraph "Fixing this resolves an issue ...".
> >>
> >>> You mentioned _REG being sort of a mutex to synchronize OSPM vs
> >>> platform access; if there's spec language to that effect, let's cite
> >>> it.
> >> That sentence I included was cited from the spec.
> > If it's necessary to justify the commit, include the citation in the
> > commit log.
> >
> >>> Ideally we should have been able to read the PCI and ACPI specs and
> >>> implement this without tripping over problem on this particular
> >>> hardware.  I'm looking for the text that enables that "clean-room"
> >>> implementation.  If the spec doesn't have that text, it's either a
> >>> hole in the spec or a BIOS defect that depends on something the spec
> >>> doesn't require.
> >> IMO both the spec and BIOS are correct, it's a Linux
> >> issue that _REG wasn't used.
> > What tells Linux that _REG needs to be used here?  If there's nothing
> > that tells Linux to use _REG here, I claim it's a BIOS defect.  I'm
> > happy to be convinced otherwise; the way to convince me is to point to
> > the spec.
>  From the spec it says "control methods must assume
> all operation regions are inaccessible until the
> _REG(RegionSpace, 1) method is executed"
>
> It also points out the opposite: "Conversely,
> control methods must not access fields in
> operation regions when _REG method execution
> has not indicated that the operation region
> handler is ready."
>
> The ACPI spec doesn't refer to D3 in this context, but
> it does make an allusion to power off in an example case.
>
> "Also, when the host controller or bridge controller
> is turned off or disabled, PCI Config Space Operation
> Regions for child devices are no longer available.
> As such, ETH0’s _REG method will be run when it is
> turned off and will again be run when PCI1 is
> turned off."
>
> >
> > If it's a BIOS defect, it's fine to work around it, but we need to
> > understand that, own up to it, and make the exact requirements very
> > clear.  Otherwise we're likely to break this in the future because
> > future developers and maintainers will rely on the specs.
>  From my discussions with BIOS developers, this is entirely
> intended behavior based on the _REG section in the spec.
> >>> Doing this in pci_save_state() still seems wrong to me.  For example,
> >>> e1000_probe() calls pci_save_state(), but this is not part of suspend.
> >>> IIUC, this patch will disconnect the opregion when we probe an e1000
> >>> NIC.  Is that what you intend?
> >> Thanks for pointing this one out.  I was narrowly focused
> >> on callers in PCI core.  This was a caller I wasn't
> >> aware of; I agree it doesn't make sense.
> >>
> >> I think pci_set_power_state() might be another good
> >> candidate to use.  What do you think of this?
> > I can't suggest a call site because (1) I'm not a power management
> > person, and (2) I don't think we have a clear statement of when it is
> > required.  This must be expressed in terms of PCI power state
> > transitions, or at least something discoverable from a pci_dev, not
> > "s2idle" or even "S3" because those are meaningless in the PCI
> > context.
> >
> > Bjorn
> Right; I'm with you on not putting it with a suspend
> transition.
>
> The spec indicates that control methods can't access
> the regions until _REG is called, so
> my leaning is to keep the call at init time, and
> then add another call for the D3 and D0 transitions
> which is why I think pci_set_power_state() is probably
> best.

Except that it is not used in all transitions; see the callers oif
pci_power_up() for example.

Technically, the config space should become accessible right after
acpi_pci_set_power_state() has transitioned the device into D0 and it
should be accessible still right before acpi_pci_set_power_state()
attempts to transition the device into a low-power state, so it looks
like _REG could be evaluated from there.
