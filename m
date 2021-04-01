Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51AC351B9B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhDASJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhDASDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:03:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D79C0613B3
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 05:04:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so2712051wmd.4
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gAhlVxUutQWC+uNCYQO7uX+BL4jBPv4pGWL5UxAihDE=;
        b=C+boqniJPxxl9EWgDxaWo+jwpZvpBejsNa/n+E8+hxJg5N76dxz78vpIPM9J9eLxhP
         Wfqlg5DyPhcVl68uwlqgao2K9Px16Zj8nvDiOFuTQtyeGnX1nmbf+0UNFt6ykcLa8v6F
         NJpp6qQD8qHmtZs1qMjhpJxPmiNdTi2th8uaMiXa4f7oD4hTXer2fcqtY3xGB3t9+8vs
         bEfBEgNVEm/Q6moBajcPvaCbsVPqg8ZqDoN7T5tA7GNkmqSOJ+7Jfst3eigoTKNGWcyY
         Q2UfZP1l8k7I9RuDeya05Eh8jBvsBFmj/6tubQ4NElONoVr9QgrM4c3maukYXgRuNyu6
         k2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gAhlVxUutQWC+uNCYQO7uX+BL4jBPv4pGWL5UxAihDE=;
        b=eQwqXUXmoh0Uwct5z0GEbhug6QLxRncOnQjUWRZbUcqwuCeBvIefbCXM1AE0ybLWNh
         mPzmQ6LpTOpGnZRch/HCr818s3/9BfHNlVFMwJip5axfVIqQZgoji2o6nJkx1D6oL/Q2
         2kgl+VCDl2ncUfXrnuM9OGm8ynEm5i1wzqruWG8sLNR3iYX3wC+xd+gMHgkvucB3D76s
         VpR9ZW4aCvvDox3TTH7RefOmsZ/5+d+1QIITfpLfTWL2rO/toWWlTcAwVIck/pafod7m
         n2g9mowCDehXL1FWCTk21RJKTcviS8nbIY1STG+epvQkkeNFD5tqvoWK0XlluVco+zwq
         OLOQ==
X-Gm-Message-State: AOAM533eQRB1Oeb23jy2sXEhXeylsxwFnW9PCr1CDdY/vMoNoKCftQXd
        i0A27MvaEW6/tBVmOTii5wxe7bCSPJCJEw==
X-Google-Smtp-Source: ABdhPJxtG4iO1JfOb85+6KFeCw8Mtx4ZhcVPwP/rhse1ygwLQadmCx1NZvaW8acQcTqYHgN7AW/RUQ==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr7938490wmq.159.1617278662063;
        Thu, 01 Apr 2021 05:04:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id q19sm8025984wmc.44.2021.04.01.05.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:04:21 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] PCI/VPD: Silence warning if optional VPD PROM is missing
Message-ID: <ccbc11f1-4dbb-e2c8-d0ea-559e06d4c340@gmail.com>
Date:   Thu, 1 Apr 2021 14:03:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
optional VPD EEPROM can be connected via I2C/SPI. However I haven't
seen any card or system with such a VPD EEPROM yet. The missing EEPROM
causes the following warning whenever e.g. lscpi -vv is executed.

invalid short VPD tag 00 at offset 01

The warning confuses users, I think we should handle the situation more
gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
optional VPD PROM and replace the warning with a more descriptive
message at info level.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2: - don't remove user info completely, replace the warning with a more
      message at info level
---
 drivers/pci/vpd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index d1cbc5e64..48f4a9ae8 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -74,6 +74,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 	       pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
 
+		if (!header[0] && !off) {
+			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
+			return 0;
+		}
+
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			tag = pci_vpd_lrdt_tag(header);
-- 
2.31.1

