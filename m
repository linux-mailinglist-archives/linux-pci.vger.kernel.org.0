Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA35225752
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 08:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgGTGJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 02:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 02:09:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA6C0619D2
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 23:09:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so11904859edq.8
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UrD5c3jR+NFWrV1o5ImsXcot7fYKK7WjYf4DnPEx7UQ=;
        b=jEje+E+sWl808Bh/5opAej2FTWTxibUG1Epd+IcaGqxq5GjeUSqwUX4qY8CXBIawO7
         hhG5SZw7KdpKWHqk1kX2dTZOyUYdLJmkDbDmEuuDUJsxvyiendFFKgzaVLVFboIG99P4
         HtRH5lFSNdDsRVMa27w5TuZ69lSkpaUVBSOqzz6Ktlp275fuHSOZhWYEKP2fpyM/+Vld
         awk9o2zmQxUMSDX5mXd7aYRklavaMtfWE+2HZkUvDt4nxpeLlBMxE4atYbdnu4TI/3V3
         2TS0daF7mTw+mM6MmNtL5KPRgOOwaEa/FcCXHQItovFGORKqIMLYEzZcFcHTQrwZkNVI
         HBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UrD5c3jR+NFWrV1o5ImsXcot7fYKK7WjYf4DnPEx7UQ=;
        b=CJaPsqZ6esMDKqM2TPss3llcFGCjRRkOuy07kqPxLyUMxRZO9/Wbz2amXAGK219qA6
         bpia+U5pbL7xMfmkiWhZNZ6oT0DyV/ecsMxNpL7uLuB7dNc8pbvumhHzQCbMs+VWj3SH
         WSAHFGp+heposRtRENc8f9Gq8WTtblWnxmNKqpfrRTPxidpssoT4OlLGdBqokUvp2iZ4
         rCqVP3vryOkI8JTCryFLPbBTala1eoWy/ZkRwQ9K5h4Sk32b8EKUW0ALh36/Y1OoRxLs
         NQ9EcZaGc5DQ9XrOIvdfPyGzkeYzOpV+0D16ad6i2sPKmI8LDOdH0XsUCs3YYC3qvGG6
         FrpA==
X-Gm-Message-State: AOAM531PjYS42fgaZAUmK2u9HSEgDBQ4EZqWs4Z+onqMEIQw2SAD6WeF
        1ToKq8r0ftrhWd+f/R6owpaS07kQiPI=
X-Google-Smtp-Source: ABdhPJx3wUgFSj3fLw5BcNffFmwj3doIvhunr9GAtAGdkPSkGQeUm+jRAxD23v1KGAkcZtdtja5imA==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr20775434edy.78.1595225347675;
        Sun, 19 Jul 2020 23:09:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:a05d:48af:10ce:55bd? (p200300ea8f235700a05d48af10ce55bd.dip0.t-ipconnect.de. [2003:ea:8f23:5700:a05d:48af:10ce:55bd])
        by smtp.googlemail.com with ESMTPSA id p9sm13917410ejd.50.2020.07.19.23.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 23:09:07 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/ASPM: Reject sysfs attempts to enable states that are not
 covered by policy
Message-ID: <f51768aa-8e8d-65e0-497c-eda1741e8a0a@gmail.com>
Date:   Mon, 20 Jul 2020 08:08:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When trying to enable a state that is not covered by the policy,
then the change request will be silently ignored. That's not too
nice to the user, therefore reject such attempts explicitly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd3..cd0f30ca9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1224,11 +1224,16 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+	u32 policy_state = policy_to_aspm_state(link);
 	bool state_enable;
 
 	if (strtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
+	/* reject attempts to enable states not covered by policy */
+	if (state_enable && state & ~policy_state)
+		return -EPERM;
+
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 
@@ -1241,7 +1246,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 		link->aspm_disable |= state;
 	}
 
-	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_config_aspm_link(link, policy_state);
 
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
-- 
2.27.0

