Return-Path: <linux-pci+bounces-2338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC783259A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 09:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD92875B8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98114288CE;
	Fri, 19 Jan 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NU0XExYZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163E24B2C
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652372; cv=none; b=M2YPj8m+Rz8HAVq36B0hw4sffLqGp41TmBDJB+TuJDNDT8lKH45Rwl6o7sJgnhNgmvfZbied3zs6y8zafll+d3KrhYbFSxZNTkOOGBXMnkJrm9rPa1GHBchjeDuACpDUg1O7HksN52+e4QUGQm9SkDNxjWVn36llXh50naEQiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652372; c=relaxed/simple;
	bh=0NtyQhvsgw43TNew/V0z84BrT4WGsBx0U3Djf9UHZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=abGRgxGqU09z//O70noD0/kDDYEU7nYvdxfdZBvnwMjqEXFBG3q+AmxLLKN7i2wXiU0wGunGe454Od5MBdQkIPe8+y1HMgY5Ou4Auvbj+AUPd0R1pX+0UDP7f6XpY9DvMwuYgDOGqBpEMVYwi3BQXBHsFbHkNgQs4gERjJAFV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NU0XExYZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337d6d7fbd5so675848f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 00:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705652368; x=1706257168; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i23IsiSzG9RviDZ2SKH7TkJYUYoPbm9hn5rTUny/9bs=;
        b=NU0XExYZxVaGGz5TbGIUPBSPX7pH1AqmFTsj2u6p8rmMMcVRr9Qzhvk+n1zCaIoX+d
         Zf7GLvrfwOlk4sKu/hXhAJRx9g5x/65GDB9nj2ojmCYOc0SuRNNZcSkP8MhK6gF0lCjo
         BBCaApnNa04e1QFU6nIcKVHuJbM53JH8v1KzQWePso0Ffs15NZQcXsm8V3aQmCdZouQn
         s4oHkZDzmPWYHFrirc4H3f8MlPbEvCaEoWJXKs52uL6ZHC78C4aiYsy7taGJEhYDqfcU
         xdX/N/tsJXaw/iW7c/rvGrUUSFdJLF9diV3vocB24b3oefmWJpWwQWE7Q+JespQ2xF7+
         G33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652368; x=1706257168;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i23IsiSzG9RviDZ2SKH7TkJYUYoPbm9hn5rTUny/9bs=;
        b=V86i0VbN8zX8KXHQqaYdNNoE6QZ90wYMXAuFIqjizxfWLzxfew1BANL5LRXhi4SEJq
         JdI4H2O5CnuJz6rW1CmZmE7HCG/1b9qgKnCsjeDR9w8Wfd3d73TkLOmDiSTT+QaupZhl
         22Ry6dG73Jp5zrflK0TWD8HV4p2kyeEObrIHQy+FkiLkzlzFqQpkfh8mHFhWMSn5w7xJ
         IVWSp/N1+7/rswjoiFWckt3wK22f6wINKuDXmFSKB5Ie7VEpXS57QfhjPCS7ynBLbq2h
         pwDRwxhXYQ4NPydum9Wa2oVVv+5DqQC8fYE5fvUTXgLntNCd1QQCdWBoESqDkz6JmZ4J
         d6Gw==
X-Gm-Message-State: AOJu0YymV45R8sX3fr1/poq0nBFhZyGTXcgDZkMzL5UTYVlJYZE3vRRt
	BNECk1tl9CDvrngIoyRjoG7SicXGSA4pndu3Ioxxi1W/tAWWfFpr5fnbhz33ooY=
X-Google-Smtp-Source: AGHT+IGsWCfBXvTF9VJGT/Up5q225a2NnostHgfaeZgPBMm1e//LQwXl/AdEU0/qrgdbI686FG8o+g==
X-Received: by 2002:a05:600c:491e:b0:40e:4807:812c with SMTP id f30-20020a05600c491e00b0040e4807812cmr299567wmp.38.1705652368574;
        Fri, 19 Jan 2024 00:19:28 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0040e6b0a1bc1sm21401815wmq.12.2024.01.19.00.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:19:28 -0800 (PST)
Date: Fri, 19 Jan 2024 11:19:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <c5035dc2-a379-48f0-8544-aa57d642136b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msg_addr" variable is u64.  However, the "aligned_offset" is an
unsigned int.  This means that when the code does:

        msg_addr &= ~aligned_offset;

it will unintentionally zero out the high 32 bits.  Declare
"aligned_offset" as a u64 to address this bug.

Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix a typo in the commit message

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..2b6607c23541 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -525,7 +525,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
 	u32 reg, msg_data, vec_ctrl;
-	unsigned int aligned_offset;
+	u64 aligned_offset;
 	u32 tbl_offset;
 	u64 msg_addr;
 	int ret;
-- 
2.43.0


