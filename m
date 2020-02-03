Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAA150104
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 05:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBCE4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Feb 2020 23:56:25 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40619 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgBCE4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2020 23:56:25 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so11490471ilr.7
        for <linux-pci@vger.kernel.org>; Sun, 02 Feb 2020 20:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLCUHssQR4GiDx7ju0uHdetm53iUCinp6YVHronPa6g=;
        b=R7K+90hMjJZ0YNdeXFKnIdoTzyKwcXYSrVqiCCqt2XHB1hOgbvg+GuVBgnUFIqaTF6
         Z9ecvq6xi3k9Q5/27pLrbDemwTKciPqkrQaGpjkYQtywMxK4TLw+VosrSRdpgGS93090
         Ynjna4MOpFd2n8N5jdENebXurUfcsnpmAJeoJoIO+cOOyBhL8DpsiK6Hkx5H/1vfSlKm
         taTjfhWVli607k3HSFNmjILisAWiul4qcCGQCTWKhJD6UBnsOyJP6lD2Q6BePvfrDacD
         dv8nUxu0v50IUNX9XGwFdQq56qHzyNmO99l0E/1gsSE5LQm78dryMoJWA6h+SX3Gv0KP
         u6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLCUHssQR4GiDx7ju0uHdetm53iUCinp6YVHronPa6g=;
        b=mesxnrN8+cFVDbok3BcLVqmrESvkOz/Iib/N9pxlu+qQiw68UG4l/fOcQUt5pNcXzD
         4VdFM9/F1xVS2oS7Hs+jzJpKXVeyGHwyJIH3Tmitak326KzWiagJLRlemSehI+3jwqNE
         Duz6VfpBwoSJchqFX/HejboCRsU8+MBBT5TTqfVji+1MPkB6S08gNr/yXy7oVgb1hiyU
         nSyHv6GtAzPeRMIzCTNdAX8qZk5ye+Y6UnNcsM+8adYQ0Ikyj1C25ujad/GzqKVKsPQI
         tdCdntm65Yf2AaYB5XI63LoDcmDKoh+Sc4XnXDR5dwmZ3oQp15ZU3zHG1aAA7zHhhQ5j
         2WyQ==
X-Gm-Message-State: APjAAAV9ZFJBw2XSJRheMMaXYU4Kl6wsQ4/IsEJgUZd12P1VioNPzmib
        MnWMCSr/1EYuaiIy7Cn3KUgRzc0/T9a3acJajOq58a2O
X-Google-Smtp-Source: APXvYqxn3AXNHtHVf/4hD7wBVu5q2Gu1FVgJXX0VDYoN4wyVugxcRsjtlfN8S8QzzLMzhEevf0jX0guhyJiyxKMat+0=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr13003748ilj.298.1580705784518;
 Sun, 02 Feb 2020 20:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com> <20200130233730.GA141912@google.com>
In-Reply-To: <20200130233730.GA141912@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 3 Feb 2020 15:56:13 +1100
Message-ID: <CAOSf1CG8z91S9RJAQpByXRUNw3wMDDnFwuJZP5xTFnDsVx8Z7g@mail.gmail.com>
Subject: Re: [PATCH v7 00/26] PCI: Allow BAR movement during boot and hotplug
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 10:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 29, 2020 at 06:29:11PM +0300, Sergei Miroshnichenko wrote:
> >
> > Also tested on a POWER8 PowerNV+OPAL+PHB3 ppc64le machine, but with extra
> > patches which are to be sent upstream after the PCIPOCALYPSE patchset is
> > merged.
>
> "PCIPOCALYPSE" is meaningless to me.  Not sure if it's relevant for me
> or not, but if you mention it, it'd be nice to have some more context.

It's a big RFC series I posted to linuxppc-dev late last year that
removes most of the pseries PCI baggage that got carried over to
PowerNV. It also re-works EEH / DMA setup to be done on a per-device
rather than per-bridge basis and those changes are blocking Sergei's.
I didn't think it would be interesting to a general audience in it's
RFC state so I didn't CC it to linux-pci, but it's here if you want to
have a look: https://lore.kernel.org/linuxppc-dev/20191120012859.23300-1-oohall@gmail.com/

Oliver
