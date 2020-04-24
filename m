Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44F1B7E9B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDXTKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDXTKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 15:10:50 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA6F20736;
        Fri, 24 Apr 2020 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587755449;
        bh=MfFP+6c7B6JLpXC5m9+1qaniqSz/QSXG2thGgEplmH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rgKmfrMj1o/4cX50G1dvBw6xSNKJvBJx+AAKL5ZgLFgW4rvrnAuV6UzfEioIptCjd
         9sspRnYsWFw27CdTR4aZLzGR63oSGt56WkFjjhi088vk8cMIAZucbR00cL2/tdS1aS
         vfSWnSopPuP5b6tP6Hc/Aaq/q1x/osY2VsrvDEso=
Received: by mail-qv1-f49.google.com with SMTP id v10so5240142qvr.2;
        Fri, 24 Apr 2020 12:10:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuZUyrmeu1REItT1Jjyb17IjUZBay1s2UWH9yjrncNgQsqNMcOcx
        TnFzHYvk1VbRU3HGBkU9vxi4KUxY4TUcGxAWhg==
X-Google-Smtp-Source: APiQypL6nxwSwL1BSBuuHSRL7v8AeB98h/sxDCOI2obb6oGnVpTZ6TVIRL9TpJ9D4J0DlGUb56NPwcffqM7uZdaaWHA=
X-Received: by 2002:a05:6214:227:: with SMTP id j7mr10830437qvt.85.1587755448530;
 Fri, 24 Apr 2020 12:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com> <20200424130847.328584-6-jiaxun.yang@flygoat.com>
In-Reply-To: <20200424130847.328584-6-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 14:10:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+33XrBowgg+pSAFLu-KChYzuFKL6DJRrOPuq60nSFN4g@mail.gmail.com>
Message-ID: <CAL_Jsq+33XrBowgg+pSAFLu-KChYzuFKL6DJRrOPuq60nSFN4g@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] MIPS: DTS: Loongson64: Add PCI Controller Node
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 8:10 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Add PCI Host controller node for Loongson64 with RS780E PCH dts.
> Note that PCI interrupts are probed via legacy way, as different
> machine have different interrupt arrangement, we can't cover all
> of them in dt.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v2: Clean-up
> ---
>  arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> index 8687c4f7370a..5e68ceae20ca 100644
> --- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> @@ -5,10 +5,25 @@ bus@10000000 {
>                 compatible = "simple-bus";
>                 #address-cells = <2>;
>                 #size-cells = <2>;
> -               ranges = <0 0x10000000 0 0x10000000 0 0x10000000
> +               ranges = <0 0x00000000 0 0x00000000 0 0x00010000 /* I/O Ports */

You're changing the first entry, so bus@10000000 unit-address should change.

Are i/o addresses really at 0x0 physical address?

> +                               0 0x10000000 0 0x10000000 0 0x10000000
>                                 0 0x40000000 0 0x40000000 0 0x40000000
>                                 0xfd 0xfe000000 0xfd 0xfe000000  0 0x2000000 /* PCI Config Space */>;
>
> +               pci@1a000000 {
> +                       compatible = "loongson,rs780e-pci";
> +                       device_type = "pci";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       reg = <0 0x1a000000 0 0x02000000>;
> +
> +                       ranges = <0x01000000 0 0x00004000 0 0x00004000 0 0x00004000>,
> +                                <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +
> +                       bus-range = <0x00 0xff>;

Not needed.

> +               };
> +
>                 isa {
>                         compatible = "isa";
>                         #address-cells = <2>;
> --
> 2.26.0.rc2
>
