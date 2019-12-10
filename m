Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003AF119144
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfLJT6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 14:58:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45246 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 14:58:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so14695199lfa.12;
        Tue, 10 Dec 2019 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvLA6SLf2bKE07yg0HKaHP2/grDfEpmexDJw0d9Uy8g=;
        b=gTFrwZsVodvFApTjCQmw3UiTwNJ+4OItpxaDmYfpRqtVGCIb4WveT1bk/NpTgTqhac
         4SDFeIxJGigGukw4OGlS+H4wren3Gw63Z17mzs7TBwuL9gsmvsxcRsIZyvS52fLCAPd5
         5IKavCuFDp806MC+KUdTcxif4p6xKxqgk+8Kpsy0tZio7VaENp7w1xHR+8oZpx550IKq
         4vAr5Loh8y1RuFUzv1ESwItchuI1DbAm00vd9+2KXWIHrAd6uSDNKM6IWLwRVPnOpsqB
         3om4eNnUmaoGUfe8/CGlIDsWyptKHl8xHk2+6ldvCa36hR3HWlx+zL6j5JIIs1iUueuh
         bD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvLA6SLf2bKE07yg0HKaHP2/grDfEpmexDJw0d9Uy8g=;
        b=GsM/u5G1rHuTi4AO8SJko0+xEp/gSl9P+2+xMHK6ufo/tf583xNyjzYvHvlSwXOyJx
         UMAIspnvnKVYHIU+VX4WOaN2kXQcdAr+Pxxn/Yw/uiGmHD9M8phzh8GgPMLWgtzNgxf3
         oY0rXOWlnKyrml2QxJbuOAUe8g0RbNxpdKyW+W0XD5+NmJPBakt37CygDlDhx6aRo4TT
         adiYqUBJPZ4ZEWSPS5UDe/yWHmLlZI4ZmpSv+Iw1DgOqeBCpbKiwiW4bqlZ8p+vik6pp
         Xoke+pihlRYmdJDnbSUsB5oOT5qMrZ4nRMtXerrgiQ+fAJ9PbrjZZTNZjt088oVrr8sY
         intg==
X-Gm-Message-State: APjAAAXoss0zWzdnDY9u5MzNElRDV3Dy+PfFa7a2xbUl+I9mPOfOsM7F
        XPxBb5of6/m5EyYJM3rnJHrZqSe6g5WKWkyqzWU=
X-Google-Smtp-Source: APXvYqzYgV7pLzv9dyjVa9JvPpCT5tZXDSo5dUz5fNuTjRw5r8yUo3wM6afiUBHEPOCG5oAOE7kVEqUbErxmp2QLR6g=
X-Received: by 2002:a19:784:: with SMTP id 126mr13582955lfh.191.1576007918112;
 Tue, 10 Dec 2019 11:58:38 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
 <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com> <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 11 Dec 2019 05:58:26 +1000
Message-ID: <CAPM=9txefUg9_EO82an3b313mZz7J7-ydTuJtWD-hOQwE4QXkQ@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 9 Dec 2019 at 21:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 9, 2019 at 12:17 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > anybody any other ideas?
>
> Not yet, but I'm trying to collect some more information.
>
> > It seems that both patches don't really fix
> > the issue and I have no idea left on my side to try out. The only
> > thing left I could do to further investigate would be to reverse
> > engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
> > but I've heard users having similar issues to the one Lyude told us
> > about... and I couldn't verify that the patches help there either in a
> > reliable way.
>
> It looks like the newer (8+) versions of Windows expect the GPU driver
> to prepare the GPU for power removal in some specific way and the
> latter fails if the GPU has not been prepared as expected.
>
> Because testing indicates that the Windows 7 path in the platform
> firmware works, it may be worth trying to do what it does to the PCIe
> link before invoking the _OFF method for the power resource
> controlling the GPU power.
>

Remember the pre Win8 path required calling a DSM method to actually
power the card down, I think by the time we reach these methods in
those cases the card is already gone.

Dave.
