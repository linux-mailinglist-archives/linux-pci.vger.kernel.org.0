Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B770D1FA58C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFPBR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgFPBR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 21:17:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1739BC061A0E
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 18:17:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w9so23340773ybt.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kh7TdnSzjMmv55tOoFOguM4fQKcmXvzqJelRJT/2fHA=;
        b=vzILdiTcV8zGZvfxPJjrCDkaIiDK8KCwgVW5sP5e/czfC9CFBD+4ikfLr1nNZiLCG4
         yExyajLI5z2tPj5jVUXTZlmBhGBcd6BGVc1XxIDjdNS3taX9qDYcvZx28CMqEi9ygJgA
         MWL6ea5rsIGkxxLvlq7vvECQtGR9tvELA1ucICg5NNO8B8aWbqA2h64ZsHzjXsnB1YQW
         4b2MdI3q0G8zF3rBfgke02muupsh2/pTPE8RoaCWeIK9EoWZZ89jLrd6Hi0IDaGyOVQO
         vuDTYNL7FXPLpo9k/VkK76GyxrbKc0NHqjiyuMipoIOah7pHfFDxwNZAF35HnrttIiGX
         Sfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kh7TdnSzjMmv55tOoFOguM4fQKcmXvzqJelRJT/2fHA=;
        b=fUPcm0qSvw+nbUM/15SpZqJuxllilq0+w0g8xfMiJpffrsuMqoMgQ2gY1u2Ag/O3sF
         vBEOb3nPEC/Rx3ecFfUiNVsDhvIyDa6dBmbZrGntVlvDAfyvcHFC3bP0EWAapJ1sYVjI
         +mSL8UgGbiWiA3UezekoN3DtQiBXPOGFQSgQncyz98SwpE81l05yMWmALGoiWJ9EYAsl
         Q2d6tPzx9NRb0mpcP924mwecxlRASdkQUfyV1NBbdK7LPVMr2EqxDnD+r0cbuT9AYySx
         NKtFvRXl2GHXdGMifghdrNKegcVQWEen6G1r3umsn78+zwGvVaV9Du3UVt4rWHfMig/G
         uIYA==
X-Gm-Message-State: AOAM530eyzevulh48Dntq2oFqAQivS7my/PMuhpsXbYC3wKi1YQ0vFkY
        A6ZVzW2nZ1yKoLVt5bU6LBXwgV1RNgxe
X-Google-Smtp-Source: ABdhPJxAth06oSMz+frpUoX8kGWlQJ8aihUMBynZvrDOTpUM1ErZyuW821epnFDUXXRGd/C8nOzICVaMXji/
X-Received: by 2002:a25:9746:: with SMTP id h6mr429416ybo.409.1592270276282;
 Mon, 15 Jun 2020 18:17:56 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:17:42 -0700
In-Reply-To: <20200616011742.138975-1-rajatja@google.com>
Message-Id: <20200616011742.138975-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 4/4] pci: export untrusted attribute in sysfs
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is needed to allow the userspace to determine when an untrusted
device has been added, and thus allowing it to bind the driver manually
to it, if it so wishes. This is being done as part of the approach
discussed at https://lkml.org/lkml/2020/6/9/1331

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df981d41a..574e9c613ba26 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -50,6 +50,7 @@ pci_config_attr(subsystem_device, "0x%04x\n");
 pci_config_attr(revision, "0x%02x\n");
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
+pci_config_attr(untrusted, "%u\n");
 
 static ssize_t broken_parity_status_show(struct device *dev,
 					 struct device_attribute *attr,
@@ -608,6 +609,7 @@ static struct attribute *pci_dev_attrs[] = {
 #endif
 	&dev_attr_driver_override.attr,
 	&dev_attr_ari_enabled.attr,
+	&dev_attr_untrusted.attr,
 	NULL,
 };
 
-- 
2.27.0.290.gba653c62da-goog

