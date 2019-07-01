Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81D65B39A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 06:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfGAEdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 00:33:22 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45040 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGAEdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 00:33:22 -0400
Received: by mail-io1-f53.google.com with SMTP id s7so25601762iob.11
        for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2019 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWSKX8SLufUgoBCaxFvbRV9xn+bc7MrFd76Ul67PmIA=;
        b=YdI2mTqZr9f6OMEtuKJgRy7L8hL084hMrYubzgn83UXSQqRPyNhNum0H4mBsSQvZyW
         1pQJuNSib4Lzvz0TgXbrlzYwdPQ/Wfp2p/bcIIm6vxCsh5n3WnICIelJxhRKW0md15ny
         D+m9o3YHsLhO+FSijApTfQyUNcC0s4G0orLFVjEn+4DHqYfemAIHsBiZMD1HojWlizpH
         HiWlNbb4B4xtst2gMYF/vhblG/hnC/HvetqTddUw5AXja75tun/XRq/mvg5QFkWtcmA2
         r5xVNSqDNE1FMZu44HR4GuQOq8Pw7sJ1cYzTSnNPf7bt6TATgsXo04b/+LjLmSJF/Wok
         Z0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWSKX8SLufUgoBCaxFvbRV9xn+bc7MrFd76Ul67PmIA=;
        b=fTArS9OIpd3tqZeuAxIpEvT+/C8zakQA3iuyQmAawRk8FfJdhboRnSrtKaFcvSC5Pt
         uw3VWGgZOOGBN1foAumknRTH6E5pT1L/BXxHOkE5+Ijm1dXdldIH+Awwh3cDxToeTa/m
         Z89SuBGBacgxL8j4jUHdWK8m0wMHs1kZllrrCNP05z+gURCbT1vAdvjzAf7LOgbP9smw
         R8Ax+7f38uRZO4pOP9cKBtBU6c0lYlNrNzbcRmsh2LnegeMkQO8CCJtz9YGQpoRTgwLq
         VbuZFL4mf2JXd84Cyi/tADKSGvlDsalbEGBIlfweeTQEMWWgECau9J+eFJMYy5qLr+XE
         e7XA==
X-Gm-Message-State: APjAAAUOAjE0k6TT1tZEo+zaie2gGZTzajkg2S18skY3gt2mOgOpmlad
        ZfFH8/HUQjkZplTjhtoh0KQTIgrLoUdixPofc+s=
X-Google-Smtp-Source: APXvYqx1ajHpH1LVXcslQp0TajawXcoZUeM2TvFh3NEJkX9S79XiR9ghPijMEBREXxcOlOyJqbr/IQeZGIuxrq5QoL0=
X-Received: by 2002:a02:a90a:: with SMTP id n10mr25643647jam.61.1561955601632;
 Sun, 30 Jun 2019 21:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com> <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com> <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com> <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com> <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 1 Jul 2019 14:33:10 +1000
Message-ID: <CAOSf1CFogb0jRqLDi1dSx-H235BmdWujDn4dYwKqAsy3V9ykfQ@mail.gmail.com>
Subject: Re: Multitude of resource assignment functions
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 30, 2019 at 12:58 PM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> *snip*
>
> Some other related thoughts:

> - Should pci=noacpi imply pci=nocrs? It does not appear to, and I feel
> like it should, as CRS is part of ACPI and relates to PCI.

Are you sure about that? There has been explicit support for CRS in
the PCIe Base spec since gen1.

> - Modern arches could give this option by default if they want
> everything done by the OS. Although this would not be nearly as nice as
> a code overhaul or branching out pci into pci-old and pci-new.

This is only really nice if you can use the new code 100% of the time.
If we're keeping around the old code then it's still going to be a
maintenance burden since there's no shortage of platforms with odd
firmware requirements.

> - I have not given iommu or intel_iommu parameters but I am getting DMAR
> faults (probably because I am using pci=noacpi) but normally the DMAR
> does not come on if you do not ask it to. Is there perhaps something
> recently added to do with Thunderbolt that is activating it? I
> understand that regardless, DMAR does not work well without ACPI. The
> main two I care about are DMAR and MADT (multiple processors) tables and
> otherwise, I would disable ACPI altogether.

IIRC the IOMMU can be forced on for anything behind a thunderbolt
controller since external devices aren't necessarily trustworthy. You
might be hitting that.

>
> Cheers,
> Nicholas
