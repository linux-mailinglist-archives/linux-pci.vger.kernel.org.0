Return-Path: <linux-pci+bounces-38529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA1BEC1FC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AC4093B5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2B1F3FE2;
	Sat, 18 Oct 2025 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxbC1Xqn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC81E492A
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746062; cv=none; b=G6wQ7AYxvNYHExklup3MxDqUgKtwriFPgAwSfPwKezvZXX4YMf7GGl/6Ijtb4+sVXCj7lst7zI3z7lMA3leyCHTZ6CC0ojX6Kd7q9x8ZEG6WuQ0qhrvxv0cJVHxQrifxV37k5gDKvBu9rKDNfOq91QsWsdOXxAPITV9TFbyj80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746062; c=relaxed/simple;
	bh=+K5j39XpTNwLHlWGtorRqscxgPOaq/a9DZ3eNvEVcAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jAjZE54H0TJGjfmzFNaqRPdNRojPJ9c1Qv2OS7CgEtGVhLVI6jpQETuZzd1mv1BtpOvo/TtEbExeDWHYRaIvpseCvrFQlGO5QmiIAbZyUcHBY4WxQu2TWlkNhChBarr0m8WtxZiUpI2pRFaJbk96v4F8ujBYIzPt96ioOeR2VR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxbC1Xqn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so2100130a91.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746060; x=1761350860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnxsirzJmf+9oD/SWVkkILfWOZE9umducoMflFiqRpQ=;
        b=fxbC1Xqn8W1nVGvBqnvR20qwKq5qnLQ7aKJXzkOlzYZMbt8jbveKl6biOBHq4yu4/c
         8fSeul/cLUVKsf8FnwMDV2zPCoMVM0tb8nRHdZZ2Lm2ntYPrO/A2OwuyDKLx7q7Sb43n
         sIJCqSTOm5LtNtzC+DUYgQQ6kvBER55r01PS3e4AVbGOQL1wilCSfz8sxP5AU4gXr2++
         lN2Ps/Uka90b/x5r+ZSoFs2Hj3O7uzrpWL9hApP2QKRal/YXRK5XpNx91bjfHABZgDdj
         SbJQ3AVBw/2SvSl0eQj81AWWsfpNzEsTwQUOEwYGRWkeCKTAt3IV+d1ZYbCt/Qj+Mgzp
         D6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746060; x=1761350860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnxsirzJmf+9oD/SWVkkILfWOZE9umducoMflFiqRpQ=;
        b=FYUtAQoGH/xszqlwFBfWdu5VqEwYKq+pYpnB0PgnpUN9Fyu0cajHvC4+ToIYb5NJtw
         O8BHT4AVTigQ9YccsLI+0XKbOXniUcc9x/5L134vwq5M2/Hyvp/Ppi5kUNiQwmwMHj8j
         TtFDR1tuW2z+QIRYCpdDCOI/yft+a639NO9bLG62SMfQMRsSrCjfecPJYhw+yoOCUtFr
         slotGIXZivVueskYC/3TkkjI57vMPIBtCcijQrDolM7duDetHeStrOf6CIws7eKQot5g
         Q87l+SJgLsZUwJiVwfqVNezo1vxNEEDtcPs+LPJaXbMht+tYqw2THDWaz5AlLjFa2dDy
         9qCg==
X-Forwarded-Encrypted: i=1; AJvYcCXRIWhr5erN79gJpFe8+zzmTTXsX1ZPsxgC/z8Qi9KAVcSuRkHcIfstlrVjYfa7hVOrsnP0gyZV1Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkZBFiIjfPCkgd6vdHyvIevpKhSjAy+dNcpbqf75vuckdtCBb
	hCUyDoF2pRSk4j0wc35kom0ghj44nqEgz/hG9/MRCf/ZpDMBKCIAqlOtIC2sTWgfYGxVJr3yD2Z
	ZKKBlW7HLBA==
X-Google-Smtp-Source: AGHT+IEDeX1KBK/211Sloe9HHYyIrse9Vb0jW4j/mlSMb7ebaIyHdLdJhj4WQAl1ftyT6/JHbLuQi37Ll112
X-Received: from pjbku18.prod.google.com ([2002:a17:90b:2192:b0:33b:a383:f4df])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d85:b0:330:4a1d:223c
 with SMTP id 98e67ed59e1d1-33bcf87f421mr6072321a91.15.1760746060452; Fri, 17
 Oct 2025 17:07:40 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:02 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-11-vipinsh@google.com>
Subject: [RFC PATCH 10/21] PCI: Add option to skip Bus Master Enable reset
 during kexec
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add bit field 'skip_kexec_clear_master' to struct pci_dev{}. Skip
clearing Bus Master Enable bit on PCI device during kexec reboot.

Devices preserved using live update might be performing a DMA
transaction during kexec. Skipping clearing this bit allows a device to
continue DMA while live update is in progress.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/pci/pci-driver.c | 6 ++++--
 include/linux/pci.h      | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..6aab358dc27a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -513,11 +513,13 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
+	 * devices in D3cold or unknown states. Don't clear the bit
+	 * if device has explicitly asked to skip it.
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot) &&
+	    !pci_dev->skip_kexec_clear_master)
 		pci_clear_master(pci_dev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..8ce2d4528193 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -400,6 +400,8 @@ struct pci_dev {
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
 	unsigned int	skip_bus_pm:1;	/* Internal: Skip bus-level PM */
+	unsigned int 	skip_kexec_clear_master:1; /* Don't clear the Bus Master
+						      Enable bit on kexec reboot */
 	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
 	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
 						      controlled exclusively by
-- 
2.51.0.858.gf9c4a03a3a-goog


