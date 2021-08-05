Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231BD3E103F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhHEI3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 04:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233871AbhHEI3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 04:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14D1C60F43;
        Thu,  5 Aug 2021 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628152149;
        bh=yWq8YLyiFewgrTfnETHlC/L3kFIsqG78OX2q0kQmbRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1WNQnAWBAGniaPG60IxnhgbSvUpwPf//+BZ4Drhtsr9Kny8e3rr5vx0p14xA9JYI
         RBn3IyV/9yTx5/SsEpeZ43GVz/0Z1uMqEPJDyRe5zaJSgAjZW1cFEyRIP1ZvjvmEWG
         dsK3PA0DekE77A64g3OTdV9CYyl/dZrOF+L9cUj/dmAJ99mKIAg1WVCXhhjhm8h1YR
         lz4RNycAKYMqKkzI6zEUDDYYWkxZWdh1yJxZz9eWUEic0TuDDVn4y2ssb0IkEPeypY
         Jw0YL9tHl2eg+5ZLfUqh98ZR22Jjxz1IKbLoYL4whDoDpzB2LZ6QBViZvFzbsG2ve4
         Fn/U+cJr+PPZQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBYkP-001DuY-UI; Thu, 05 Aug 2021 10:29:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: of: Setup PCI before setting the OF node
Date:   Thu,  5 Aug 2021 10:28:59 +0200
Message-Id: <aa3fcc0975923cf7037bfd793d43a345b5496e4f.1628151761.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628151760.git.mchehab+huawei@kernel.org>
References: <cover.1628151760.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this change, it is easier to add a debug printk at
pci_set_of_node() in order to address possible issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..c5dfc1afb1d3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2374,15 +2374,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	pci_set_of_node(dev);
-
 	if (pci_setup_device(dev)) {
-		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
 	}
 
+	pci_set_of_node(dev);
+
 	return dev;
 }
 
-- 
2.31.1

