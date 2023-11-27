Return-Path: <linux-pci+bounces-180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA627F9FF2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A4B20FF7
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1EE1DFD2;
	Mon, 27 Nov 2023 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kv8XsuqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000710CB
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:25 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a3e0fb11aso5943886d6.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089184; x=1701693984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+E40YbuoBKmAjqkT6wNa06Lpu/e8RsvW8Aa+FgX6YU=;
        b=Kv8XsuqFwPw+PendwGLsbOjgoUZwmmT3PNk1mxw2t3U3kn4cdhjOHOB3kVmNQwXRAk
         FwLl9+lrIHbOTprVKPx7LVmilDBdEK2cryucwPqkRQGBp7Lg95NKTJlpq+/WSAv06VnZ
         4O0SK9Ve9coWk5MEVF2+fDbj3Oqi1buONg1E7Z8jg7AJ7WB5NTSHkoRUhC4CeB+Rlnfp
         OkNF0U8pLmkJqPOCRN0i7xURl6HMX3h6VAL8BM7k3bMwMj1Y1hO1Bn1wQNv7AjshEKdq
         3ZciFLgMMhz9goS2FCBdIIWhw14c/Z1E9FscQE65HBNiJgEmyXlwNLNghmjQ2+63MhvB
         VYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089184; x=1701693984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+E40YbuoBKmAjqkT6wNa06Lpu/e8RsvW8Aa+FgX6YU=;
        b=fpg2wUnyQXEPxGhOuHD3rfH0XXtgpKb64QtPcuPbkhx0naHc85oLD5wxtwMzo/vhuC
         X59dHvC7qYHjWav5UHDb8dSBLwTG57sN2UqustEozhn1QnawPtxGrVjQL/tMyWxqpoIF
         QKtpjzZPvmJV9cjfZWiOkunGdw2eRAyKSnrgUdftLHhN7HKIjmP0p56AUzyMeze9YweZ
         HTWQOXnfqVZJtwa2nHjKwzz55IUoBAnIvSnT7TsPfBBmQvPOjflLaM1LdOu6PMA4CDoK
         cpTFkDY6cMbqptB2XQPj2izJed+XK9TnVlrm6qW5oy+FurB/D5GqQOwXYk898jmoNp0E
         MY8w==
X-Gm-Message-State: AOJu0YxkSWEo2VVzmw0PKVerOMS5AWCzUJrLkEFB1ep3OczD+iEJ7GCF
	/1vH08BPNg/qDiHZEO2RRaCJ
X-Google-Smtp-Source: AGHT+IGjJ2kzkE/6gacJvEqAeEjIAyBT1VNMtpx4NnbwGuihBYTTMBLfyUdv0rtU06YkX96BCpwzXQ==
X-Received: by 2002:a0c:edcd:0:b0:67a:49c5:8cc3 with SMTP id i13-20020a0cedcd000000b0067a49c58cc3mr1827133qvr.32.1701089184590;
        Mon, 27 Nov 2023 04:46:24 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:24 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: kishon@kernel.org,
	bhelgaas@google.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 9/9] bus: mhi: ep: Add checks for read/write callbacks while registering controllers
Date: Mon, 27 Nov 2023 18:15:29 +0530
Message-Id: <20231127124529.78203-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MHI EP controller drivers has to support both sync and async read/write
callbacks. Hence, add a check for it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 3e599d9640f5..6b84aeeb247a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1471,6 +1471,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
+	if (!mhi_cntrl->read_sync || !mhi_cntrl->write_sync ||
+	    !mhi_cntrl->read_async || !mhi_cntrl->write_async)
+		return -EINVAL;
+
 	ret = mhi_ep_chan_init(mhi_cntrl, config);
 	if (ret)
 		return ret;
-- 
2.25.1


