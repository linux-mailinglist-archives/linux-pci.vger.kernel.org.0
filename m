Return-Path: <linux-pci+bounces-13596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C798829F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93551B212BA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C618661F;
	Fri, 27 Sep 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="fVK/pveb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F34156864
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433438; cv=none; b=lxvGcC6atLT/GmdbQMXf6f973c46YpVD190Ybe9MD5zbXCxSwM8FQzyMgwDSF781616m3UguaKnPVHpA+OXQh+ktG730n7CjYOEA1tw5RcbiA5wIOFt01C+OV8ICFUW3hIzkzW3YIwx/qeGPglmJCshXz5gz8CLJb6laNMzwbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433438; c=relaxed/simple;
	bh=Tt9jZ/UlU54e+UzJCTQL9NrMvJYonLk5qDAVRDf4jek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfl01WRQ1TMH5RrKv0wU1dgvuCYshs2eW4Ea6JWdgmKG27SYJMcF5iBj6bPNrzmb68aatebgFFtlHaCu0XIQhnFDc6UsgPTaPAdNFVhmc4YFlg6r3q01Egops0/PjN5SSMel1uG2BvT7WSZBNcYpqRHNN0KDoSY1UkFeWS1v4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=fVK/pveb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db299608e7so1339882a12.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433436; x=1728038236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGxVblQfa7uHrpy+5tBOyLSFvRT+VEn8gcPfSrU2Ja0=;
        b=fVK/pvebJxJXu/4HmJUhcL8gy2axYlsWTtjbKJkeXHkFL9BrtZrHekt+2PD4bKIwu+
         AMf7E0FNd7FZcBdUs9xR8tsUwqSSLo9u6wJQkE6tRC1iZHzUoPEWEXmYPBuZM3u37tjE
         3aNj9tERw5xYOGZQRrglqwNzmnJt8381+Q+FAVFAG8cTxfbLRH+1Ealg/+niw1MzNu0b
         jfJITKYJ0MU/30igzNFEi7VGLKLSZfScTmnJaGcmDjgxjb4ykfaXRB6WaFLU723UKzL1
         iAO+bBEKA/bAKfUYm9DQL6LSoF1gDl8Y/4gWFmEB7QVSTzj6VNWDFAeI/tfu6rntVgm7
         GlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433436; x=1728038236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGxVblQfa7uHrpy+5tBOyLSFvRT+VEn8gcPfSrU2Ja0=;
        b=ZnSro9v5lVn9kbbuDjc7GCGtrMrLiM8aGqE7HN/7m28ImiaWKANtHXOdgNh6EJebI5
         oko+YOLtiAZSetxTUQCSk0XFFFJFiSEgbhQ+B+953a+SrUpKB5a5FFsH26JoeIZekOuj
         uAbput6RNDtv9MQIprBO3n2UobCv5WNywkIZQTBlqpz3CERiKrgbpF72xs7g3FyT89n9
         08xowBS1KiZXcnU2iuFo4U8stcA9BuZ17TQ5+dMNQMp5rpDQL2vKdg0P6J500ewQgCWb
         FLEpiLgvL0PeKc6ym2cmlJy5GUqo59YOsp0pxGdbXUvb7LIQXTXAEe/xMu01tL0TXgHo
         k9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0nHAqZt0zuV9/xm4RojHAF1U2ddKQAXZF5bqb8h6uzh1W+2WA0oMBBvSg1RuS2XJrBx1P5AKPUKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SZywLI69S/T+7ArZRyQCDPU+NQUIfr28m04uJTwH0LOYfeZe
	5H4zuSq/AmQ1UDpyG7m8W7JdbkYcuFzz5WIV0DR30m9j9AmsL+hTK5sXESZnr5U=
X-Google-Smtp-Source: AGHT+IEdr2fEbI1BtpZEI2LBNs60DKodvJNbkxxgSsKjdyxmA9kEzrG50k1Zw1QH67cjtJ9+jtBG3A==
X-Received: by 2002:a05:6a21:1796:b0:1cf:3c60:b8dc with SMTP id adf61e73a8af0-1d4fa7ae2f4mr4012116637.34.1727433436352;
        Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm1342036a12.22.2024.09.27.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:37:16 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v10 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Fri, 27 Sep 2024 18:37:00 +0800
Message-ID: <20240927103659.24600-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927103231.24244-2-jhp@endlessos.org>
References: <20240927103231.24244-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

v6~10:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..bd0a8a05647e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1442,6 +1442,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1458,6 +1461,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.46.2


