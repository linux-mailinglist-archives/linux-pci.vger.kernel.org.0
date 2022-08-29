Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A25A545B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiH2TO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH2TOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 15:14:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C6ADDF;
        Mon, 29 Aug 2022 12:14:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e13so10476551wrm.1;
        Mon, 29 Aug 2022 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=RbO37N7QTpIQObWY9aOOdCjJI6oZh3oO2MXU7agHs6U=;
        b=oe2gcoy7afZSoYTfqsWGmfLr+2OkWLKXaVyiBos5ZKOfHzSuOK7oHGXHgU+gu7L7LG
         W3jAp0kKUJahon/TeiKVeBdOiRcK/ZYobvdBRsmxQVGYdKP/HBbyvccmqLNyrfh6hJpI
         xrQLH0+4fw8bwigJMn+lcpsmWEzeRZ67yAFyeN8guVrBjEVGOcWsBhAtemAL2y5uLTic
         cWYpygRWMky8D0DuL6i2OMkDsuROZqIzzsp/UFuxHwUCFPGJuATtOU1aACAGATKfnKn4
         qwPv+HX8lsLb51+LgntOHh3N3dnEtWA5iAMV4n5sE7RofDF+aFKRnFIEzAe3hG8LL3SI
         I9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=RbO37N7QTpIQObWY9aOOdCjJI6oZh3oO2MXU7agHs6U=;
        b=oHjpVGQKp7ugwhCxF5u9yxGucPDfOXYXIRsmjSbwfUEhtwt4C16ytkKnYCUuEQsJPP
         b9Zt+fWcNOOsMOYRS+qcYdYSH4YSwLBRTM8jZwVBvQUMvJXr3T7kxdPFSOCOh11BKCFI
         FTHCJzwgc1v9MiV/zenixxaNv+tE1SdKNQ4GH+GAXh7LddTuNPIKAlFj2crcbseR8UqT
         vkYhAz4gfhd8csZa1MqUfS2YyfFdzqszp/WgfONjhqXWgwyyPekSJJdj3CLygAV4g11L
         8R4fDoArJ0MqajboU3qI8+abpZt7o0hxtVIZlNGo0C/UjRe3N+xKamtV9Jz+E9ocwKMN
         jymA==
X-Gm-Message-State: ACgBeo1YrcxUYjZJVcWD+yvC6/Ce1bLiLqi3iFvWz9x+aUjeUaQdcvBh
        94nET0rIfHJet3R2MvJIEgI=
X-Google-Smtp-Source: AA6agR5EJ/fJpEhZ/3hZPLRybA1/GrgOVV99uCtO1s1KQwSyrOu8UD4VIpINTiZmhis+XHi6o1KR7g==
X-Received: by 2002:adf:fc83:0:b0:226:d2d4:bc27 with SMTP id g3-20020adffc83000000b00226d2d4bc27mr5678528wrr.606.1661800485519;
        Mon, 29 Aug 2022 12:14:45 -0700 (PDT)
Received: from [192.168.9.20] (IP-91-192-2-192.techmedia.com.pl. [91.192.2.192])
        by smtp.googlemail.com with ESMTPSA id bg36-20020a05600c3ca400b003a845fa1edfsm6888188wmb.3.2022.08.29.12.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 12:14:44 -0700 (PDT)
Message-ID: <4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com>
Date:   Mon, 29 Aug 2022 21:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Korneliusz Osmenda <korneliuszo@gmail.com>
Subject: [PATCH] Guard pci_create_sysfs_dev_files with atomic value
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Gateworks Ventana there is a number of PCI devices and:
  - imx6_pcie_probe takes longer than start of late init
  - pci_sysfs_init sets up flag sysfs_initialized
  - pci_sysfs_init initializes already found devices
  - imx6_pcie_probe tries to reinitialize device

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215515

Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
---
  drivers/pci/pci-sysfs.c | 6 ++++++
  include/linux/pci.h     | 2 ++
  2 files changed, 8 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fc804e08e3cb..a6648239e235 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1378,6 +1378,9 @@ int __must_check pci_create_sysfs_dev_files(struct 
pci_dev *pdev)
  	if (!sysfs_initialized)
  		return -EACCES;

+	if (atomic_cmpxchg(&pdev->sysfs_init_cnt,0,1) == 1)
+		return 0;		/* already added */
+
  	return pci_create_resource_files(pdev);
  }

@@ -1392,6 +1395,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
  	if (!sysfs_initialized)
  		return;

+	if (atomic_cmpxchg(&pdev->sysfs_init_cnt,1,0) == 0)
+		return;		/* already removed */
+
  	pci_remove_resource_files(pdev);
  }

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..5477de2ef057 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -465,6 +465,8 @@ struct pci_dev {
  	pci_dev_flags_t dev_flags;
  	atomic_t	enable_cnt;	/* pci_enable_device has been called */

+	atomic_t	sysfs_init_cnt;	/* pci_create_sysfs_dev_files has been called */
+
  	u32		saved_config_space[16]; /* Config space saved at suspend time */
  	struct hlist_head saved_cap_space;
  	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
-- 
2.36.1
