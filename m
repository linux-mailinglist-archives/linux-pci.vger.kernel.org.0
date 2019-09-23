Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8CBB111
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfIWJK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 05:10:59 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:33361 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfIWJK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2019 05:10:58 -0400
Received: by mail-qt1-f180.google.com with SMTP id r5so16276322qtd.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2019 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8YwhPsnZ4Dn4ddZeDtc7eIWRTCkb8CcIGryzNRbAYJU=;
        b=iwamg/taDRFNHLqRvcPceN0j55hqanRb4+T40n7P4TVJCAKLN5Vs8aH+/m9CeKIIqY
         jVdE8nV2qkbzGeEpl8WbxPYUMof6rnbdb0tY4Iz9s/UPrMgssgsp1hsua0Yp+k/oIPIM
         DHnBGqgU8hx7/0OdHgNDpma0ob+NEogXC6HkXSOLOcp+CMIpDVv3+QZYo/nrId+cIBgv
         Tquc4OrMzzLGcMMlRcIxlrhpen6s2NOQAhJhzo7/VkAYSJH3Sf0AoQZ4+acGK8OLWhOg
         dzvqRcXlqQhwnbfoisAEOtzF2rkQMjAfl/H+PKV+JO6xHheOw3p8VnNxe0Ycfio73MwV
         RQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8YwhPsnZ4Dn4ddZeDtc7eIWRTCkb8CcIGryzNRbAYJU=;
        b=Vzf7+azqiAPOR2nnQXfWzAdoDKnGgWScF1pdR30WXQmVMep6n2znQ5EwzVW/N9URL/
         DXF7N5RGuiV0aTvg8AdvTfn8KTQ6bAUlHBZPIL59/smniPZFoxTgZIx/f0ISXhZ6OyNk
         tF34rxTbRChdRkzy7R91zpZOgLQC8OOqs6kiiVdhgFa/omHXpIfU5EVhH8s/3UIMaelk
         jZZZ7re4e8enZ4yTE2/xmABIkYouLdU/lEshlcOD4ogfnXsJeUnw4wL2i3fJnRya2NK2
         8lxBQLLssDG5bAAv7Avg59QjdABLvHMv10W+bDwh21qzRsWFKfeJouyX814b/gwEr6J8
         16OQ==
X-Gm-Message-State: APjAAAXYBPd8v3u2Qe+6nhALlK8fTIogNrJrMaL5rCrXOfp5HST/dyuN
        uMV6QxRg78ZiuoybjrCHNlqo4tQ974djsSf//xiPJA==
X-Google-Smtp-Source: APXvYqwwelQvxYlEvCFDYGCRhcrNpjdDh2rM+8vm9Y3sLkmLoGtt/jt3oitHQMAExy/xFM5G+pc5BvBlwreE6bC90vI=
X-Received: by 2002:a0c:d0d0:: with SMTP id b16mr22856243qvh.191.1569229857649;
 Mon, 23 Sep 2019 02:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com>
 <CAJZ5v0g4T_0VD_oYMF_BF1VM-d1bg-BD8h8=STDrhVBgouPOPg@mail.gmail.com>
 <01cf6be6-9175-87ca-f3ad-78c06b666893@linux.intel.com> <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
 <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com>
 <CAD8Lp47oNJb5N5i4oUQfN5b=xCtUc1Lt852pnXxhNq0vyWj=yg@mail.gmail.com> <CAJZ5v0j=x4HHOsJ6fCX-xOr29-4BMRzjR5H5UaoWW9v-Ci8ODQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=x4HHOsJ6fCX-xOr29-4BMRzjR5H5UaoWW9v-Ci8ODQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 23 Sep 2019 17:10:46 +0800
Message-ID: <CAD8Lp47qSte0C6sUFBkXVAHa755R5PnNUSvjRYD=JehYJ2R0pQ@mail.gmail.com>
Subject: Re: Ryzen7 3700U xhci fails on resume from sleep
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 4:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> > I'll report it to the vendor,
>
> Yes, please.  At least try to get the information on what the exact
> platform expectations with respect to the OS are.  Quite evidently,
> they aren't just "do the usual thing".

AMD's response was:
 > It=E2=80=99s modern stanby system, we don=E2=80=99t have any resource to=
 debug
Linux issue on it.

I imagine there are people in AMD that do care, but we don't have the
right contacts here, not sure if you happen to have anyone you could
forward this thread to just in case.

Anyway, I looked again and found some more interesting points and a
likely workaround, if you can help me nail down the details.

I checked again the experiment of runtime-suspending and resuming the
USB controller. As before, the problematic step is waking up. In
pci_raw_set_power_state() the pmcsr is first read as value 103, then
written as 0, then it msleeps for 10ms (in pci_dev_d3_sleep()), then
reads back value 3.

What I hadn't spotted before is that even though it failed to change
the power state bits, bit 8 did get successfully unset, indicating
that the device is not completely dead.

I then increased the msleep delay to 20ms and now it resumes fine &
USB devices work.

Unfortunately it's not quite as simple as quirking d3_delay though,
because the problem still happens upon resume from s2idle. In that
case, pci_dev_d3_sleep() is not called at all.

    if (state =3D=3D PCI_D3hot || dev->current_state =3D=3D PCI_D3hot)
        pci_dev_d3_sleep(dev);

In the runtime resume case, dev->current_state =3D=3D PCI_D3hot here (even
though pci_set_power_state had been called to put it into D3cold), so
the msleep happens.
But in the system sleep (s2idle) case, dev->current_state =3D=3D
PCI_D3cold here, so no sleep happens.
That is strangely inconsistent - is it a bug?

I also noticed that there is a 100ms d3cold_delay, but that seems to
happen before pcmsr is accessed at all, and doesn't have take any
effect here. However, I did also notice that there is no d3cold_delay
done during wakeup from s2idle, it only happens on wakeup from runtime
suspend. The code does seem to be written that way (runtime_d3cold
flag) but I wonder if that is correct. From the standpoint of the ACPI
PM specs, is there a difference between runtime suspend and s2idle
suspend? Since there is no firmware-based system suspend happening I
wonder if the d3cold_delay should apply in both cases.

I compared behaviour to another system with Amd Ryzen5 3500U. It's not
quite the same SoC but the XHCI controllers have the same PCI IDs. On
that platform, I was able to reproduce the failure to runtime resume,
but then it succeeds with a d3_delay of 20ms. On system
suspend/resume, this other platform uses S3, and the XHCI controller
is already in D0 upon resume (looks like the firmware turns on the USB
controllers for us, so Linux avoids any difficulties there).

That seems to agree that quirking these XHCI controllers (based on PCI
ID) to have a d3_delay of 20ms seems sane, but first we need to nail
down why that delay is not applied at all during resume from s2idle.

Daniel
