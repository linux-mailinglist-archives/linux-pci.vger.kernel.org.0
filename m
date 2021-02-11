Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED2318C91
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBKNtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:49:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:57332 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231803AbhBKNop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 08:44:45 -0500
IronPort-SDR: pVt0NuKM7Bm8Ju0gKJPfc29JYkfOHW9mJsELdAcFgDPaQgEuBCCk9Jy/YCSBnLiVmZxlXt2QGz
 2L53AIS1IvpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179681622"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="179681622"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:40:54 -0800
IronPort-SDR: 24JqG9J6olWdNdGOKCNiNGyIJoQrHfgkUuRc8sj/LgieDg/H+Exf1wVSo4hUC9086U2jfQcg+n
 J9wumpXAB+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="510853242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2021 05:40:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF9A6C5; Thu, 11 Feb 2021 15:40:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v1 1/9] media: atomisp: Remove unused header
Date:   Thu, 11 Feb 2021 15:40:00 +0200
Message-Id: <20210211134008.38282-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
References: <20210211134008.38282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sfi.h is not anyhow used by the driver. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 5a5121d958ed..8c65733e0255 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -22,7 +22,6 @@
 #include <asm/processor.h>
 
 #include <linux/i2c.h>
-#include <linux/sfi.h>
 #include <media/v4l2-subdev.h>
 #include "atomisp.h"
 
-- 
2.30.0

