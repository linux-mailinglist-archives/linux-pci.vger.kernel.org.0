Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C60285BD7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 11:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJGJ3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgJGJ3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 05:29:08 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2FC061755;
        Wed,  7 Oct 2020 02:29:08 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b19so753596qvm.6;
        Wed, 07 Oct 2020 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iIERLImq3Ms+i5LiMOyJ3F9czPCYG4xQAXJ9DbFoH5E=;
        b=evV78oLrcGUrSNDUhBQASQObx3m6BUV2wczvYUY2UnCGGsnjeLd1fuPp7om9vtXNZx
         UkOZy0NEBUNyvL5eD2WLsVJa/3lmTY4//rnqF6LfbUDSeqEF56XMupS3YAZ7TWRFOE9a
         oDAaGoN+1VGUa6xb3zIECLcSC7cYdYxEEQ/457mbMMy1uqILYSi/NZQ+uGNFJJSwgGbL
         t5XI2L3J3+BvDtwLIFRKqK3IRRXBhiJN9LY4JgtsFUXDJMPc3LQB4/hvCGdVMquF0vg8
         Z31NCnREbREtggOMx4bqFvunPidNyI+y2rBClQdCz1DPQ5qTwWdpxEM5j68afGQkwKfj
         QUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iIERLImq3Ms+i5LiMOyJ3F9czPCYG4xQAXJ9DbFoH5E=;
        b=nbz7VsIBYoDCbiaGM380kalwHrncQXhSsaMnhaTuY84o7p4jdiYNYyqUoYHqcNMNTk
         DEOSI8S3RZGNpmW0rnYBcuVEenyYp8jZoQ6s/fnI+i1kXAyxx6Vgs1B16tuljSXzxd91
         TTS9x9ANTuUATYxdNjsOu1B6DGFunJM1UAdeAyiqPXjqmNyaVG/UeIj4GEbirXNLoo9h
         dvlaHzkkkzZnzBqePoNCNnCiY6DJ8+hvKSK0ehaNd+1xkYYYSTsDrqOIxJUtJwo6dovj
         mS+3AGkmksAfLXYV6yk/biOeiFZJ82JcoTFy6NR1OnROQ94zm84Khc0+YH64UAYIJy8q
         1dUQ==
X-Gm-Message-State: AOAM530QSPwNfn6P1EtcNfLmt0FfpakN5/k+cDLb/8hwK2Okq08V/h/t
        jrEDK3onikSStSDmHC5QpYYxEYmExjtM9or+Djs=
X-Google-Smtp-Source: ABdhPJy8cxnNRxciLOC9lRq0WKEB5808UHlR18+bFC3W1JJmH30PbCI/bQSAB/DyF60j4FFUu6OY5L2eacMcsqTWzOw=
X-Received: by 2002:a05:6214:a52:: with SMTP id ee18mr2249334qvb.39.1602062947315;
 Wed, 07 Oct 2020 02:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201005191930.GA3031652@bjorn-Precision-5520> <902912C5-FEE0-488A-8017-9A59B0398BD1@canonical.com>
In-Reply-To: <902912C5-FEE0-488A-8017-9A59B0398BD1@canonical.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 7 Oct 2020 11:28:56 +0200
Message-ID: <CAA85sZvE9OCYc4HW1NnoE3BvjFj7-vh5Xb1fTPSK-yXdjkRnwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 6:26 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Ian, who's also working on an ASPM issue]
> >
> > On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
> >>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
> >>>> BIOS may not be able to program ASPM for links behind VMD, prevent I=
ntel
> >>>> SoC from entering deeper power saving state.
> >>>
> >>> It's not a question of BIOS not being *able* to configure ASPM.  I
> >>> think BIOS could do it, at least in principle, if it had a driver for
> >>> VMD.  Actually, it probably *does* include some sort of VMD code
> >>> because it sounds like BIOS can assign some Root Ports to appear
> >>> either as regular Root Ports or behind the VMD.
> >>>
> >>> Since this issue is directly related to the unusual VMD topology, I
> >>> think it would be worth a quick recap here.  Maybe something like:
> >>>
> >>> VMD is a Root Complex Integrated Endpoint that acts as a host bridge
> >>> to a secondary PCIe domain.  BIOS can reassign one or more Root
> >>> Ports to appear within a VMD domain instead of the primary domain.
> >>>
> >>> However, BIOS may not enable ASPM for the hierarchies behind a VMD,
> >>> ...
> >>>
> >>> (This is based on the commit log from 185a383ada2e ("x86/PCI: Add
> >>> driver for Intel Volume Management Device (VMD)")).
> >>
> >> Ok, will just copy the portion as-is if there's patch v2 :)
> >>
> >>> But we still have the problem that CONFIG_PCIEASPM_DEFAULT=3Dy means
> >>> "use the BIOS defaults", and this patch would make it so we use the
> >>> BIOS defaults *except* for things behind VMD.
> >>>
> >>> - Why should VMD be a special case?
> >>
> >> Because BIOS doesn't handle ASPM for it so it's up to software to do
> >> the job.  In the meantime we want other devices still use the BIOS
> >> defaults to not introduce any regression.
> >>
> >>> - How would we document such a special case?
> >>
> >> I wonder whether other devices that add PCIe domain have the same
> >> behavior?  Maybe it's not a special case at all...
> >
> > What other devices are these?
>
> Controllers which add PCIe domain.
>
> >
> >> I understand the end goal is to keep consistency for the entire ASPM
> >> logic. However I can't think of any possible solution right now.
> >>
> >>> - If we built with CONFIG_PCIEASPM_POWERSAVE=3Dy, would that solve th=
e
> >>>   SoC power state problem?
> >>
> >> Yes.
> >>
> >>> - What issues would CONFIG_PCIEASPM_POWERSAVE=3Dy introduce?
> >>
> >> This will break many systems, at least for the 1st Gen Ryzen
> >> desktops and laptops.
> >>
> >> All PCIe ASPM are not enabled by BIOS, and those systems immediately
> >> freeze once ASPM is enabled.
> >
> > That indicates a defect in the Linux ASPM code.  We should fix that.
> > It should be safe to use CONFIG_PCIEASPM_POWERSAVE=3Dy on every system.
>
> On those systems ASPM are also not enabled on Windows. So I think ASPM ar=
e disabled for a reason.
>
> >
> > Are there bug reports for these? The info we would need to start with
> > includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=3Dy).
> > If a console log with CONFIG_PCIEASPM_POWERSAVE=3Dy is available, that
> > might be interesting, too.  We'll likely need to add some
> > instrumentation and do some experimentation, but in principle, this
> > should be fixable.
>
> Doing this is asking users to use hardware settings that ODM/OEM never te=
sted, and I think the risk is really high.

They have to test it to comply with pcie specs? and what we're
currently doing is wrong...

This fixes the L1 behaviour in the kernel, could you test it?

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..893b37669087 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
                    (link->latency_dw.l0s > acceptable->l0s))
                        link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+
                /*
                 * Check L1 latency.
-                * Every switch on the path to root complex need 1
-                * more microsecond for L1. Spec doesn't mention L0s.
+                *
+                * PCIe r5.0, sec 5.4.1.2.2 states:
+                * A Switch is required to initiate an L1 exit transition o=
n its
+                * Upstream Port Link after no more than 1 =CE=BCs from the
beginning of an
+                * L1 exit transition on any of its Downstream Port Links.
                 *
                 * The exit latencies for L1 substates are not advertised
                 * by a device.  Since the spec also doesn't mention a way
@@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                 * L1 exit latencies advertised by a device include L1
                 * substate latencies (and hence do not do any check).
                 */
-               latency =3D max_t(u32, link->latency_up.l1, link->latency_d=
w.l1);
-               if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
-                       link->aspm_capable &=3D ~ASPM_STATE_L1;
-               l1_switch_latency +=3D 1000;
+               if (link->aspm_capable & ASPM_STATE_L1) {
+                       latency =3D max_t(u32, link->latency_up.l1,
link->latency_dw.l1);
+                       l1_max_latency =3D max_t(u32, latency, l1_max_laten=
cy);
+                       if (l1_max_latency + l1_switch_latency > acceptable=
->l1)
+                               link->aspm_capable &=3D ~ASPM_STATE_L1;
+
+                       l1_switch_latency +=3D 1000;
+               }

                link =3D link->parent;
        }
---

If it doesn't you could also look at the following L0s patch

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 893b37669087..15d64832a988 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_latency_up =3D 0, l0s_latency_dw =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+                       l0s_latency_up +=3D link->latency_up.l0s;
+                       if (l0s_latency_up > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               }

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+                       l0s_latency_dw +=3D link->latency_dw.l0s;
+                       if (l0s_latency_dw > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               }

                /*
                 * Check L1 latency.
---

I can send them directly as well if you prefer (i hope the client
doesn't mangle them)

> Kai-Heng
>
> >
> > Bjorn
>
