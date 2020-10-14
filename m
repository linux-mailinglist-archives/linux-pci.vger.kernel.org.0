Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B728E15F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgJNNdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgJNNdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 09:33:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEEC061755
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 06:33:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t9so2201396qtp.9
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qdoyyc0RschdoToCKzC40AnEfXtZYm5KkhCCVQ3+ROE=;
        b=GnCzAiKLQdQXENmWiqWnVNlewFHmjxY3lD5tn+Tu1k9mCM/UWu6zV/0sMUOQ/pheM6
         0BHZh3ExxfiVvZGtBTuAX0UjrjMpU1I9mI48LeTj9LPOAovu3MDi5AEI+V4BWDdSDTJG
         Y5UiSwT73UXNsZc8rB7yrof8/28Mz00HUCeMkASO0MjjheB0nYIC1IUZf7Az+S3vJQJP
         ury/RDEe0kMHJYVe4tMiriwaMF5Iiq4P4vhNUZdBpJFtrWM8k8G+Fcyp4zNmrNLJF3My
         10eUiebi/iYBYo6ZcCpoHlOiqfjwnQIcU93avvo8RidMWy6oeS4g1BQqmnaNsOrOe/HT
         cDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qdoyyc0RschdoToCKzC40AnEfXtZYm5KkhCCVQ3+ROE=;
        b=P1hpxrN5SJhr+wYTkxz4kAY/3Rdc5EAjM2P3Z7CoJSDwEt/RNqWNs4tJhlVfptlsxW
         yZZ+IWetFsnYM76AZio88TzEzfQPcNml5eL6wF5yi22ZWeWit8KJ1MKX4sefefelYGdl
         elKkdU/HHRt/cKjX/YKZG6GYbNlrWOL/tdA7vcxv4JRMl+6zm2dTw7CunWOr0Q82vfN4
         7B1EdX31ZjrdoXORojIJvbllCghr/iDU/aqLO46xbUMHFgaKlDn9IgGgt5e6s6xQAytj
         +U3++gLCEtmQ1C7m6f3C+WsdHV/DubGxJ7z/C2AM/pR/9XD1lsBQ7vNtuQqynx8yBpWo
         9y3g==
X-Gm-Message-State: AOAM5327F1trr8wUkLdg8ilh3IyTL+Rudoisfbw5/p92vpBQ5/k5EsBT
        KQAiu5epIVN2kcRt/NEDYiubrp9DpO+7S3TVo0upwzPm
X-Google-Smtp-Source: ABdhPJyQPFt0j3cYSSdAR+d0J84/5ns5/jKv0LKRfZHay2B+/0qDu3B4Fg2Yz+T8UnHD31kZlf2pYV7YfYJa0WZmscg=
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr1178670qtu.337.1602682408731;
 Wed, 14 Oct 2020 06:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201007132808.647589-1-ian.kumlien@gmail.com>
 <20201008161312.GA3261279@bjorn-Precision-5520> <CAA85sZsxLZ5m9SNe=5RD9oA7FV0mdwEvGqnXkdtbp_-e_6G5LQ@mail.gmail.com>
 <0AD07E1E-02D1-4208-B90F-1949C85ECB64@canonical.com>
In-Reply-To: <0AD07E1E-02D1-4208-B90F-1949C85ECB64@canonical.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 14 Oct 2020 15:33:17 +0200
Message-ID: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 10:34 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Oct 12, 2020, at 18:20, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> >>
> >> On Wed, Oct 07, 2020 at 03:28:08PM +0200, Ian Kumlien wrote:
> >>> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> >>> "5.4.1.2.2. Exit from the L1 State"
> >>>
> >>> Which makes it clear that each switch is required to initiate a
> >>> transition within 1=CE=BCs from receiving it, accumulating this laten=
cy and
> >>> then we have to wait for the slowest link along the path before
> >>> entering L0 state from L1.
> >>>
> >>> The current code doesn't take the maximum latency into account.
> >>>
> >>> From the example:
> >>>   +----------------+
> >>>   |                |
> >>>   |  Root complex  |
> >>>   |                |
> >>>   |    +-----+     |
> >>>   |    |32 =CE=BCs|     |
> >>>   +----------------+
> >>>           |
> >>>           |  Link 1
> >>>           |
> >>>   +----------------+
> >>>   |     |8 =CE=BCs|     |
> >>>   |     +----+     |
> >>>   |    Switch A    |
> >>>   |     +----+     |
> >>>   |     |8 =CE=BCs|     |
> >>>   +----------------+
> >>>           |
> >>>           |  Link 2
> >>>           |
> >>>   +----------------+
> >>>   |    |32 =CE=BCs|     |
> >>>   |    +-----+     |
> >>>   |    Switch B    |
> >>>   |    +-----+     |
> >>>   |    |32 =CE=BCs|     |
> >>>   +----------------+
> >>>           |
> >>>           |  Link 3
> >>>           |
> >>>   +----------------+
> >>>   |     |8=CE=BCs|      |
> >>>   |     +---+      |
> >>>   |   Endpoint C   |
> >>>   |                |
> >>>   |                |
> >>>   +----------------+
> >>>
> >>> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> >>> transition to L0 at time T. Since switch B takes 32 =CE=BCs to exit L=
1 on
> >>> it's ports, Link 3 will transition to L0 at T+32 (longest time
> >>> considering T+8 for endpoint C and T+32 for switch B).
> >>>
> >>> Switch B is required to initiate a transition from the L1 state on it=
's
> >>> upstream port after no more than 1 =CE=BCs from the beginning of the
> >>> transition from L1 state on the downstream port. Therefore, transitio=
n from
> >>> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
> >>>
> >>> The path will exit L1 at T+34.
> >>>
> >>> On my specific system:
> >>> lspci -PP -s 04:00.0
> >>> 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semi=
conductor Co., Ltd. Device 816e (rev 1a)
> >>>
> >>> lspci -vvv -s 04:00.0
> >>>              DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <=
512ns, L1 <64us
> >>> ...
> >>>              LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exi=
t Latency L0s unlimited, L1 <64us
> >>> ...
> >>>
> >>> Which means that it can't be followed by any switch that is in L1 sta=
te.
> >>>
> >>> This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.
> >>>
> >>>                                                    LnkCtl    LnkCtl
> >>>           ------DevCap-------  ----LnkCap-------  -Before-  -After--
> >>>  00:01.2                                L1 <32us       L1+       L1-
> >>>  01:00.0                                L1 <32us       L1+       L1-
> >>>  02:04.0                                L1 <32us       L1+       L1-
> >>>  04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-
> >>
> >> OK, now we're getting close.  We just need to flesh out the
> >> justification.  We need:
> >>
> >>  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
> >>    and follow the example.
> >
> > Will do
> >
> >>  - Description of the problem.  I think it's poor bandwidth on your
> >>    Intel I211 device, but we don't have the complete picture because
> >>    that NIC is 03:00.0, which doesn't appear above at all.
> >
> > I think we'll use Kai-Hengs issue, since it's actually more related to
> > the change itself...
> >
> > Mine is a side effect while Kai-Heng is actually hitting an issue
> > caused by the bug.
>
> I filed a bug here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D209671

Thanks!

I'm actually starting to think that reporting what we do with the
latency bit could
be beneficial - i.e. report which links have their L1 disabled due to
which device...

I also think that this could benefit debugging - I have no clue of how
to read the lspci:s - I mean i do see some differences that might be
the fix but nothing really specific without a proper message in
dmesg....

Bj=C3=B6rn, what do you think?

> Kai-Heng
>
> >
> >>  - Explanation of what's wrong with the "before" ASPM configuration.
> >>    I want to identify what is wrong on your system.  The generic
> >>    "doesn't match spec" part is good, but step 1 is the specific
> >>    details, step 2 is the generalization to relate it to the spec.
> >>
> >>  - Complete "sudo lspci -vv" information for before and after the
> >>    patch below.  https://bugzilla.kernel.org/show_bug.cgi?id=3D208741
> >>    has some of this, but some of the lspci output appears to be
> >>    copy/pasted and lost all its formatting, and it's not clear how
> >>    some was collected (what kernel version, with/without patch, etc).
> >>    Since I'm asking for bugzilla attachments, there's no space
> >>    constraint, so just attach the complete unedited output for the
> >>    whole system.
> >>
> >>  - URL to the bugzilla.  Please open a new one with just the relevant
> >>    problem report ("NIC is slow") and attach (1) "before" lspci
> >>    output, (2) proposed patch, (3) "after" lspci output.  The
> >>    existing 208741 report is full of distractions and jumps to the
> >>    conclusion without actually starting with the details of the
> >>    problem.
> >>
> >> Some of this I would normally just do myself, but I can't get the
> >> lspci info.  It would be really nice if Kai-Heng could also add
> >> before/after lspci output from the system he tested.
> >>
> >>> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> >>> ---
> >>> drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
> >>> 1 file changed, 15 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >>> index 253c30cc1967..893b37669087 100644
> >>> --- a/drivers/pci/pcie/aspm.c
> >>> +++ b/drivers/pci/pcie/aspm.c
> >>> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pde=
v,
> >>>
> >>> static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >>> {
> >>> -     u32 latency, l1_switch_latency =3D 0;
> >>> +     u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> >>>      struct aspm_latency *acceptable;
> >>>      struct pcie_link_state *link;
> >>>
> >>> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_=
dev *endpoint)
> >>>              if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> >>>                  (link->latency_dw.l0s > acceptable->l0s))
> >>>                      link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> >>> +
> >>>              /*
> >>>               * Check L1 latency.
> >>> -              * Every switch on the path to root complex need 1
> >>> -              * more microsecond for L1. Spec doesn't mention L0s.
> >>> +              *
> >>> +              * PCIe r5.0, sec 5.4.1.2.2 states:
> >>> +              * A Switch is required to initiate an L1 exit transiti=
on on its
> >>> +              * Upstream Port Link after no more than 1 =CE=BCs from=
 the beginning of an
> >>> +              * L1 exit transition on any of its Downstream Port Lin=
ks.
> >>>               *
> >>>               * The exit latencies for L1 substates are not advertise=
d
> >>>               * by a device.  Since the spec also doesn't mention a w=
ay
> >>> @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_=
dev *endpoint)
> >>>               * L1 exit latencies advertised by a device include L1
> >>>               * substate latencies (and hence do not do any check).
> >>>               */
> >>> -             latency =3D max_t(u32, link->latency_up.l1, link->laten=
cy_dw.l1);
> >>> -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> >>> -                 (latency + l1_switch_latency > acceptable->l1))
> >>> -                     link->aspm_capable &=3D ~ASPM_STATE_L1;
> >>> -             l1_switch_latency +=3D 1000;
> >>> +             if (link->aspm_capable & ASPM_STATE_L1) {
> >>> +                     latency =3D max_t(u32, link->latency_up.l1, lin=
k->latency_dw.l1);
> >>> +                     l1_max_latency =3D max_t(u32, latency, l1_max_l=
atency);
> >>> +                     if (l1_max_latency + l1_switch_latency > accept=
able->l1)
> >>> +                             link->aspm_capable &=3D ~ASPM_STATE_L1;
> >>> +
> >>> +                     l1_switch_latency +=3D 1000;
> >>> +             }
> >>>
> >>>              link =3D link->parent;
> >>>      }
> >>> --
> >>> 2.28.0
> >>>
>
