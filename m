Return-Path: <linux-pci+bounces-22359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096EFA447DF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453D9883BCD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43518204F77;
	Tue, 25 Feb 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL0GYxMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22421DF98F
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503571; cv=none; b=PSbaxyo2NIv4Q+GPLpvN8U90Kzr8wjjABX9OBb3oTIQASKkzIeKdfr/p1Hu6cRhcLesbzKJN9lfhdGzvaSH2RQ+Fg1YWHG9IIORDi76fwdBQ/pJmVt8IUFykXHOmBcAU/2QObOGNl9XGr86+76HrNE/fQ7+/Kj7+8uv3gZJSxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503571; c=relaxed/simple;
	bh=solmisJfOwq7tSo+vQhMg46du8qP0Mm5gMU1KVww0NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqaHo0omd4Z2Sb+CGHzfT418kAkih1LGLV+gMb9/TWGcM/+Apgz9Dx2mxMtMu4dd4wVOlcXhYO3HX4IEYFaE37pNIJWMAqF797ofQsiz4hGYByJrDCJNACTeZc58+NBEEKrXn4KEHgrrcO4DSJRwp5EoRB4+mhg69zwyIzMXPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DL0GYxMp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2211acda7f6so133301015ad.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503569; x=1741108369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jG0W9H5EHgY60+XGt77vkeLnWA8gkbVQ9cdgHwuEC4=;
        b=DL0GYxMpYglS0lhWClMZUGd6/PdKyx+WD1rk6Tv0FBVSU3YyysYRMh1Qe/DkRWTfRj
         vW1WE7lf+746zeXLyKws+xqtj6Px9kg2Y/Ij70iiaQkMwBh16tc6JEiTtN2ZPZSdW9fW
         z/wsNALWMHfgrraBwtO56qAdhzXX7TKXl/jg5twhwQvwZTw4XNbRlxpdJLqR6U1kIFKZ
         0eDw3zjEhw+psATGHZUZ022Wg2GUTH2Ww6lwlaKeOdKew7E1Ug/uamqU5WPq9RBt5vMX
         5Zof/sH5KlrlqOyEJ/db4Vyg4qLsnbhXC+ea1Ax+dOM1xxG4HngabVOoP3fSYlwzUc/j
         B1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503569; x=1741108369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jG0W9H5EHgY60+XGt77vkeLnWA8gkbVQ9cdgHwuEC4=;
        b=OIWpuOSQx0GAlJ7L/8s+PaOLn1TQwTt3NfbURP6GHY59AvQQOCvDbrLK+DqjRm17+b
         Kv5kKDdmid6CEdl8ESwLfkidshn/SwwdYNULO7fUSyfaD4LKWsVw5DbjobO4HOqk24FB
         oS3QL1/W5+jE9VxIcVnGtayiNVrzIJ7JaWvZ8pLzXs9CfwfpC6q05JEqKJSe/c/phvp3
         2BPQFtfi6frXeJ8r/MFc4trjF8qb7reW0Z7v+0YaHY6kJo+CctJiZzz9CSPKHqNmYYEY
         2aFPzhGlSmLahasbEBrmdiL7K246frazPREey8Z2pQrMHMI6hbzvdemEoTiq1R4sPkM5
         wxmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvklIsJY7broI1DljsO+kVRBD6y7cpqBQY2obgySg3Xa6N9QrLivbAfD9rpvOxJmG7nemlVBQln4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rJbmDykqYSKkZ8O+UCOwYOG2G2XMTozjPozaXoZRlbLZh8bX
	gkkisZXUlMP5P3c+tbtIaQUHSEpdegtKGlyk78mPE37gJQS6mVVRC49vyXuO0g==
X-Gm-Gg: ASbGncu+NXOGHL5yMhnitn/NfAEmTReMwjG2BqDSMg8hxedOPIw7sWJBb9xjWteTBQD
	Hh+UTARYnFFrfQ0ghaJ4J6x2LlEbSPAFHroY3rHoUcCfH+PcHrOrdH64DoEQagNSkaTZ0So2fuk
	sIgd7DmY8sXHbMqtMQyS+RyzYvI/FawVDWdqM3rMU/9Hu6bYecdJHFbre+328AyaVSb0WGrGr2z
	81jUSZLDXpqIlTt68DbMDnp20KiE54aLogHsdmfz5rGEWwQvPwIDNxjgct4tWcKj62wSlopZ1Rh
	3X72AmsdJhRu7ch1iUmc85fKQXsyLdTJNM5s32EoHjgDhHfWfKd3iw==
X-Google-Smtp-Source: AGHT+IHjmQd2iyEjNZ5iWvHuuhwXr+ROlu+iTqFwv0oDwguUc9oGY/92+rxd8sOUv0ftc2AvvJk1eg==
X-Received: by 2002:a17:902:e892:b0:220:e63c:5b08 with SMTP id d9443c01a7336-223200853e2mr3925605ad.11.1740503568871;
        Tue, 25 Feb 2025 09:12:48 -0800 (PST)
Received: from localhost.localdomain ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f40sm16844925ad.144.2025.02.25.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:12:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shradha.t@samsung.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
Date: Tue, 25 Feb 2025 22:42:37 +0530
Message-Id: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series has a couple of fixes for the recently merged debugfs patches.
This series is rebased on top of pci/controller/dwc branch.

- Mani

Manivannan Sadhasivam (2):
  PCI: dwc-debugfs: Perform deinit only when the debugfs is initialized
  PCI: dwc-debugfs: Return -EOPNOTSUPP if an event counter is not
    supported

 .../controller/dwc/pcie-designware-debugfs.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.25.1


