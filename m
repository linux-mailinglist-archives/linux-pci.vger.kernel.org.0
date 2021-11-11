Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBF44DD02
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 22:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKKVYl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 16:24:41 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42614 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKKVYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 16:24:41 -0500
Received: by mail-qt1-f175.google.com with SMTP id z9so6585946qtj.9;
        Thu, 11 Nov 2021 13:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OVuYP4CbXEmwPEVAkgcrDSEMJ/gdFGf/ByFsNppFyk=;
        b=E3sLybzPLnry9mj00ZD65Bw/+k6EK4q1wpleuf3EImdrWKRJPmT5eLManwbZB8YlSz
         6B5l5jkZs3ib+jNUU+6FrlIu1EN3ig5YvS5pnt19Ds6RLU8OpB4q5GCGNsVgmhHlAUUL
         Ifr0YJ8UbcHpK49OPuxX9M0qGVAxJNiJjrw/PrBI6EezW1tCt3c/argD9OJYPeVohYZo
         Q1LIohcjzp8zs+hYqtURqRvuYa4++Cb1ou8TYpWBI8Bo8rquPwoZfKA8AW0TXQlcN/5w
         isSqajsKpU8hN6dVDLI5Z1eG4tTDAEzSrM5pwCVfGkyy06COcagDJbPyx9jDaB9y8c2O
         z/Pg==
X-Gm-Message-State: AOAM5324YCvczoIioap0ybv9ZGEPt2kjRxbOZNfyYFjrh/tQ6+LNdClx
        Z+vLTuL3Y/CqNvWCZZk/zmTXUQhV1vc=
X-Google-Smtp-Source: ABdhPJx3crV6tsa1vAXB48vnfLJQgF63qvocrWYQsLez8qSnRMRlvm4FVvCVyKRCMNaA5Sep1rQGWg==
X-Received: by 2002:ac8:7f0c:: with SMTP id f12mr11266385qtk.362.1636665710278;
        Thu, 11 Nov 2021 13:21:50 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id b9sm2207340qtb.56.2021.11.11.13.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 13:21:49 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id de30so7204213qkb.0;
        Thu, 11 Nov 2021 13:21:49 -0800 (PST)
X-Received: by 2002:a37:9d53:: with SMTP id g80mr767634qke.12.1636665708899;
 Thu, 11 Nov 2021 13:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20210407030948.3845-1-Zhiqiang.Hou@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 11 Nov 2021 15:21:37 -0600
X-Gmail-Original-Message-ID: <CADRPPNRL8m+YawUJJe0MNLhRQ4NJROv4DVzP+rWTGeS6fCbDnQ@mail.gmail.com>
Message-ID: <CADRPPNRL8m+YawUJJe0MNLhRQ4NJROv4DVzP+rWTGeS6fCbDnQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/6] PCI: layerscape: Add power management support
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>, gustavo.pimentel@synopsys.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 7, 2021 at 9:13 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch series is to add PCIe power management support for NXP
> Layerscape platforms.
>
> Hou Zhiqiang (6):
>   PCI: layerscape: Change to use the DWC common link-up check function
>   dt-bindings: pci: layerscape-pci: Add a optional property big-endian
>   arm64: dts: layerscape: Add big-endian property for PCIe nodes
>   dt-bindings: pci: layerscape-pci: Update the description of SCFG
>     property
>   arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
>   PCI: layerscape: Add power management support
>
>  .../bindings/pci/layerscape-pci.txt           |   6 +-
>  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
>  drivers/pci/controller/dwc/pci-layerscape.c   | 450 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>  6 files changed, 370 insertions(+), 97 deletions(-)

Hi Bjorn,

I don't see any feedback on this version.  Is there any chance that
the binding/driver changes can be picked up?

Regards,
Leo
