Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7172165B
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jun 2023 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjFDLbG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 4 Jun 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 07:31:05 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F73AB;
        Sun,  4 Jun 2023 04:31:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977c963041dso17188066b.1;
        Sun, 04 Jun 2023 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685878262; x=1688470262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aL+o2q9WhcJmMB5Yajs16jdTbmhGEnj7bHGrpS9KdA=;
        b=iN2r8kC/5NpwelyNdhctUo8s2Ep1Apbf86V8bCG1jS6eAnCgJIAnYO54MehyMH0vTQ
         PXKED8/EBZhhAsLP3Lri1aShN9dYQjDYAFXIns4bS08b8Fl9dj4tTdlf7BFfSfrTUbML
         au5pMFJoMqy0dTeZ3fQo0nGb/Xr9t/ocySVRkdHLV9i3+mGsm+z/7St6BZnNS81S2Ogc
         LEmwnJeYyR8vyubXRo5aiU8I1l8rVUx9b6YkOhKHycODqPuy8wQ1h6U/KWnDZmNbihbC
         PEKPs/go7dWcxbCx13LsclhuLVp0c/NMtSpWh6XWVhSFa+VdBA0qTNny3DwEKnTci8NR
         6Fyw==
X-Gm-Message-State: AC+VfDx+XDrfmeWhbaqtpLHriXHTDNtpf/vKcfxKyuSSIYcaW4Qm66ae
        6xwHnR6a/WhHD9Anql94jvD07fJ8eXtHY3E+Pz0=
X-Google-Smtp-Source: ACHHUZ5ky9PsrrOle7rH26Nn34AShVg9V3oHbWiTjgDKaOLAUpJbWY6V40VeJUcdJJdH6NQQ2r2a1suc56BMKzb4kY8=
X-Received: by 2002:a17:906:49:b0:953:2918:71e7 with SMTP id
 9-20020a170906004900b00953291871e7mr10405245ejg.5.1685878262158; Sun, 04 Jun
 2023 04:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZHpPOzT0nm+vddPq@bhelgaas> <fda371a2-da84-c764-c809-2a361418b4ef@amd.com>
In-Reply-To: <fda371a2-da84-c764-c809-2a361418b4ef@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 13:30:48 +0200
Message-ID: <CAJZ5v0gzSitt2zm2fhwkg51ZRUd_1ZBVB8akiUK_cnr8wupFQA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 2, 2023 at 11:57 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/2/2023 3:21 PM, Bjorn Helgaas wrote:
> > [+cc Rafael, Len, linux-acpi]
> >
> > Hi Mario,
> >
> > On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
> >> ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
> >> after returning from s2idle. This is because the BIOS checks whether the
> >> OSPM has called the _REG method to determine whether it can interact with
> >> the OperationRegion assigned to the device.
> > "s2idle" is a Linux term; I'd prefer something that we can relate to
> > the ACPI spec.
> It's important for the symptoms of this issue though, this
> problem doesn't trigger "just" by moving D-states.
>
> It happens as a result of system suspend.

As I said in my response to Bjorn, s2idle is D0 from the ACPI
standpoint.  It is not a system sleep and it has no special meaning in
ACPI.

The problem seems to be related to the low-power S0 idle _DSM calls to me.

> >
> > Maybe a pointer to the specific function in the driver that has a
> > problem?  Based on the patch, I assume the driver uses some control
> > method that looks at PCI config space?
>
> The issue isn't in anything Linux code "does"; it's in the "lack"
> of Linux code doing what it needs to IE using _REG.

So the argument seems to be that under certain conditions the PCI
config space becomes unavailable and so _REG(dev, 0) needs to be
called when this is about to happen and _REG(dev, 1) needs to be
called when the config space becomes available again.  Fair enough,
but I'm not sure why this is limited to system suspend and resume.

Moreover, "PCI_Config operation regions on a PCI root bus containing a
_BBN object" are specifically mentioned as one of the cases when _REG
need not be evaluated at all.  I guess the operation region in
question doesn't fall into that category?

> At least for this issue _REG is treated like a lock mechanism.
> In the spec it says specifically:
>
> "When an operation region handler is unavailable, AML cannot access
> data fields in that region".
>
> That is it's to ensure that OSPM and AML don't both simultaneously
> access the same region.
>
> What happens is that AML normally wants to access this region during
> suspend, but without the sequence of calling _REG it can't.

Is this about being unable to access the opregion or racing with
concurrent accesses on the OS side?

> >
> >> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> >> state of PCI devices.
> > Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
> > changed in the past and may change in the future, but the name/section
> > number will not.
> Sure.
> >
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/pci.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index e38c2f6eebd4..071ecba548b0 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >>      return acpi_pci_bridge_d3(dev);
> >>   }
> >>
> >> +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
> >> +{
> >> +    return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> >> +                             ACPI_ADR_SPACE_PCI_CONFIG, c);
> >> +}
> > You never check the return value, so why return it?
>
> _REG isn't mandatory for any of these uses, and I wanted to make
> sure that if it does end up being mandatory in a future use that
> the return code wasn't thrown away.  If you think it's better to
> just throw it away now, I have no qualms making it a void instead.

I don't think it can reasonably become mandatory without adding a
specific _OSC bit for that.

> >
> > The function actually doesn't *toggle*; it connects or disconnects
> > based on "c".
> Can you suggest a better function name?
> >
> > This looks like it only builds when CONFIG_ACPI=y?
>
> The prototype for acpi_evaluate_reg isn't guarded by CONFIG_ACPI
> so I figured it worked both ways.
>
> But looking again I don't see a dummy implementation version for
> the lack of CONFIG_ACPI, so I'll double check it.
>
> >
> >>   /**
> >>    * pci_update_current_state - Read power state of given device and cache it
> >>    * @dev: PCI device to handle.
> >> @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
> >>   int pci_save_state(struct pci_dev *dev)
> >>   {
> >>      int i;
> >> +
> >> +    platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
> > I would expect these to be in the PM code near the power state
> > transitions, not in the state save/restore code.  These functions
> > *are* used during suspend/resume, but are used in other places as
> > well, where we probably don't want _REG executed.
> >
> > Cc'd Rafael and PM folks, who can give much better feedback.
> My knee jerk reaction when we found the root cause for this issue
> was to put the code right around the D-state transitions, but I
> decided against this.
>
> I put it in save/restore intentionally because
> like I mentioned above it's treated like a locking mechanism between
> OSPM and AML and it's not functionally tied to a D-state transition.
>
> When the state is saved it's like Linux says
> "I'm done using this region, go ahead and touch it firmware".
> When it's restored it's like Linux says
> "Don't use that region, I'm claiming it for now".

So it looks like you want to use _REG for protecting PCI config space
against concurrent accesses from AML and the OS.

> Think about that other patch I wrote recently that controls D3
> availability [1].  If it was only run in the D-state transitions and
> the root port stays in D0 but has a _REG method it would never get
> called.

And why should it be evaluated in that case?
