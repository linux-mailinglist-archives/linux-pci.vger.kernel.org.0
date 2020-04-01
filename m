Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9F19A3DC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 05:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgDADK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 23:10:26 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17815 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731617AbgDADK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 23:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585710570;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=KcAzchodFlHrCft8V2AwyHfzu9rilizY3Z6FGXX3y14=;
        b=JyJ+gy9/NxNNe5zeYbTkc2ynPUYF/KFmz8AqZs/lElhDoux5BlGDaJFZv34m1C15
        4+6qRl/zGc/SQQs14dizVehpX10ZzA1AbBqVzWIVt3wLgElhOjJrWi+uVGw0s2zYwnR
        JrYxrCFXwPuihr+cu5Td3xv/hUxF8++r6pZ8k3TI=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585710568507865.2339431988825; Wed, 1 Apr 2020 11:09:28 +0800 (CST)
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
Message-ID: <20200401030658.1174045-5-jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
Date:   Wed,  1 Apr 2020 11:06:48 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
References: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
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
--
v2: Clean-up
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/d=
ts/loongson/rs780e-pch.dtsi
index 45c54d555fa4..8766f97306c6 100644
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
+
+=09=09=09reg =3D <0 0x1a000000 0 0x02000000>;
+
+=09=09=09ranges =3D <0x01000000 0 0x00004000 0 0x00004000 0 0x00004000>,
+=09=09=09=09 <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+
+=09=09=09bus-range =3D <0x00 0xff>;
+=09=09};
+
 =09=09isa {
 =09=09=09compatible =3D "isa";
 =09=09=09#address-cells =3D <2>;
--=20
2.26.0.rc2


