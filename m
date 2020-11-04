Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0B2A5C79
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 02:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgKDB6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 20:58:30 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:24332 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgKDB6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 20:58:30 -0500
X-IronPort-AV: E=Sophos;i="5.77,449,1596466800"; 
   d="scan'208";a="61594042"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 10:58:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B90A4151D43;
        Wed,  4 Nov 2020 10:58:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 0/3] dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema
Date:   Wed,  4 Nov 2020 10:58:13 +0900
Message-Id: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert bindings of rcar-pci.txt to json-schema. Also, document
r8a77965 and r8a774e1 to the yaml file.

Changes from v2:
 - Fix the subjects of all patches which Bjorn pointed it out:
 https://patchwork.kernel.org/project/linux-renesas-soc/cover/1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/#23734117
 - Minor fix the description in the patch 3/3.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=373695

Changes from v1:
 - In patch 1/3
 -- Fix indentation which yamllint detects.
 -- Fix typo which checkpatch.pl detects.
 -- Add ref: pci-bus.yaml
 -- Remove some properties which the pci-bus.yaml defines.
 -- Use unevaluatedProperties instead of additionalProperties.
 - In patch 2/3
 -- Add Reviewed-by from Geert-san.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=371929


Lad Prabhakar (1):
  dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings

Yoshihiro Shimoda (2):
  dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema
  dt-bindings: PCI: rcar-pci-host: Document r8a77965 bindings

 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 115 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 -------------
 2 files changed, 115 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

-- 
2.7.4

