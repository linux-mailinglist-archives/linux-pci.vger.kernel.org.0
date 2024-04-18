Return-Path: <linux-pci+bounces-6424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3F8A995D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6EC1C22554
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B515F3EE;
	Thu, 18 Apr 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJrQZq3n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A71635C9
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441569; cv=none; b=msNtT36KqVg57Me0iLywV3qpyW6paL9EJaF2rANzg7tAb1dPXpO3KvLnC4BNaSGxBr9ikwRwlFK263DkPRF6M3Q8+XMXwNzUrHm17d0VKgoXFnjq4EFZ/bhd93lfVtYPEqZ9uUtyU/XaaLgjqMjiATIIELkGPfivLVZ1jIXCk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441569; c=relaxed/simple;
	bh=wPvLz/T9iagzWRw0v80g9J/FvD2gtvoj9y/M+lLke4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EfM00hlEwCCTa1Uxeyr0LLaUOqsW6zgjAXYC/sKRjPzaeyziuLIineIfpPG9CA3Jvy+Shp1e3nXjsGCBiEZvCb18neUsp1V+Sns36LPaeA7tkapMqnBZScUmN3UCriqX7zPv1eU9kL6gs8IB6HZFfIujDAJRpm7+/2dOsbpVnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJrQZq3n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso755526b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441567; x=1714046367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4Vj1F8R9TI8q7MIK5l/hQOX3n83ir4wVWxXui6RS8=;
        b=VJrQZq3nDTrXUaP2FAdVkEU7DTIfNzYglNDYxzFYFiF23eZ9Q9zPkjqiiiGs+PQdmq
         dKqKt0YNyWOVoRVkwSj8rrnDsUMuIeL3io87CIpd3pLisQjPNq9bbu2Eux6bFRkbCqW0
         qs1NBcQuhDGf364bIoKzmC08sCcz3BaccvswR679u9Ra830VcqtjzVSWA3X1UH673zoH
         n3UPaJMh2Pfz8qf9MWzlrJl6x0UQbhfRmGHB8P0pB25G3o+F/YNxm9besibBUoBBdFlV
         Gc2m7URSpiZuTU58LI6C2d1n4f8yCzclMNR1Rqcsm3KDtQ5JwVHtfcL/FlslkhJ6SbHM
         RxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441567; x=1714046367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4Vj1F8R9TI8q7MIK5l/hQOX3n83ir4wVWxXui6RS8=;
        b=scQ17slv9cyOgrPeUTejUnMlf0nA1Vx8HKf7R/l/G77Jel6QMdboW7SQCDh4EmH2xO
         b7hk17sV44/7ejYzICz1Xj7n9QT4ivTAS7Nzu7ezC77ipg9CFGrJ2SxG6RWoE+JCUNCc
         45nKk1TC0GL9oHmqAvcNKEnnjiDpPkza3AbHEUpXv5o5/CprhH5r77x+orY86u1VVHWR
         3EcF7U2UKzeRA6A68ti1SgDsZE7ysbKjmqrneSvKXystnmH+qDSlXwnBruPTvFv3ELCC
         xpTGzFGavPgrOGKTm2jVsQPPKY7QlplTF8xqgBlFoA20cxrI8i2HBHCmkbz7kBnG2pMr
         a0rA==
X-Gm-Message-State: AOJu0YxvuiQOX0OZXt4hej0eMkJMRKqa2SpkLnHdlFQsUOGWkmaxv4Hj
	ttFx/u2LnfdY9kagUeban3SaxmQNl8wrPOYCx346652AwKQKCk8JLp9U3AED4w==
X-Google-Smtp-Source: AGHT+IHS4gloWj5hbhC/Dd93ipCogJ+/9dqpYOONaI+FHxZh5OpO8R4bGfLpKzOfOMYd7YFcmZ2ViQ==
X-Received: by 2002:a05:6a00:1249:b0:6ed:21c0:986c with SMTP id u9-20020a056a00124900b006ed21c0986cmr3457626pfi.24.1713441567326;
        Thu, 18 Apr 2024 04:59:27 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:26 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:37 +0530
Subject: [PATCH v3 9/9] PCI: endpoint: pci-epf-test: Handle Link Down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-9-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=wPvLz/T9iagzWRw0v80g9J/FvD2gtvoj9y/M+lLke4A=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQr01KUXVFgco1oK+RZ9YRiOBYAvsONgoEOsE
 NzCsfYEukCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK9AAKCRBVnxHm/pHO
 9eCpB/954s7tYvaNExbVtn0Cb9jUNaZpGRd+LEIC6PkCi17re20PXsmvPcIqsieXfz49Yq+W6A0
 C+hJr1bxyW7RWuPdxg6lCmoZbaJPsUAGPmsyUZgExobZrNKBwvn2VkH25b24OKjNs4aT/mlGgdH
 dIl7LANDCLrglhdzfeZFJmyHn9k0s8srrgMyNbjBrzbcq8+tIXOAD1lYXCfObHfbtqikbZwIqd3
 tziFmt2qsaBYr1elhIJkODV68Rt725P2rf82fDpEK02rpAavTXm54TQvCNShFfgeu1tcE2LzqR9
 u+qB7adK1p9/fYqK4iZ8YH4HDGJzZkDXhTh+hpUgKHCsWY42
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
under any of the following circumstances:

1. Fundamental/Hot reset
2. Link disable transmission by upstream component
3. Moving from L2/L3 to L0

When the event happens, the EPC driver capable of detecting it may pass the
notification to the EPF driver through link_down() callback in 'struct
pci_epc_event_ops'.

While the PCIe spec has not defined the actual behavior of the endpoint
when the Link Down event happens, we may assume that at least the ongoing
transactions need to be stopped as the link won't be active. So let's
cancel the command handler work in the callback implementation
pci_epf_test_link_down(). The work will be started again in
pci_epf_test_link_up() once the link comes back again.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c8d0c51ae329..afb28df174c3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -809,10 +809,20 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_link_down(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_test->cmd_handler);
+
+	return 0;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
 	.link_up = pci_epf_test_link_up,
+	.link_down = pci_epf_test_link_down,
 };
 
 static int pci_epf_test_alloc_space(struct pci_epf *epf)

-- 
2.25.1


