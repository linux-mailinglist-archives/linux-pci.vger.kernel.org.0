Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AF62FF36
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 22:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKRVNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 16:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRVNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 16:13:53 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD912D00;
        Fri, 18 Nov 2022 13:13:51 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id e15so3978804qts.1;
        Fri, 18 Nov 2022 13:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im9Cn2bVvvKaUdjTn6G7loRSPb2+5gZ1xm+k4nkrlTg=;
        b=g6OvNySY+MUGiXhS68lk8zHbOwpTFSn5B1GyGRkoIKogLsthr70fU7WRIcJB1Zn9m/
         kp5FEV91fSOVuHRo9BnsEKZwL+1qznwDjpm+qJRGKEj0Wt0SpP4d8BMCkVziIHXKwNtA
         5VO5BYmq8YMnPU4pohxkrOmWCSzJ1e/3MN05chn44NNu90xRjeFtY3w6nJpF6hZaTzYg
         RS6axAL6HnZFtYiRTqyXfd3FiQXFKMdZThIfkzP/rVKTJ6S3IR2YSbrCdCdepg2dugzB
         zyRhoX8rnj/17OXiONXMl68a4EHs2ONpBZ0SA2LcyKKzeH/q0jPjJDiVLCFwvxxJ0BUU
         BUQA==
X-Gm-Message-State: ANoB5plOkUcXa56XpfePXXHacW+G+uI1SiDXryUgZPjOgNAsxG4W9+wP
        8ISY3uoD9UfjP5May0QfPf/cwirRzJydJ5ee2fM=
X-Google-Smtp-Source: AA0mqf75tJmpvYnmRNNRXxLth4HQ/ihllc1egjsQV9c6i8wVwP8kU4jaOQCzebxxaBJ1TykRdBPwL1/IaKhgt/HvKV0=
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id
 i19-20020ac860d3000000b003a546785b24mr8291713qtm.411.1668806030966; Fri, 18
 Nov 2022 13:13:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0i3LyfMLx8cuYMdRzJagW-d0Vz3PBVEtFGpDBD6+7VZHQ@mail.gmail.com>
 <20221118202336.GA1271811@bhelgaas>
In-Reply-To: <20221118202336.GA1271811@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Nov 2022 22:13:39 +0100
Message-ID: <CAJZ5v0i8K4Uss4KgbzdRyocTKYu10eCCm8UZ=QtEFJ4_WZYciw@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 9:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Rafael,
>
> Sorry, I'm still confused (my perpetual state :)).

No worries, doing my best to address that.

> On Fri, Nov 18, 2022 at 02:16:17PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 17, 2022 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > > > > > >
> > > > > > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > > > > > D3 if power managed by ACPI").
> > > > > > > > > > > >
> > > > > > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > > > > > device contains power resources.
> > > > > > > > >
> > > > > > > > > Wait.  Is this as simple as just recognizing that:
> > > > > > > > >
> > > > > > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > > > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > > > > > >   to use _S0W to learn the device's ability to wake itself.
> > > > > > > >
> > > > > > > > It is.
> > > > > > >
> > > > > > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > > > > > web page [1] says it identifies Root Ports capable of handling hot
> > > > > > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > > > > > says "I can wake myself from D3hot and D3cold", how is that different
> > > > > > > from "I can handle hotplug events in D3"?
> > > > > >
> > > > > > For native PME/hot-plug signaling there is no difference.  This is the
> > > > > > same interrupt by the spec after all IIRC.
> > > > > >
> > > > > > For GPE-based signaling, though, there is a difference, because GPEs
> > > > > > can only be used directly for wake signaling (this is related to
> > > > > > _PRW).  In particular, the only provision in the ACPI spec for device
> > > > > > hot-add are the Bus Check and Device Check notification values (0 and
> > > > > > 1) which require AML to run and evaluate Notify() on specific AML
> > > > > > objects.
> > > > > >
> > > > > > Hence, there is no spec-defined way to tell the OS that "something can
> > > > > > be hot-added under this device while in D3 and you will get notified
> > > > > > about that".
> > > > >
> > > > > So I guess acpi_pci_bridge_d3() looks for:
> > > > >
> > > > >   - "wake signaling while in D3" (_S0W) and
> > > > >   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
> > > > >
> > > > > For Root Ports with both those abilities (or bridges below such Root
> > > > > Ports), we allow D3, and this patch doesn't change that.
> > > > >
> > > > > What this patch *does* change is that all bridges with _PS0 or _PR0
> > > > > previously could use D3, but now will only be able to use D3 if they
> > > > > are also (or are below) a Root Port that can signal wakeup
> > > > > (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
> > > > >
> > > > > And this fixes the Pink Sardine because it has Root Ports that do
> > > > > Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> > > > > they cannot wake from D3.  Previously we put those in D3, but they
> > > > > couldn't wake up.  Now we won't put them in D3.
> > > > >
> > > > > I guess there's a possibility that this could break or cause higher
> > > > > power consumption on systems that were fixed by c6e331312ebf
> > > > > ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> > > > > I don't know enough about that scenario.  Maybe Lukas will chime in.
> > > >
> > > > Well, it is possible that some of these systems will be affected.
> > > >
> > > > One of such cases is when the port in question has _S0W which says
> > > > that wakeup from D3 is not supported.  In that case I think the kernel
> > > > should honor the _S0W input, because there may be a good reason known
> > > > to the platform integrator for it.
> > > >
> > > > The other case is when wakeup.flags.valid is unset for the port's ACPI
> > > > companion which means that the port cannot signal wakeup through
> > > > ACPI-related means at all and this may be problematic, especially in
> > > > the system-wide suspend case in which the wakeup capability is not too
> > > > relevant unless there is a system wakeup device under the port.
> > > >
> > > > I don't think that the adev->wakeup.flags.valid check has any bearing
> > > > on the _S0W check - if there is _S0W and it says "no wakeup from D3",
> > > > it should still be taken into account - so that check can be moved
> > > > past the _S0W check.
> > >
> > > So if _S0W says it can wake from D3, but wakeup.flags is not valid,
> > > it's still OK to use D3?
> >
> > No, it isn't, as per the code today and I don't think that this
> > particular part should be changed now.
>
> But the current upstream code checks acpi_pci_power_manageable(dev)
> first, so if "dev" has _PR0 or _PS0, we'll use D3 even if _S0W says it
> can wake from D3 and wakeup.flags is not valid.

Yes, the current code will return 'true' if _PR0 or _PS0 is present
for dev regardless of anything else.

The proposed change is to make that conditional on whether or not _S0W
for the root port says that wakeup from D3 is supported (or it is not
present or unusable).

I see that I've missed one point now which is when the root port
doesn't have an ACPI companion, in which case we should go straight
for the "dev is power manageable" check.  Let me redo the patch to
address this.
