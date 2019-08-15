Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E778F667
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfHOV23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 17:28:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39452 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfHOV22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 17:28:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id z3so1551793pln.6
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2019 14:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CzxowEpJmd11cBUgktNypBl0jin8gKn66clYtoWT60=;
        b=Lkf6z9Ce+rChidzNiXZC1q3WIXY47grSjd1qnYt93J0bPxL7ln+4F4ZrvgXZDQFEpo
         mtli2j+1csfsZ3L3EJnNPpuoiU2YOdcLdb2rSZCYIKlinus8q4dg73zvpqN2N9V4zKgJ
         RXj/FuBB2yD4SphYrxc0KgLjPbMs5akadHR2/tluOkD2QzWU9Gi9rCxqA6stZM/3utWK
         0PyESuhfgJGFJE1ruUqUmc3VKtv06ge5L/4gAvncITAkOKURLUDbL9MIAi16LoDgQjHK
         JUeWW/kelWjnAqeVQYU9AmBDWZ+IsiU3ICa+RG1xs7/UQQhJkc/lezCHBAoeqC6OQp/B
         RuKQ==
X-Gm-Message-State: APjAAAU0JEpJ1Mnv3cReARsJjnBzfNyRdRkC2SE9/6RrYbWXILHYaeMY
        UCpmTPTMoj8V2V3h1xFOuM0=
X-Google-Smtp-Source: APXvYqztadAAmV6phgUe9Ch/QnnH9D/HP0rxiJ9ODWP0n5K+Be2YSusjO2XKuGeFrDzRt/gK3z3kiA==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr6229024pla.197.1565904508045;
        Thu, 15 Aug 2019 14:28:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a3sm4066593pfc.70.2019.08.15.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:28:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI/P2PDMA: Fix a source code comment
Date:   Thu, 15 Aug 2019 14:28:21 -0700
Message-Id: <20190815212821.120929-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory"; v4.20)
introduced the following text: "there's no way to determine whether the
root complex supports forwarding between them." A later commit added a
whitelist check in the function that comment applies to. Update the
comment to reflect the addition of the whitelist check.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/pci/p2pdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 234476226529..f719adc2b826 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -300,8 +300,8 @@ static bool root_complex_whitelist(struct pci_dev *dev)
  * Any two devices that don't have a common upstream bridge will return -1.
  * In this way devices on separate PCIe root ports will be rejected, which
  * is what we want for peer-to-peer seeing each PCIe root port defines a
- * separate hierarchy domain and there's no way to determine whether the root
- * complex supports forwarding between them.
+ * separate hierarchy domain and there's no way other than using a whitelist
+ * to determine whether the root complex supports forwarding between them.
  *
  * In the case where two devices are connected to different PCIe switches,
  * this function will still return a positive distance as long as both
-- 
2.23.0.rc1.153.gdeed80330f-goog

