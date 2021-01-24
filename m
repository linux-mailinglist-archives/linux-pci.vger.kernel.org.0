Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CD301D42
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jan 2021 16:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAXPkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 10:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhAXPk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jan 2021 10:40:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B9C061574
        for <linux-pci@vger.kernel.org>; Sun, 24 Jan 2021 07:39:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m2so8451800wmm.1
        for <linux-pci@vger.kernel.org>; Sun, 24 Jan 2021 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nEfmcnY2SNGxvFZXWMklRTzdftnORkRjeqq5ePF7+7A=;
        b=vAG/IMzcAJK/wRVQwmKomypIK/ybuQMXMoIv9rtgNRI4lQZWTtkWEYn/QEL9lQ6xZg
         fMMmKqE/uFVe/zJKEsLEhHTa+zXIIXkvvIPuV7QjSf2nPt7wJyKvfv8E4EKKTA1PdU93
         I+lMayC73Mwn40qaEVv3IZ7351gJNEHdjpOVcLX7Ebu5x81Eua8tUk3UDAn4bD8XXo5t
         483VCdJoiSMsU3+GuPklNJ1nRqp7Xcweh3s3/YLkCkSfh0v/BIK4iXlOduMYRrNqCs4u
         W4SqweYqBoNSW9Dhvq8cbbgbDwQDWRT+oDuhtPq9Ny50OvV3TqNbrlRWDyGhu/HVcBTn
         46Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nEfmcnY2SNGxvFZXWMklRTzdftnORkRjeqq5ePF7+7A=;
        b=ch1Y+sPcpNXn0yo9N1J7p2xhjvB6vhuW5ZXm3fEf8x3adDrYFVjuL+TK+ANyTPGWjQ
         ddVPpQyCvnNohvbDSDQxAKgBk+ngiwFox5A8Uu4WEqDiDnH2hGxCNo4runn/T8oxIKns
         qKz5d9k3/+irz6PuaV2ZOhG1RU5ouFLBVPaDVkyUJSAMvw5pAYp/hXtpYeI3k1xbwWML
         lbiK+ArxLJS1N4jPVWuyorC1qIxwJ7ePqS8cLNYMeWznazBDc1rARWQtO8E94WUNXbgc
         0HiG8gKbcrk/bUxjUisXmt19/UmLs9e12asQ2uSSMpUkD851phV4g+HUYMLndHTm1fH6
         jdVA==
X-Gm-Message-State: AOAM532jP2AvUC/Vrv7WRcbmdKrc/zFfHF42N/tAn/ZjX0T/c3EJOGKu
        saJMRif6rON4tXsKAinqqqUW/FQQqNI=
X-Google-Smtp-Source: ABdhPJyIEPsZN3xk1rfrR4qr09GzMxo28ZwMmfQ2KhKjlpLnadVIOw8Kv6ygjXgEWlu2hcPxXjFYiQ==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr2650036wms.176.1611502784475;
        Sun, 24 Jan 2021 07:39:44 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:6d62:6718:4fcc:a925? (p200300ea8f0655006d6267184fcca925.dip0.t-ipconnect.de. [2003:ea:8f06:5500:6d62:6718:4fcc:a925])
        by smtp.googlemail.com with ESMTPSA id h23sm17983567wmi.26.2021.01.24.07.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 07:39:44 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Fix handling of pci user accessor return codes in
 syscalls
Message-ID: <f1220314-e518-1e18-bf94-8e6f8c703758@gmail.com>
Date:   Sun, 24 Jan 2021 16:39:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Referenced commit changed the user accessors to return negative errno's
on error, seems this wasn't reflected in all users. Here it doesn't
really make a difference because the effective check is the same.

Fixes: 34e3207205ef ("PCI: handle positive error codes")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/syscall.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 31e39558d..8b003c890 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -20,7 +20,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	u16 word;
 	u32 dword;
 	long err;
-	long cfg_ret;
+	int cfg_ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -46,7 +46,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	}
 
 	err = -EIO;
-	if (cfg_ret != PCIBIOS_SUCCESSFUL)
+	if (cfg_ret)
 		goto error;
 
 	switch (len) {
@@ -105,7 +105,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_byte(dev, off, byte);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err)
 			err = -EIO;
 		break;
 
@@ -114,7 +114,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_word(dev, off, word);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err)
 			err = -EIO;
 		break;
 
@@ -123,7 +123,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_dword(dev, off, dword);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err)
 			err = -EIO;
 		break;
 
-- 
2.30.0

