Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352F519A3CE
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 05:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgDADJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 23:09:49 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17802 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731592AbgDADJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 23:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585710529;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=GaL5PU1+MzN2vdc172Z+8T4IBBXDqZVCHe8kJc6oNlI=;
        b=T2MAplSi5XVCw0+Be5E2HUiFKOVdFUm2uFz0LN4gRQ7fgsF/ptwDQ+HAghBj+6aV
        OStnO8fFHxU7pKzVu+SpI6/77iLpvTGGNsDKbAN9JVFuJPuilf8frZvyGqfWpxlsPIM
        5i/6DP+PNOn+aQ58qnEwQu4Qc51v4bmHpFLDw6fA=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585710527100667.6418910848599; Wed, 1 Apr 2020 11:08:47 +0800 (CST)
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
Message-ID: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/5] Loongson64 Generic PCI driver v2
Date:   Wed,  1 Apr 2020 11:06:44 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jiaxun Yang (5):
  PCI: OF: Don't remap iospace on unsupported platform
  PCI: Add Loongson PCI Controller support
  dt-bindings: Document Loongson PCI Host Controller
  MIPS: DTS: Loongson64: Add PCI Controller Node
  MIPS: Loongson64: Switch to generic PCI driver

 .../devicetree/bindings/pci/loongson.yaml     |  57 ++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  17 +-
 arch/mips/loongson64/Makefile                 |   2 +-
 arch/mips/loongson64/vbios_quirk.c            |  29 ++
 arch/mips/pci/Makefile                        |   1 -
 arch/mips/pci/fixup-loongson3.c               |  71 -----
 arch/mips/pci/ops-loongson3.c                 | 116 --------
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-loongson.c         | 257 ++++++++++++++++++
 drivers/pci/of.c                              |   9 +
 12 files changed, 380 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
 create mode 100644 arch/mips/loongson64/vbios_quirk.c
 delete mode 100644 arch/mips/pci/fixup-loongson3.c
 delete mode 100644 arch/mips/pci/ops-loongson3.c
 create mode 100644 drivers/pci/controller/pci-loongson.c

--=20
2.26.0.rc2


