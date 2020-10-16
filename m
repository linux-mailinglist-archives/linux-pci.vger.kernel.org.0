Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9A2907CB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409439AbgJPOyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409438AbgJPOyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 10:54:01 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905D8C061755
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 07:54:01 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id de3so1194853qvb.5
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uvPsbBCVgpEyNkXzeRH4ousRQR+UCCsXd9+M67vq/4c=;
        b=W1xCfTNPErnDJUuqjtcpEd8BcyqFu9nQ0YF4tws6/H5LnIp8KMf7iaIJE96YPFbzp+
         WPJYsMseEVDpv2EwRCTURkMrhZD3jXL6yyh1nHvatqZ35HjtdjWeGZJrh2v/LXq2XVpu
         mLwW0sMZDjhadQg91DJNgCoPGXOecZMeblRTEoSHGdU/CFWX6cBvMFTzRmx/ZqAm0kxM
         czhaKzPLP4R24+CX/4SydECGjbGwlQCjtKqt3OuTxIyN2WUSfzig/7wQjoUh0pEZqVGT
         XYww4Pe9i8uix52PrTG4ZCAfz5p/6hwTne8fAUygh4vFvvMQM6ApJmgiZmpGtLl6LQta
         nKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uvPsbBCVgpEyNkXzeRH4ousRQR+UCCsXd9+M67vq/4c=;
        b=EngF4TLDkifm7KqrvVjCFb5T2FR9bLJebuOtHPvgJEByWIYhEEkwUxdx5KI+NyboBV
         cX1nQdmPCYLC9nIpTnwH5u7lMlN30XphUWpMGrHCcx+tdWm0aF0BruL9JPReozwc1q6U
         nfScScJqNIswgSWQRt5E/deeq1CjydJAOG7uxm2Zq71IObpXhUtWfEagDml1j31SqONq
         ojIx6pqyrcUd4vKAID+pHSQgsMu8+MvPrAv0LIhIyu+v2fPKmlSMP8BQUl0B3kBv+NTE
         Fopl7SHWdU/MCIJFgR/fxKPUOYwzp4ZMH+Eon3vhpr/0achGSOAU885KbOnlCfrmyGie
         u2MQ==
X-Gm-Message-State: AOAM531kHiUh1Hv34JSV3rWmBYso8wB8w1JwAKo4JL6/tFMvicUkgyr3
        OGGMf2R/r8W+NCZ9MLwmVecBkGht4/J9EU65e+U=
X-Google-Smtp-Source: ABdhPJx/H6Qx0o6u7abrGdo/1C7eiYnCK7Tvi2/Kd6z9qm1z08cQkNZhl6lIUxWk12cM2veviEsiJ9fbCeLWhd3qKUs=
X-Received: by 2002:a0c:99c6:: with SMTP id y6mr4414917qve.41.1602860040569;
 Fri, 16 Oct 2020 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
 <20201014143646.GA3946160@bjorn-Precision-5520> <CAA85sZuSAorUvLJ5KL6=OqpEgBuHc47hf3wdBX9u_pX9xpYCoQ@mail.gmail.com>
In-Reply-To: <CAA85sZuSAorUvLJ5KL6=OqpEgBuHc47hf3wdBX9u_pX9xpYCoQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 16 Oct 2020 16:53:49 +0200
Message-ID: <CAA85sZsEQV+YgZaW0WsW2M2Xuv6P0w=D+H3n7-dk-7JT3ip23g@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 5:39 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Wed, Oct 14, 2020 at 4:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:
> >
> > > I'm actually starting to think that reporting what we do with the
> > > latency bit could
> > > be beneficial - i.e. report which links have their L1 disabled due to
> > > which device...
> > >
> > > I also think that this could benefit debugging - I have no clue of ho=
w
> > > to read the lspci:s - I mean i do see some differences that might be
> > > the fix but nothing really specific without a proper message in
> > > dmesg....
> >
> > Yeah, might be worth doing.  Probably pci_dbg() since I think it would
> > be too chatty to be enabled all the time.
>
> OK, will look in to it =3D)

Just did some very basic hack, since i think it's much better to get
the information in dmesg than have to boot will full debug.

I assume that there is a niftier way to do it - but i wanted some
feedback basically...

My current output is:
dmesg |grep latency
[    0.817872] pci 0000:04:00.0: ASPM latency exceeded, disabling:
L1:0000:01:00.0-0000:00:01.2


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..5a5146f47aae 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       bool aspm_disable =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -446,6 +447,16 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
        link =3D endpoint->bus->self->link_state;
        acceptable =3D &link->acceptable[PCI_FUNC(endpoint->devfn)];

+#define aspm_info(device, type, down, up) \
+       if (!aspm_disable) \
+       { \
+               pr_cont("pci %s: ASPM latency exceeded, disabling: %s:%s-%s=
", \
+                       pci_name(device), type, pci_name(down), pci_name(up=
)); \
+               aspm_disable =3D 1; \
+       } \
+       else \
+                pr_cont(", %s:%s-%s", type, pci_name(down), pci_name(up));
+
        while (link) {
                /* Check upstream direction L0s latency */
                if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
@@ -456,10 +467,14 @@ static void pcie_aspm_check_latency(struct
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
@@ -469,14 +484,22 @@ static void pcie_aspm_check_latency(struct
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
+                       {
+                               aspm_info(endpoint, "L1",
link->downstream, link->pdev);
+                               link->aspm_capable &=3D ~ASPM_STATE_L1;
+                       }
+                       l1_switch_latency +=3D 1000;
+               }

                link =3D link->parent;
        }
+       if (aspm_disable)
+               pr_cont("\n");
+#undef aspm_info
 }

for L1 and L0s, which we haven't discussed that much yet:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5a5146f47aae..b01d393e742d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_latency_up =3D 0, l0s_latency_dw =3D 0;
        bool aspm_disable =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;
@@ -459,14 +460,24 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+                       l0s_latency_up +=3D link->latency_up.l0s;
+                       if (l0s_latency_up > acceptable->l0s)
+                       {
+                               aspm_info(endpoint, "L0s-up",
link->downstream, link->pdev);
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+                       }
+               }

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+                       l0s_latency_dw +=3D link->latency_dw.l0s;
+                       if (l0s_latency_dw > acceptable->l0s)
+                       {
+                               aspm_info(endpoint, "L0s-dw",
link->downstream, link->pdev);
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+                       }
+               }

                /*
                 * Check L1 latency.
