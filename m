Return-Path: <linux-pci+bounces-5426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E4189263C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 22:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FEDB2124A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FC1E535;
	Fri, 29 Mar 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as17UjhR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99179DF
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748509; cv=none; b=Sn/8A7FY4LYXOrgmZsTpRFA5fnTcttKBKSCLR7IgBEcvI9b2xlyo63ud0A2YxVcO+Zj5zsNQSR0v65eQTPvsVBCejmIWkykjCQk6BJ0Vc95fjqJq/ZuvSlEjQi1EJMV+PF6BtxBLJBcuBZ1floV/wiqku91j07pMEMAtitq9bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748509; c=relaxed/simple;
	bh=tAoMsoJ/iVaiTmFroebM+eRSv2csHcdXzBVtpfdTb2k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VOJzFMdjFnumBlrHHSiYX35zkL1/lPite/lrWOpQYpZW0gh+cgLrLeKltZj6c+bDINCyQ2vEYmZ/lX+Xnf0FFiiHpeLV3MBuv1MmNHPui7CxllwBu/hqrDbzNxyhnrIQzpq7XJMY2X35Vyww3x+/SA/u5ZM4PGwJVOvpUEVPsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as17UjhR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56db72fc3a8so353470a12.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711748506; x=1712353306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=40Y/dZOeqBYVtqCrclMIQqMCxWUvbpQn0kDZB5mXyjw=;
        b=as17UjhRvkT9IrZOphuQjGwBWuqX7OhAxlK/geWeiKnNw/5EP4B3aOZqYS02Ij3/Ur
         aReUMdmXJlM/Pr4Ye6emHxjMB1mHXDLUipr0jgmghhkcCnFdm3lBMtyfISwUY2JyxOe+
         xgRo5nB6NkoH+c1nxty2BVswmLqdCIz/tygKPzZTxmLAAg7kgRn8b23+Z/TNno4tb2zC
         xUkvO2vCpyOa6VgrTCKuP73PFvWsqbCA+cn6WxAmnJhpUj49ukEPmpOTtpukkw+kF1A2
         sdca2kXhKvfGelz/Eac26TtLPXo0I2zXDoUJhKFW0BtQ6iIfQhTxibDdybeHs8pRarxK
         VX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748506; x=1712353306;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40Y/dZOeqBYVtqCrclMIQqMCxWUvbpQn0kDZB5mXyjw=;
        b=cTf+qNLe07B82wy+vJpnSaQZLnPP+Xfqu7osZfLS29urSmE3tktbfErEKR5ANB9XEj
         fVIr+h0idDvssW35NTw6KFTfjmOdDqHoh3ZZrorIk06F46Zgk5sAwQsw37xi2IqRtkvG
         r8koDTZZGU4xCb81iQAdhvJCcE0s6mItor7+EYjCzfhqcNXwc9T/ZfMzuem4mzyRdL3J
         m4RY5MO19eGyEEsleRko+ANzUSRNR18aR9ZnoImQdrdCTgxb/KTtVg802QFizjzqxL8g
         aHmPZnyjXAYNNctfU/Wo/RonW8CZUaQ3FisU4NUGa1HO9ciqJPIhgK0u+9LTF4OZI5Xt
         qGXQ==
X-Gm-Message-State: AOJu0Yxz+AVVbokPceVt2lMauAJPAB5Qzg2JoAMMgu3dp+50soEu4GBg
	Pxg+GKHpgysSIypYCaro9AX/ewduo6IB7hszr+AANghgc312W5Ty
X-Google-Smtp-Source: AGHT+IFbGNIvNc8Nopuo/e09NcCgfCoYDUYLSe6TQF72SA/e3PY/kNKLoViU3hdG2XtRAh5Mm4aqig==
X-Received: by 2002:a50:d6c5:0:b0:56b:829a:38e3 with SMTP id l5-20020a50d6c5000000b0056b829a38e3mr2394399edj.16.1711748506185;
        Fri, 29 Mar 2024 14:41:46 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7bbd:b600:50f7:b974:760:86c8? (dynamic-2a01-0c22-7bbd-b600-50f7-b974-0760-86c8.c22.pool.telefonica.de. [2a01:c22:7bbd:b600:50f7:b974:760:86c8])
        by smtp.googlemail.com with ESMTPSA id t19-20020aa7d713000000b0056c08268768sm2451461edq.10.2024.03.29.14.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 14:41:45 -0700 (PDT)
Message-ID: <3bdea180-e0ea-451d-ac14-5b02c192467e@gmail.com>
Date: Fri, 29 Mar 2024 22:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 1/2] PCI: Restore original PCI_COMMAND value in
 pcim_release
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cb48fd68-9bfa-45b7-ac4f-d1c2b9b1f207@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cb48fd68-9bfa-45b7-ac4f-d1c2b9b1f207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Instead of the complex handling of INTX and MWI in PCi devres, let's
simply restore the original vale of PCI_COMMAND in pcim_release().

Only side effect I've seen so far is that the "enabling device" info
message is printed each time a driver is re-probed after a EPROBE_DEFER.
I propose to silence this message by changing it to debug level.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/devres.c | 8 ++------
 drivers/pci/probe.c  | 3 +++
 include/linux/pci.h  | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2c562b9ea..7766f4df4 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -172,14 +172,10 @@ static void pcim_release(struct device *gendev, void *res)
 		if (this->region_mask & (1 << i))
 			pci_release_region(dev, i);
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
-
 	if (this->enabled && !this->pinned)
 		pci_disable_device(dev);
+
+	pci_write_config_word(dev, PCI_COMMAND, dev->pci_command);
 }
 
 /*
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2..60052c979 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2558,6 +2558,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_init_capabilities(dev);
 
+	/* Store original register value */
+	pci_read_config_word(dev, PCI_COMMAND, &dev->pci_command);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a..92c3c99c9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -352,6 +352,7 @@ struct pci_dev {
 	u8		rom_base_reg;	/* Config register controlling ROM */
 	u8		pin;		/* Interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
+	u16		pci_command;	/* Restore original value in pci_disable_device */
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
-- 
2.44.0



