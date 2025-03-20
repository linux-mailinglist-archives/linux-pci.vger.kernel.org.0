Return-Path: <linux-pci+bounces-24205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A1A6A129
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439DD4620C7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FA21325F;
	Thu, 20 Mar 2025 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhTBIPc3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C662147F2
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458884; cv=none; b=rWEjG4t/mDrHqtIUbL/mYCAIcvdkHVEOu0iBVLVLM/Z0B/GZ4rBeJP98O1MZ0O7xTroxLbHVq9gXe2pd2b9Ar24++/p0hA1S5dWrQBUZD7Px2XnpHDIfgAI1d7VkZ58z41B6KJn1TsMf84gEEQA+Z6hfGhGm2enGjdCFtWAu5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458884; c=relaxed/simple;
	bh=yoUiQSYGpSGekAoG2O4E8f17ta3m6ARia8UOtVAr6JI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyEdpxyLnWwQIgaNEAbMSBqb6wfeOzmS69jO/yHb4RwKncIWhjew8ZW47zVC2H70jIOz3p9Hd0wPI4ggskCFlpL9TdxZdU5zrsTb8+GMMVUca2Lb2QqcZkNjvov1w3Hww46Ur5CVfyhQ3NGsCXFhecvgWjt1Syu0+8IMFGmL+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhTBIPc3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so691273a91.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458882; x=1743063682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqyah9gjao8rMiwTqNmziiGpp43wpvz0+2z6DdoovpM=;
        b=JhTBIPc32I8Fq9FxNPo17w+h285Fc+VTGbAcq9S/o8LXGvoTqbTxwm0TsOEGJeJNq7
         Obe6c3Mo/eIidk7Qrt8ggHDbZPHKrMZxni+8+8fdnlZ+FYzM37UR0QlDNtOkomV+Edhq
         zHF+wCdi8Yx3kYT43D0lDO++GsSSAWUH5YHMQnWNGljds6lof9VUfGNpuy54m6Gcijtr
         CHQXEYWhT7o1NF4lKC/3wL+oMptvtPv7Vn1oCDz+cdCNq0bqcKEmIau3IGetH9LXU/F0
         NRi1glNIZNrko/q+OfBq0MrH4WmZI/YIev+sxXb+LPfw3F7DmscfmwvAgz8vJaYwIhl2
         8vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458882; x=1743063682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqyah9gjao8rMiwTqNmziiGpp43wpvz0+2z6DdoovpM=;
        b=A+FEsJPVVGPI1kc5/NAlM5SA7vk94ugdyQ5dZ10/x3lw+fRxCrck+WPIGTk75cv9+D
         /rSfLHxpZzxxh4h+QUSIfg7NJ3eDW+OZPrlCSd39UPC6XNBs07Mc0OtAXx/kKAUEnyFp
         efF2cMHAWb2pSCNBz3kC+bUp4pNkMqqZr8ZEP1zvL3BP8ShM9NQxhuV2Rwy3xm4toNGd
         49jYc44F9LM4+sBBDvtQ/TsMWrD+oPAd+r+sC6HfmuQlGjyYtQrZkbKIHO0IOFRq3M4U
         2LbMan9CNHvpK22LokN8toB31hWAXI6zz49z8cPNJ5trJNuVzhK8yi5JB701QtQM+Tc1
         cB5Q==
X-Gm-Message-State: AOJu0Yzz/MAiNzTmoRwD0NynF/kP1XSgrNmmQrgNSz82GLuhK8rWUPxr
	wfec/PU1YjaKLS/XKAD29irTCFnz3aB/Ki+0K83UczddMY8NB4Fy4Q56Wwc/HzN2ATnowr+OPb7
	jmg==
X-Google-Smtp-Source: AGHT+IH/o1u1mFbEa/B+GyrhmD3YYeil4k1yDaWCytnQgmgCp6TV83vyISw4wc+d5IAipkFRli4zitaJNwM=
X-Received: from pjbli18.prod.google.com ([2002:a17:90b:48d2:b0:2ff:6e58:89f7])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c4:b0:2ff:5ed8:83d0
 with SMTP id 98e67ed59e1d1-301d52c0657mr3852034a91.16.1742458882425; Thu, 20
 Mar 2025 01:21:22 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:56 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-7-pandoh@google.com>
Subject: [PATCH v4 6/7] PCI/AER: Add ratelimits to PCI AER Documentation
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ratelimits section for rationale and defaults.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..896d2a232a90 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. uncorrectable).
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


