Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267C39C897
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFENUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 09:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFENU0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48E996140B;
        Sat,  5 Jun 2021 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=0wrVNZznKeJfo5SB3znfHgOnJ4tfb20n/hagYRQA1zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWDZdNlAchDmkSQ9YiZdQyTJmH2AhgzxnaomZAo7Cal6QS2gfPhbReZ4LLYSybukS
         aqib+5GWN54e0N6TW3pAkGv+1UeLLHeknPbZv5X9ssuSf4VxJgBbVBH3a47QN6hMaZ
         vcJmhffXkMyC17TB/Y8JKsA8hp+D9UNjyRra1I5oYpEK3CDsEZmMkcWk0pU6UMwnK7
         bQ9lPrC0yHN14iv87Clza03LgOlBQ1GxZiER6mhcox1xGvI/TB7M5b7mA2kTiXO2J3
         jCwfnsxxKAwXynIGzZNTLXiYBZYrjZ8BES06xx8h6GFlkRSyeAhq0CPz1xCeVttsmN
         PQWnf49AgVgHQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GG9-FK; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 26/34] docs: PCI: endpoint: pci-endpoint-cfs.rst: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:25 +0200
Message-Id: <5268f6eb75bc0fe000f4884bca0a17f01eddbc40.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

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

