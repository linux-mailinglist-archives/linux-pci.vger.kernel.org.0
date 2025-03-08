Return-Path: <linux-pci+bounces-23178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F9A579BD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8321897270
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B14190470;
	Sat,  8 Mar 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTHsKewT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAFC133
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741429417; cv=none; b=KD2Lfq/wOFfdS/hAMhTACCoeuIBNBtgNvesGU5K2+t3FT0OxkkmkMhYDpNwhChy4oB6CaRn5CwxV+Hyqp4HGtuZ1AA1IgG0cbnCzs1lIGh9XS+bRTdcukcjnM7f/MpZbL/s23UhNR/XNoaVeV0LhJdTNMzF1xTkO7O7SDxDMMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741429417; c=relaxed/simple;
	bh=kQdnxo2eQAhesGGQYLkLLnavSig6b3TJRMcAF2Gn9dY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ryRXGrVDVrZM3mUYS5KCVwhL8XaTE63s9xE1904c7CqZNcFEdKm+NamDOPH/w16uoT19wTFqBHcynL2a+5y1lLm6J/ZSF2EmVR+0YnbI4HruZ0UCrpzrFvwrDa5IL4l294Hrv6dIbiUPitjmc9j9QWAzw/Nt8SbMV0YGcUpVME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTHsKewT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so22794585e9.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 02:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741429413; x=1742034213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sb5zpBZeAXxrIZv2sz7E55sdm1vl362JAnmyo0Aw2TM=;
        b=aTHsKewTAK8MJi5sLtjakOPp28PeGFy5IfQNhRPo3X+76pOzrOyTHjOPfq+7/uM7EZ
         5EszgkLcwaZSxWWo5/hMxS2+gnJvad6jGWQ2PoxwPYaIW+6uPBhyVOo4Bep6DOvXcLXg
         L3TAGScI7CVb1zTBok1qxS2KgZla5/QPfpAtTwbAI1R/Qval/1nWalWETAZK60YkUTgI
         E53694O6+hdJgMguXacgIFK0e8/KnHOu9U3hhoe8OxKGHGqNxZNU23JAQdTEBKXO9rgL
         gugT60hF5olXwEZsV9fpgHXIlC3ET6JoRItqkm6uHq3Qwgpxp/ETp/68HW+P+jqXuxrE
         6jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741429413; x=1742034213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb5zpBZeAXxrIZv2sz7E55sdm1vl362JAnmyo0Aw2TM=;
        b=BLrHw+ywGEqPQrQYy8K5AhSiqa/DAlaRmMbTF/2jq+PqukqE3G+NU366dNwL/2Ig8y
         4+SLaxDz2zLXzB9/LicnSOfkQ6JYOIz5icfpo/ibb9Ky5v2c/xi06azQGxhXkENx7/od
         skDjE53OSW0wBdN75Uhyok9qqJ8/qkpl6OCGdPIhtBBS58OR/xFMu8xj1oHKLYuHSY+s
         iOKAXdp0xMm6BjGrczhiBho0UG/X/TIfWJJ0kGNtHylgZts9tHXG0N8eg2FOHS0N/8vU
         W6tSUkuRIFoKI/kko/uf3lqzyySvoMIklS6cJ1UpL0Zs429yP6AzDVCNTNjDhotyT3Li
         pM2w==
X-Gm-Message-State: AOJu0YwpnsRn4fGASH7Sc6drbCj3Yuekhm66GgUQ+O/UNwzx8VVifeOc
	Gl10xob7Q9trf1a6pnZvRy7ECgDZfj5cQnHn/l/xVuyZmi/2KpfMVFd87Ghsp7WVZ0o7EdiXT/q
	0
X-Gm-Gg: ASbGncuAd+OP/0aP19KEDxebgLw7C2QJ8j4HQ2mw1NEQYzz8EL7phQr0T9oTOMYIICM
	iySTGyWSPzEZ20YF0bQDLhEJ/43qE3eG2GH7D/dNisj/K8bFZHlm7y5OCCZTjkgZByFDBtJTcIA
	CIPVwzSldckQnn1J0yTefjXN2BIWHCFk8x+WaSaNddDmABTIb2Fadz70bd6Ds43qdqZ/3mEJLlJ
	jT+NBMgpGUdAWSu/vg45x5MDN3Tak/nrF6JXPzd1oc1209np45Q/9KEVyu/Aod2VgOFyfau7Xz2
	M+nesMj7umc1icHQrZHODeGID8/BdNPGj/Lt+IMKMNjs8y99tQ==
X-Google-Smtp-Source: AGHT+IGias6fvwETskjIBnti4LTUI/Mop7shoYkmXpTe0gsjKO2iXxZCclvqsnwdhZPa9bu3TOt2wA==
X-Received: by 2002:a05:600c:4f82:b0:43b:ca31:fcfd with SMTP id 5b1f17b1804b1-43c601e18e1mr46639445e9.18.1741429413556;
        Sat, 08 Mar 2025 02:23:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfcb8sm8483155f8f.33.2025.03.08.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 02:23:33 -0800 (PST)
Date: Sat, 8 Mar 2025 13:23:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [bug report] PCI: Check BAR index for validity
Message-ID: <9b116a86-d235-4a77-8002-7de0be61e24f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Philipp Stanner,

Commit ba10e5011d05 ("PCI: Check BAR index for validity") from Mar 4,
2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/pci/devres.c:632 pcim_remove_bar_from_legacy_table()
	error: buffer overflow 'legacy_iomap_table' 6 <= 15

drivers/pci/devres.c
    621 static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, int bar)
    622 {
    623         void __iomem **legacy_iomap_table;
    624 
    625         if (!pci_bar_index_is_valid(bar))

This line used to check PCI_STD_NUM_BARS (6) but now it's checking
PCI_NUM_RESOURCES (15).

    626                 return;
    627 
    628         legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
    629         if (!legacy_iomap_table)
    630                 return;
    631 
--> 632         legacy_iomap_table[bar] = NULL;
                ^^^^^^^^^^^^^^^^^^^^^^^
Leading to a buffer overflow.

    633 }

regards,
dan carpenter

