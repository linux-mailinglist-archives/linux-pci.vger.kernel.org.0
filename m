Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4402F19C0E4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgDBMMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:12:00 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35444 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgDBML7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:11:59 -0400
Received: by mail-ed1-f43.google.com with SMTP id a20so3822155edj.2;
        Thu, 02 Apr 2020 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQNKCc7PUxqRbfY956FD6h+k4Y66wdaQrbWQY54QQ5w=;
        b=agymgViUtAI2emTrH34p5ZHRX2vFxpJYQZfO6Ph/EpAkAH2SKbGh9Gwowg/y5F2xF9
         GN9bUassTsCq6TmOom09VHTeAwUjAGfKm8kyfj8L5nGKieUt7e9AmBZ0/ZTmGkrOLi9N
         pr+6N6O7GHNu8M8Iu1GZGh3K0wLBtSPqGXELUNzjNXnj/DFNRaqkfc9QZto9nWu40mDz
         GZ2nhih6haNInv37Cq8PqojOPRewbPgnPnex1rzGDwVqgC31gSH+X7GQNx0ioCcTTAet
         GS4NOrCtJ2TuSOIXnr3rZMN64006zcLHMZ2xA+KOGNbosVbW8GmBGh6odMjJ9ZwM4eB9
         iEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQNKCc7PUxqRbfY956FD6h+k4Y66wdaQrbWQY54QQ5w=;
        b=uiNfsFjatiixPhFU0JiUfPN3qh4EEOsQFy65bQKQQdKqKJTRsc7k5vG5hD9PWN++3E
         eP0JG5c3CZiTQZVBBntxnDsTrLIF23QOUyky4OHYZpKjlrgEGVudgLkzoBbG2OIU7Sh7
         yJiyTGtajFNSctrnCGx7vYD6gEcwB8cWE5XJms5I6VV+fINAUGZkUKPSU0Wa0pnuSZAM
         WmGXtRdCSCNmCyHxR/D0kj4UoBgJjOZ/YI02RrVK59lnqsNxWUszEX7YxpBROKap5kYB
         fD7he1MwTMriJosnDIPIE5IDdTO6sYbwg0eYXtC6Fru+HM3//FsgVuYTJxasjmCPLL9y
         ryCw==
X-Gm-Message-State: AGi0PuaOkBUGyZxKcu0ShUmcHM9vYgY/iNp2bDBoBH4EX21szL48GJcG
        UlNqZVNxkFko96pdKiYMr5w=
X-Google-Smtp-Source: APiQypLPNlmjZYpYHEbYalA5cdj8vdbm+4lcqgc+IcUsx4IEdOq3RzlqeMTeSu9WJGrGxVExBWuiNQ==
X-Received: by 2002:a50:da49:: with SMTP id a9mr2429759edk.388.1585829515709;
        Thu, 02 Apr 2020 05:11:55 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host250-251-dynamic.250-95-r.retail.telecomitalia.it. [95.250.251.250])
        by smtp.googlemail.com with ESMTPSA id w20sm1083611ejv.40.2020.04.02.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:11:54 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] Multiple fixes in PCIe qcom driver
Date:   Thu,  2 Apr 2020 14:11:37 +0200
Message-Id: <20200402121148.1767-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This contains multiple fix for PCIe qcom driver.
Some optional reset and clocks were missing.
Fix a problem with no PARF programming that cause kernel lock on load.
Add support to force gen 1 speed if needed. (due to hardware limitation)
Add ipq8064 rev 2 support that use a different tx termination offset.

v2:
* Drop iATU programming (already done in pcie init)
* Use max-link-speed instead of force-gen1 custom definition
* Drop MRRS to 256B (Can't find a realy reason why this was suggested)
* Introduce a new variant for different revision of ipq8064

Abhishek Sahu (1):
  PCIe: qcom: change duplicate PCI reset to phy reset

Ansuel Smith (7):
  PCIe: qcom: add missing ipq806x clocks in PCIe driver
  devicetree: bindings: pci: add missing clks to qcom,pcie
  PCIe: qcom: Fixed pcie_phy_clk branch issue
  PCIe: qcom: add missing reset for ipq806x
  devicetree: bindings: pci: add ext reset to qcom,pcie
  PCIe: qcom: fix init problem with missing PARF programming
  devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie

Sham Muthayyan (2):
  PCIe: qcom: add ipq8064 rev2 variant and set tx term offset
  PCIe: qcom: add Force GEN1 support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  56 +++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 134 +++++++++++++++---
 2 files changed, 167 insertions(+), 23 deletions(-)

-- 
2.25.1

