Return-Path: <linux-pci+bounces-177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A237F9FE9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F431F2063A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FA200AD;
	Mon, 27 Nov 2023 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZ6cKU83"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC919BD
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41f155c862bso21513631cf.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089171; x=1701693971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0WeQVv6xDz1fA7FB+siaDKsF7jHm7RdEkvM6+sXcAk=;
        b=lZ6cKU83Ln+yT/quD7SMkjuwFY3qBG0aTEJS0eDJLPc+z7f10ZTOE9BTw5yPQsMu4B
         KjA05E+EIQ82KNtEcJ36VDnA78Sz+Pel8lJ1fOAw2dqzaNyxD2Uwfmot7VKOl8WwAtVC
         vWol2mFYS1sLZKRoplGwX7i4y+wYwYshYesxG7U/3G8fh+5x7vd33LULhwf8G9yXYGXv
         cJBGctkrKlqBTw0i2lrLUeQ4/sLTHFND19X7Nv+BzbZpvQ7UsNSfS/lLZd63BYfDszcW
         MLQw4nTqae/FSEK5EarttPP5YNwtAbXJckpVIq/bVSAddd5zD2r87JsLLJk4PeJ7sQG6
         2XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089171; x=1701693971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0WeQVv6xDz1fA7FB+siaDKsF7jHm7RdEkvM6+sXcAk=;
        b=IIkZkZ+h3VR77w3cFcmfdDdabNhjM4+VmwZx45+u6/2GyG/PWfCel8MbG3iYSNfcBW
         RFciGlQqWINd0Y9fDkAQdAlhoz0oHm0D7K3SYcc77BSLJVDZN2JNuuHMMsUSDJwy67gv
         vA5Z959KFVvz8+FOFSLSCc2Q5BTQHv8kVz1w95LyJpXKe3XI+Hfpo7H1xTETqAoLF68Z
         dC1puvYNFIXIGP5MWVu6YC1p9Rkkv9CPe8TtFkmpIVrJcY+yA4wRlzyBTvoYCaLOsh7a
         R4NFSnF8zR2iEZ/AnLN3a+sKymX8shbtw3hJ77v8/6BfClO2dLvrB/y6ApjLlbNJPbv6
         wStg==
X-Gm-Message-State: AOJu0YxeNEfskCA2ec4GRNVcU1Ltl/W1oq2txGa5Q/Jhdivc8fKJEKiE
	dH76K2FrTqRHMk4gGO8et0dj
X-Google-Smtp-Source: AGHT+IERxAcM9ld/cVONnYwD9Qw8esi9QM+/QvFXWK+aoyDNWVgo9aOd0jymm0Z4uVeT5EbnhzFY6g==
X-Received: by 2002:a05:6214:469b:b0:67a:35f3:4408 with SMTP id or27-20020a056214469b00b0067a35f34408mr9911296qvb.31.1701089170905;
        Mon, 27 Nov 2023 04:46:10 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:10 -0800 (PST)
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
Subject: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Date: Mon, 27 Nov 2023 18:15:26 +0530
Message-Id: <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
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

Now that both eDMA and iATU are prepared to support async transfer, let's
enable MHI async read/write by supplying the relevant callbacks.

In the absence of eDMA, iATU will be used for both sync and async
operations.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 3d09a37e5f7c..d3d6a1054036 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
 	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
+	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
+	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
 	if (info->flags & MHI_EPF_USE_DMA) {
 		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
-	} else {
-		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
-		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
+		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
+		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
 	}
 
 	/* Register the MHI EP controller */
-- 
2.25.1


