Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66323A258
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHCJyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCJyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 05:54:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A621EC06174A
        for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2020 02:54:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so34606416qka.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2020 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bjBagwegXHh5fQ8tdHtVNNfKsaijhhOVJfYUZBTtEvQ=;
        b=kuIl1Pb5GLi3Rsu7KJ07ztRYdkFPTfjgYiMwjuyWRORjM+fCohqsYpknYfQ7djXE3P
         1Kcp6IlMS5qDgZvv/rPBMrpzfMJOHk7wWjivoNDmVSByp2nJDDokL4oXbTwIbl506ygL
         DjuTHvPISSdnlv0PSPbt9EGJUjYEDy3wP4XqOJJi8CEqekr1Nh8WfhQtahuDYak3BZR+
         zJMmjlaE/LUj50pkYhbLh0peQhMb+GecIbaaHvzoUcDXvmul1g3mwa/BoQ9DsUoehD8v
         ERU7nx+g4RqTLv9ZQmCfQWYT9y2GE5f+rLtu7rKfZO2JNDCGgzICN80/vqt0chk63CA9
         KZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bjBagwegXHh5fQ8tdHtVNNfKsaijhhOVJfYUZBTtEvQ=;
        b=QCnzRMcsZShzNEuO/a15DLUYoamPPiiblIy7zkukEC+gPt7nZOGDfOfquYrmJoidR6
         ohK3LA8DrHjzkE6p7tFYJD8WK1pp+igz+DZOMfJZ1JDwtBwjTEfW4+l9BINsBsWxS51s
         ud816vqZ34j1K2xPaWMPmTCjNBpMJS3CkT3SjDddS91R6TzcVPNyFn+qQnrQG/nRIMt4
         qeQYBm/OXZAZRRQZ020sL8QVNwOzAO42PLor1rGh5ycUWQ8DDXi/AQRIVDjW49Hg3bB4
         +AXQGWBWf+kHSUfunZo+lAGA00gs8l0Qyfi2miEESlsreyWJ/TzUjXf4SvIJM01hTfu2
         8axg==
X-Gm-Message-State: AOAM530AKLgh1WBrVs3I/6rAV2X7ti5b6jBesLs0X3ipmCQHlH35pWkp
        /DFWCNggbbuwOU0nMQwo/fgpnx61INHZX+/T02A=
X-Google-Smtp-Source: ABdhPJxUmYPIF/UklTtlNcsIP/0TLWcNYYdNt7enTg49rGSRGHnfwb0nazAQQqGG9ib3aKJgKZFgmz0rnW+UCL8SmXA=
X-Received: by 2002:a37:a45:: with SMTP id 66mr15758899qkk.435.1596448483472;
 Mon, 03 Aug 2020 02:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
 <20200729224710.GA1971834@bjorn-Precision-5520> <CAA85sZt7xHJc85Ok8j2QDmB-E_r-ch5kBKqYeUe1KnA6Gt-iDw@mail.gmail.com>
 <CAA85sZvL4_mR=w2MU7JUx5eksnCt1yBZD=jbhAMoMVz38OJ5aA@mail.gmail.com>
 <CAA85sZuQchm20C4v9V+TnOx+GZ4DJ13jX4g7fPdDB0QJN2Ot=A@mail.gmail.com> <CAA85sZvMfQciCtUqQfqLEDiR0xVcAFLyfrXRHM1xKn3mf8XyEw@mail.gmail.com>
In-Reply-To: <CAA85sZvMfQciCtUqQfqLEDiR0xVcAFLyfrXRHM1xKn3mf8XyEw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 3 Aug 2020 11:54:32 +0200
Message-ID: <CAA85sZuZzX55jPr7K+pgOaQof9FGv=2CDE4zSvg-zL6czxJuoQ@mail.gmail.com>
Subject: Re: [RFC] ASPM L1 link latencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 3, 2020 at 11:44 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Thu, Jul 30, 2020 at 1:26 AM Ian Kumlien <ian.kumlien@gmail.com> wrote=
:
> >
> > On Thu, Jul 30, 2020 at 1:12 AM Ian Kumlien <ian.kumlien@gmail.com> wro=
te:
> > >
> > > On Thu, Jul 30, 2020 at 1:02 AM Ian Kumlien <ian.kumlien@gmail.com> w=
rote:
> > > > On Thu, Jul 30, 2020 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> > > > > On Sat, Jul 25, 2020 at 09:47:05PM +0200, Ian Kumlien wrote:
> > > > > > Hi,
> > > > > >
> > > > > > A while ago I realised that I was having all kinds off issues w=
ith my
> > > > > > connection, ~933 mbit had become ~40 mbit
> > > > > >
> > > > > > This only applied on links to the internet (via a linux fw runn=
ing
> > > > > > NAT) however while debugging with the help of Alexander Duyck
> > > > > > we realised that ASPM could be the culprit (at least disabling =
ASPM on
> > > > > > the nic it self made things work just fine)...
> > > > > >
> > > > > > So while trying to understand PCIe and such things, I found thi=
s:
> > > > > >
> > > > > > The calculations of the max delay looked at "that node" + start=
 latency * "hops"
> > > > > >
> > > > > > But one hop might have a larger latency and break the acceptabl=
e delay...
> > > > > >
> > > > > > So after a lot playing around with the code, i ended up with th=
is, and
> > > > > > it seems to fix my problem and does
> > > > > > set two pcie bridges to ASPM Disabled that didn't happen before=
.
> > > > > >
> > > > > > I do however have questions.... Shouldn't the change be applied=
 to
> > > > > > the endpoint?  Or should it be applied recursively along the pa=
th to
> > > > > > the endpoint?
> > > > >
> > > > > I don't understand this very well, but I think we do need to cons=
ider
> > > > > the latencies along the entire path.  PCIe r5.0, sec 5.4.1.3, con=
tains
> > > > > this:
> > > > >
> > > > >   Power management software, using the latency information report=
ed by
> > > > >   all components in the Hierarchy, can enable the appropriate lev=
el of
> > > > >   ASPM by comparing exit latency for each given path from Root to
> > > > >   Endpoint against the acceptable latency that each corresponding
> > > > >   Endpoint can withstand.
> > > >
> > > > One of the questions is this:
> > > > They say from root to endpoint while we walk from endpoint to root
> > > >
> > > > So, is that more optimal in some way? or should latencies always be
> > > > considered from root to endpoint?
> > > > In that case, should the link ASPM be disabled somewhere else?
> > > > (I tried to disable them on the "endpoint" and it didn't help for s=
ome reason)
> > > >
> > > > > Also this:
> > > >
> > > > [--8<--]
> > > >
> > > > >   - For each component with one or more Endpoint Functions, PCI
> > > > >     Express system software examines the Endpoint L0s/L1 Acceptab=
le
> > > > >     Latency, as reported by each Endpoint Function in its Link
> > > > >     Capabilities register, and enables or disables L0s/L1 entry (=
via
> > > > >     the ASPM Control field in the Link Control register) accordin=
gly
> > > > >     in some or all of the intervening device Ports on that hierar=
chy.
> > > >
> > > > > > Also, the L0S checks are only done on the local links, is this
> > > > > > correct?
> > > > >
> > > > > ASPM configuration is done on both ends of a link.  I'm not sure =
it
> > > > > makes sense to enable any state (L0s, L1, L1.1, L1.2) unless both=
 ends
> > > > > of the link support it.  In particular, sec 5.4.1.3 says:
> > > > >
> > > > >   Software must not enable L0s in either direction on a given Lin=
k
> > > > >   unless components on both sides of the Link each support L0s;
> > > > >   otherwise, the result is undefined.
> > > > >
> > > > > But I think we do need to consider the entire path when enabling =
L0s;
> > > > > from sec 7.5.3.3:
> > > > >
> > > > >   Endpoint L0s Acceptable Latency - This field indicates the
> > > > >   acceptable total latency that an Endpoint can withstand due to =
the
> > > > >   transition from L0s state to the L0 state. It is essentially an
> > > > >   indirect measure of the Endpoint=E2=80=99s internal buffering. =
 Power
> > > > >   management software uses the reported L0s Acceptable Latency nu=
mber
> > > > >   to compare against the L0s exit latencies reported by all compo=
nents
> > > > >   comprising the data path from this Endpoint to the Root Complex=
 Root
> > > > >   Port to determine whether ASPM L0s entry can be used with no lo=
ss of
> > > > >   performance.
> > > > >
> > > > > Does any of that help answer your question?
> > > >
> > > > Yes! It's exactly what I wanted to know, :)
> > > >
> > > > So now the question is should I group the fixes into one patch or
> > > > separate them for easier bisecting?
> > >
> > > Actually this raises a few questions...
> > >
> > > It does sound like this is sum(link->latency_up.l0s) +
> > > sum(link->latency_dw.l0s) of the link vs acceptable->l0s
> > >
> > > But, would that mean that we walk the link backwards? so it's both si=
des?
> > >
> > > Currently they are separated - and they are not diaabled as a whole..=
.
> > >
> > > How should we handle the difference between up and down to keep the
> > > finer grained control we have?
> >
> > so, this:
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd53fba7f382..18b659e6d3e8 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> > +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
> > +               l0s_max_latency =3D 0;
> >         struct aspm_latency *acceptable;
> >         struct pcie_link_state *link;
> >
> > @@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
> > pci_dev *endpoint)
> >
> >         while (link) {
> >                 /* Check upstream direction L0s latency */
> > -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > -                   (link->latency_up.l0s > acceptable->l0s))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> > +               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > +                       l0s_max_latency +=3D link->latency_up.l0s;
> > +                       if (l0s_max_latency > acceptable->l0s)
> > +                               link->aspm_capable &=3D ~ASPM_STATE_L0S=
_UP;
> > +               }
> >
> >                 /* Check downstream direction L0s latency */
> > -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > -                   (link->latency_dw.l0s > acceptable->l0s))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > +               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> > +                       l0s_max_latency +=3D link->latency_dw.l0s;
> > +                       if (l0s_max_latency > acceptable->l0s)
> > +                               link->aspm_capable &=3D ~ASPM_STATE_L0S=
_DW;
> > +               }
> >                 /*
> >                  * Check L1 latency.
> >                  * Every switch on the path to root complex need 1
> >
> > --- vs ----
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd53fba7f382..74dee09e788b 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> > +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
> > +               l0s_max_latency =3D 0;
> >         struct aspm_latency *acceptable;
> >         struct pcie_link_state *link;
> >
> > @@ -448,14 +449,17 @@ static void pcie_aspm_check_latency(struct
> > pci_dev *endpoint)
> >
> >         while (link) {
> >                 /* Check upstream direction L0s latency */
> > -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > -                   (link->latency_up.l0s > acceptable->l0s))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> > +               if (link->aspm_capable & ASPM_STATE_L0S_UP)
> > +                       l0s_max_latency +=3D link->latency_up.l0s;
> >
> >                 /* Check downstream direction L0s latency */
> > -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > -                   (link->latency_dw.l0s > acceptable->l0s))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > +               if (link->aspm_capable & ASPM_STATE_L0S_DW)
> > +                       l0s_max_latency +=3D link->latency_dw.l0s;
> > +
> > +               /* If the latency exceeds, disable both */
> > +               if (l0s_max_latency > acceptable->l0s)
> > +                       link->aspm_capable &=3D ~ASPM_STATE_L0S;
> > +
> >                 /*
> >                  * Check L1 latency.
> >                  * Every switch on the path to root complex need 1
> >
> > ----
> >
> > Currently we don't make a difference between them and I don't quite
> > understand the upstream and downstream terminology since it's a serial
> > bus ;)
>
> So, played around a bit on my old macbook pro (since it's a intel
> system with different controllers)
>
> I did one baseline on 5.8, one with the l1 patch applied and one with
> a variant of L0s applied.
>
> Did a lspci at each boot, and here is the results:
> diff -u lspci-base.txt lspci-l1.txt
> --- lspci-base.txt 2020-08-03 11:20:05.328814478 +0200
> +++ lspci-l1.txt 2020-08-03 11:31:38.997572430 +0200
> @@ -200,14 +200,13 @@
>
>  00:1a.0 USB controller: Intel Corporation 7 Series/C216 Chipset
> Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
>   Subsystem: Intel Corporation 7 Series/C216 Chipset Family USB
> Enhanced Host Controller
> - Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> + Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>   Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> - Latency: 0
>   Interrupt: pin A routed to IRQ 23
>   Region 0: Memory at a0a16c00 (32-bit, non-prefetchable) [size=3D1K]
>   Capabilities: [50] Power Management version 2
>   Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> - Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> + Status: D3 NoSoftRst- PME-Enable+ DSel=3D0 DScale=3D0 PME-
>   Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
>   Capabilities: [98] PCI Advanced Features
>   AFCap: TP+ FLR+
> @@ -722,7 +721,7 @@
>   DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 unlimited
>   ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> - LnkCtl: ASPM Disabled; Disabled- CommClk+
> + LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
>   ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x4 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> @@ -1088,7 +1087,7 @@
>   DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 unlimited
>   ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
> - LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> + LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>   ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x4 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt
> ---
>
> And:
> --- lspci-l1.txt 2020-08-03 11:31:38.997572430 +0200
> +++ lspci-l0s.txt 2020-08-03 11:37:54.875843204 +0200
> @@ -274,7 +274,7 @@
>   DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>   LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <512ns, L1 <16us
>   ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
> - LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> + LnkCtl: ASPM L0s Enabled; RCB 64 bytes, Disabled- CommClk+
>   ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
>   TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> @@ -455,7 +455,7 @@
>   DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <2us, L1 <64us
>   ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> - LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> + LnkCtl: ASPM L0s Enabled; RCB 64 bytes, Disabled- CommClk+
>   ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> @@ -517,7 +517,7 @@
>   DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <2us, L1 <64us
>   ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> - LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> + LnkCtl: ASPM L0s Enabled; RCB 64 bytes, Disabled- CommClk+
>   ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> @@ -721,7 +721,7 @@
>   DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 unlimited
>   ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> - LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
> + LnkCtl: ASPM Disabled; Disabled- CommClk+
>   ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x4 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> @@ -1087,7 +1087,7 @@
>   DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
>   LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 unlimited
>   ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
> - LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
> + LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>   ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>   LnkSta: Speed 2.5GT/s (ok), Width x4 (ok)
>   TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> ----
>
> The actual total path is now:
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..e16c5712bef0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency =3D 0;
> +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
> +               l0s_max_latency =3D 0, l0s_up =3D 0, l0s_dw =3D 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
>
> @@ -448,14 +449,19 @@ static void pcie_aspm_check_latency(struct
> pci_dev *endpoint)
>
>         while (link) {
>                 /* Check upstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -                   (link->latency_up.l0s > acceptable->l0s))
> -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> +               if (link->aspm_capable & ASPM_STATE_L0S_UP)
> +                       l0s_up =3D link->latency_up.l0s;
>
>                 /* Check downstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -                   (link->latency_dw.l0s > acceptable->l0s))
> -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> +               if (link->aspm_capable & ASPM_STATE_L0S_DW)
> +                       l0s_dw =3D link->latency_dw.l0s;
> +
> +               l0s_max_latency +=3D max_t(u32, l0s_up, l0s_dw);
> +
> +               /* If the latency exceeds, disable both */
> +               if (l0s_max_latency > acceptable->l0s)
> +                       link->aspm_capable &=3D ~ASPM_STATE_L0S;
> +
>                 /*
>                  * Check L1 latency.
>                  * Every switch on the path to root complex need 1
> @@ -469,9 +475,9 @@ static void pcie_aspm_check_latency(struct pci_dev
> *endpoint)
>                  * L1 exit latencies advertised by a device include L1
>                  * substate latencies (and hence do not do any check).
>                  */
> -               latency =3D max_t(u32, link->latency_up.l1, link->latency=
_dw.l1);
> +               l1_max_latency =3D max_t(u32, latency, l1_max_latency);
>                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> +                   (l1_max_latency + l1_switch_latency > acceptable->l1)=
)
>                         link->aspm_capable &=3D ~ASPM_STATE_L1;
>                 l1_switch_latency +=3D 1000;
> ---
>
> There is a lot that can be incorrect in this case, will try a
> different L0s path and see if it changes behaviour
>
> Info about the machine:
> lspci -t
> -[0000:00]-+-00.0
>            +-01.0-[01]--
>            +-01.1-[04-9a]----00.0-[05-6a]--+-00.0-[06]----00.0
>            |                               +-03.0-[07-37]--
>            |                               +-04.0-[38-68]--
>            |                               +-05.0-[69]--
>            |                               \-06.0-[6a]--
>            +-02.0
>            +-14.0
>            +-16.0
>            +-1a.0
>            +-1b.0
>            +-1c.0-[02]--+-00.0
>            |            \-00.1
>            +-1c.1-[03]----00.0
>            +-1d.0
>            +-1f.0
>            +-1f.2
>            \-1f.3

And sometimes your suspicions is confirmed...

diff -u lspci-l0s.txt lspci-l0s-fixed.txt
--- lspci-l0s.txt 2020-08-03 11:37:54.875843204 +0200
+++ lspci-l0s-fixed.txt 2020-08-03 11:52:01.522670482 +0200
@@ -105,10 +105,10 @@
  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
  LnkCap: Port #3, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency
L0s <256ns, L1 <8us
  ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
- LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
+ LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
  ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
  LnkSta: Speed 5GT/s (downgraded), Width x4 (downgraded)
- TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+ TrErr- Train+ SlotClk+ DLActive- BWMgmt+ ABWMgmt-
  SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
  Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
  SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
@@ -654,7 +654,7 @@
  DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
  LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency
L0s unlimited, L1 unlimited
  ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
- LnkCtl: ASPM Disabled; Disabled- CommClk+
+ LnkCtl: ASPM L1 Enabled; Disabled- CommClk+
  ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
  LnkSta: Speed 5GT/s (ok), Width x4 (ok)
  TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-

And patch is:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..d926929c6103 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_max_latency =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -447,15 +448,23 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
        acceptable =3D &link->acceptable[PCI_FUNC(endpoint->devfn)];

        while (link) {
-               /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
-
-               /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S) {
+                       u32 l0s_up =3D 0, l0s_dw =3D 0;
+                       /* Check upstream direction L0s latency */
+                       if (link->aspm_capable & ASPM_STATE_L0S_UP)
+                               l0s_up =3D link->latency_up.l0s;
+
+                       /* Check downstream direction L0s latency */
+                       if (link->aspm_capable & ASPM_STATE_L0S_DW)
+                               l0s_dw =3D link->latency_dw.l0s;
+
+                       l0s_max_latency +=3D max_t(u32, l0s_up, l0s_dw);
+
+                       /* If the latency exceeds, disable both */
+                       if (l0s_max_latency > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S;
+               }
+
                /*
                 * Check L1 latency.
                 * Every switch on the path to root complex need 1
@@ -469,9 +478,9 @@ static void pcie_aspm_check_latency(struct pci_dev
*endpoint)
                 * L1 exit latencies advertised by a device include L1
                 * substate latencies (and hence do not do any check).
                 */
-               latency =3D max_t(u32, link->latency_up.l1, link->latency_d=
w.l1);
+               l1_max_latency =3D max_t(u32, latency, l1_max_latency);
                if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
+                   (l1_max_latency + l1_switch_latency > acceptable->l1))
                        link->aspm_capable &=3D ~ASPM_STATE_L1;
                l1_switch_latency +=3D 1000;
----

Sorry about the noise
