Return-Path: <linux-pci+bounces-5033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA58879A4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEBF2819B2
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7651034;
	Sat, 23 Mar 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTUD2JVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6647F7A;
	Sat, 23 Mar 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214089; cv=none; b=FCCqe2CDi/JUjb5xYJtVTAtd4KTJjZBMk3kSi7in6EfgbklhALXWpZaIZdYwqR8V2lXH87jFkRrP61TPB8SdecQOS77V2vStEZMmxPNVcpmSxdkDCmOt2E1QQYIKb1KzQEQY+XuJBhnVkayZK05dqOL+a2ugWrki/Gx5NNCIxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214089; c=relaxed/simple;
	bh=upmrpjz7fYMwIHUK/S8OcJN7LqevTj4cPEX7TDtKP6k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ffc0+PTFimO/orbI+ROBdr8oy0HYF1vMwo0PNe4PPmQ9FKYOvywgg44nNVthe4HMjqOzPgTztojoDQM/emAY/YZvQQPP616/JbVlFzNW2quGFJihXdN9EKy7SEdGdiEiQSvUdPZVXtUIL6P6gkk4ygz/S/Hygrf0WwguhuCa43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTUD2JVh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3326818a12.3;
        Sat, 23 Mar 2024 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214085; x=1711818885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pSEsOO7burX3PDgdTZjPJuUkZ9Hl7UwB/uzggeQm3Eo=;
        b=GTUD2JVhPuTeNy/zkRtWXMShZaE3S6yLEkfXbrpjNpD8e+fg5TriicnFuqOx51YfRv
         oTKTts0nD7O7jCnTfWB37Hmh9ViD19a9qxyOlNLhsHP8D7cC3Slik107wQtqUjAp+d3F
         zhvEE2QIMqDSPPeN6FfAtaBHHMQCln1hNQv9gv0lmnUqunbMXPZ66ehmjGdeKm9l16yu
         oF6V5IXEJHalzv1By6e78FKEetf6urc73nc+4H5YviCzQc1C30Yo2UrNi8vJaPJYIZEy
         noreXAm+5MQ0z5E6EbqsrSCDzp/ML9ML+113or4Duo/hjoBDU91LekzhKVMzBY/DdFYT
         h0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214085; x=1711818885;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSEsOO7burX3PDgdTZjPJuUkZ9Hl7UwB/uzggeQm3Eo=;
        b=N2k3wZ2vIy5i8oUGrORazYUH2yIGb43z47aS7GfRV94HyUnEAuy9F2DzJbaRg2/v/W
         HTWHbjh8srZMKY/DyGk1b0KzWgBOHJueWIUUZAEot888K1xV7paUsPEKTS3zPIL/t+3X
         6JQQgLSkA/uH5ZiDFVMaOCuUGix0tye/lZFKmLZ6FwUaGTgkNQeKXEmCjcQJNYz0xqjI
         8tuRbFgkcROcTYQraKok1NkbTXW3SGBMPeLpAvlL6ukIX+g6lvrrvXo4qxYaAAFzkhI6
         z/dQCe+2fGjYu28TurBU1FJfk5JY/xBqldUWUKsu50ejriJ5Q+vyRWm3WsWLMCMLGssl
         S8WA==
X-Forwarded-Encrypted: i=1; AJvYcCWmmbE2cLzYKlx4NOdD8Gxy06X+DQpvpw444iNgIIUO0V3SK08XEPLIx5Nc4V2ktCaLtGZbXl2bQ4rfzEOSAoMtgCBHAPUzWFqe
X-Gm-Message-State: AOJu0Yweil5rAhB69fOxCqbkGkHHqRWp1TJv+yOAScMsFOfCpHuulHv2
	THbnKVfXEOHzqZRQRvW+iVeGa/4eJxrty+fzH/XeWn+YrgCuAJPC
X-Google-Smtp-Source: AGHT+IE6xw5Y0TbJvAG/H6REzOshn1nzSMukTTeaRVjE02ac6Av9ijiegAXmCNY/6fAlVQbH/YETKA==
X-Received: by 2002:a50:ab49:0:b0:56b:bfa5:4b44 with SMTP id t9-20020a50ab49000000b0056bbfa54b44mr2083715edc.33.1711214085391;
        Sat, 23 Mar 2024 10:14:45 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc38:af00:d7:3466:9e54:a813? (dynamic-2a01-0c23-bc38-af00-00d7-3466-9e54-a813.c23.pool.telefonica.de. [2a01:c23:bc38:af00:d7:3466:9e54:a813])
        by smtp.googlemail.com with ESMTPSA id d13-20020a056402400d00b0056be1339ff3sm1074095eda.41.2024.03.23.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:14:44 -0700 (PDT)
Message-ID: <5068d0ce-2140-4d3f-b305-e8f0d61eed1f@gmail.com>
Date: Sat, 23 Mar 2024 18:14:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] ata: pata_cs5520: Remove not needed call to
 pci_enable_device_io
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few lines earlier pcim_enable_device() is called, which includes
the functionality of pci_enable_device_io(). Therefore we can safely
remove the call to pci_enable_device_io().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/pata_cs5520.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 38795508c..027cf6710 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -151,12 +151,6 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!host)
 		return -ENOMEM;
 
-	/* Perform set up for DMA */
-	if (pci_enable_device_io(pdev)) {
-		dev_err(&pdev->dev, "unable to configure BAR2.\n");
-		return -ENODEV;
-	}
-
 	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		dev_err(&pdev->dev, "unable to configure DMA mask.\n");
 		return -ENODEV;
-- 
2.44.0



