Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F8B423D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbfIPUpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:45:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39853 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfIPUpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:45:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so831768wrj.6;
        Mon, 16 Sep 2019 13:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eXx97jIUvnWKUhsHS/jDfcPmaEhHScsepaLww/BGjQ=;
        b=se4ZXQsR3iyN4fqmN5C+nAf65xEPcucEC84URvhLQnNfDjay1x66bkSf+QDBdY0Yl5
         8kkezgv83ea6FNzkKNOSt2lrbmkvWKhP1htk4qj1Ir6KcGXHwydMAWGqH4nxnwM2Nkmj
         yqFtpeLOUzOztsrY7q2pRK6FOx8SEQlMjc3rDm23Phs3poUMfCgPY/OR0R9hjbRxv337
         gP/sVhddCFLUJpTSZGOp+2ppyEGg/WfXf4xN4ElTjN5o04yWOeWuCeqMQU3arI6d50/p
         3m3mH0p8rdEaPFr91NsHcTZZRUet8sXc0VrrQ7wnqMHWWNOG+s2vtuGRo27mcQEXIJUW
         fGNQ==
X-Gm-Message-State: APjAAAWvv3C6hu1Nb2M7QgJWZ90mOZaRtgpp1S/mXFnKDLmRR9alPaOx
        MraoszOiFIS2YJy1xj5HqI21oxYqrFc=
X-Google-Smtp-Source: APXvYqyHM8UA9SDJz1d8txwgNTURDLDNvolNfIMcs9JKwmOiilqCjpc62ifIaPkDslH6MdK8gAZZ4Q==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr198870wrv.68.1568666739007;
        Mon, 16 Sep 2019 13:45:39 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:45:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH v3 14/26] rapidio/tsi721: Loop using PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:46 +0300
Message-Id: <20190916204158.6889-15-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use idiomatic C style and avoid the fencepost error
of using "i < PCI_STD_RESOURCE_END" when "i <= PCI_STD_RESOURCE_END"
is required, e.g., commit 2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END
usage").

To iterate through all possible BARs, loop conditions changed to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= PCI_STD_RESOURCE_END".

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/rapidio/devices/tsi721.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 125a173bed45..4dd31dd9feea 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2755,7 +2755,7 @@ static int tsi721_probe(struct pci_dev *pdev,
 	{
 		int i;
 
-		for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			tsi_debug(INIT, &pdev->dev, "res%d %pR",
 				  i, &pdev->resource[i]);
 		}
-- 
2.21.0

