Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E24207D71
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406551AbgFXUeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgFXUdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17741C061797
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s7so3503462ybg.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=063/REsTpnFRr+cDI+sseVhgFckW5SG29uiho3UNZTY=;
        b=QHLFKZjziQv1B4lTQJOFrFkeBBeD3vqMRAW+KU8uSJ0z8P5diTku752ppGYK+p1sHj
         Tuqj5FmieFc5zewP3DRNS5iM40Pga5Yd012RZ1UJSub9OeGcQ/BjM9Xhswo2S+wawZKA
         RoZrP4AKzJhPxHnp2kwUEq2iAcWJC9Jvd0o41DT/D0J5C0PT78vt0tH2KpFNFHvjKqOE
         izzBiEOpzdtuThxfwOEyO+K5m3BsSaqVWi7OpscZsOWnWe/8qa7rh4O22Mfte1SMk6Qe
         rW+Cnirb92ArG8+1lDPtjHVyv4CvsFhD6/kzdDW605IdVtQymCiQD3WRRYOvRlD/Mv+p
         36IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=063/REsTpnFRr+cDI+sseVhgFckW5SG29uiho3UNZTY=;
        b=nKTZi0Kf4kP5nJuPzcAdD6veNTp4g/WMwFuekuJt/rqqC1RRK4IC0ZjAh7q3mf66+5
         Dm5irE/KCen7nnvwhLc2INGFRlFXvME2dlhKRCfwxKVCSA9vxmjOev9VahRD6I2IbfFx
         +aWGQ06OYcZkiLnKXqKKTLC1AIQiFTi3aXDLie7IfZZaJmdqFM+Hdiy0cp+8+LRFiWCf
         Rc09me9SII1QJpJ1C8gWtbGRQg1w5V5DKSLcz4SwMo5+dBgeAGIb2bes4xwUHIitkX+h
         3b+FUsHVK+JQsG/gemLloimb+L2oxgYXxeH4AXUVG6euf1LYg+/yQiF5p8jXl/a9SETj
         OCdw==
X-Gm-Message-State: AOAM530GOKRfCciLQRcq9aRSj+f7UfuBS6ohb8D8EeecfV8moUXmuC6p
        9KQuqTuL4Rv6vLSE4BoWe6xaqFYWAcqBaPR9NCc=
X-Google-Smtp-Source: ABdhPJxSD93X1bZbMxIVxbatDlNzo+plulwlXrP7mUhDGUyc2zpYsUnUjocqKRL/aFZ9kJnCfhHJEfDbrbY1YJULi70=
X-Received: by 2002:a25:e8b:: with SMTP id 133mr46457083ybo.13.1593030803250;
 Wed, 24 Jun 2020 13:33:23 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:52 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 14/22] efi/libstub: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..95e12002cc7c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -35,6 +35,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.27.0.212.ge8ba1cc988-goog

