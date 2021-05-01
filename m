Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03643370771
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEANoR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 May 2021 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhEANoP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 May 2021 09:44:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45414C06174A
        for <linux-pci@vger.kernel.org>; Sat,  1 May 2021 06:43:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so804330wmv.1
        for <linux-pci@vger.kernel.org>; Sat, 01 May 2021 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1q+tmNEi+/p/jX9Zo9gmqbdVRaBJ6gVM369VI6F33Rw=;
        b=HwOAc3sqNhOZ06cDxu/9ZCCSyfzVjRard8b1HD8KT+uOl0zCx51X/56SJ9gymqi3xF
         eafpKxKuDeUaGLezMoc3RARWmmVv7bXOmQo0m5Iv2A4St6YI7DWyzfTdHc7gaW7HxXlr
         eHAVfbvWtLr799538SWMY52RsStjYR3U0MTic96kK/7TEsWg0uansFHz5MTQwYIzGe4c
         vrbwEdPem35A1chYF5pFILlJ5zDZZyl9LfYDE0F9G11Paqkl4ob6tiYpgRp5zIy0D838
         ctXNLFvM3Z+xH2OneDGoEbdivcrOWYE4qxdu4N8CZ8K/J5tvYYA8yuLRAU3TVSqOATN4
         rUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1q+tmNEi+/p/jX9Zo9gmqbdVRaBJ6gVM369VI6F33Rw=;
        b=a+T3QZIswMPG/qAJhid5Hhu6wdTzuGkWjI2yg2hYVdgY8nSZYoB0m9vXfqB0T1dtmW
         Z4mEphE+ulajZUdoB/5EQHLJze+P51zFEXVo690OOfCGQn7+B9y84hYIIslxfuH8WX5E
         wF5BXtTMe4qG/5NtLhQ3IqQjofqlGxY/HmV7NEhsZH3CmsziQoUnsCiHisnHujC8T8KC
         gk6MqkoZt1xkEhZymJyNJtozSjGmsGqyL91AmNwl8AxH/n53YMukQszRsKi7g9KO1QXB
         oWwvG33YFE0lcYYJuOvfaoN1VHgUBX4YPWbeAjEwHAMURh/WHogxR1GjA/YOvW9AZUi2
         eeyA==
X-Gm-Message-State: AOAM532OFOl56P68Qy3AVrBLrYJh3jymu9V0SvbNeEGc+ybr+sCKZCQn
        Sl6hCuhW2g64RdDEg/ayKS3+iiE7kVJtfw==
X-Google-Smtp-Source: ABdhPJwurq2qEgfEwdPpxEsMljWjGqYC1aEE7X92e1a00So1j7cSfy1CnUd132iEzlfaILVRGsn/GQ==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr11872161wmh.187.1619876602977;
        Sat, 01 May 2021 06:43:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:85cf:5643:a9e6:8be4? (p200300ea8f38460085cf5643a9e68be4.dip0.t-ipconnect.de. [2003:ea:8f38:4600:85cf:5643:a9e6:8be4])
        by smtp.googlemail.com with ESMTPSA id j13sm7870780wrd.81.2021.05.01.06.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 06:43:22 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <6edebb53-b714-3205-6266-d02416fd3cfe@gmail.com>
Date:   Sat, 1 May 2021 15:43:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this patch we avoid some unnecessary looping and make the code
better readable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 741e7a505..0752505d7 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -163,12 +163,11 @@ static int pci_vpd_wait(struct pci_dev *dev)
 }
 
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
-			    void *arg)
+			    void *buf)
 {
 	struct pci_vpd *vpd = dev->vpd;
 	int ret;
 	loff_t end = pos + count;
-	u8 *buf = arg;
 
 	if (pos < 0)
 		return -EINVAL;
@@ -197,8 +196,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 		goto out;
 
 	while (pos < end) {
+		unsigned int len, skip;
 		u32 val;
-		unsigned int i, skip;
 
 		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						 pos & ~3);
@@ -215,14 +214,19 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 
 		skip = pos & 3;
-		for (i = 0;  i < sizeof(u32); i++) {
-			if (i >= skip) {
-				*buf++ = val;
-				if (++pos == end)
-					break;
-			}
-			val >>= 8;
+		len = min_t(unsigned int, 4 - skip, end - pos);
+
+		if (len == 4)  {
+			put_unaligned_le32(val, buf);
+		} else {
+			u8 tmpbuf[4];
+
+			put_unaligned_le32(val, tmpbuf);
+			memcpy(buf, tmpbuf + skip, len);
 		}
+
+		buf += len;
+		pos += len;
 	}
 out:
 	mutex_unlock(&vpd->lock);
-- 
2.31.1

