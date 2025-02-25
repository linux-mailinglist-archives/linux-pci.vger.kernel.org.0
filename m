Return-Path: <linux-pci+bounces-22345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E97A441B9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9719116C6EF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102CB26772D;
	Tue, 25 Feb 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="FBk6w/H2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9672686B3
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492321; cv=none; b=UwJkIjK+6JAaNGnlLgdE6dJu6uRntoxjjDi9xnA0jrFTeuoAiccuOXqM4tx7QZxIcNn6ztrITSkvnRgpt0cj9bPued+pZs7+lg52Eu4OH8n+PsSWuoQr8GxVI0wq1WQb/AgYpbTcGwm3MtaJmuTjSEZj5S2oGkokBSuOuriebp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492321; c=relaxed/simple;
	bh=gpcDjd2ys+1/GXZMy58GrQmGAViqOhk10U5APZI1bwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnQrz6TkYRxmll6xbkxZXF5kO5b9V74BfaMDl6OYtQ8Veeax6dbk1/qh+yHjD4HibKbJXyzT6tv5SMmICZOnBIJTqrfWRw/uq5PABABPBjMRsrUfsmo2L/GUt9yq2WKyz2WzgL6z9nugp3XIi73v29aOfECU0ZCHKEEJ50hdTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=FBk6w/H2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso1106295366b.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740492317; x=1741097117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6461ban+1g2qu9SgG0oSTcJISIZ7Z8nL0LN7J32hL00=;
        b=FBk6w/H2hfu2V57tLOxoATVhBm2/Rjh59E4qy5NseJ6liU/IeqGAg3aoYxgiZE+OiO
         0p0mS50pR7gSrox6nNft5kNIk+B3YoV0OJ3m6wmBC4u5ljfpYdFI9hVrL7SXZpeN3X6+
         +T3AuG6yYcqKnS6XBrLvKJ+H9KKsft/cVAwZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492317; x=1741097117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6461ban+1g2qu9SgG0oSTcJISIZ7Z8nL0LN7J32hL00=;
        b=MNVX+2iuTh9d3FFOUvyjcItTXE3hmOpnvzzL+7uzK15Il/8BtGpBbONqBg98mAHy2o
         DlZ86zIMoLcWdBH1B5g6k6MlVr1AZLrAUuNIfY7ccbyYfP/Hr4J8bG3ebMhBSPYMZD9e
         cn9DZjOPX87gxsPk4BMPehB/q/6BEnKpqxON1PBQR9qTK8ovA+fjDZEvqwBXcIRKSB8F
         ovemF+Jeomao5kVU75sS0UCsn//7widgtcH7tqZfQ6c+xVNsZDcE1o34ym8r1jqgkCha
         TLZqtD0SEJ5CnnnSExhZkp4nsHPjG2IYJsjpeEUK2oneQM/+7TyxAa28XERX7XSuvyuZ
         EAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/t2pwwmMMAMLuYXfsrfIfe15zijzT5DCrjgWurV7QreiPo3s4btLSKi+hUJW1cS9ndBL4qwUK2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZT5vj7bzi55SOzvPIC1B2UK0L37YAFOWsrc235YkPa+k1SVz
	MxbZN177sSY1qXI9onP5GY1e9ZdrFhOSFP2EVtDHe9ie2sTd5mYrRIt7hFlYhGtbYZ90KNISylM
	7
X-Gm-Gg: ASbGncsM2y27vmd/W8C6C3Jjb3HbLRH5bfiqTsczVEa+0A6OCMhalQRcI6W50Yfbmii
	QgCk+Ej7LXvVbosJPLBxb2LeUuY0B66qE7skK4Z2M2T5YXQXTOPhApasziZYOXcmLMpRoiyHCM1
	yc1dwcCcKHcT0O8bSP6fwf8LVUnAxf2oAPLuB+s0+kFWOoTUpFEhUqqxSFVRUK6zfJkGUpiA+OV
	8A0FI14Ps1Au1sdfgEonWwfSrvlSfWjY7de21NTDW9z2jPG9w9DVDvomoWXtvqMuwodIjkSAJGp
	AqRitqlzWbF4dqyxDADJYA400ZZRPZHh3rq39uHnolxGp1eAG66sVsjdYFzOFusZqw==
X-Google-Smtp-Source: AGHT+IF9aVZ271pd7Rivr+4PMLzSxl4QN0DdFXBiXSE8kbbx+f24AkB2D93JM67HV9at4+50ibsh4g==
X-Received: by 2002:a17:906:7950:b0:ab7:63fa:e4ab with SMTP id a640c23a62f3a-abc0cd0b6bamr1855443966b.0.1740492317294;
        Tue, 25 Feb 2025 06:05:17 -0800 (PST)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbef5sm149367966b.14.2025.02.25.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:05:16 -0800 (PST)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	"Juergen Gross" <jgross@suse.com>,
	"Stefano Stabellini" <sstabellini@kernel.org>,
	"Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: [PATCH] xen: Add support for XenServer 6.1 platform device
Date: Tue, 25 Feb 2025 14:03:53 +0000
Message-ID: <20250225140400.23992-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XenServer on Windows machine a platform device with ID 2 instead of
1 is used.
This device is mainly identical to device 1 but due to some Windows
update behaviour it was decided to use a device with a different ID.
This causes compatibility issues with Linux which expects, if Xen
is detected, to find a Xen platform device (5853:0001) otherwise code
will crash due to some missing initialization (specifically grant
tables).
The device 2 is presented by Xapi adding device specification to
Qemu command line.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 drivers/xen/platform-pci.c | 2 ++
 include/linux/pci_ids.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 544d3f9010b9..9cefc7d6bcba 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -174,6 +174,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1a2594a38199..e4791fd97ee0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3241,6 +3241,7 @@
 
 #define PCI_VENDOR_ID_XEN		0x5853
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
-- 
2.48.1


