Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD222D042
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXVIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 17:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGXVIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 17:08:17 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C77C0619D3;
        Fri, 24 Jul 2020 14:08:17 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g18so1229146ooa.0;
        Fri, 24 Jul 2020 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9egpgQL3ltlL+ONGWIllGBIJT2EgS30CUYnF3YyVCU=;
        b=SFBfYzCPZ9fDw6LHS95FjI4E+dD6r6pLZgsHCUOQcppIvqHH01WCRbDwkRF9lA2D7w
         uYW82BM0kQjxDqaDchErRDrM+C2zStFyMkwOPdG4Zitinh5nEBFR5UGGY11ma6dYwuLW
         /OHBf4H/yKT26P/5ZE+p+0CNcD/uUPSEwU0Q3MOcl2NuE2cP01jRORxgCLQLFR9lgZEc
         sOAd6yRQmxYb2nJZHYlSicb+ANIrdvzz6zK5gKubjTwOZ2nkAW58ebOP5aMPI7Ap2h06
         mMBbHIx4ENNlu5w7VXchnbEqOz7CThth36mXNtfV1TTrImU5NPjVM5TsA2+CML3Gbwpq
         0ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9egpgQL3ltlL+ONGWIllGBIJT2EgS30CUYnF3YyVCU=;
        b=tOMkKhz3sArZMszgY3OdfpJuT6syZa5jUfsst6Ag1NaP4Q1EkUs6AgUhw0lMfU+TlR
         4mDlNzesv0A+gUOPpmpAObyYsH4/53h4jtOGb9gH+Mmq7duiIL49LuZLGXY47stL53Xk
         rSdIqVANyE1qsqbCRLbE8FrTEJOdVD3wlRxj0pdb67gYh1DaDDZWpF2pTXviaL1aj2e+
         YJaJm1k7gGC9KXszjnBaVtNZTIdZGvHrGDKD1PaVj99xh3y/bB7asLlmY4XF/pf3UPvC
         n0osvj2JERcxKqT+qDMdvxE8m4FV/aJynRaMH5EsuJ0K4NZlGRl2NQlewRCDqH13zGGD
         jXTQ==
X-Gm-Message-State: AOAM532VIOiGnD1TZI1EOBEBxFl15BltZYN6F6pxf1RcCa+myH71P8Oo
        cqWMxIcVpUTbOXEt275dH28UiPa2zDfbDwcK51Y=
X-Google-Smtp-Source: ABdhPJye40ASWtRv1qfpV93UKjRmfbYnV3XiN5viKeuGCRwuOzNYU2xMuOxLTmmpjtmrPumjK2YVH7Mjzt4fayWg02g=
X-Received: by 2002:a4a:b503:: with SMTP id r3mr11108276ooo.92.1595624896777;
 Fri, 24 Jul 2020 14:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
 <CADLC3L2ZnGTQJ+fwCy42dpxhHLpAFzFkjMRG3ZS=z7R4WK08og@mail.gmail.com>
 <CADLC3L1R2hssRjxHJv9yhdN_7-hGw58rXSfNp-FraZh0Tw+gRw@mail.gmail.com> <87CA0F2C-5CEB-4CE7-8399-534CABE5ADD8@canonical.com>
In-Reply-To: <87CA0F2C-5CEB-4CE7-8399-534CABE5ADD8@canonical.com>
From:   Robert Hancock <hancockrwd@gmail.com>
Date:   Fri, 24 Jul 2020 15:08:05 -0600
Message-ID: <CADLC3L2ioR8c9oCyeg0t0qc_UeW9VSKqsK++mrrkCOkaMyD9WA@mail.gmail.com>
Subject: Re: 5.7 regression: Lots of PCIe AER errors and suspend failure
 without pcie=noaer
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 8:32 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Robert,
>
> > Unfortunately it appears that this ASMedia PCIe-PCI bridge:
> >
> > 02:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1083/1085 PCIe
> > to PCI Bridge [1b21:1080] (rev 04)
> >
> > doesn't cope with ASPM properly and causes a bunch of PCIe link
> > errors. (This is in addition to some broken-ness known as far back as
> > 2012 with these ASM1083/1085 chips with regard to PCI interrupts
> > getting stuck, but this ASPM problem causes issues even if no devices
> > are connected to the PCI side of the bridge, as is the case on my
> > system.)
> >
> > Might need a quirk to disable ASPM on this device?
>
> Yes I think it's a great idea to do it.
>
> Can you please file a bug on [1] and we can continue our discussion there.
>
> [1] https://bugzilla.kernel.org

Hi, I created a bug entry earlier as a result of another discussion,
which includes the debug info as well as a proposed patch:
https://bugzilla.kernel.org/show_bug.cgi?id=208667
