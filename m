Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659BA2EAC2F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbhAENov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbhAENov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 08:44:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3010C061793
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 05:44:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so3046156wma.5
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxBOSPXdt1KE4KRfESGM7lDH9UwLyaTef5/94sYT5Lg=;
        b=k9E22mhtoYSmxWgLV32Zz/wEftwzeTRJXDbpQLK6jVSyHqR/ukMZ4xEK9wd3kGdOu3
         ApSHMRCcDOAMuT5v8n/diwEZKz24dasn4j0Q6KXvok2eOdNYIkuFsTbk2XXtKoMOGb8F
         wjxt2ShqGzrkqLnm/BnTM6jH7hbioAlEQbj0ycjfaNkwqLSI27JVHkd1dkA3xQTITzGP
         0fSOqZeiriMZIA6pHXemwgiJ3jsELV3pLdhyK+LINiPYjIffVrZQMVPTcmgcZ5dNTMTj
         iYrcNgy1+HLmpZgWq0Hq7zMYcw58K1KjWeyXmC45kjNaUT/VD2CLE+gJaDcs/N8AqDzX
         w2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxBOSPXdt1KE4KRfESGM7lDH9UwLyaTef5/94sYT5Lg=;
        b=lpb10TpaE8H3ukZK6aIn9F4dteLIGHVC71VJ3BRWRB3Sp4weXjmif21hx1ojg+DdFf
         z7g14lVXO2KYribO7VUoN+37yEL6Q/1JhOu5gl43bD3KqmJIZMPXvRKJkz8fK5KFPJNT
         SnrVwm37tw1s9d62sEuhTOPFtuX+aVrBSri+gavN3VsAh7KbwBO9oln7SYl//rFjTeMx
         +QKZxlHe5h3VW6Py4PYkt+VejP4PVyqKO1QBkizOA8S23y4y9yeXen+POdkgr6m9MZLd
         HduwcU81ZmpmHOw8QIRVaDlZhFeUJgisOy7InjAoERrwilnHKDMzoBANVSjuVfQQ/IXP
         3sAQ==
X-Gm-Message-State: AOAM533OmlwxZBiB/cIzVwtVJYk3j/tvbBbCZ6Kb/nTVcygnGuDp1MQG
        7D/XsFEESWNYkkLRm4o1WIaxcu++tLI=
X-Google-Smtp-Source: ABdhPJzEQpuZDGSyAKMlkTFO1nHHUn6kxF5BqQSJS9BhEdjJ9giJfYIF4nCODnMfgKaEKi9Q8gXe7A==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr3636179wmg.65.1609854249584;
        Tue, 05 Jan 2021 05:44:09 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
        by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:09 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com
Cc:     devspam@moreofthesa.me.uk, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/4] pci: export pci_rebar_get_possible_sizes
Date:   Tue,  5 Jan 2021 14:44:01 +0100
Message-Id: <20210105134404.1545-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
References: <20210105134404.1545-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Darren Salt <devspam@moreofthesa.me.uk>

This is to assist driver modules which do BAR resizing.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/pci/pci.c   | 1 +
 drivers/pci/pci.h   | 1 -
 include/linux/pci.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..ef80ed451415 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3579,6 +3579,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
 	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
 }
+EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
 /**
  * pci_rebar_get_current_size - get the current size of a BAR
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9aa1f4..640ae7d74fc3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -608,7 +608,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
 #endif
 
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..9999040cfad9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,6 +1226,7 @@ void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 void pci_release_resource(struct pci_dev *dev, int resno);
+u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
-- 
2.25.1

