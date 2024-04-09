Return-Path: <linux-pci+bounces-5974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0F89E45D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2795282BE4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53A12BE9C;
	Tue,  9 Apr 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/TeYkEp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CC15820B;
	Tue,  9 Apr 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694513; cv=none; b=gSnWJi3ZPaviwRRXRXNYsUV85t2LxryJaScT/TD1fE9gc1o0zzKafpUiEDRYuK/RX9a7kgANj6WRV01hUhU+FcgUvUQLg7vg5vqScNGjd4yPuZgjkFTb1lbUnLRk4VgeaujRPoIR2SYseMpnxKsPp8s/MvSaTKWYwc6k4Dhqon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694513; c=relaxed/simple;
	bh=U+OPEd0AARwykrYqFgdN+1zLVizIT4ru0E4x2oJOcdg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C9xjScS1ByUoM3JDbG+W+Wrjo+K1QeG9SGUg49V3Mle+SA6/OQyAvl6gwcC2FUt7M318tCTMXswdifLYvzM/tbYZf6bf4XrQ2QwcV+BdMTacS0XWkb20ikRlcisa8PQs8pqTSCDcur0ezTltEL16eQ+FK+cy0tjBdYH5ZNHwBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/TeYkEp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d487659bso6186511e87.2;
        Tue, 09 Apr 2024 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712694510; x=1713299310; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:autocrypt:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9gs1dLprRj1fsmQa3APmBAfIuyo6zWHZME3uMmmvqw=;
        b=m/TeYkEpZtLbiWSgSemuSuy9sRWS6SYCz8x1tsJcAEANUpY6YRuTgHuFSMGONa/5am
         kW94l7kHAETkSkm3AGpe1MieU8MwOW/We5BoMxCY55MdCeLBv82OZunJg2e4zoRyIAQC
         LgD9Z8IAiEE69KZP8WpQlL+zYz9/vMwN9v6S+MlgsKJq9JpOFxju8pQTQ0INiit834Vc
         X5etCx0UUzt/EEMZjhf8XKtX2OfQ2C/kLi0pGfENCC2Z05POCtfaUPqVElZ0Dco4hot+
         YUNH/W7TZBOr80Q4xT1PkDiFH3Ll5LJkydHnNJvJJyuCMFt3o1h/YBaPOmp7PW0GIZip
         wPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694510; x=1713299310;
        h=content-transfer-encoding:subject:autocrypt:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9gs1dLprRj1fsmQa3APmBAfIuyo6zWHZME3uMmmvqw=;
        b=BO5PEBBymU5idtFRVDbOg+Rloxaav/Dn5c24z/3Xku7wOQYQf4XxrOYm/mU1sOu1b5
         +S9tp/F8RZTHdKbToEhDc1Y1rQOZW6vEj068rtTZTNvOZ9h8gY/W+QUgfGke0oD6R9xT
         rebPXkfioQICkWFnOLB+biWXnEbG8CquxqqSJceKpGvONcu0po7kOsW53iVB93RqhizI
         Z6aTq5GnSz2tZpF4gTmn8I1WEs9lvZNocvMOmWXoUVqKcTKtnCKzNeIP8FM1Ut+FU3Ls
         sK6oniLvrggkIrnBbs9kuqD0ugDlKy/E8iMW13EY2XsMm1UA3lKZV65jOkXjFGuVzhMw
         iJpg==
X-Forwarded-Encrypted: i=1; AJvYcCWirJsfqdz8W1S7t/SHX8s5BSQhPjLjiQCtJvUCCNU6WykGNWTrPPizNMfOl/83SK5c9edPfY0rwacTgzKQJnTVAwIdvitHEvdX
X-Gm-Message-State: AOJu0Yy5D8MCdh2wn55c05hU7eEWlV6CE2/hA45PhQxu/YE1Fr4xncLt
	RjIgTTzefkmIV/d+y+IIvFBCuRjt2a2hOSdBZ6w95ILvG5H3Xex3
X-Google-Smtp-Source: AGHT+IHPeg7dFruFePgXsmr/HDARv7ZpjEe4JtO30u/ZynjCmCdhDv5U7jls6ur28w5V79pnwc6WCA==
X-Received: by 2002:a05:6512:3e1f:b0:515:d100:1650 with SMTP id i31-20020a0565123e1f00b00515d1001650mr396390lfv.57.1712694509340;
        Tue, 09 Apr 2024 13:28:29 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9100:f800:9534:e76b:750e:c03d? (dynamic-2a02-3100-9100-f800-9534-e76b-750e-c03d.310.pool.telefonica.de. [2a02:3100:9100:f800:9534:e76b:750e:c03d])
        by smtp.googlemail.com with ESMTPSA id el4-20020a170907284400b00a51b3410e46sm5030628ejc.7.2024.04.09.13.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:28:28 -0700 (PDT)
Message-ID: <3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com>
Date: Tue, 9 Apr 2024 22:28:27 +0200
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
 <afaerber@suse.de>, Manivannan Sadhasivami
 <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Subject: [PATCH v2] ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Only managed PCI resource in the driver is the iomapped bar. However the bar
is unmapped in the same function. Therefore using the device-managed
versions just causes overhead, w/o any benefit. Once this is switched to the
non-managed versions, there's nothing left to be managed for
pcim_enable_device(). Therefore we can reduce overhead here too and switch to
the non-managed version as well. This includes removing the no longer needed
call to pcim_pin_device().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- extended commit message
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


