Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7162E277
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiKQRCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 12:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiKQRBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 12:01:40 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF013D7C;
        Thu, 17 Nov 2022 09:01:38 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id w9so1448337qtv.13;
        Thu, 17 Nov 2022 09:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEjWIgqPE/yKlPIeL7hLLjyszxImNDx6l7dN1ULUouw=;
        b=68dioufqfYzeZs9hYidmzgIsupDXLXh2hmh7ttOlCuMh1EOtqt+IXfNnObKvLtAXJi
         ijrObU11ynwDV8piLBNvjm7BvIfIZVadSyTwd1D9c59f/ptrDcY+fPCyulyVuR44pjIZ
         g/kJMAbOdfGGK9vevuKCo2QJUAg45JCTnCWvlki5P9yuZNNXXtALxmGOCP8SEJ0Q1Ipy
         amBRCDPRsyNAW2clYki0liOlMNxxeq9Muqh3AEPcG2hEXqYqATSUTYxtUBY0r5I4P2/r
         GsizXjoUjPfw95FNkxxe6rXt6WKcrm1kGyHWJiW5tLS/23nl6Wmh8ZIo4GL5ml+90NuG
         ckUA==
X-Gm-Message-State: ANoB5pnibBC6rJNPm5saSSW0zi1Fa+ZpDUP6YbzSu10j8Gl6clHYoqfu
        uztGBvQdaEmhkU20i1UWDXe4nsIFzrCkIAq9Ln+Pzq7xwd8=
X-Google-Smtp-Source: AA0mqf7AjKqeg9aRlzDQRBfLrcfNHveVnQifmnWAJ7dkBHXEsFgAgRqi4jRRJurjMN2uVvjLbLSCQTT5veY6S3Iith0=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr3109964qtc.48.1668704497796; Thu, 17 Nov
 2022 09:01:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gyVq0AOM1_kd3QWHj+jihL-vxBv=fcEJ_Zcp8QiOymcg@mail.gmail.com>
 <20221116232838.GA1140883@bhelgaas>
In-Reply-To: <20221116232838.GA1140883@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Nov 2022 18:01:26 +0100
Message-ID: <CAJZ5v0gX_ZEM60_4V-vn+uP+QqPEewwkpk8-PpnY28bUHgdFPw@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > >
> > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > D3 if power managed by ACPI").
> > > > > > > >
> > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > device contains power resources.
> > > > >
> > > > > Wait.  Is this as simple as just recognizing that:
> > > > >
> > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > >   to use _S0W to learn the device's ability to wake itself.
> > > >
> > > > It is.
> > >
> > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > web page [1] says it identifies Root Ports capable of handling hot
> > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > says "I can wake myself from D3hot and D3cold", how is that different
> > > from "I can handle hotplug events in D3"?
> >
> > For native PME/hot-plug signaling there is no difference.  This is the
> > same interrupt by the spec after all IIRC.
> >
> > For GPE-based signaling, though, there is a difference, because GPEs
> > can only be used directly for wake signaling (this is related to
> > _PRW).  In particular, the only provision in the ACPI spec for device
> > hot-add are the Bus Check and Device Check notification values (0 and
> > 1) which require AML to run and evaluate Notify() on specific AML
> > objects.
> >
> > Hence, there is no spec-defined way to tell the OS that "something can
> > be hot-added under this device while in D3 and you will get notified
> > about that".
>
> So I guess acpi_pci_bridge_d3() looks for:
>
>   - "wake signaling while in D3" (_S0W) and
>   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
>
> For Root Ports with both those abilities (or bridges below such Root
> Ports), we allow D3, and this patch doesn't change that.
>
> What this patch *does* change is that all bridges with _PS0 or _PR0
> previously could use D3, but now will only be able to use D3 if they
> are also (or are below) a Root Port that can signal wakeup
> (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
>
> And this fixes the Pink Sardine because it has Root Ports that do
> Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> they cannot wake from D3.  Previously we put those in D3, but they
> couldn't wake up.  Now we won't put them in D3.
>
> I guess there's a possibility that this could break or cause higher
> power consumption on systems that were fixed by c6e331312ebf
> ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> I don't know enough about that scenario.  Maybe Lukas will chime in.

Well, it is possible that some of these systems will be affected.

One of such cases is when the port in question has _S0W which says
that wakeup from D3 is not supported.  In that case I think the kernel
should honor the _S0W input, because there may be a good reason known
to the platform integrator for it.

The other case is when wakeup.flags.valid is unset for the port's ACPI
companion which means that the port cannot signal wakeup through
ACPI-related means at all and this may be problematic, especially in
the system-wide suspend case in which the wakeup capability is not too
relevant unless there is a system wakeup device under the port.

I don't think that the adev->wakeup.flags.valid check has any bearing
on the _S0W check - if there is _S0W and it says "no wakeup from D3",
it should still be taken into account - so that check can be moved
past the _S0W check.

Now, for compatibility with systems where ports have neither _S0W nor
the HotPlugSupportInD3 property, the acpi_pci_power_manageable()
return value should determine the outcome regardless of the
adev->wakeup.flags.valid value, so the latter should only determine
whether or not the HotPlugSupportInD3 property will be inspected
(which may cause true to be returned before the "power manageable"
check).

IOW, something like this (after checking _S0W):

if (adev->wakeup.flags.valid &&
    !acpi_dev_get_property(adev, "HotPlugSupportInD3",
ACPI_TYPE_INTEGER, &obj) &&
    obj->integer.value == 1)
        return true;

return acpi_pci_power_manageable(dev);

Where the if () condition basically means that wakeup signaling is
supported (and there is no indication that it cannot be done from D3
as per the previous _S0W check) and hotplug signaling from D3 is
supported.

> > > This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> > > don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> > > previously the fact that we checked for "HotPlugSupportInD3" meant the
> > > device did NOT have _PS0 or _PR0.
> > >
> > > [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
