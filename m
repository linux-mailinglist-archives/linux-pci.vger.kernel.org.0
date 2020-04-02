Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6219C845
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbgDBRpF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 13:45:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42372 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbgDBRpF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 13:45:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id e4so3533308oig.9
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2020 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciIw1P+AciIPVRcSA+xgtTfNvu8Z4LEGAoW8vtRJG9A=;
        b=VXA6CrMz53r8cVWPp0IY6eu5PetsOAMZXQ6jSYjp63dq86cRSAskmHfHaEOXfQ+Vww
         yT5sPEmIZGf7qpdxSK+ECan/qfZqLiT/i3TIIuVDd+vDF8o0W/e9Ag42Od7odpYnrEMU
         C0EdEPI7WBEraOsNUObTV6dfCcjEaBzhq2apxXDWmUoQKJOKYlk4JXXYfqU7jp9KusQF
         eubfRMV4s5HWPRpde1h1ehrvCrOue9+FTeX40qydQ3bkWNoxVD4V9S0xbkotyoNMx4qi
         3LjqRCsN6Ojn1b8DjOsulJpzT5GhwOVU8c7RvldnjRyh5cXorNA0FXVVqO8r32y/M3W7
         8x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciIw1P+AciIPVRcSA+xgtTfNvu8Z4LEGAoW8vtRJG9A=;
        b=jlwrDa9rSaL7FgYyuYO7QH9E/YlXRI2OnHWl4tL+zRE3jaZgYqZO9UbYiHsnnu6JNJ
         S7mcVloyr2+HrhHktbcqEtctTs8k7t1BrfKaCGrzFBgWB9tjyspazGcQ1EFfnOXr8/vC
         avVuLGJTISxN/k5rMOwW4BWRSBSUmodYr0R6noLtb1/AnGfMecr2js4OoUJaJsKy12Gf
         pgW2a2gnEJYKiU36RXWNFflGDIOg/1pr4PieMdG8pemeujy4/l0/hFFD+FvZvGlXVo3c
         u1XstDzlXQVYhfYw7kyt3ydNPrcrKFOsJCjjUAW5ICIVHJ/8u0wOjKy7mjT2m3LSmvy3
         +EiA==
X-Gm-Message-State: AGi0PuZZdevTVAdQc2uQR6n6KAk/yWs02NlqBW/67Qy8+lXqJwwBQuqh
        DspU2QE3T7mVxGUX1rZuwklji3ouDBH1Yc0trcEc2qEW5EJjgA==
X-Google-Smtp-Source: APiQypK2XU9kvp2BwIPAaFtHDVmceF7VMmrP9h4svg4/MjoiAFHiMWG9fb3FxiGuUAFGuEwlr9rMtoWOcCZgm7dmG1M=
X-Received: by 2002:aca:ac46:: with SMTP id v67mr162807oie.62.1585849504798;
 Thu, 02 Apr 2020 10:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com> <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com> <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com> <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com> <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
 <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com>
 <TYAPR01MB4544972970249F317DEBE5AAD8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vCKRtWxfB1u-XZxVeioi76Fdhb_gOWMC9TtSEmyFersg@mail.gmail.com>
 <TYAPR01MB4544C9091D4E2186FD7A0A37D8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <TYAPR01MB45442E975AEA3EDD22A3CD3BD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45442E975AEA3EDD22A3CD3BD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 2 Apr 2020 18:44:37 +0100
Message-ID: <CA+V-a8uZX+D1peigQuoTgmJq6KzZhUN_J7DjA_jCw=Re=titkw@mail.gmail.com>
Subject: Re: PCIe EPF
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Thu, Apr 2, 2020 at 5:58 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Prabhakar-san,
>
> > From: Yoshihiro Shimoda, Sent: Thursday, April 2, 2020 10:23 AM
> <snip>
> > By the way, according to previous your report, you are using pci/next branch
> > and the branch is based on v5.6-rc1. There is no evidence though,
> > I'd like to use next-20200401 tag from linux-next repo to use v5.6 based kernel
> > whether the strange issue happens on the latest v5.6 kernel code or not.
> > Note that I confirmed the next-20200401 tag has a commit d293237739414d
> > ("misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation").
>
> I'm afraid but I'd like to recall this because next-20200401 seems unstable on
> R-Car Gen3 environment (a lot of WARING happens). So, perhaps using linux mainline
> v5.6 + merging pci/next branch is better.
>
Taking your advice I rebased my patches on Geert's tree [1] (master
branch) and choose
M3N as my root device, and with rigorous testing I can confirm
read/write/copy work
without any issues. Using the same branch with G2N as root device still failed.

Since this is a Root device issue and not ep I am posting v6 and
swiotlb can be handled
separately for G2x platforms.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
> > Best regards,
> > Yoshihiro Shimoda
>
