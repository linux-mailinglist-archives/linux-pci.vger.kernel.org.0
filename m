Return-Path: <linux-pci+bounces-35516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D2B450D9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEAE1BC50F1
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0362FDC2F;
	Fri,  5 Sep 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcfCalSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBADDF71
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059468; cv=none; b=KLWp7PkcmyEPPm/+NGBHaevap1Atiz+aWy5wIcUHlEUjq2w1Sy5i1qwJd+1cG1o9QLvKakpp7ODPY8lJFm+bUUlyI2yzFlpWTkW6JSJGeTM9BVb99UfKm1nKQowpc4b5yKeHJiOEByDugHHGfDoN4fFhG91O2e2HoB5f9sjV0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059468; c=relaxed/simple;
	bh=BK69GKXDo5Lr+Qkt1GmUdgKZZr1aJR2lLdycYBt0bJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bsoGtVVSm0rHcXheBrBRJo/Yn3ADJgALRXlWvRuz6TBxKg5UOFAeVmGw51wljM1Hvdm4qyVX06aOlUVLHaOI8e7vLyaiklBNsWFj8JBRmMDrUfKXoZUgjqh51fwqcC4i6y1jMqz1X39qeXcp2bf3rlQKine3hTXucrMnbBsj8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcfCalSB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b84367affso16449575e9.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2025 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059465; x=1757664265; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEyqxPQTlvHE7Rb9nf0Ka5S6ku97HAqdoQLaDQei9o8=;
        b=WcfCalSBQX5L5ITP6TimiMFu5LeZmc5lCsiv4UcIC7sgdWIAeacQi+ivcACERdRbJo
         5K+hEqjm9Fzx8dyl2G/09eXEa8r9AjQKrB/SfEVqduRj6IGOGznuC+vvebSPNFePhQHW
         HKQXFYWm04kQNz7C9nHmUfUYlqNdoVY+hzr8kXZQ0Ep2iS8+SYwifQaTV4lKRVpPWCKl
         kQ8uOBE8MdobqhEks0IiblQjB9vZv7D+MJinT19M5p7sm17udyD5jxCtjpKuYo2cUC1b
         UTJVhz2viI9Ds5vlyWoaH6DAn02bpN8b1jeyekVLEpRK/XX3hkAtqbCiyUnmQWNyxwzS
         rSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059465; x=1757664265;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEyqxPQTlvHE7Rb9nf0Ka5S6ku97HAqdoQLaDQei9o8=;
        b=VsaU+BRHrhpWbkH+sq+q8jHyx8XqLI3C4KBnF+xBmlOiuKi8cHLAj2I2xCtP2AySGD
         nWxYP2UnNKplYUK6N6LF55yyOf5vYcybktOS45Mj69LEWp/3KJXJ/o+G2IRvTe1ylLR9
         kEApCFpYLUfFN4zbgLEQbKCnVaRbhPutz7S30B+ilr5woPWJXgadGMp1dHr+nUoJV3NC
         SkuCHkryQO/sYKNf5XQtZ/TdbjiaD39GIX4tOQfhBHTHYA9XDVB5JCWpzN3a5///0ZkM
         UCrVu4NirJApBBi3zSv3TToAztAVjqsfswlgYuS903eLVt7drU5wINCv2TAgq443p/Pd
         KYxA==
X-Forwarded-Encrypted: i=1; AJvYcCWI6JGksapcc5oK1pGbTGeZG/PsvBaBbs/fuQ7C9xr/C6Q3TzVQy7REbfoAVwA+CVxBlwIV72n9qh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAJdHXLPSU2I9s2D6oP1p7Zb4swonJuNeRE2kRtLFkTN1IZxm
	/6aSn/QHRqRdKnP+QmboZf8emC7tabp3CG/amkiQtOKVzIdcL6wO4XKCYobcOnbXB3w=
X-Gm-Gg: ASbGncuLpEdrQ4+SuMDZ8qSLCc5rFDeryj8Gmkmuc/livswqhP/ho7YKH5+WuochSI2
	jfTS41GDd/AjuhbgGHVuKyGz84HhxokZXbsf85IF7GFBoeeS1t4Dx5S4J3Y0mvXRF9uGNu35ODH
	P67WkJ00XDfjYDwyq75RVhHVaiqX+ZpeQ+1kBso4C6sSs6Mh2KxT78ugptFZCdqgF4hYW+zQ2tz
	TkpqODDhcDoiNcGtBFdkH/SzS0lbeWJ9z/+fJOJpaxlOo4TlnEQ1T5S5USagAc5oSX+Ve2ZRhHN
	zdYflUSuK32z/py2hZb9h8imeCMxGoGlJBze+mY7J0bU8UTdg3y/q7pgXLPrvBlshsEpVLCqGcW
	j2VVKJX61fdj7r/fjvXk2M+inGv6HpkdSOu7yAIhQbMPl6uiA
X-Google-Smtp-Source: AGHT+IFg31bO3+yEGrU5RDt0pIsHa2/S7Tm9NAlDysnLBMH3Sorox3ujEfiAyqMx4B2CxZfrtHTl2w==
X-Received: by 2002:a05:600c:35c5:b0:45d:cf5f:cff8 with SMTP id 5b1f17b1804b1-45dcf67429bmr53251585e9.11.1757059464523;
        Fri, 05 Sep 2025 01:04:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf276d204asm30777648f8f.24.2025.09.05.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:04:24 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:04:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: stm32: clean up some error handling in probe()
Message-ID: <aLqZhL-DV4LOnHlD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that the other error paths use gotos to clean up and
these two don't.  Generally, the implication with that warning is that
the error handly has been ommitted.  In this case, the error handling is
fine, but we can avoid a bit of code duplication by using gotos to clean
up.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-stm32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 964fa6f674c8..96a5fb893af4 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -287,18 +287,16 @@ static int stm32_pcie_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0) {
-		clk_disable_unprepare(stm32_pcie->clk);
-		stm32_remove_pcie_port(stm32_pcie);
-		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+		dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+		goto err_disable_clk;
 	}
 
 	pm_runtime_no_callbacks(dev);
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		clk_disable_unprepare(stm32_pcie->clk);
-		stm32_remove_pcie_port(stm32_pcie);
-		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+		goto err_disable_clk;
 	}
 
 	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
-- 
2.47.2


