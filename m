Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248C319559B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgC0Krl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 06:47:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0Krk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 06:47:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RAlXB2117631;
        Fri, 27 Mar 2020 05:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585306053;
        bh=4njoQxq90QN3hHZRS5zql1ytyXJOR1pn085xcmSSb6M=;
        h=From:To:CC:Subject:Date;
        b=aferkor/Eq1MEH5773efv1Tq6H680KadTblZx1rM/mjie8JvsIQzkOzbn1Xg6iP6q
         ovTXnOGrAWY28oSkTkF//4psiZvNryWOoRibuyx46mLHRCq8mbFdv9/axI0I+EJ1d2
         rL54zV5Fhq+seYiySnBv/hVtWkzhkRkiuACPVA3E=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02RAlXop113842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Mar 2020 05:47:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 05:47:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 05:47:33 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RAlT8o128190;
        Fri, 27 Mar 2020 05:47:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] PCI: cadence: Deprecate inbound/outbound specific bindings
Date:   Fri, 27 Mar 2020 16:17:24 +0530
Message-ID: <20200327104727.4708-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is a result of comments given by Rob Herring @ [1].
Patch series changes the DT bindings and makes the corresponding driver
changes.

[1] -> http://lore.kernel.org/r/20200219202700.GA21908@bogus

Kishon Vijay Abraham I (3):
  dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
    bindings
  PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
    property
  PCI: Cadence: Remove using "cdns,max-outbound-regions" DT property

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
 .../controller/cadence/pcie-cadence-host.c    | 17 +++++++------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 7 files changed, 47 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml

-- 
2.17.1

