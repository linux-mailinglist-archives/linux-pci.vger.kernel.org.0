Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05769BFC49
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfI0AZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45140 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfI0AZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so745907oti.12;
        Thu, 26 Sep 2019 17:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSIM/mVNAQUFTI8poYL0tbeVsabT6n06A8LUKfKixqE=;
        b=UwbwatXpaojKG2T+EF0sCiKPxLZzbRNJCRU/1l4Hdor8K7puYEzz/EjhB7MA6hB/Vb
         ReCpYSa12FvcLXDltZ458bNPHiGhEJ60H7BzzDWz7/VbBISP0kKMDqtaHQDL+CYjSnEx
         CfG1OhLDFNtj0XErLDT8KuDFudbktd1zwRaDwS7TwRsaJKMaVxXlgBFdCCQ+gFUwxUIX
         a2EcA1dMw8jmt8OkSkfgzLGNfUfyiidQRMFzXg7aCORwIRV5ynfL1byMsDfSLwbgffJg
         PrZqSH7tRcNwks6UQx+iWY6mmluHTHmJH3dsilME2nj3vR+wx56WlNOuSMP8eHRpNux/
         sE0g==
X-Gm-Message-State: APjAAAUy1TlVx2uo3KNBAj+rUIhzBoC3oIn7MeXs57P+5B3928O1fBYU
        /kG3dRY49RfZzU4+92MeJMfS6Xs=
X-Google-Smtp-Source: APXvYqz+gt7zD0g7DVclnrzC6AFnTepOJfcgHAqg8BRkcLS/bgxsfuL2h2LiMFlwEq9ILoaJHvmz+w==
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr991391otp.221.1569543911563;
        Thu, 26 Sep 2019 17:25:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 10/11] of/address: Translate 'dma-ranges' for parent nodes missing 'dma-ranges'
Date:   Thu, 26 Sep 2019 19:24:54 -0500
Message-Id: <20190927002455.13169-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'dma-ranges' frequently exists without parent nodes having 'dma-ranges'.
While this is an error for 'ranges', this is fine because DMA capable
devices always have a translatable DMA address. Also, with no
'dma-ranges' at all, the assumption is that DMA addresses are 1:1 with
no restrictions unless perhaps the device itself has implicit
restrictions.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e918001c7798..5b835d332709 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -519,9 +519,13 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 *
 	 * As far as we know, this damage only exists on Apple machines, so
 	 * This code is only enabled on powerpc. --gcl
+	 *
+	 * This quirk also applies for 'dma-ranges' which frequently exist in
+	 * child nodes without 'dma-ranges' in the parent nodes. --RobH
 	 */
 	ranges = of_get_property(parent, rprop, &rlen);
-	if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
+	if (ranges == NULL && !of_empty_ranges_quirk(parent) &&
+	    strcmp(rprop, "dma-ranges")) {
 		pr_debug("no ranges; cannot translate\n");
 		return 1;
 	}
-- 
2.20.1

