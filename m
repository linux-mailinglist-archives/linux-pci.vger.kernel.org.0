Return-Path: <linux-pci+bounces-6456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDF8AA20A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC16281EFC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F1178CD2;
	Thu, 18 Apr 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpfQJ8wI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E61176FD2
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464961; cv=none; b=MHLmQqJAc5q04UgNfEA6dhUyd63nCMYW/3/CrE24MqRmBcdNk8RY/Agyu16CCtzexlOZk8t8W49Fnx9h17Xt+e6vhr9eU6CnXrN3QPeqChPU5LaU39j8+Nfsb2V9CR16T+8twk0Z+xmDKL3PEfv3EI1BdT/IdRxZOVUTou+6zPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464961; c=relaxed/simple;
	bh=ukblXwO5D/cPmh45NLuTzC/zWXEcNReks1X2oF1PxyI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GgUfzDW7wu2MWAJDQ9gSeCaCIV3cAlSuxEGIHWbHdnR7yfWr+HFasPFP8rgMjfjGh4Wtfz4F5eD0erp8EenpAstvaEmLFiqcXo3QxScQbpK0/aDk6ipi9We0Sv62f00hJmNZEGGox7QlZ4kd/QBQMdFGvTA+u1MvIIpVuLYZQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpfQJ8wI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418dc00a30bso8978415e9.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713464958; x=1714069758; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csbD9APsYdKZNyan1AfWkLLDsEbgTkVQ19kx9AMnMa8=;
        b=SpfQJ8wIs5mYrL7p6j7F38DI5uRNRxTehtNMjSJk2YuB5jq9aw2r04c5KQ0GaWPoSr
         l+MH8oXT2R4mFP/mTHmI/olyV6YEzCVE1rTE+uBJU4TcQWsX3lEqgzwQjHm7Yv3tWkrt
         uXeioKbC2CFgqVZV0ZFXsnu4DQ/rS2xda+JcyYBXVl7Vp/GB2ixw4Zh6D+Y1XEDSWsMV
         /pQxxNJoOLb7579rwtYpu2+r5WbXx68Qtgm6eEah8u7vInIefbG91m1dP1hhQ+DJcWZY
         xrcFBqKeUw7vL3oXH6zpVv8s+ypmraR3Yyzrxxuz6tzyDBj6Y5hI+FSMFRZ8J4kQgavY
         EXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464958; x=1714069758;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csbD9APsYdKZNyan1AfWkLLDsEbgTkVQ19kx9AMnMa8=;
        b=J5NMY4iQ+s/fSLajikVjMhORxnFPRd432xpEFdL+HZ9GOSYcW0srpoX/53F558W0JX
         MFz9zdl6FXQj7AAVYKnffPslW4QgqEGRwqe9i2KjsWpc1qxj6dY27+jv2xC2Pb1Hhpm6
         1gsUTI90N87CdoHSNhavdbqowO2T3OWWujy1Fnsr2rD552eny8JHMZc24ntNrdbgWCo+
         REZWvHhRbjqnF5En6EULfd4MsJcn0CDVwGB5PWtmZANxg/Y1fSbzihnnFS62Lo82teMY
         znZmt5ynouEQiXzqKyNVDEwSzLic3j+26r6jCWghdl4rlfqrgdcUs/bX3Sqn4KkbhD+Y
         PDmg==
X-Gm-Message-State: AOJu0YxeJXwnnzAMNo29IM7fNaY1+qPtLGlEa69KOIr711vp1eYwMrxi
	KBIHCzY2nXUpGzrXHrGis7RUu9v+GkuE34tWousWjCdTzW+yjT3ySA3jsw==
X-Google-Smtp-Source: AGHT+IH54Kss2HW4jQZez1wCnp88h9OPreoqHLSERYS10+VwVPM0c1PmhAPWX+4G2OlyCfExe1timA==
X-Received: by 2002:a05:600c:1e87:b0:418:138e:f271 with SMTP id be7-20020a05600c1e8700b00418138ef271mr2408150wmb.15.1713464958392;
        Thu, 18 Apr 2024 11:29:18 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a7c:3800:e468:94af:626f:f554? (dynamic-2a01-0c22-7a7c-3800-e468-94af-626f-f554.c22.pool.telefonica.de. [2a01:c22:7a7c:3800:e468:94af:626f:f554])
        by smtp.googlemail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm1405909wmq.18.2024.04.18.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 11:29:17 -0700 (PDT)
Message-ID: <52fd058d-6d72-48db-8e61-5fcddcd0aa51@gmail.com>
Date: Thu, 18 Apr 2024 20:29:21 +0200
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
Subject: [PATCH v2] PCI: Annotate pci_cache_line_size variables as
 __ro_after_init
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Annotate both variables as __ro_after_init, enforcing that they can't
be changed after the init phase.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove annotation from extern declaration in pci.h
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5f8edba78..59aaebb67 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -142,8 +142,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
  * the dfl or actual value as it sees fit.  Don't forget this is
  * measured in 32-bit words, not bytes.
  */
-u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
-u8 pci_cache_line_size;
+u8 pci_dfl_cache_line_size __ro_after_init = L1_CACHE_BYTES >> 2;
+u8 pci_cache_line_size __ro_after_init ;
 
 /*
  * If we set up a device for bus mastering, we need to check the latency
-- 
2.44.0

