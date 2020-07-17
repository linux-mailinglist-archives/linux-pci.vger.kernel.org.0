Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258C52231FB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 06:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgGQENw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 00:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQENw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 00:13:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093ECC061755;
        Thu, 16 Jul 2020 21:13:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u12so5296525lff.2;
        Thu, 16 Jul 2020 21:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3Lvy+/OH9z2jCzIK+z+Qwn1xr98qqMgmgQ1Ho1iSWBg=;
        b=aXOnEeX1AuBGxenBuWAnRgMfbnP60RGVU/GV01wT86UYEXGdhCzG0oleFfg+4ScfnP
         b6MP1CZh/armT48drJR5MHQ/Eu49ihapDOhIE8elHzd12sKuWxPCJI0rRosBDCxReOKV
         h+WcDu0cqKlMYJtzxLUdYRFJKxIIgoakd9oFokqORQ9V+z8cV1AQgpQld91jZcVtAh/k
         Eqm3I4djaf8eLq905PImT85t32cGUK1fnWJU6HGdilzGP4fr7BE3qhLn8aXpWvKDMl+8
         tuVnNvRHqtV3GLnaXM60rBuXlvipONPnh8Mz2vc0iDEPUQCGz30IIfQqrBIxqhDz2hso
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3Lvy+/OH9z2jCzIK+z+Qwn1xr98qqMgmgQ1Ho1iSWBg=;
        b=p0R95marVSD1v6Q2YZHL6OOsYyLDaf4seEL44NOXGcPPnf7HX6ydnRGHrQ6B7M9D+m
         pnSSjde9EyRMRJ15wNpIXsoG1u+EBWJFnRfPw5Imk9ND3H8L+yRzVQJHEIvwLrWZPaR0
         IG0E3KAaDktRdewyhrhlTpdVOK+lJzV5bH2CXywiafpPLuPqA99Zlk+rfkik3o8s5vLc
         d4uubLvSIdLJajytGRxtzRAf+8i8IniD16Rzabcr/4x4aC8tirv8JQDCOGySpg0Wmn2V
         PYzybogUQnqqfUJ3d4LQ3uMDMgFx5bFRWZbCkMj7UupGSabwgUNc5uBxu0PDVWc35Bob
         hqRg==
X-Gm-Message-State: AOAM53210aN2xyTTlpHYRBD3zJ/qS9uUztuax7VTkE7M7YdMymRIMcHx
        RbEbqJJxYSoBEVrVXcpn+G7sqIQQeSc8ZM+Pgph+OlCc
X-Google-Smtp-Source: ABdhPJzcOfr0kEkGnnHuc0Oqz/LzUKcbRNEfEDLWudgveKV3OUDPPbeCgCGraLsK3wZapShpkimn7lL8cZsiCXQ9wSs=
X-Received: by 2002:ac2:5593:: with SMTP id v19mr3613131lfg.43.1594959230410;
 Thu, 16 Jul 2020 21:13:50 -0700 (PDT)
MIME-Version: 1.0
From:   Forest Crossman <cyrozap@gmail.com>
Date:   Thu, 16 Jul 2020 23:13:38 -0500
Message-ID: <CAO3ALPy8_pxVyFROZUWNafEH1vUCP6LVpNmBBuMDSewGitzdLw@mail.gmail.com>
Subject: ASMedia USB 3.x host controllers triggering EEH on POWER9
To:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, all,

I have several ASMedia USB 3.x host controllers (ASM2142 and ASM3142,
both share the same Vendor ID/Device ID pair) that I'd like to use
with a POWER9 system (a Raptor Computing Systems Talos II).
Unfortunately, while the kernel recognizes the controllers just fine,
as soon as I plug in a device, an EEH error occurs and the host
controller gets repeatedly reset until it eventually gets disabled. An
example of one of these errors can be seen here:
https://paste.debian.net/hidden/e39698eb

Based on the "PHB4 Diag-data" reported by the kernel, it seems that
LEM_WOF_R bit 35, PHB_FESR bit 20, and RXE_ARB_FESR bit 28 have been
set. According to the PHB4 specification
(https://ibm.ent.box.com/s/jftnfhceul07qjh9jtn91xwjmclabc71), they
respectively mean the following:
 - ARB: IODA TVT Errors - "TCE Validation Table error occurred. The
entry is invalid, or the PCI Address was out of range as defined by
the TTA bounds in the TVE entry."
 - RXE_ARB OR Error Status - "RXE_ARB error bits, ... OR of all error
status bits."
 - IODA TVT Address Range Error - "IODA Error: The PCI Address was out
of range as defined by the TTA bounds in the TVE entry."

In other words, the ASMedia USB controllers seem to be trying to write
to addresses they're not supposed to, and thankfully the PHB4 is
catching these bad writes before they can cause any corruption of my
system's memory. Of course, this has the unfortunate side-effect that
these devices are completely unable to operate with my computer, and
since it seems to be possible to use these controllers on x86 systems
(presumably because of the less-strict/disabled-by-default IOMMU), I
wonder if maybe it would be possible to work around these errors in
either the kernel or the OPAL firmware? My thinking is that instead of
disconnecting the misbehaving devices, maybe the errors could be
"forgiven" (but still blocked) and the device permitted to continue
operating, possibly with some USB data loss from "writes to nowhere"
or retries that may reduce performance. Or maybe if the issue is
caused by some high address bits being set to random values, those
bits could be masked-off so as to not trigger the errors and even
avoid data loss.

So, my question is, is any of this possible? I know the simple
solution for me is to just RMA the cards and avoid purchasing
ASMedia-based USB host controllers in the future, but the fact that
they still seem to work "mostly ok" on x86 systems (with the
occasional kernel panics and BSODs reported by users) piques my
curiosity and makes me wonder if maybe there's a way for me to have my
cheap, buggy hardware cake and eat it, too.

Now, I'm a novice at kernel hacking, so I don't really know what I'm
doing, but just for fun I did try to paper over the issue by adding an
EEH handler to the xhci driver
(https://paste.debian.net/hidden/16081515), but as you might expect,
that didn't do anything but prevent further communication with the
device. I also read a bunch of the PHB4 and IODA2 specs to see if
maybe there'd be a way to implement that bit-masking thing I
mentioned, but both of those documents are, uh, rather dry reading, so
I haven't read them in their entirety, and I don't know enough about
how this all works to try to search the text for what I need.

All that said, if anyone has any suggestions or comments, I'd be
really interested to hear them, even if it's just to question why I'd
go to such ridiculous lengths to try to get software to account for
buggy hardware.


All the best,

Forest
