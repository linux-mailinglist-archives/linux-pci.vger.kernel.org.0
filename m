Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56385193EF1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 13:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgCZMe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 08:34:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZMe5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 08:34:57 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M42b8-1jHRiq0SAa-0002fd; Thu, 26 Mar 2020 13:34:56 +0100
Received: by mail-qk1-f177.google.com with SMTP id o10so6062795qki.10;
        Thu, 26 Mar 2020 05:34:55 -0700 (PDT)
X-Gm-Message-State: ANhLgQ37zGZcl98Gc2SIQ6fkcbA/6mx4u9Zy3PjSLIeQ7kRPFF6IxiK1
        ikAGpn1LEvgEl08ZEBnmv0ibLrICAyT9k+k6JoI=
X-Google-Smtp-Source: ADFU+vtOuL2BPcbttit4yBDNaP/8ddvWjjqH2/iCEGaAFs+JlAfjGtlSfNwtuRaUS5t2LeQ5UcEPn2VK+SRr7Phk8Ls=
X-Received: by 2002:a37:6455:: with SMTP id y82mr7853725qkb.286.1585226094723;
 Thu, 26 Mar 2020 05:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com> <1585205326-25326-3-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1585205326-25326-3-git-send-email-srinath.mannam@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Mar 2020 13:34:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0MP9xhmDgyN4TJ5_jzagVTO1hKVgNFs6R4NA6WoKBFJA@mail.gmail.com>
Message-ID: <CAK8P3a0MP9xhmDgyN4TJ5_jzagVTO1hKVgNFs6R4NA6WoKBFJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: iproc: Add INTx support with better modeling
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oYUCtX8DTgQxERAtlNDulhmkpSBttP5J1/eh+AMQi+rJfTPHmkw
 cBGP/+l2RLTL/DTiQWJf8xGZasPqeCxGAdmVOSmDynykO8VEW/cszpYELRci8AebHTnIu0z
 uROJf5qy2pdrhuZjKSxLvlzndJM+Nvf81xhwMfLHnswRDq1oTOUcVWlcApENXNtdWvWWi99
 /tLAMz1ygq1C1rkPT+nyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:InMNIBg92dc=:n4uoIGacY1pz95Nvg6mpdF
 ly1ounx6BdQfgYCf9lNo+FzMNFv1VEBOrAH4OVRsqNZHjlbU3sqXW6SHiYj7nv6MuSQ7zTyV/
 ZaUMIr6QTEaQsW8XsA6GYnEAEjmGPgcpXPqC4mIq7Tb1g8ca1CC1C56wEWqbvS24H1oMAKCj2
 jpJJzfbry+anvQaHkEcNauGHs/7BIEDhxfYd9Vi+lTFiBybfsGo4OBoQWDjCUZTHq/LDd6hUw
 3Klovw/febGLo2wFs5aBKX+vTctr+pw+H1N3lvmv7/iClB0u4t2uQ2mxqUxRDMFfxpUGWpy4f
 wznjZbSnUn3AYOB88n1lnvmhqC1VVQrx5annTrTYnBlB6tVlTzrhHW3ogeEJV1VarUG+V8bFQ
 uaLu3VZLtaf2N8/wGapf6shWj88Bm+F7ymK2H4XBXUGITpx4guCGN2n1pmCk+EfobFgy86xcU
 XDErhJAaFAvQu/KojJaCgoMB7Fh9zkzSR8666AVLI0v1pwpHjmm3txJWko21NgbIkPFi0YyyS
 gJbgvpaYpNDRiUuNx+vMps2rdi4LHzWMabgpENr46PycHWIj7ewBF2YPho2rgza0UqEid0ZHj
 YfwgI8a0WZME3bB86BsZBrTE/oGFnxGR4o2KtFB0Ir8x97HrO0+SSF31oFrrdlwkx7U1+xM32
 EdVD9vrJphLcPgTUt0IXzvOCCyX/u+AfP5lYX+jUDojIxBvDV3r455/d+w6sF5ZbbII2+7fdG
 yD9fjiKyOpU8JmWr3PPIxgZ6zDQT92Bo+wvM1VBFtusWx2/kUK+4vr869tzr9f9vbd52pbgef
 wsHzHpFLW53D0my2EyFfRw7b/sFquBbKSw5WVguTkEz/jjYMME=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 7:49 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> -static void iproc_pcie_enable(struct iproc_pcie *pcie)
> +static void iproc_pcie_mask_irq(struct irq_data *d)
>  {
> +       struct iproc_pcie *pcie = irq_data_get_irq_chip_data(d);
> +       u32 val;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&pcie->intx_lock, flags);
> +       val =  iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_EN);
> +       val &= ~(BIT(irqd_to_hwirq(d)));
> +       iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, val);
> +       spin_unlock_irqrestore(&pcie->intx_lock, flags);
> +}

I think these need to use a raw spinlock, or you get problems with
PREEMPT_RT

     Arnd
