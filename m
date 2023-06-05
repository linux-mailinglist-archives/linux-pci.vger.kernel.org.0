Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01567220F1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFEIZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 04:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEIZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 04:25:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044BBAD
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 01:25:46 -0700 (PDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 686703F42E
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685953545;
        bh=w/vz4qy3Kc7GOpDb+K0VZMneVYxuO4mipxqG9LguKK8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lQXJHQdWxiAUtX8//YuXiJod2Y9mAZaTY22VEoNDePKm31+8wZLkJNnWaEGl2STaU
         qTe0lRkI6py8cedsKN9vleECcGnyh4K+uzcTqHKjVwqhp2UfRrDyAN9pH/Oqy+U0K2
         HpKf/HONW+PUsQsz7CBOZReRL2/391QMl9Mrr0LuMgnbu5IbwJ/S3W/MRR6YM1METd
         GOBiWk10G/QBMQXb/r5fQBT+VLSNHB47gokw11neitRE7hDbV3WaR3/iqHcuj3kiT6
         +XPGiqjPBOofdDqjT+ssr8sD4AT3igCbERR26/s6QgWd3gvRLk8tm+JmiLyqs+g4Lc
         PL2s1uX/0jS2g==
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75ec35e6e2fso14809085a.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Jun 2023 01:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685953544; x=1688545544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/vz4qy3Kc7GOpDb+K0VZMneVYxuO4mipxqG9LguKK8=;
        b=cjH3kqQuqJK0ZwryhbY6I9S67zAm2jwYoZAf07zu2eq7VCWQHGAKcuZO6oOfxp1Znn
         31JIRWVD9Z+eLWZDxya1zCFsPYEvZgpFk9DTsHUnGBuPCqwG+QsJ/rUXIMl5Nx6otXjL
         PUrD6UkuTBcw/n0zeoVC3XOLcwzjmiKTAMF3rjWERCdRfCOzlVg+3eRUVrx7oPXLuhrn
         yDgHHcXkhhGXiN4+GAFkRA7FkT9vA77kBNq/BPOQuablKfkPjrSp3LeIW7llDTI/PaR1
         TfuSPxTqw33aklstEthRPtV8zvGz1FF334PwLZJnddeCkDrLE9vXnd9m2JPydjIEyn86
         JyTQ==
X-Gm-Message-State: AC+VfDx/nKlmegA/RcZBpmLEQdjpRiZ8+E8OwEvZ2OXFrycUqMOJJq5G
        498kKwp389naqMy1G51mnYzJBUCt9dF6fL+I5R0+d3r2hY2417GgI8G3p4QIX7sPi7ZRfudHqjW
        C8/lyq9TTm/tshzopBLrymRumIe92AvWQk1fMdfwT7iRkyGHKshbKuQ==
X-Received: by 2002:a05:620a:678b:b0:75e:b9b8:ab57 with SMTP id rr11-20020a05620a678b00b0075eb9b8ab57mr1321524qkn.70.1685953544344;
        Mon, 05 Jun 2023 01:25:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AgPS6tYIm8uNjvjRnd4X/dKtb3kpAGwevuMacOVrV0JiWen9kzqyAmGft2GuHieBV9kyujChRhnQqQi4e9Po=
X-Received: by 2002:a05:620a:678b:b0:75e:b9b8:ab57 with SMTP id
 rr11-20020a05620a678b00b0075eb9b8ab57mr1321510qkn.70.1685953544065; Mon, 05
 Jun 2023 01:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230601162537.1163270-1-kai.heng.feng@canonical.com>
 <269262acfcce8eb1b85ee1fe3424a5ef2991f481.camel@gmail.com>
 <CAAd53p7c6eEqxd3jecfgvpxuYO3nmmmovcqD=3PgbqSVCWFfxA@mail.gmail.com> <577f38ed-8532-c32e-07bd-4a3b384d5fe8@molgen.mpg.de>
In-Reply-To: <577f38ed-8532-c32e-07bd-4a3b384d5fe8@molgen.mpg.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 5 Jun 2023 16:25:32 +0800
Message-ID: <CAAd53p6TNFLrwJZaR5OJKnbDn6ggidOLgeaFSn8JVf4oXZUBcQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Use PME poll to circumvent
 unreliable ACPI wake
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alexander H Duyck <alexander.duyck@gmail.com>,
        linux-pm@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

On Fri, Jun 2, 2023 at 4:43=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> [Cc: linux-pci@vger.kernel.org]
>
> Dear Kai,
>
>
> Thank you for your patch.
>
> Am 02.06.23 um 03:46 schrieb Kai-Heng Feng:
> > On Fri, Jun 2, 2023 at 4:24=E2=80=AFAM Alexander H Duyck wrote:
> >>
> >> On Fri, 2023-06-02 at 00:25 +0800, Kai-Heng Feng wrote:
> >>> On some I219 devices, ethernet cable plugging detection only works on=
ce
> >>> from PCI D3 state. Subsequent cable plugging does set PME bit correct=
ly,
> >>> but device still doesn't get woken up.
>
> Could you please add the list of all the devices with the firmware
> version, you know this problem exists on? Please also add the URLs of
> the bug reports at the end of the commit message.

Firmware do you mean the firmware on I219 device, or BIOS?

>
> Is that problem logged somehow? Could a log message be added first?

There's nothing gets logged. When this happens the ACPI GPE is dead silent.

>
> >> Do we have a root cause on why things don't get woken up? This seems
> >> like an issue where something isn't getting reset after the first
> >> wakeup and so future ones are blocked.
> >
> > No we don't know the root cause.
> > I guess the D3 wake isn't really tested under Windows because I219
> > doesn't use runtime D3 on Windows.
>
> How do you know? Where you able to look at the Microsoft Windows driver
> source code?

Device Manager shows the current PCI state.

>
> >>> Since I219 connects to the root complex directly, it relies on platfo=
rm
> >>> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
> >>> works for first cable plugging but fails to notify the driver for
> >>> subsequent plugging events.
> >>>
> >>> The issue was originally found on CNP, but the same issue can be foun=
d
> >>> on ADL too. So workaround the issue by continuing use PME poll after
>
> The verb is spelled with a space: work around.

Sure, will change it.

>
> >>> first ACPI wake. As PME poll is always used, the runtime suspend
> >>> restriction for CNP can also be removed.
>
> When was that restriction for CNP added?

The restriction for CNP+ was introduced by commit 459d69c407f9
("e1000e: Disable runtime PM on CNP+") and modified by 3335369bad99
("e1000e: Remove the runtime suspend restriction on CNP+").

>
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 +++-
> >>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net=
/ethernet/intel/e1000e/netdev.c
> >>> index bd7ef59b1f2e..f0e48f2bc3a2 100644
> >>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >>> @@ -7021,6 +7021,8 @@ static __maybe_unused int e1000e_pm_runtime_res=
ume(struct device *dev)
> >>>        struct e1000_adapter *adapter =3D netdev_priv(netdev);
> >>>        int rc;
> >>>
> >>> +     pdev->pme_poll =3D true;
> >>> +
> >>>        rc =3D __e1000_resume(pdev);
> >>>        if (rc)
> >>>                return rc;
> >>
> >> Doesn't this enable this too broadly. I know there are a number of
> >> devices that run under the e1000e and I would imagine that we don't
> >> want them all running with "pme_poll =3D true" do we?
> >
> > Whack a mole isn't scaling, either.
> > The generation between CNP and ADL are probably affected too.
> >
> >> It seems like at a minimum we should only be setting this for specific
> >> platofrms or devices instead of on all of them.
> >>
> >> Also this seems like something we should be setting on the suspend sid=
e
> >> since it seems to be cleared in the wakeup calls.
> >
> > pme_poll gets cleared on wakeup, and once it's cleared the device will
> > be removed from pci_pme_list.
> >
> > To prevent that, reset pme_poll to true immediately on runtime resume.
> >
> >> Lastly I am not sure the first one is necessarily succeeding. You migh=
t
> >> want to check the status of pme_poll before you run your first test.
> >> From what I can tell it looks like the initial state is true in
> >> pci_pm_init. If so it might be getting cleared after the first wakeup
> >> which is what causes your issues.
> >
> > That's by design. pme_poll gets cleared when the hardware is capable
> > to signal wakeup via PME# or ACPI GPE. For detected hardwares, the
> > pme_poll will never be cleared.
> > So this becomes tricky for the issue, since the ACPI GPE works for
> > just one time, but never again.
> >
> >>> @@ -7682,7 +7684,7 @@ static int e1000_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >>>
> >>>        dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
> >>>
> >>> -     if (pci_dev_run_wake(pdev) && hw->mac.type !=3D e1000_pch_cnp)
> >>> +     if (pci_dev_run_wake(pdev))
> >>>                pm_runtime_put_noidle(&pdev->dev);
> >>>
> >>>        return 0;
> >>
> >> I assume this is the original workaround that was put in to address
> >> this issue. Perhaps you should add a Fixes tag to this to identify
> >> which workaround this patch is meant to be replacing.
> >
> > Another possibility is to remove runtime power management completely.
> > I wonder why Windows keep the device at D0 all the time?
>
> Who knows how to contact Intel=E2=80=99s driver developers for Microsoft =
Windows?

Probably this mailing list?

>
> > Can Linux align with Windows?
>
> Before deciding this, the power usage in the different states should be
> measured.

The power usage doesn't matter if the device can't function properly.

Kai-Heng

>
>
> Kind regards,
>
> Paul
