Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030FE29FD35
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 06:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJ3F3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 01:29:13 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:22044 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725770AbgJ3F3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 01:29:12 -0400
X-IronPort-AV: E=Sophos;i="5.77,432,1596466800"; 
   d="scan'208";a="61013956"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Oct 2020 14:29:11 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DC7D8400F793;
        Fri, 30 Oct 2020 14:29:10 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/3] dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
Date:   Fri, 30 Oct 2020 14:29:02 +0900
Message-Id: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert bindings of rcar-pci.txt to json-schema.

Changes from v1:
 - In patch 1/3
 -- Fix indentation which yamllint detects.
 -- Fix typo which checkpatch.pl detects.
 -- Add ref: pci-bus.yaml
 -- Remove some properties which the pci-bus.yaml defines.
 -- Use unevaluatedProperties instead of additionalProperties.
 - In patch 2/3
 -- Add Reviewed-by from Geert-san.

Lad Prabhakar (1):
  dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1

Yoshihiro Shimoda (2):
  dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
  dt-bindings: pci: rcar-pci-host: document r8a77965 bindings

 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 115 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 -------------
 2 files changed, 115 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

-- 
2.7.4

