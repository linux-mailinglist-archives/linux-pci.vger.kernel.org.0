Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806273E9CC6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 05:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhHLDOK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 23:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhHLDOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 23:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E3B1610A7;
        Thu, 12 Aug 2021 03:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628738025;
        bh=upoubUoFXUupbVihHazGgBdMNxy54/SCZ+T3/jlKERk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OqwSfW+yiJvyboc2kkEo2xyT9xNzZliDAW3jBXxzSAjFLlvb+FE/m/C5FwmRU5WaL
         PoqT4RztphbwRX/w+Be9o+BR3opJ+qTRTYo03xsvoWplFj8Jh5qdbEp13WfVuflwSd
         tj2gV3FEQKZedTJ+I+rNTCv7ZLIWv3N9ted/muxXXNmGzmC9OSvCnj+PQ6lkZoyqcW
         wXG7jVeRXi3ewnrqw/e1mpzEVCxxtwE6zIeSaPUdd9HA1BvnyIwNR5rokED8k3yokh
         B4LE0bN0wNbCZ0TP11TjQr6+F6Ag0NLsA0ySeOt7uE/YU+gL2KtAYa1daCEipciEXK
         5XxVCj2Zs6LGw==
Received: by mail-ed1-f47.google.com with SMTP id x14so7142422edr.12;
        Wed, 11 Aug 2021 20:13:45 -0700 (PDT)
X-Gm-Message-State: AOAM531Gsyakwt4gTacJ8XG0f5HH0hB8wUJtEZTyHnyFta65D6HrqixI
        HOjRiG5809gQ2GLETYbMgnOfMOhUFmUwSVNNvw==
X-Google-Smtp-Source: ABdhPJzbwIiwyus8IKZuyQeUUkPB0pXANOg79zMYiZaRiaBA4SqoNv4lSkj50zVHajQIBRcwrMp2s6DtG1DsUpopkEI=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr2783756edw.137.1628738023720;
 Wed, 11 Aug 2021 20:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
 <20210804085045.3dddbb9c@coco.lan> <YQrARd7wgYS1nywt@robh.at.kernel.org>
 <20210805094612.2bc2c78f@coco.lan> <20210805095848.464cf85c@coco.lan>
 <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
 <20210810114211.01df0246@coco.lan> <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
 <20210810162054.1aa84b84@coco.lan> <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
 <20210811084648.66ddff29@coco.lan>
In-Reply-To: <20210811084648.66ddff29@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Aug 2021 22:13:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLg-jD1P3oGDocMaeHWQc+9kLr3gEdantRNUScUq5xsQw@mail.gmail.com>
Message-ID: <CAL_JsqLg-jD1P3oGDocMaeHWQc+9kLr3gEdantRNUScUq5xsQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to work
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 1:46 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 10 Aug 2021 11:13:48 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > > > >                                         compatible =3D "pciclass,=
0604";
> > > > >                                         device_type =3D "pci";
> > > > >                                         #address-cells =3D <3>;
> > > > >                                         #size-cells =3D <2>;
> > > > >                                         ranges;
> > > > >                                 };
> > > > >                                 pcie@1,0 { // Lane 4: M.2
> > > >
> > > > These 3 nodes (1, 5, 7) need to be child nodes of the above node.
> >
> > This was the main issue.
>
> Ok, placing 1, 5, 7 as child nodes of 0 worked, with the attached
> DT schema:
>
>
>         $ ls -l $(find /sys/devices/platform/soc/f4000000.pcie/ -name of_=
node)
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/of_node -> ../../../../firmware/devicetree/base/soc/pcie@f4000=
000
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/of_node -> .=
./../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/=
pcie@0,0/pcie@1,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000=
:03/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/p=
cie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/of_node -> .=
./../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/=
pcie@0,0/pcie@5,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/pci_bus/0000=
:05/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/p=
cie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/of_node -> .=
./../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/=
pcie@0,0/pcie@7,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/pci_bus/0000=
:06/of_node -> ../../../../../../../../../../firmware/devicetree/base/soc/p=
cie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node -> ../../../../..=
/../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0/pcie@0,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node -=
> ../../../../../../../../../firmware/devicetree/base/soc/pcie@f4000000/pci=
e@0,0/pcie@0,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/of_node -> ../../../../../../firmware/=
devicetree/base/soc/pcie@f4000000/pcie@0,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node -> ../../../..=
/../../../../firmware/devicetree/base/soc/pcie@f4000000/pcie@0,0
>         lrwxrwxrwx 1 root root 0 ago 11 08:43 /sys/devices/platform/soc/f=
4000000.pcie/pci0000:00/pci_bus/0000:00/of_node -> ../../../../../../../fir=
mware/devicetree/base/soc/pcie@f4000000

This all looks right to me, but...

> The logs also seem OK on my eyes:
>
>         [    3.911082]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f=
4000000
>         [    4.001104] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000
>         [    4.043609] pci_bus 0000:01: pci_set_bus_of_node: of_node: /so=
c/pcie@f4000000/pcie@0,0
>         [    4.076756] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0
>         [    4.120652] pci_bus 0000:02: pci_set_bus_of_node: of_node: /so=
c/pcie@f4000000/pcie@0,0/pcie@0,0
>         [    4.150766] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0
>         [    4.196413] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0
>         [    4.238896] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0
>         [    4.280116] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0
>         [    4.309821] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0

...these do not.

>         [    4.370830] pci_bus 0000:03: pci_set_bus_of_node: of_node: /so=
c/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
>         [    4.382345] pci_bus 0000:04: pci_set_bus_of_node: of_node: (nu=
ll)
>         [    4.411966] pci_bus 0000:05: pci_set_bus_of_node: of_node: /so=
c/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
>         [    4.439898] pci_bus 0000:06: pci_set_bus_of_node: of_node: /so=
c/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
>         [    4.491616] pci 0000:06:00.0: pci_set_of_node: of_node: /soc/p=
cie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
>         [    4.519907] pci_bus 0000:07: pci_set_bus_of_node: of_node: (nu=
ll)
