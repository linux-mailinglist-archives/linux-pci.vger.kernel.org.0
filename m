Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87842C88D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJMSWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 14:22:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC65C061570
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:20:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so11386317wrl.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=S4KiNJ0xwtVPHy1jy7OLgTDaym7CvCdiNC8o8ajWkDc=;
        b=kvkZHGFd/uoiBlsdnwEUMUUOate+uJKaXp0yYY4HQevbTUncJgMgxagjJWQugxYZSg
         Oc7z4nsZdG+s7H6JjnA2cbJ9UL7RNw4cg9tT1ib8CjaG6zwAHHrv9b/QCoxJrBLVKMv8
         fCsrwgc195hM2lcNB5OzIlSQ7w88u+XOJQx3nTgnrl2EAxEMNy6ENgd6FLXMEIB1EFlq
         LfdkvbS+PjlsYHFOzEqvgPbVjhdUmoGV8qzjAAhxJ48xV70qmdkKhyPekCoZ6COtfPIy
         4VoNECHuEOGIDwOKgvaIAPRlhcW/fQIpWR8dTzVWE99hUnDJTqsbVJI065cdNRk535kn
         kZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=S4KiNJ0xwtVPHy1jy7OLgTDaym7CvCdiNC8o8ajWkDc=;
        b=NLZg5PeiAJQ+P49ezViem/2ziQEQpKvOrpbkeEnvV92ebk8kRW1At+teuFZLOJpeXA
         cHE2BLg8lviswDYDXuhUE5PUX67Bmq8FiaH865CHpz6ZXUkGWa/FCdWR5tfCOZK+OqdT
         NNeJdHBaiZ9n6rmMzC0xL/7y4DdzC9aYRoRjrXB5P/cnmEt3R5o+jFVhfUPYrzUZpkdL
         omVMNPAHlCFgXEtBhG9UKG4Vr2bzpoFns6W/GbxTZGFJgpaPUZG4NY35Yws3yB5Af2or
         w6A1h96+fDQgEV5Au85ZzjkohXjoIPSA/L1LQOCb4dZfZ0VAgzwMRfqMvT/hZSFdb/Qs
         stfw==
X-Gm-Message-State: AOAM531rxwNTZM6+8SbCfm/sPcx15J5cuQJ50sOEcOKtTCV6Txv5zjNt
        9xCbVu3ApgckUCX4JJnnjfsOEIj3I8I=
X-Google-Smtp-Source: ABdhPJyg78Cvnm4WhwN72wN4MX6xNrEnthtEE3KdDg5ZUwq1EwVhCZPXo7pB6eiCIJWrX14+zrxcCA==
X-Received: by 2002:adf:8b06:: with SMTP id n6mr813690wra.5.1634149211408;
        Wed, 13 Oct 2021 11:20:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:fa00:49bd:5329:15d2:9218? (p200300ea8f22fa0049bd532915d29218.dip0.t-ipconnect.de. [2003:ea:8f22:fa00:49bd:5329:15d2:9218])
        by smtp.googlemail.com with ESMTPSA id l5sm278501wrq.77.2021.10.13.11.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:20:11 -0700 (PDT)
Message-ID: <6211be8a-5d10-8f3a-6d33-af695dc35caf@gmail.com>
Date:   Wed, 13 Oct 2021 20:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Fix stack overflow caused by pci_read_vpd_any()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent bug fix 00e1a5d21b4f ("PCI/VPD: Defer VPD sizing until first
access") interferes with the original change, resulting in a stack
overflow. The following fix has been successfully tested by Qian
and myself.

Fixes: 80484b7f8db1 ("PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 5108bbd20..a4fc4d069 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -96,14 +96,14 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 	return off ?: PCI_VPD_SZ_INVALID;
 }
 
-static bool pci_vpd_available(struct pci_dev *dev)
+static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
 {
 	struct pci_vpd *vpd = &dev->vpd;
 
 	if (!vpd->cap)
 		return false;
 
-	if (vpd->len == 0) {
+	if (vpd->len == 0 && check_size) {
 		vpd->len = pci_vpd_size(dev);
 		if (vpd->len == PCI_VPD_SZ_INVALID) {
 			vpd->cap = 0;
@@ -156,17 +156,19 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg, bool check_size)
 {
 	struct pci_vpd *vpd = &dev->vpd;
-	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
+	unsigned int max_len;
 	int ret = 0;
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (!pci_vpd_available(dev))
+	if (!pci_vpd_available(dev, check_size))
 		return -ENODEV;
 
 	if (pos < 0)
 		return -EINVAL;
 
+	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
+
 	if (pos >= max_len)
 		return 0;
 
@@ -218,17 +220,19 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 			     const void *arg, bool check_size)
 {
 	struct pci_vpd *vpd = &dev->vpd;
-	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
+	unsigned int max_len;
 	const u8 *buf = arg;
 	loff_t end = pos + count;
 	int ret = 0;
 
-	if (!pci_vpd_available(dev))
+	if (!pci_vpd_available(dev, check_size))
 		return -ENODEV;
 
 	if (pos < 0 || (pos & 3) || (count & 3))
 		return -EINVAL;
 
+	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
+
 	if (end > max_len)
 		return -EINVAL;
 
@@ -312,7 +316,7 @@ void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
 	void *buf;
 	int cnt;
 
-	if (!pci_vpd_available(dev))
+	if (!pci_vpd_available(dev, true))
 		return ERR_PTR(-ENODEV);
 
 	len = dev->vpd.len;
-- 
2.33.0

