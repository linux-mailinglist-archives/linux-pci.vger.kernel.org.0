Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD473F30D9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhHTQEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 12:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234629AbhHTQC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 12:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF9D361264;
        Fri, 20 Aug 2021 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629475311;
        bh=TiOt/P4/QPtCLS0E75RDsmJdhwnKcPRpnT639l4Hm7M=;
        h=From:To:Cc:Subject:Date:From;
        b=fbXqToDF0pob26JIQat1YGMYZB1Ra+SJh+gk3xPZErpX29cyXON2Hgi/9TQm+cd69
         v1BapGh4LaWO9UNKqeGRC/I1YMzQIS2CA2HRSOg+f7okUq6KwtHkDPRFOiXaSOH7ke
         ulWiHtwqhJQfjqwZF58fEofoQU0csU0+NsfadrD3zIJ1+U9hJIIZVj+LV3LIXP43xc
         Ze9W0AtHO/AKJlVbfPVnK0M0rMlcUkIehJuveigdQjFD3UH1bZf1Z/9KookP5oeD//
         3YxDyr79NIIQf68xgGmQErtBszubS5/VUZQSnoY+loZe8DMCblq8j6O+qGrHwhCjnL
         uZ03IwL/7BIDQ==
Received: by pali.im (Postfix)
        id 662797C5; Fri, 20 Aug 2021 18:01:48 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] PCI: Define slot-power-limit DT property
Date:   Fri, 20 Aug 2021 18:00:20 +0200
Message-Id: <20210820160023.3243-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is RFC patch series which define a new PCIe slot-power-limit DT
property (first patch) and show example how to use it in pci-aardvark.c
driver (second and third patch). Second and third patches depends on other
pci-aardvark patches which are under review. I included them here just to
show how this new slot-power-limit DT property can be used.

Please let me know what do you think about this approach of defining Slot
Power Limit in DTS file.

Pali Rohár (3):
  dt-bindings: Add 'slot-power-limit' PCIe port property
  PCI: aardvark: Add support for sending Set_Slot_Power_Limit message
  arm64: dts: armada-3720-turris-mox: Define slot-power-limit for PCIe

 .../devicetree/bindings/pci/aardvark-pci.txt  |  2 +
 Documentation/devicetree/bindings/pci/pci.txt |  6 ++
 .../dts/marvell/armada-3720-turris-mox.dts    |  1 +
 drivers/pci/controller/pci-aardvark.c         | 66 ++++++++++++++++++-
 4 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.20.1

