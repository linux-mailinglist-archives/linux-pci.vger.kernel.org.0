Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F8439AA5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhJYPnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 11:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232673AbhJYPnG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 11:43:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E63460F70;
        Mon, 25 Oct 2021 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635176444;
        bh=/EA1ZAMyLcB3Pv54GqH5FxuPnB3C0lNTVGdITSn85WM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uriQqWR79lkskbj36qK2x7YgxWLdQu3mGve8sf+/u4KBLMU4hcJihVdVNhhYg3yW7
         uF6AzBPtz95P39yXY5UrzPDmk8MIS9V8YL83MpDHn/nmkHg2Xp1FbBORDoTx/noSs7
         W8ugzkPVPVOwy9N2rSSTh4zFicqP/aHaLQOybu8ffl8o0bQZ+7WPknVyu45papGtcb
         4qQiY60OdAwk2MUYEGB0IWO5k24/TBHsCL2mpzEtCc3oE+2RedrR+OA5fuSb2jePbg
         cAX+43MRjU7MkXo0pDuPTzsfX8K3MA7zKOM9vcNzIz1FogAWM6ven+QnLXpw/ResKE
         5lJvYsgE4oGAQ==
Received: by mail-ed1-f44.google.com with SMTP id z20so1148409edc.13;
        Mon, 25 Oct 2021 08:40:44 -0700 (PDT)
X-Gm-Message-State: AOAM532YFsXYApd7pvM5FMSnDTzQwgNt4wgab8TIPtiPh2aAkDXatYVv
        /ziPb5KtUd9IJiQ0g1m91y88fXTnXg2vtL3GUA==
X-Google-Smtp-Source: ABdhPJwQ8T5Cvh5z6HNoITA8K2ILylKqItfQWWc0KoHd+Geq1Ag5D/0abRVxNsOUU+BSQL7eGRyuElS+3uXDRd6BTHA=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr12516665ejc.320.1635176393733;
 Mon, 25 Oct 2021 08:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211023144252.z7ou2l2tvm6cvtf7@pali>
In-Reply-To: <20211023144252.z7ou2l2tvm6cvtf7@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Oct 2021 10:39:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLwGtEVrAc1SFUBfQp22Vxp8hb5Kft1B9t_nFMZ=q8M-g@mail.gmail.com>
Message-ID: <CAL_JsqLwGtEVrAc1SFUBfQp22Vxp8hb5Kft1B9t_nFMZ=q8M-g@mail.gmail.com>
Subject: Re: RFC: Change PCI DTS scheme for port/link specific properties
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 23, 2021 at 9:43 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello Rob!
>
> I think that the current DT scheme for PCI buses and devices defined in
> Linux kernel tree has wrong definitions of port/link specific properties:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/pci/pci.txt
>
> Port or link specific properties are at least: max-link-speed,
> reset-gpios and supports-clkreq. And are currently defined as properties
> of host bridges.

pci-bus.yaml in dtschema is what matters now and it's a bit more flexible.

> Host Bridge contains one or more PCIe Root Ports (each represented as
> PCI Bridge device) and to each PCIe Root Port can be connected exactly
> one PCIe Upstream device.
>
> PCIe Upstream device can be either endpoint PCIe card or it can be also
> PCIe switch is consists of exactly one Upstream Port (represented as PCI
> Bridge device) and then one or more Downstream Port devices (each
> represent as PCI Bridge device). To each Downstream Port can be
> connected again exactly one PCIe Upstream device.
>
> Port or link specific properties (e.g. max-link-speed, reset-gpios and
> supports-clkreq) define "the PCIe link" between the Root/Downstream
> device and Endpoint/Upstream device. And it is basically Root/Downstream
> device which configures the port or link. So I think that these
> properties should not be in Host Bridge DTS node, but rather in DTS node
> which represents Root Port (or Downstream Port in case of PCIe switches).

I tend to agree, but that ship has sailed because we don't tend to
have a RP node in DT. Most host bridges also tend to be a single RP.
In those cases, the properties come from whatever node we have.

Certainly if there are multiple RPs on the host bridge bus (bus 0),
then we need multiple child nodes for the RPs. IIRC, some host
bindings do this already.

> Mauro wrote in another email, that he has PCIe topology with
> single-root-port host bridge to which is connected multi-port PCIe
> switch and he needs to control reset-gpios of devices connected to
> downstream ports of PCIe switch.

I did a lot of work on that to get it right in terms of having the
right nodes matching the bus hierarchy and resets distributed in the
nodes.

>
> Current pci.txt DT scheme is fully unsuitable for this kind of setup as
> basically PCIe switch is completely independent device of host bridge
> and so host bridge really should not define in its node properties which
> do not belong to host bridge itself.
>
> Rob, what do you think, how to solve this issue?
>
> I would suggest to define that max-link-speed, reset-gpios and
> supports-clkreq properties should be in node for Root Port and
> Downstream Port devices and not in host bridge nodes.
>
> So DTS for PCIe controller which has 2 root ports where to first root
> port is connected PCIe switch with 2 cards and to second root port is
> connected just endpoint card:
>
> pcie-host-bridge {
>         compatible =3D "vendor-controller-string"; /* e.g. designware, et=
c... */
>
>         pcie-root-port-1@0,0 {

pcie@0,0 and 'device_type =3D "pci"' are needed to indicate this is a
bridge node and apply the schema.

>                 reg =3D <0x00000000 0 0 0 0>; /* root port at device 0 */
>                 reset-gpios =3D ...; /* resets card connected to root-por=
t-1 which is pcie-switch-1-upstream-port */
>                 max-link-speed =3D <3> /* link between root-port-1 and sw=
itch is GEN3 */
>
>                 pcie-switch-1-upstream-port@0,0 {
>                         reg =3D ...; /* upstream port at device 0 */
>
>                         pcie-switch-1-downstream-port-1@X,0 {
>                                 reg =3D ...; /* downstream port 1 at swit=
ch specific address */
>                                 reset-gpios =3D ...; /* resets card conne=
cted to switch's port 1 */
>                                 max-link-speed =3D <1> /* link between th=
is port and card is GEN1 */
>
>                                 /* optional node for endpoint card */
>                                 /* pcie-card@0,0 { ... }; */
>                         };
>
>                         pcie-switch-1-downstream-port-2@Y,0 {
>                                 reg =3D ...; /* downstream port 2 at swit=
ch specific address */
>                                 reset-gpios =3D ...; /* resets card conne=
cted to switch's port 2 */
>                                 max-link-speed =3D <1> /* link between th=
is port and card is GEN1 */
>
>                                 /* optional node for endpoint card */
>                                 /* pcie-card@0,0 { ... }; */
>                         };
>                 };
>         };
>
>         pcie-root-port-2@1,0 {
>                 reg =3D <0x00000800 0 0 0 0>; /* root port at device 1 */
>                 reset-gpios =3D ...; /* resets card connected to root-por=
t-2 */
>                 max-link-speed =3D <2> /* link between root-port-2 and ca=
rd below is just GEN2 */
>
>                 /* optional node for endpoint card */
>                 /* pcie-card@0,0 { ... }; */
>         };
> };
>
> Any opinion?
