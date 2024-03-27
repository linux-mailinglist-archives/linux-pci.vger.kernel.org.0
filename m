Return-Path: <linux-pci+bounces-5248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2F88DCE6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13832911D2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3112C525;
	Wed, 27 Mar 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM0ZsazC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A276058;
	Wed, 27 Mar 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540399; cv=none; b=h1rAJE5YOMFL/HafTipJ44a9Ypd0w9PsW1Om8AOgRFOTzKwinEEiNGG4HNLeiZvOtpEvub7R/J4yYhzCBQyS2y8ZYScE4RNaNzps6xXrWU2h6dux8naDYlOpXn6dU+riJy7rlBkSAusRv9MicNUnyf+t3oJ1rJc/XfZ1zXEkC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540399; c=relaxed/simple;
	bh=JZz4r+DZvAJfMMvFcxeOBk8CPkc44g+7wUOVX84W9kM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JFNX0GjPx2kRckWeVxM7XL/GTX9YHUjLgVkCM7t7NaJFX2qQJ2x2k5N9ZJBLzRtJeizeqzENmEbTKFvPhZlAthmBqvI41xvNEKls+WzTnMHf1dBfHM59HDhvJWDAf/NFrGcDb1VC690CmxVpoJw+2Tv4tsKUrSFAYUQoB0dser0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM0ZsazC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so8436822a12.2;
        Wed, 27 Mar 2024 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540396; x=1712145196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pGVgjHqx69a1T1Z/ASYMAKc8jlnGhIXFhQHpJqKVfSE=;
        b=PM0ZsazCV6v45e8jBDnpG7KQCGtKtxIN+OTv0rlpHqk/SdzuhpUAuvxR9LT3c6k0I8
         8YIfuvX+qKK5qhyZU4rnRQD1BsTh7Dxf1fqK/qt+ZlEpgCU99o6oFzhuw/ndsbVPD7gm
         xpln3S4RelsJ/1QgiCHpCz9S0yQPKan/VcM0uvTBOOYbnxzO+DxRwxrGSSlXAqv7wsmk
         vo3gyoBqCLK2s6dbXb7eaYqew6PGl0Ntwz9vo/i/axauu0HwFO8ULBXUSGL4MqWxVcyN
         CGJfqrSJ1+6xYGTphPTgQEGSopWLm3mmECYOpyfI+pY7q+xSlWDxZ0EQvnRUXU8mH5/X
         f3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540396; x=1712145196;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGVgjHqx69a1T1Z/ASYMAKc8jlnGhIXFhQHpJqKVfSE=;
        b=obkfRk7VaOMYqLiRZjOHyOQ26d02i+mw1Fy1Z4kGReuEF6E/N1tyarvaWez+lVIXaJ
         KBOXSGht6mpa7yxbs1DYdrpFqnW4jVALIqvqx03nuauup4S3GkAlctDz3b+oz22VUqLM
         kuFwmVl+5bcGsTCSP3uLrNWk7pgVa+1eQA9k1h2XK2Bsi8qHVS+3nKUK1Odp82+N8WA/
         k7FEsXpd1OA0x8q2NSukGr16aZa0uvjdNADqvFj3+BCBU4rl0oE8kWW/SxncuKmiU2Y3
         Bi6jij6Fzd0A8FCl9SwEmtW54DRK93NEQn5dm3GBgpPpidmQHio5ULoTwtdvCVlNqt7f
         2C4A==
X-Forwarded-Encrypted: i=1; AJvYcCUL0zTzDVLD+iPtkfJnga95rTVbolOQkm8PajJsHshPFqKNgXkZhcHmiiWwhgl7DAHixTrJZ8cxlC10B8R5TumIw1YbBKAB
X-Gm-Message-State: AOJu0YxVQ33OLb7Ksfg5p1uUtA6iVkV3gAUBPJ+Pj1UHSsHn+bl5HU7U
	5B5L00KZsfFVnddeKSL1Pyfkvi+BAw3faJeLJ14yxhh6XPE/KSCl
X-Google-Smtp-Source: AGHT+IFA24vRVu+FoKbHxtoPFktnztJzuncdqmSvFwCGpz6Ep0o4QroMPFwHVLbrLonE9e0JFQp7Kg==
X-Received: by 2002:a50:cc83:0:b0:56b:9925:38a with SMTP id q3-20020a50cc83000000b0056b9925038amr814789edi.38.1711540396172;
        Wed, 27 Mar 2024 04:53:16 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a? (dynamic-2a01-0c22-7b87-a500-dd0e-a4dd-4c2a-b10a.c22.pool.telefonica.de. [2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a])
        by smtp.googlemail.com with ESMTPSA id cf10-20020a0564020b8a00b0056c1cca33bfsm2488468edb.6.2024.03.27.04.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:53:15 -0700 (PDT)
Message-ID: <b5ebb7e2-7c94-4111-8e10-cf162547f466@gmail.com>
Date: Wed, 27 Mar 2024 12:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] PCI: Add pcim_iomap_region
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Several drivers use the following sequence for a single BAR:

rc = pcim_iomap_regions(pdev, BIT(bar), name);
if (rc)
	error;
addr = pcim_iomap_table(pdev)[bar];

Let's create a simpler (from implementation and usage perspective)
pcim_iomap_region() for this use case.

Note: The check for !pci_resource_len() is included in
pcim_iomap(), so we don't have to duplicate it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/devres.c | 28 ++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2c562b9ea..afbb8860b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -343,6 +343,34 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
+/**
+ * pcim_iomap_region - Request and iomap a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: BAR to request and iomap
+ * @name: Name used when requesting regions
+ *
+ * Request and iomap a region specified by @bar.
+ */
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar, const char *name)
+{
+	void __iomem *addr;
+	int rc;
+
+	if (bar >= DEVICE_COUNT_RESOURCE)
+		return NULL;
+
+	rc = pci_request_region(pdev, bar, name);
+	if (rc)
+		return NULL;
+
+	addr = pcim_iomap(pdev, bar, 0);
+	if (!addr)
+		pci_release_region(pdev, bar);
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(pcim_iomap_region);
+
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a..751ffe8c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2323,6 +2323,8 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+				const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.44.0



