Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906543F732E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhHYK2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbhHYK1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 06:27:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C3C061292;
        Wed, 25 Aug 2021 03:27:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x4so22613493pgh.1;
        Wed, 25 Aug 2021 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDV1qUC/en7sXzyKaLfWNTN+O6Ei1wxbt8/kHxJ7Nac=;
        b=OlIB6gjhsq8yYPg5lX57SFJqImS4PATXnLGMWswrt6rZp1107btprXW6qN2B0S8+7z
         whIy91dBhN0Z5EPdHfgkFY5EdF+SfwiXkaonNMq8ZDz6oug0/lYCUJ+7DMpP7vKsYtvM
         zVg4VLECikYJ5nDiFAusuv3TmtcFzRSo012pphpfD+fOSNjgFUSNB6uKp/cgkoK6lbez
         3oUf2zgO24Q3G7NAg2G5+++9ymk8qMadMMBYixbcQ+jxgVHgps7//siK1yb5TR0aH48l
         GuMh08CVZg6Gm5B3D+QTtsyq7QdxFZr8olC4PexE1a8JMnTrbJoDYqA+ij+OYcuBMq0p
         XgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDV1qUC/en7sXzyKaLfWNTN+O6Ei1wxbt8/kHxJ7Nac=;
        b=ZjI9c15q9kKupOuAO0wLtxqn/N8NLVY7ABiA1AvKuYOe7jZC3UtoDLNblA/jeVFydq
         k+tBW0JWNYsFtdXWpH7Iu8fm6DVML/5WJW70uzTKkboYtOw69W/nPeefICJPvVhqVYdP
         rR7qQcGxwf+lANgjNL0hvM+RQYBfhqWp2eoBhfbY5O2Ucnchiaoat/ipbEMRtXYRoWU7
         91ZMXwgbM8ndu1dHEO3nIPYMM7Ss+8wGbr4bsXGRlBB63BtxvRSKMFtbmcGSCq7X/d+T
         Coeuhb8WwGV5E1Hc4H48tIpDs8aQsZPKyMaS2YpGUWXFpla9LXkeoRLBPaXcysPejgwv
         yBlQ==
X-Gm-Message-State: AOAM532rWDUTsbuOnaRQaFRSQV8GlKl0+tR17+ZnpePGRlBJU5CShd/l
        Y0wIhZvI9BVKoYrxs62qcFg=
X-Google-Smtp-Source: ABdhPJwoB4JHP+QJph4hBP45JoK+b7sKIJJTkg46DEr2Cj0JC5KGVm0w9eUmUDoVldQmVqUWFh/pDw==
X-Received: by 2002:a62:7c08:0:b0:3ee:7bd5:13e1 with SMTP id x8-20020a627c08000000b003ee7bd513e1mr6510185pfc.27.1629887225254;
        Wed, 25 Aug 2021 03:27:05 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id f23sm1786403pfa.94.2021.08.25.03.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:27:04 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bhelgaas@google.com, maz@kernel.org, tglx@linutronix.de
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 1/3] Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
Date:   Wed, 25 Aug 2021 18:26:34 +0800
Message-Id: <20210825102636.52757-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq has been there for many years but it
has never been documented. This patch is trying to document it as
what it is really implemented in the kernel code.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb7..eeacdce 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -96,6 +96,16 @@ Description:
 		This attribute indicates the mode that the irq vector named by
 		the file is in (msi vs. msix)
 
+What:		/sys/bus/pci/devices/.../irq
+Date:		August 2021
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		If a driver has enabled MSI (not MSI-X), "irq" contains the IRQ
+		of the first MSI vector. Otherwise "irq" contains the IRQ of
+		the legacy INTx interrupt.
+		"irq" being set to 0 indicates that the device isn't capable of
+		generating legacy INTx interrupts.
+
 What:		/sys/bus/pci/devices/.../remove
 Date:		January 2009
 Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
-- 
1.8.3.1

