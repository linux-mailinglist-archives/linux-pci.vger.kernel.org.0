Return-Path: <linux-pci+bounces-5034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D98879AA
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0FB20DE7
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF42940B;
	Sat, 23 Mar 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAorOPav"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99C4D9F0;
	Sat, 23 Mar 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214200; cv=none; b=QunXMpgWHNahZvQhzDLzXGwdmSr6yqmsH82sWvl0ZYa4MwJpZpn3qWzLyeO2oBDJXkjXANfz7562Wy45vUmoXw/lxMk20zucI0DVdzOLXbb2QnmYtrqfbSf8Ob3uNkaAzBPxMFIqpfQyJxcmTStZzsxclH+tHO+gQuwG0Pe1MYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214200; c=relaxed/simple;
	bh=J5wdYSH9NLUMMFH+wAls46nILSQFyV86tcUVxw9kyb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bs7sf37lPhq1v6rDhtXIT2yk5KGz8w+P3iNwl/0p5CAzDufb4eq85m0jut2ewcYDK5+dDI9AbmbYSoFbVaCSUV/mXhKdl6hrt2HByGNmE0FGWFkWXsytKdMlp5eiDgh0IEF6/Z6GAApCa0Iq/Xm10LB8oSsnF9uS6wCfb0lHs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAorOPav; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so4156326a12.0;
        Sat, 23 Mar 2024 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214197; x=1711818997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VmgMdZ4xUlyuZRTA6aewwg/Lz6fT5jH31pUmdOCwplc=;
        b=YAorOPavSBWuXQIBBAabchj7recgHRT9vUBokYbqVnZMFYneobiYxhnibFt5OqFSQj
         djJWP1qwIa/xWcb926xtB48SRs/yUJ/evi5QjhGoCRlWkKtaHwUrfsq/2MNM2hBUhCYG
         6gD6/0QC4X2fkHWYfPxwp0dSdEaujp5OfPorvtSZW+toZf89VRKB2N1kYdQxJ9zB2J7Y
         yhrsN0se3IQyNtlTE/EMn7drmLmNpUMlvfwmEfmwEDdz8ZvruVZrh10xA9yI3BX8Be+G
         O2i7BMpH6dXv5WoD45glhi9V3a1Y/VfFHQEvq2ZBEeQeYZj8s3JEgFUad1gJVDNC/V28
         9PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214197; x=1711818997;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmgMdZ4xUlyuZRTA6aewwg/Lz6fT5jH31pUmdOCwplc=;
        b=Z12g0QjcdVm2sRFs0hpVlrw4XBdjhe2EL/dQGoGPDK+UNZkC8tTfRj7qkyDvu52ov8
         CEWErMjz6Pe/U/+64nuiHCXVeohz2fE9o/RnAKpCAmIDgsmPfJBG260qn/4NoFrYLVyI
         sDn2lNoAEvykn9Zv3v52JSACJsDzt/nnNt3HOWAA+/s59zoqBNFeqHrzZoZe16P4C4Rf
         /41p8DOpOC0cca4Lz72485ErV6P6s7BnFiGAcZ9kmgqnqfpd+Ux48NIYW5c+LCrCmjCW
         14ownKFe4rxvGIC/urNskAp4g0vQ9FACj2zZ3uIgEDuepII+X9k12pF+P/eQ+RwglRQr
         C9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8onatKvX8GcJy/eSfeVjhGszoyEpESef1Ci5AqgHb3/9qEB+rDPA0dS1gfLvtX+qvl+JifAmdvGdrVy+aa5+6RWInqMnRArUV
X-Gm-Message-State: AOJu0Yw202Ly6lJNZLT9YxUUqtiDRIykxBkRrLOk5NQ3uk94kmkZB6jm
	gXsaAK/UW8LtYpT103jt3n8MSK+YAo/Aio90UjC0nk0RmwOWF7EK
X-Google-Smtp-Source: AGHT+IHpEy49RCfhgj8AOde/Qe7Z064MT+MZlxTHrRXj/Ehoo+bXI9RbCOsRbE0YvpoiopcDcEbkvA==
X-Received: by 2002:a50:9f44:0:b0:568:d55c:1bb3 with SMTP id b62-20020a509f44000000b00568d55c1bb3mr2245032edf.31.1711214196991;
        Sat, 23 Mar 2024 10:16:36 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc38:af00:d7:3466:9e54:a813? (dynamic-2a01-0c23-bc38-af00-00d7-3466-9e54-a813.c23.pool.telefonica.de. [2a01:c23:bc38:af00:d7:3466:9e54:a813])
        by smtp.googlemail.com with ESMTPSA id r1-20020aa7cb81000000b0056c052f9fafsm196875edt.53.2024.03.23.10.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:16:36 -0700 (PDT)
Message-ID: <213ebf62-53a3-42b7-8518-ecd5cd6d6b08@gmail.com>
Date: Sat, 23 Mar 2024 18:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] PCI: Remove pci_enable_device_io()
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

After the last user was removed, remove this PCI core function.
It's very unlikely that we'll see a new device requiring
io space access, even though memory space access is supported.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c   | 14 --------------
 include/linux/pci.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4..a26d00bf1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2110,20 +2110,6 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	return err;
 }
 
-/**
- * pci_enable_device_io - Initialize a device for use with IO space
- * @dev: PCI device to be initialized
- *
- * Initialize device before it's used by a driver. Ask low-level code
- * to enable I/O resources. Wake up the device if it was suspended.
- * Beware, this function can fail.
- */
-int pci_enable_device_io(struct pci_dev *dev)
-{
-	return pci_enable_device_flags(dev, IORESOURCE_IO);
-}
-EXPORT_SYMBOL(pci_enable_device_io);
-
 /**
  * pci_enable_device_mem - Initialize a device for use with Memory space
  * @dev: PCI device to be initialized
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a..ba1275778 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1315,7 +1315,6 @@ int pci_user_write_config_word(struct pci_dev *dev, int where, u16 val);
 int pci_user_write_config_dword(struct pci_dev *dev, int where, u32 val);
 
 int __must_check pci_enable_device(struct pci_dev *dev);
-int __must_check pci_enable_device_io(struct pci_dev *dev);
 int __must_check pci_enable_device_mem(struct pci_dev *dev);
 int __must_check pci_reenable_device(struct pci_dev *);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
-- 
2.44.0



