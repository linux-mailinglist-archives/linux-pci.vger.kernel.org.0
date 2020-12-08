Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5A2D2BDC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgLHN1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 08:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgLHN1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 08:27:32 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F2C061749
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 05:26:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so16240326wrt.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 05:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hp/t6rXGVfnrDxRU1xj2X6bN2VMpS5atgS8GkaFjod0=;
        b=OKLnAuBoKuzhPa4rutI2OHx2ttqHhz5kf1f9Phz7zLSucPI2mL14JuGYFeoDKFPHEw
         XZVdwnGRFtBpYDUYCGBRZICnQw6hHl3mbnn4aV0mTITmYlCQqNa7pvLW3Kli0nj9bcZf
         EYKC41PNEbXlrqFTbJhzLr+Kn2DjGvO6ZeZSRJ67Mh9oMnj2IHbjzQlWHbwomYPPuC/p
         hSdu4X08Jbe+hS3o6WeCrLymvd8k0LqzRTGHvrLF1jRG86MU2S3MlOYk6Z2588aP3x4H
         jQ2OxYLtmuSkCqtlGQqQZ84+Ow7B+GcVzul9YSXd+UIkQMTeopIkLvGtCVV8CPuusq0j
         IWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Hp/t6rXGVfnrDxRU1xj2X6bN2VMpS5atgS8GkaFjod0=;
        b=f9n/EffHMtwErUeI73pceJeH6nnP6YaHnhn/JQ196mD3D4IxoOK58YcdV3mwFazUbl
         oS4RoswgOcN94UuwzJOZzJ6hGnLpB9MfjFXnEM57FUYQ9c7DcQ/6TaWiuZKwoLJOGEKk
         Kp0GxXd78QOIP8FUGZp0dDhneChTIAUjGKuvxKEIA14ZvCqboRA7NopojoctJ+nS3QJV
         J8dOuGwKF2IZ/rbAEZn4nerirLZv+mxPdyZTPQ9ep8U+3rM86no20tNp1kccwmOwVtfv
         wRzG/QY2KxBJ+BBW6I+IpG/yPC05wVDsmibDMzI3m2x3qw/iN1kmB49GieUmXp1PUHRd
         o5Lg==
X-Gm-Message-State: AOAM53193VZ3MYW6BHGP/RxdeUU2XeAB7R8KVfu6kDPpuvmc00a6Q5qe
        rSX8qwHpfY6XM0rQKkOQkNSmQF/gdcw=
X-Google-Smtp-Source: ABdhPJxzjvuYl7bU9CNBCWZE+cp+cRTS6bVUDJyHVWUFxiN19lBo1CJjtNGC7cLl35RtMD2MSlmR8A==
X-Received: by 2002:adf:bc92:: with SMTP id g18mr3993617wrh.160.1607434010846;
        Tue, 08 Dec 2020 05:26:50 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id j13sm3784356wmi.36.2020.12.08.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 05:26:50 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Don't try to read CLS from PCIe devices in
 pci_apply_final_quirks
Message-ID: <b5b1456c-d5ff-d1d1-ba95-b9a12eda8ae7@gmail.com>
Date:   Tue, 8 Dec 2020 14:26:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't try to read CLS from PCIe devices in pci_apply_final_quirks().
This value has no meaning for PCIe.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d9cbe69b8..ac8ce9118 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -163,6 +163,9 @@ static int __init pci_apply_final_quirks(void)
 	pci_apply_fixup_final_quirks = true;
 	for_each_pci_dev(dev) {
 		pci_fixup_device(pci_fixup_final, dev);
+
+		if (pci_is_pcie(dev))
+			continue;
 		/*
 		 * If arch hasn't set it explicitly yet, use the CLS
 		 * value shared by all PCI devices.  If there's a
-- 
2.29.2

