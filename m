Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31D197B14
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgC3LpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 07:45:01 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17810 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729828AbgC3LpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 07:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585568653;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=rl3cSQTZ5AYvm0VZ1Lg689PwQCP7BqHc/lf/r9uza2s=;
        b=HGCEYcU22jDCjdQavbzD+FUVhCyh6LOO5Fv1+0AWm6o+unv9R28jkY6KA5Y21ael
        ZQ9Ji0JVYWjt1cUETH29mjkGS1DJTgYkrRhe+1OKpJH/iCWz8Pci3t59PYLvRy2NoCT
        Micsi8tzD7GG/yj2po3hTXZGsDfUT2Lh5WLojHlA=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585568650396198.02167131302042; Mon, 30 Mar 2020 19:44:10 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200330114239.1112759-5-jiaxun.yang@flygoat.com>
Subject: [PATCH 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Mon, 30 Mar 2020 19:42:29 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI Host controller node for Loongson64 with RS780E PCH dts.
Note that PCI interrupts are probed via legacy way, as different
machine have different interrupt arrangement, we can't cover all
of them in dt.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/d=
ts/loongson/rs780e-pch.dtsi
index 45c54d555fa4..f09599a4b9d7 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
@@ -5,10 +5,25 @@ bus@10000000 {
 =09=09compatible =3D "simple-bus";
 =09=09#address-cells =3D <2>;
 =09=09#size-cells =3D <2>;
-=09=09ranges =3D <0 0x10000000 0 0x10000000 0 0x10000000
+=09=09ranges =3D <0 0x00000000 0 0x00000000 0 0x00010000 /* ioports */
+=09=09=09=090 0x10000000 0 0x10000000 0 0x10000000
 =09=09=09=090 0x40000000 0 0x40000000 0 0x40000000
 =09=09=09=090xfd 0xfe000000 0xfd 0xfe000000  0 0x2000000 /* PCI Config Spa=
ce */>;
=20
+=09=09pci@1a000000 {
+=09=09=09compatible =3D "loongson,rs780e-pci";
+=09=09=09device_type =3D "pci";
+=09=09=09#address-cells =3D <3>;
+=09=09=09#size-cells =3D <2>;
+=09=09=09#interrupt-cells =3D <0x1>;
+
+=09=09=09reg =3D <0 0x1a000000 0 0x02000000>;
+
+=09=09=09ranges =3D <0x01000000 0x0 0x00004000 0x0 0x00004000  0x0 0x00004=
000>,
+=09=09=09=09<0x02000000 0x0 0x40000000 0x0 0x40000000  0x0 0x40000000>;
+
+=09=09};
+
 =09=09isa {
 =09=09=09compatible =3D "isa";
 =09=09=09#address-cells =3D <2>;
--=20
2.26.0.rc2


