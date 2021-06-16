Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20AC3A9269
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhFPGaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhFPG34 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B104B6141B;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=My1ZHNSGoHRHq4FA9ySxIEbkvWlKRcsgp6LpqtXUf2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/F21QnzCLB1Q2iC1siLmWTPEBhcM3dtUTJff27YXlbAd1jFtQvsaLxsY4ZGhps36
         /MJnHNwxFMOh5W21sN6WVf9QjpwmrzKQyzDlB2rVBHli6tayuLVyaJgSFS6ZCuNHYY
         RU9odDLZuTyf27dPTGsT62N4h3gYpNT7nYg+7r4CVVB96ksTeIrjj9wkNtScCdpUqE
         GnCiTEY76oO4NI3nsOPr/Sk7B5oQEDfw0pDb7A851hN0a+R4LVQ/EBBav4mJ0Lpt6T
         V1/rkmDaN4psvzSXpntBTrGX+ghzK9WM36GVGdriJEbEmJ4XJqzS5MhH4VW993flin
         CBdBkL8Er1ehQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJe-Uw; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 21/29] docs: PCI: endpoint: pci-endpoint-cfs.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:36 +0200
Message-Id: <4b18febe4a4f030dd9d43e5e6a2a0aa28bd5b734.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index 696f8eeb4738..db609b97ad58 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -125,4 +125,4 @@ all the EPF devices are created and linked with the EPC device.
 						| interrupt_pin
 						| function
 
-[1] :doc:`pci-endpoint`
+[1] Documentation/PCI/endpoint/pci-endpoint.rst
-- 
2.31.1

