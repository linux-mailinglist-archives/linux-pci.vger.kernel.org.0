Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3833382DC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 01:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhCLAuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 19:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCLAtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 19:49:55 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D6C061764
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:54 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j15so7779548qtj.12
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wy+IwcbFe5iyl37uDl+oXBLCNbLEHUQXvTEZYf7ymx8=;
        b=TFaPttpAjNfe+2iixUj6bfpglHAqdyJonN+f/D/N4GxhYzufIVNkNGd52Z481IiXLa
         J7zK9PmVKfZgaMXiBRQ+GQtnc7Vrgn9nMBlfx1v+5B/BOEhThUKYOHdycFINi66rsJ9n
         k+rlStscftY35kfr5wg7QYXNcjmxPrl9goemzUQa08kgwYkcgPAmxhdD5RlWO5s5tIcf
         2Qxw4fQhL1ORNIz5WRig2l6/Q8mJ6txwoQqqPLf970ALae7jjgaj4GvNENLYY1wAqFr7
         2UZoruoI+cwg1gYH1874qrh6FP4ZiB0odU/ppmrbRZZrBthB+1LqWzxw8PqfRpKrDzFV
         7Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wy+IwcbFe5iyl37uDl+oXBLCNbLEHUQXvTEZYf7ymx8=;
        b=rPmdME+8JgybVeRWuHQO5YrFV7xDfwIjCNh2zcjbK7OiW+n22J+ydbFfg6ge7wscb8
         PZ+3JNusi719H/AkD4DvQiQfHfr/yn4MiqMPPueCf02OTsslifN6y6sbfDCA72qRpSBd
         dpecxYA7vEXk9AS1oDFAweSPFcZ5ANw+G4bE9SUrhlkpnEzvG9mjIe/e7IB9gx/kwdNA
         yrvLyan9WzOT6jOX05Kd01IGHiBhA1qw8uKWkbF8SUBII7mBNU5/OX34zfXBkDRg6Nug
         d3dv9dKqTmdpybGjO2CT7iOPcglI8WIdbNpfFkR15OfTxvlPX+7VlvJ7H+s5IML4AbpQ
         E+UQ==
X-Gm-Message-State: AOAM532T8yhRsXNnX9Al7pqRRN3wrElCE7Ozbx6JPmUKAbC54oClN5ZI
        vxDMl4HlNSUZ2606WCPJAZ+5cIzMpUGOedYKrPc=
X-Google-Smtp-Source: ABdhPJznSvPJLG6qaFoP2kj2Ov4WrW1xkoR+hl4AeQuvmUyvA146uVMjKfz/DR0rMwbjq3TBrHrovQw5xd3PO2vJOjg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:50c7:: with SMTP id
 e7mr10016068qvq.58.1615510193452; Thu, 11 Mar 2021 16:49:53 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:19 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..6be5b61a0f17 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -75,6 +75,7 @@ config ARM64
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.31.0.rc2.261.g7f71774620-goog

