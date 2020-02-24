Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 724BE16B261
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 22:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBXV34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 16:29:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53112 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgBXV34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 16:29:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so846106wmc.2;
        Mon, 24 Feb 2020 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArTAv9akc7/LkDwjVGNvRKjk3sNTR9LtjKLQSrks0NI=;
        b=HqueA0Lmn1Zpxq9axX/VWOSITGEVfEB6gNYiySfDYa+MnjQREfX353O41GJJlDmDVG
         BBLpXrJcwzfp8wyLD9tTJBLnCH0NzijpqXDNocE1ukKTAPByiEJiVqE+G5RJm0WGfYNp
         nnk9Mk001ImOqYNh/YUb7KH0dhuTY5XcWaVOdJzIjuDnCZlLgjIrt6c8TgGnE4IEo8Uj
         3tKGJuVmE8sabhkXM0g9UsX8ToFE0VLokzJ+ggyjxXtLj1WuA9PdE5ouVY8vPd8UCabM
         uGx7OYe1jqn3UAeKAR1fWL5jlVlstqcBhMdDIoLzfeXH+iqcWyNpoP6dz7Rzd5fan0nn
         G3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ArTAv9akc7/LkDwjVGNvRKjk3sNTR9LtjKLQSrks0NI=;
        b=QMLGX6dT6R7rRkfk+Wysl2NuTjjPN176mM0s7HXZpsRTRHiVbH0K0eS+CEnLbWrFZV
         Youzodjv9RbOzGPEpd+rMu/JX+tr4ZvYJd9wcvLBhIFKeQS0AUD81ATHBOjO/SwTeLEk
         ARZTpbumdjXnq4hoo6ztTGbTPdhBxtPDMCH6Jj+bRL4TltOIViwVpnTN1W25TeQe/llV
         vPB9EEWQZTfpsGntWIwz+H+gcjxSqTx45dAgSok3bkMOJtNTsfBJqkBx9ac1mqC+vw2e
         K93dH6JlnuQhoeD6Lzwe3fGNWw7d65gMSTQfCwJcMLaY1bYpSJNiPDvRcBCmgD/7RyQ9
         SDPg==
X-Gm-Message-State: APjAAAXcShwbMSKrktD32q8dHJtCKg1tWY9/pHNQ6FRNkNtfn785EBTu
        6frKQzpNNsc+pxL9tSzRK10=
X-Google-Smtp-Source: APXvYqx+DvUE0kC2j4UIbCGBXuUEWDtRHddCVoQpFeYEPG2WJbQ3xje4KUKvIQFUJ7q0sl1X381/2w==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr895842wmc.115.1582579792028;
        Mon, 24 Feb 2020 13:29:52 -0800 (PST)
Received: from ?IPv6:2003:ea:8f29:6000:3d90:eff:31bc:c6a9? (p200300EA8F2960003D900EFF31BCC6A9.dip0.t-ipconnect.de. [2003:ea:8f29:6000:3d90:eff:31bc:c6a9])
        by smtp.googlemail.com with ESMTPSA id f8sm20427058wrt.28.2020.02.24.13.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:29:51 -0800 (PST)
Subject: [PATCH 8/8] sound: bt87x: use pci_status_get_and_clear_errors
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
References: <5939f711-92aa-e7ed-2a26-4f1e4169f786@gmail.com>
Message-ID: <a336d6f7-42f4-4a65-0e7d-c99282e13eeb@gmail.com>
Date:   Mon, 24 Feb 2020 22:29:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5939f711-92aa-e7ed-2a26-4f1e4169f786@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use new helper pci_status_get_and_clear_errors() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 sound/pci/bt87x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 8c48864c8..656750466 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -271,13 +271,8 @@ static void snd_bt87x_free_risc(struct snd_bt87x *chip)
 
 static void snd_bt87x_pci_error(struct snd_bt87x *chip, unsigned int status)
 {
-	u16 pci_status;
+	int pci_status = pci_status_get_and_clear_errors(chip->pci);
 
-	pci_read_config_word(chip->pci, PCI_STATUS, &pci_status);
-	pci_status &= PCI_STATUS_PARITY | PCI_STATUS_SIG_TARGET_ABORT |
-		PCI_STATUS_REC_TARGET_ABORT | PCI_STATUS_REC_MASTER_ABORT |
-		PCI_STATUS_SIG_SYSTEM_ERROR | PCI_STATUS_DETECTED_PARITY;
-	pci_write_config_word(chip->pci, PCI_STATUS, pci_status);
 	if (pci_status != PCI_STATUS_DETECTED_PARITY)
 		dev_err(chip->card->dev,
 			"Aieee - PCI error! status %#08x, PCI status %#04x\n",
-- 
2.25.1


