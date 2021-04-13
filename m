Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4270335E622
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbhDMSSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 14:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238322AbhDMSSC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 14:18:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35251613BA;
        Tue, 13 Apr 2021 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618337862;
        bh=WnJiO8xMI84T93ixx6pdUvMpBrWgeGZXvzjBysS19Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bEvtTnHQ5UqIFlRDkZndzLIFghxt7ReVRVwQig8raE4wmg7tAFhXBmlHCYyBy/xmv
         bUYZ48nBTrCfmIf/56UkPJatNuYmUU9MWoEJB62HfVz9ArjYxLYVD6WNZSbkWmVprN
         W2ZkoChA9RIsRslNSRZBbsMbX3Bt/WfzZ+q1BYAJCtwQVKy1BTusESDxmGdlfDgz09
         RmziPKFozn7sKgyatoRu7spRhAMbo9YWtPmRQpSl2PdOfzq2g2wzQQOoMNcVJ833uJ
         uJaE4bQSAK3xxcqSbZ9Dqvwj+KeWamta/f7u8QrxfTJLRi4ETInwQ1oLcBmrUWH9IW
         PQ7IOmKgzLRSw==
Received: by mail-qv1-f41.google.com with SMTP id h3so7784446qve.13;
        Tue, 13 Apr 2021 11:17:42 -0700 (PDT)
X-Gm-Message-State: AOAM530YhAt6Tf0WR3qLi/jo/b46n87AHD7nfDbTMiP621D4RUhOLnoP
        oDPuUp7kWiYwRK5rNDdkbPqpA+D9G/5WnI11jQ==
X-Google-Smtp-Source: ABdhPJyYLs47pOcEN0xLW3aBws14zdPQh2BhTHl0PKd48sZecSWQSqM5HXIpccjFgJzAUPXEN0xZk6Y/vV++v3aSCjY=
X-Received: by 2002:a05:6214:8c4:: with SMTP id da4mr34891158qvb.57.1618337861448;
 Tue, 13 Apr 2021 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210412123936.25555-1-pali@kernel.org>
In-Reply-To: <20210412123936.25555-1-pali@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Apr 2021 13:17:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
Message-ID: <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain to zero
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 7:41 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove'
> function and allow to build it as module") PCIe controller driver for
> Armada 37xx can be dynamically loaded and unloaded at runtime. Also drive=
r
> allows dynamic binding and unbinding of PCIe controller device.
>
> Kernel PCI subsystem assigns by default dynamically allocated PCI domain
> number (starting from zero) for this PCIe controller every time when devi=
ce
> is bound. So PCI domain changes after every unbind / bind operation.

PCI host bridges as a module are relatively new, so seems likely a bug to m=
e.

> Alternative way for assigning PCI domain number is to use static allocate=
d
> numbers defined in Device Tree. This option has requirement that every PC=
I
> controller in system must have defined PCI bus number in Device Tree.

That seems entirely pointless from a DT point of view with a single PCI bri=
dge.

> Armada 37xx has only one PCIe controller, so assign for it PCI domain 0 i=
n
> Device Tree.
>
> After this change PCI domain on Armada 37xx is always zero, even after
> repeated unbind and bind operations.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function a=
nd allow to build it as module")
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index 7a2df148c6a3..f02058ef5364 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -495,6 +495,7 @@
>                                         <0 0 0 2 &pcie_intc 1>,
>                                         <0 0 0 3 &pcie_intc 2>,
>                                         <0 0 0 4 &pcie_intc 3>;
> +                       linux,pci-domain =3D <0>;
>                         max-link-speed =3D <2>;
>                         phys =3D <&comphy1 0>;
>                         pcie_intc: interrupt-controller {
> --
> 2.20.1
>
