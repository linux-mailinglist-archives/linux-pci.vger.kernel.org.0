Return-Path: <linux-pci+bounces-6219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8B8A3E94
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 23:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AF91F21632
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD375466D;
	Sat, 13 Apr 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg3TbGZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DF2901
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042357; cv=none; b=m05awmTmUTDKMs56455LUAfpLgiKcvr01ZkaG2g3WzNklthS4X4PoO/H1rnvbBfJGojgpIo20fuNgggAJwHBSPmFcCMDOc3ohZKdPcjAtIxMKe5cuivJiBEE6QIE8oKtYJDXZ7/cNj0z0eemoi0kkeh7s6B7yyzJDWrgaHNvxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042357; c=relaxed/simple;
	bh=DWhsmcm3XPQV/1BHhz/IG8/6xSHXBoYJXRgQjdtxhtA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bC8NL5yS8HkS/YM6elXmh8wAraOvTLYBR82VeJewdwUnlRaQv9nKWfvQEIdApOi2/YDU2ge2VqpVMu0uTVvpetgD0GrYPSf4dsep7foKXcwLzm/hKBm7Tq/++b/GZdyBR7w51u3wYqrrG42jek8X0t8+eJ910Q/z/azKKyRQyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg3TbGZZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso1899037a12.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713042354; x=1713647154; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCsy7VDIm99QBLyzuqwru6Ud169oH1X0shiG+sTOPOo=;
        b=Pg3TbGZZsdhfKuLHtyzHC3zye8C2bxcvpSa4pLY2DPWOB8RPJpbfVNAslS20XPZpYU
         3U97GI4Oj11PUvomiCpiYsqu6y2v6S63EeCbE+RlbmXMaomJiE06jSk6lkIhKeGQz3Y5
         D+QXU/XOZaNLUCRQ44XYa9y0IrBeRdkpCTX/Wt0hxhhnke6Ghdu6gidSuT8ymn3f/isC
         9EXAYcN3mshtinpsuGWCZrwRwt7f4ApPEnQeeoIyHC4Y5YhT7eT+WWiuKvTAjGkcTSoa
         uGkgyF1q4ZnLyt0G01EnqQy0DKie1D2HhGnQCqi4AbHo3KFZouWL3Wn3L7nyb8we8A/6
         Ovqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713042354; x=1713647154;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCsy7VDIm99QBLyzuqwru6Ud169oH1X0shiG+sTOPOo=;
        b=nrGk6ZAlF0M+9Pif6n6Wf60gVsGr8VtNT4pVLJlsELtbgvB4zMfpH9/wE7AxjUPwEV
         6HbyCHzo5+jrasstD5xO+s2VYcwiK3/ZqMb2Op+u7ot2Wzho7YY9aPsjR4fbyv2MzGTW
         RwALDkdpo9X3PZUMkuVOxJtEGBtJ3nHZ2KIunupxg/Nb0KjX9KQCkxveMLwjbrNZWaPP
         X36u0O2cNCeyI8oOCzGvG5ugVaopmt0N7vU+Yn9eazox37CDK9pm7roGExtgmfLIPgyY
         xknbTKuFvTO3VyZlCTYbt6dZGFVspz6UBq2e1CB9+Q0QOsP55xpevYiZxflyxGog4gPh
         dJvA==
X-Gm-Message-State: AOJu0Yy+nddQi79aj/fs9pTzkdukcvlKzI5a8SKC4ZxvLlqzzbHLe/er
	viVkgbOC0du1DpRzZZuw0JSmhBnk/wPUYZb07z8AQ8Df4TNuTzlFhYGeAg==
X-Google-Smtp-Source: AGHT+IFf5TSGSWGvml054SyjdxjlC5w5UxAb9x6Sl5BbyXnjr0d2uwXCFxUI+gQ1VY/zfWVg7ytNKg==
X-Received: by 2002:a50:d54f:0:b0:56d:fbea:40ae with SMTP id f15-20020a50d54f000000b0056dfbea40aemr4093217edj.23.1713042353735;
        Sat, 13 Apr 2024 14:05:53 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b4e:ed00:81c3:86f6:8077:78ae? (dynamic-2a01-0c22-7b4e-ed00-81c3-86f6-8077-78ae.c22.pool.telefonica.de. [2a01:c22:7b4e:ed00:81c3:86f6:8077:78ae])
        by smtp.googlemail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2976062edv.22.2024.04.13.14.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:05:53 -0700 (PDT)
Message-ID: <ccb214ae-4c51-46b0-85f0-dba7ebe77743@gmail.com>
Date: Sat, 13 Apr 2024 23:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Annotate pci_cache_line_size variables as
 __ro_after_init
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Annotate both variables as __ro_after_init, enforcing that they can't
be changed after the init phase.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5f8edba78..e7ac4474b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -142,8 +142,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
  * the dfl or actual value as it sees fit.  Don't forget this is
  * measured in 32-bit words, not bytes.
  */
-u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
-u8 pci_cache_line_size;
+u8 pci_dfl_cache_line_size __ro_after_init = L1_CACHE_BYTES >> 2;
+u8 pci_cache_line_size __ro_after_init;
 
 /*
  * If we set up a device for bus mastering, we need to check the latency
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 69b10f2fb..cf63be0c9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2334,8 +2334,8 @@ extern int pci_pci_problems;
 
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
-extern u8 pci_dfl_cache_line_size;
-extern u8 pci_cache_line_size;
+extern u8 pci_dfl_cache_line_size __ro_after_init;
+extern u8 pci_cache_line_size __ro_after_init;
 
 /* Architecture-specific versions may override these (weak) */
 void pcibios_disable_device(struct pci_dev *dev);
-- 
2.44.0


