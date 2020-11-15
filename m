Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3B2B39BB
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 22:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKOVuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 16:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKOVuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 16:50:22 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85661C0613CF
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 13:49:49 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id r12so7724231qvq.13
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xgDvfaZxWB3gDa6Y5ugVMBlYgQ1l33gLyTmQE7ydMns=;
        b=sikh53ZzTERa2a0xVKmYIbi1AtCPt88liZ1wIjS7okAdaqJ34rcirh3cCx2r67qAWL
         dRhWugOgrUkDAZN1CT1O4BE5xwJemI7tyI2xpDOZ7oyW3pSLZAllr8LlAYIxXpXDHO+P
         sajhFUYLkrP3FwjRQ9Sfm1unBK8fu2ASj5FFK41DouK3ogUZJVtY/9AZTR9QtehGwz7b
         Ons3xPwWQu9Z6ulH4J3B2C0yugaxn0ZA2jve/kPhi9BHb+irWC7WfiDEG/uSKIpF9WOJ
         1pQ+JsFmcYPT4QWObwVdy3vQzczhm12qRGKl6lwBWbqxB5tVpDQ+1dI/yDRMROhChr2f
         f1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xgDvfaZxWB3gDa6Y5ugVMBlYgQ1l33gLyTmQE7ydMns=;
        b=shhLpke3HfZvPZn0h5nr64YJQf0CR2/qAnKjTL+siewY0w1KOMbWy4HihpfOQtL5IA
         Ar8EJo1mkv8YBYmJF2dNnAlVgwYt35RmZBOyxjaLZPBHFE8ake1Kz0GTvyh4I0bJo8Yk
         OIyhvh8Gmqi9wrCOWmnbW1nMMhdgtoiq1BNIbYqUvSbeHCvJ64EaMsyU3c9lkL8J9x9A
         HhkxHKHuxWXg+Pxnp1flqy2DMDefrvXik6yHV1qLCq0pi0w+qqFSo3EFWKCWfRrL+Zys
         bQV0If/VAaXai10MESFlWDYefJbJzlI+tJ19T1vAPu16/9p0cxFPjl7Hnv88QeaMycQh
         93yQ==
X-Gm-Message-State: AOAM5338vJCYPFIJLH+vsJrqi2PR8ZQneGIbyoPka2monoUJ0OM5G3hA
        CDBYbbgVKZN88jZrqK8GyBY7EeCaUgKPLEfy1jQIyD0h
X-Google-Smtp-Source: ABdhPJzd6j2Km09WiwbNq7B756oaEyEIZ1/fYq17DyKeRHCbgc4EBHPCBX2119KSLWR9TZrifh3N4s5LWLMLppZmnkI=
X-Received: by 2002:a0c:e8c8:: with SMTP id m8mr12350261qvo.41.1605476988408;
 Sun, 15 Nov 2020 13:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20201022183030.GA513862@bjorn-Precision-5520> <20201024205548.1837770-1-ian.kumlien@gmail.com>
In-Reply-To: <20201024205548.1837770-1-ian.kumlien@gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 15 Nov 2020 22:49:37 +0100
Message-ID: <CAA85sZs_9hUFU233qBeZenyheBaLyhjGFCm+zFHgEseL=JuC3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Is this ok? Or what's missing?

On Sat, Oct 24, 2020 at 10:55 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> "5.4.1.2.2. Exit from the L1 State"
>
> Which makes it clear that each switch is required to initiate a
> transition within 1=CE=BCs from receiving it, accumulating this latency a=
nd
> then we have to wait for the slowest link along the path before
> entering L0 state from L1.
>
> The current code doesn't take the maximum latency into account.
>
> From the example:
>    +----------------+
>    |                |
>    |  Root complex  |
>    |                |
>    |    +-----+     |
>    |    |32 =CE=BCs|     |
>    +----------------+
>            |
>            |  Link 1
>            |
>    +----------------+
>    |     |8 =CE=BCs|     |
>    |     +----+     |
>    |    Switch A    |
>    |     +----+     |
>    |     |8 =CE=BCs|     |
>    +----------------+
>            |
>            |  Link 2
>            |
>    +----------------+
>    |    |32 =CE=BCs|     |
>    |    +-----+     |
>    |    Switch B    |
>    |    +-----+     |
>    |    |32 =CE=BCs|     |
>    +----------------+
>            |
>            |  Link 3
>            |
>    +----------------+
>    |     |8=CE=BCs|      |
>    |     +---+      |
>    |   Endpoint C   |
>    |                |
>    |                |
>    +----------------+
>
> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> transition to L0 at time T. Since switch B takes 32 =CE=BCs to exit L1 on
> it's ports, Link 3 will transition to L0 at T+32 (longest time
> considering T+8 for endpoint C and T+32 for switch B).
>
> Switch B is required to initiate a transition from the L1 state on it's
> upstream port after no more than 1 =CE=BCs from the beginning of the
> transition from L1 state on the downstream port. Therefore, transition fr=
om
> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
>
> The path will exit L1 at T+34.
>
> On my specific system:
> 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Conne=
ction (rev 03)
> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 8=
16e (rev 1a)
>
>             Exit latency       Acceptable latency
> Tree:       L1       L0s       L1       L0s
> ----------  -------  -----     -------  ------
> 00:01.2     <32 us   -
> | 01:00.0   <32 us   -
> |- 02:03.0  <32 us   -
> | \03:00.0  <16 us   <2us      <64 us   <512ns
> |
> \- 02:04.0  <32 us   -
>   \04:00.0  <64 us   unlimited <64 us   <512ns
>
> 04:00.0's latency is the same as the maximum it allows so as we walk the =
path
> the first switchs startup latency will pass the acceptable latency limit
> for the link, and as a side-effect it fixes my issues with 03:00.0.
>
> Without this patch, 03:00.0 misbehaves and only gives me ~40 mbit/s over
> links with 6 or more hops. With this patch I'm back to a maximum of ~933
> mbit/s.
>
> The original code path did:
> 04:00:0-02:04.0 max latency 64    -> ok
> 02:04.0-01:00.0 max latency 32 +1 -> ok
> 01:00.0-00:01.2 max latency 32 +2 -> ok
>
> And thus didn't see any L1 ASPM latency issues.
>
> The new code does:
> 04:00:0-02:04.0 max latency 64    -> ok
> 02:04.0-01:00.0 max latency 64 +1 -> latency exceeded
> 01:00.0-00:01.2 max latency 64 +2 -> latency exceeded
>
> It correctly identifies the issue.
>
> For reference, pcie information:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D209725
>
> Kai-Heng Feng has a machine that will not boot with ASPM without this pat=
ch,
> information is documented here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D209671
>
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..c03ead0f1013 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency =3D 0;
> +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
>
> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_dev =
*endpoint)
>                 if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
>                     (link->latency_dw.l0s > acceptable->l0s))
>                         link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> +
>                 /*
>                  * Check L1 latency.
> -                * Every switch on the path to root complex need 1
> -                * more microsecond for L1. Spec doesn't mention L0s.
> +                *
> +                * PCIe r5.0, sec 5.4.1.2.2 states:
> +                * A Switch is required to initiate an L1 exit transition=
 on its
> +                * Upstream Port Link after no more than 1 =CE=BCs from t=
he beginning of an
> +                * L1 exit transition on any of its Downstream Port Links=
.
>                  *
>                  * The exit latencies for L1 substates are not advertised
>                  * by a device.  Since the spec also doesn't mention a wa=
y
> @@ -469,11 +473,13 @@ static void pcie_aspm_check_latency(struct pci_dev =
*endpoint)
>                  * L1 exit latencies advertised by a device include L1
>                  * substate latencies (and hence do not do any check).
>                  */
> -               latency =3D max_t(u32, link->latency_up.l1, link->latency=
_dw.l1);
> -               if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> -                       link->aspm_capable &=3D ~ASPM_STATE_L1;
> -               l1_switch_latency +=3D 1000;
> +               if (link->aspm_capable & ASPM_STATE_L1) {
> +                       latency =3D max_t(u32, link->latency_up.l1, link-=
>latency_dw.l1);
> +                       l1_max_latency =3D max_t(u32, latency, l1_max_lat=
ency);
> +                       if (l1_max_latency + l1_switch_latency > acceptab=
le->l1)
> +                               link->aspm_capable &=3D ~ASPM_STATE_L1;
> +                       l1_switch_latency +=3D 1000;
> +               }
>
>                 link =3D link->parent;
>         }
> --
> 2.29.1
>
