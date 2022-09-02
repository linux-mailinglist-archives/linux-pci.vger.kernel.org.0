Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0F5AB4F1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiIBPWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiIBPVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:21:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DE158A84;
        Fri,  2 Sep 2022 07:54:24 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 622B9C0002;
        Fri,  2 Sep 2022 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662130461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjA2LlA0OrAFyjrKnUOD6lqWgwSmggNzmFY+qSRLKb0=;
        b=PTdNAZVwA2xm8zcn9E4iVOSVlfj7soqVTvmq3U3gLI2i+Vj/tu2xTrsXJhjJBsrVgBBiRs
        ZLwnSU9whjJGWXjM1tjC+PfxhI5MxD6iFpQwxUJiDhErjUia5FA1xpDi69q5CP5dL0ARg4
        KsUqiO51UaJmFO+334VsE1DJBcuPYkCVIVX8NvGLmQY/+92TxQmnqY48VHayy4p4Zf6Rp1
        zXos+tqeEmY8hEin0h0mcpLULx+rl2qNfKwenCWYvZyfKEPX/OIRxYUHKepqRuoYZbWyh7
        yH4dVRux5TRjQouYK6vOdn5P2LIIUBhPDIBL0modfKp4Zu2Iu3slK78+1qrSVQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: mvebu: Add support for error interrupt
In-Reply-To: <20220817230036.817-1-pali@kernel.org>
References: <20220817230036.817-1-pali@kernel.org>
Date:   Fri, 02 Sep 2022 16:54:20 +0200
Message-ID: <87o7vxesir.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> PCI mvebu error interrupt source is triggered for non-INTx event.
> So e.g. when AER or PME event occurs.
>
> This patch series adds support for reporting AER and PME interrupts on
> Marvell PCIe Root Ports which allows use to kernel AER and PME drivers.
>
> Without this change kernel AER and PME drivers do not work at all.
>
> DT bindings for this support is currently provided only for Kirkwood and
> Dove platforms as other new mvebu SoCs requires extension to armada IRQ
> driver, which is currently disallowed.
>
> Without new DTS files, pci-mvebu.c driver acts as before this change,
> there is no AER and PME kernel support.
>
> I have tested this change on Armada 385 board (with additional changes
> to A385 DTS files and IRQ driver, not included there) and AER interrupt
> is delivered to kernel AER driver correctly.
>
> Pali Roh=C3=A1r (4):
>   dt-bindings: PCI: mvebu: Update information about error interrupt
>   PCI: mvebu: Implement support for interrupts on emulated bridge


>   ARM: dts: kirkwood: Add definitions for PCIe error interrupts
>   ARM: dts: dove: Add definitions for PCIe error interrupts

Applied both dts patches on mvebu/dt

Thanks,

Gregory


>
>  .../devicetree/bindings/pci/mvebu-pci.txt     |   1 +
>  arch/arm/boot/dts/dove.dtsi                   |   8 +-
>  arch/arm/boot/dts/kirkwood-6192.dtsi          |   4 +-
>  arch/arm/boot/dts/kirkwood-6281.dtsi          |   4 +-
>  arch/arm/boot/dts/kirkwood-6282.dtsi          |   8 +-
>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi      |   4 +-
>  drivers/pci/controller/pci-mvebu.c            | 256 ++++++++++++++++--
>  7 files changed, 252 insertions(+), 33 deletions(-)
>
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
