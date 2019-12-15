Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63111FB2A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2019 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOUoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Dec 2019 15:44:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40201 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOUoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2019 15:44:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so6273647oto.7;
        Sun, 15 Dec 2019 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt9xL93I8MsKs6Socqd2NmMVjNPgCRRv4tjGDgdBCSw=;
        b=IQ2bT4OFZQWWliGC6Q+V6Kf26jnuzpQACPXwyY6cwPMUJe0lD7BDA0rJLHRc9AXQ+7
         nUEzp1ASKVPv7h6zeGDoll31LQwdkrQtAcIN2+6nx5WZny6yhUJOnqiwFNTkut6yFTA1
         kMeckmsoC3tLNdBKledAnfZnx8cHXghd3aBmZLI7ZhyyT7sXyrt14wocHkFxe9A4kW/J
         SThbE0Mx/WoCntEioF+6KZz/gHL1umZFXDjGJA0WjPEcfmhgXl2Jo3YntsteRQfjRX/4
         ZPaNmW+HeQ2+x76oRGia3CS2jcc7ASMO27s5yHqdVri5kjws8+FioaxM5SYJmTl3k36V
         MjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt9xL93I8MsKs6Socqd2NmMVjNPgCRRv4tjGDgdBCSw=;
        b=YsOZ8p23FujVJpt6g83z7C+/UmbsFuZj4MjSEb5jmPLv67I0g5zjYH+xPvRe73Hq0a
         Xz2VKS90KDsl0Sa2dI2BpHgTjEN9THK1f+A2dzOUOwFgKLt8mTQ7VkPECbl6jneGOyxD
         drj9leeoFi68jb96Zlr1f5swARTu4dmpTSvP/tytgEHrH0BGLyYdcANujRda5bD/oCkW
         xgHwYqLSa9JomxLbzNviN1CTbV4iMhlErCkPlpzXFfVVfoXdEAsxm4m7vIxn4KUO7aH3
         WpYU/BSTOCscxppv1VEL8nLpjqL6Ll+jb2hqif37+fKyiBhbxMLwcdiWg2D37wBDWUT0
         Ab1w==
X-Gm-Message-State: APjAAAW2KGwmOhvKtzvONpv0fh/der++C5hn889UjuIcguyB9v5R523P
        Z+Mcxbi7LGI065mvDmiYdn0xY8IhonhdqH2CsCU=
X-Google-Smtp-Source: APXvYqzTskIRt2Xw6EqKZjSVIvxiX/lSFCf08HAZcNVOCGDv9OhkOltw6Or9ek9Mtm4/ItWI9/ZSUmrTMq6qqm+Z6UI=
X-Received: by 2002:a9d:6a4c:: with SMTP id h12mr28669493otn.81.1576442671149;
 Sun, 15 Dec 2019 12:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20191208210320.15539-1-repk@triplefau.lt> <1jpngxew6l.fsf@starbuckisacylon.baylibre.com>
 <20191215113634.GB7304@voidbox>
In-Reply-To: <20191215113634.GB7304@voidbox>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 15 Dec 2019 21:44:20 +0100
Message-ID: <CAFBinCC+i5nFdyHGZkaV0gm3Qkn6OA8xR91iQJAK1SGUBRMJTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: amlogic: Make PCIe working reliably on AXG platforms
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Remi,

On Sun, Dec 15, 2019 at 12:28 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> On Mon, Dec 09, 2019 at 09:32:18AM +0100, Jerome Brunet wrote:
> >
> > On Sun 08 Dec 2019 at 22:03, Remi Pommarel <repk@triplefau.lt> wrote:
> >
> > > PCIe device probing failures have been seen on some AXG platforms and were
> > > due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
> > > solved the problem. After being contacted about this, vendor reported that
> > > this bit was linked to PCIe PLL CML output.
> >
> > Thanks for reporting the problem.
> >
> > As Martin pointed out, the CML outputs already exist in the AXG clock
> > controller but are handled using HHI_PCIE_PLL_CNTL6. Although
> > incomplete, it seems to be aligned with the datasheet I have (v0.9)
> >
> > According to the same document, HHI_MIPI_CNTL0 belong to the MIPI Phy.
> > Unfortunately bit 26 is not documented
> >
> > AFAICT, the clock controller is not appropriate driver to deal with this
> > register/bit
> >
>
> Regarding both @Martin's and your remark.
>
> Unfortunately the documentation I have and vendor feedback are a bit
> vague to me. I do agree that CLKID_PCIE_PLL_CML_ENABLE is not a proper
> name for this bit because this register is MIPI related.
>
> Here is the information I got from the vendor [1]. As you can see
> HHI_MIPI_CNTL0[29] and HHI_MIPI_CNTL0[26] are related together, and
> HHI_MIPI_CNTL0[29] is implemented in the clock controller as
> axg_mipi_enable which is why I used this driver for HHI_MIPI_CNTL0[26].
I agree, the details you got so far are unfortunately pretty vague
(with my knowledge at least)
from my experience Amlogic has very good documentation internally, so
I'm sure that more details are available.

Yue Wang (the Amlogic PCIe controller maintainer) is already Cc'ed and
I added Jianxin. I hope that they can explain the meaning of bis 26
and 29 in HHI_MIPI_CNTL0 on the AXG SoCs (assuming Remi's contact at
Amlogic can't) and how they are related to the PCIe controller (even
though they're in a MIPI related register).


Martin
