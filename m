Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D453BC7D3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGFI3w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 04:29:52 -0400
Received: from us-smtp-delivery-115.mimecast.com ([216.205.24.115]:47581 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbhGFI3w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 04:29:52 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 04:29:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1625560033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Wz7hn9Kd3NoSNljmyCys5rwpfM2MRQrFBRp50KmUpA=;
        b=jJqoJhkYd4Tcg6ODNcZoVpfIKCUKVfV55qDXIXMeCB/KhbHqmHRfc7yaNGs6HOYLfT7iTJ
        slrmY36UH4yUrs7/0N5Si317O00Pct1buYMyF0FYTJ0DHxAj8++Ym1NKaxejJBDP36tUlR
        Oek/WkNtao6EyMiX0BjbB1n4vILJ0X8=
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-dAQF_euGM-652Mnpd8YqHg-1; Tue, 06 Jul 2021 04:21:06 -0400
X-MC-Unique: dAQF_euGM-652Mnpd8YqHg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2242.4;
 Tue, 6 Jul 2021 01:21:02 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <kw@linux.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ckim@maxlinear.com>, <qwu@maxlinear.com>,
        <rahul.tanwar.linux@gmail.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH] PCI: dwc/intel-gw: Update MAINTAINERS file
Date:   Tue, 6 Jul 2021 16:20:59 +0800
Message-ID: <b3249e08155e04ac08d820be3b8da29a913c472a.1625559158.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=rtanwar@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for PCIe RC controller driver for Intel LGM gateway SoC.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3298f4592ce7..61c1cfcc453b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14392,6 +14392,13 @@ S:=09Maintained
 F:=09Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
 F:=09drivers/pci/controller/dwc/pcie-histb.c
=20
+PCIE DRIVER FOR INTEL LGM GW SOC
+M:=09Rahul Tanwar <rtanwar@maxlinear.com>
+L:=09linux-pci@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+F:=09drivers/pci/controller/dwc/pcie-intel-gw.c
+
 PCIE DRIVER FOR MEDIATEK
 M:=09Ryder Lee <ryder.lee@mediatek.com>
 M:=09Jianjun Wang <jianjun.wang@mediatek.com>
--=20
2.17.1

