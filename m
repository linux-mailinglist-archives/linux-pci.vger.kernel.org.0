Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3018D1E69B7
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405969AbgE1Sr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405966AbgE1SrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 14:47:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB7C08C5C6;
        Thu, 28 May 2020 11:47:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs4so915426edb.6;
        Thu, 28 May 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C0hYqHcMOeGmeNkFJaRKYE9LRqgonnvy7dyDwDZLMKk=;
        b=Z+7cOlU1Z+FswU1WSwnvV2gStkFRPyxQ8ZhAIpohlCoCBMIOFhAF9UdQZq2dMxTVi/
         u3vdVfV7ZgPht/zGL1mG4HDugozPSsHUyRB+brGbftGi6PoVjvR1+33I517fD/zazGhZ
         22yyHsv384ySypfY0RphM2zS72g5YV+i8VJiq/j6FvPDGQBQs48cWtW/CQja5Trr5QBw
         0E4gy64WdaNuRPObBHndMGtCyGfoAg2AT0uv9bt72g3uCAhZZIODedBHkQ44q4PeNfkM
         y1y2DuIsOdYMLcn9L/lAeG/S+mG0o5HWxvwrVeUM63UZ9a2x3P/ON2Su7CwMskmE7ggY
         Rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=C0hYqHcMOeGmeNkFJaRKYE9LRqgonnvy7dyDwDZLMKk=;
        b=PRvC/ctv7qcDvuXyZD1ogVGArQUKatuS/fTBYruuiZm6jhHAkl5ZdeXY6ZttcHasMF
         As6ppHFqww/Om9RxbOcs+ENkU3jvLpWhWgYYLJxuV6i0fB4Ww5uDyDaDerZ8DfO9reY9
         zKOYObmgnOr8nyuBLBAOX149UJmQbIEXhSCchzHa7qFYHEw2iwuP1idd+e2XLdH6b70K
         5wFbwy/SpCswfJQZ7H4JDibocPtXTBwSrj2w5b6pCAG5vVa08prqbcW9izreyIlE3BaL
         PjppzKjDjNDkIGsnQ4NZF0LTVINIRHOMPAmDQfnO+oYe9Ed25yIH/HUDU780rTx3/9FA
         tdEA==
X-Gm-Message-State: AOAM530ang6rQX16F9ZKqRw76NtsYLs0dl5gEr/guQ350cxXzRetRUWG
        HR/AWqHSv/LyZQYT84u2cvF3L7rZ
X-Google-Smtp-Source: ABdhPJzH6sLGHOUWeATOskSrI00u0rH4Gx95oCEfcaPwrXya9BwAfrI8AVrNG0c/wPk2P1BUcJ6MdQ==
X-Received: by 2002:a50:a412:: with SMTP id u18mr4739604edb.192.1590691641603;
        Thu, 28 May 2020 11:47:21 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f28:5200:593c:f5d:44cf:3de4? (p200300ea8f285200593c0f5d44cf3de4.dip0.t-ipconnect.de. [2003:ea:8f28:5200:593c:f5d:44cf:3de4])
        by smtp.googlemail.com with ESMTPSA id b14sm5038552edx.93.2020.05.28.11.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:47:21 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: PCI: Disable not requested resource types in pci_enable_resources
Message-ID: <18bb3264-9901-135d-8b40-1ee98dd672f1@gmail.com>
Date:   Thu, 28 May 2020 20:47:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, if both resource types are enabled before the call, the mask
value doesn't matter. Means as of today I wouldn't be able to e.g.
disable PCI_COMMAND_IO. At least my interpretation is that mask defines
which resource types are enabled after the call. Therefore change the
behavior to disable not requested resource types.

At least on my x86 devices this change doesn't have side effects.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/setup-res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d21fa04fa..6ef458c10 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -459,8 +459,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	int i;
 	struct resource *r;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
+	pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
+	cmd = old_cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!(mask & (1 << i)))
-- 
2.26.2

