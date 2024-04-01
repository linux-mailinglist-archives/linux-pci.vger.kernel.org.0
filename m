Return-Path: <linux-pci+bounces-5483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CE893CDC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FB61F23AEA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DD4643B;
	Mon,  1 Apr 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFoY21F+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0B4501C;
	Mon,  1 Apr 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985432; cv=none; b=LS1X53cd1wNGc+eVoc1quQsb0xKbHJqYJhpItQStsQRTu4Cj//0xeB4UDyvA+9GPgXUMRkJd6cvj5X8ydqtuZnJbPvD3fnFCocsolDQPLL6GI0+Vwjg2lrPOGRy6h1Vj6t4zv7p5I6Yikti/uu88m0jmJM19VyoTbh+HJ6sLheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985432; c=relaxed/simple;
	bh=kwW/UvezWdhhna8gZrKN/DT1SvFNi6W4KnUEdEhxRBg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BIUTQB5ELXPeRV6wXCRytcTWDYkV85dPgc6iEoUhdXXNx9fEN3aCQJWQTaH9yRr9mtfmTUd0iQoES8y5jrHsjW50Nfc74FF+OLlMqdhObML14UYPCKo4eJE4HSCfKn76wbDHTWw5GOZBOpPq+wmq/HghFUX4KkjzGpa+33DN5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFoY21F+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51381021af1so5280726e87.0;
        Mon, 01 Apr 2024 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711985429; x=1712590229; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSdHQnl/uz145vU7uogIX8qKGpE25neuqOhaoto+Ve8=;
        b=GFoY21F+s9Nto/AFztSRijMDLVwfWn5QJVhpctpeckNS/dGn/uQysiQEx9iS8W10kG
         l+cayEnXF4DNwk4LM4VAGYxcxdKpxuvSg0Haht5pCsdASpYVBDMDrmr8sJ2n2NYziaA8
         Vvqzs7zsQhjIJdfsOfntunE/N3Rile6g66vpXGynPA45H9afo3FgOuyzQMpYIhDOftrr
         84Q/7lTaQ5EbpdxGCho7f8ZFeF/FnGHz9HPOCaYAYvlKGQMbbL1JqqgLTKVd3/D6O1S0
         yfDATAQiXYr67GcTVmXF/v73kj73EwgJT9uvIqlglXbUHjBzZI3iGA7M9rGrAoKULyB8
         sRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711985429; x=1712590229;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSdHQnl/uz145vU7uogIX8qKGpE25neuqOhaoto+Ve8=;
        b=swtLMeirqY3WoBzBhgxaAVDCmIHo1FWcoUNwLuRrifKKxicnumqaDeEI1ww91CMKzp
         YPxLligat38A3T7xAJXnfQaHGY0q7rsnOiR8X+EuXBzk7fEWNPmypdCkSLi57TtyqUxL
         qnzCeg2RUC94hfRAeUWe4Q1yHL1mxC2UlRZz18VuDGR7EkbNro4GOXn8hhZTFhxF1Zft
         4/DfsNekHwRTxBvxiltt01/y0h7pjwRcMOrohFD++khYoyt1yfw+wBrFm1ARQ/vT1rA7
         KZWqwYBWCnLAFL3vM2VXcOHncGjOad0/ApzE0tcswL6FF7DGa43l6yKNw4+GVnGqiR0i
         veKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgJXHsu/0H3lLDJ9EDCZTcZzm6zWFYdJS7yHAKo5TNLgdh+c7c0KLb4C/QxcCpLawRXTJPl4QZA3cOdoqHb042MEn5n4HKkH2R
X-Gm-Message-State: AOJu0Yz/ug3hZYThFg+6/9UGHs8LBggc8gDJFCNzlr0eV6F1igtunowF
	jfDDpOMunLdAyL9CawX7op/bniZ1iRf1npP+otguCxGKY0sOjlJm
X-Google-Smtp-Source: AGHT+IE8m6i8mCJcAs3EONB8kEs2SvxnC7e2yJEvhesRJPNPtw3Ma1i+KZKtykGmrnSStwaUkVsrEQ==
X-Received: by 2002:ac2:44cd:0:b0:516:a686:8ae1 with SMTP id d13-20020ac244cd000000b00516a6868ae1mr3340045lfm.62.1711985428447;
        Mon, 01 Apr 2024 08:30:28 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6ffc:6d00:155c:9c47:3959:e8e5? (dynamic-2a01-0c22-6ffc-6d00-155c-9c47-3959-e8e5.c22.pool.telefonica.de. [2a01:c22:6ffc:6d00:155c:9c47:3959:e8e5])
        by smtp.googlemail.com with ESMTPSA id h6-20020a170906590600b00a46e56c8764sm5376424ejq.114.2024.04.01.08.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 08:30:28 -0700 (PDT)
Message-ID: <cd66af0c-835e-4222-b362-e2e9cafdeb40@gmail.com>
Date: Mon, 1 Apr 2024 17:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Using the device-managed versions has no benefit here, because
resources are released as part of the asynchronous fw loading.

Actual reason why I got here is that I was looking for places with
dubious use of pcim_pin_device().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index a5eb43f30..bc93ca075 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -65,7 +65,7 @@ static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
 
 	dev_info(&pdev->dev, "fixup device configuration\n");
 
-	mem = pcim_iomap(pdev, 0, 0);
+	mem = pci_iomap(pdev, 0, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "ioremap error\n");
 		return -EINVAL;
@@ -103,7 +103,7 @@ static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 
 	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, bar0);
-	pcim_iounmap(pdev, mem);
+	pci_iounmap(pdev, mem);
 
 	pci_disable_device(pdev);
 
@@ -200,11 +200,9 @@ static int owl_probe(struct pci_dev *pdev,
 	const char *eeprom_name;
 	int err = 0;
 
-	if (pcim_enable_device(pdev))
+	if (pci_enable_device(pdev))
 		return -EIO;
 
-	pcim_pin_device(pdev);
-
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-- 
2.44.0


