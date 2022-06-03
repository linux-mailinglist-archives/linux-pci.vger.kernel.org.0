Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758E53C9BB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiFCMNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbiFCMNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 08:13:21 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F482EA1A
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 05:13:17 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 5983AC39A782;
        Fri,  3 Jun 2022 14:13:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 5983AC39A782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1654258393; bh=UT9VhOp9mvwZIXUBq5mVtLAlnYeOa1Vsafc06zYyv64=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Iz6iTu+k2siye+mqqDFSRXWCLQCfwfo1HsdC/eVH0BH6/+ntnOVMTy9U9VZhlHkU1
         Xwlh5wKpmXfCXt7oAxJ4Kr2umD+uNrBUGRbvFk3mKWOfFTnPtsVvyLtPAsv/r0/PUr
         JOhJw9kbk0d4dVfynoNm8dr2N9IcrETD+4i+mkxY=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
References: <20220602162039.GA20136@bhelgaas>
Sender: khalasa@piap.pl
Date:   Fri, 03 Jun 2022 14:13:12 +0200
In-Reply-To: <20220602162039.GA20136@bhelgaas> (Bjorn Helgaas's message of
        "Thu, 2 Jun 2022 11:20:39 -0500")
Message-ID: <m3tu926j3b.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn et al.,

Bjorn Helgaas <helgaas@kernel.org> writes:

> I'd really like to have a single implementation of whatever quirk
> works around this.  I don't think we should have multiple copies just
> because we assume some firmware takes care of part of this for us.

I second this.
I think it should work this way:

MPS affects the whole buses, i.e., packets are not fragmented by PCIe
bridges. MPS works for both RX and TX. This means the CPU MPS (if any)
must be enforced (set in the registers) over the whole bus (system).

The system may use different (smaller) MPSes for different devices,
though. Perhaps the user should be able to ask for smaller value
(currently it's done using enum pcie_bus_config_types).

MRRS can be larger than MPS (a single read causes multiple packets of
response), and can be different for different devices.
Still, all devices must be programmed the system's limit at most (or
less if the user wishes to).

IMHO this means we should use max_mps and max_mrrs for the whole system,
and then e.g. platform PCIe controller driver or a device driver could
lower them, triggering writes to the PCI config registers down the
buses.
Individual devices/drivers could use smaller values without changing the
global variables.

> I have the vague impression that this issue is related to an arm64 AXI
> bus property [2] or maybe a DesignWare controller property [3], so
> this might affect several PCIe controller drivers.

[2] seems like a bug in TI specific SoC and revision only.
[3] it seems all DWC PCIe hosts (and maybe devices) need a limit (two
limits).

E.g.:
- i.MX6 needs MRRS =3D 512 (or lower at user's discretion) and MPS =3D 128.
- CNS3xxx needs MRRS =3D MPS =3D 128 IIRC.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
