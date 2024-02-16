Return-Path: <linux-pci+bounces-3617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5B858438
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B53B285C20
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600C13473D;
	Fri, 16 Feb 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPrPgQZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB2134750
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104926; cv=none; b=u3ZPy+D6+enAz7g7CAz36K+wl2v59kdqkpSKTFhcNfARPm8m7ei0ojXbMZHOzinm4jH8kFcLg2eQXqxxQ+bN7/QCU7BLhkLT0apJ6RExUvB0vkYfKr5EmRvpFdZ3Ku1EvEq7Lp6LRo2mMW7ovrQEsok/siwWWTP738L2D0nwHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104926; c=relaxed/simple;
	bh=R1GLPwlYfMEGgtPbyaSg7QFWg/JNBX3HH10DnKKcCK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvwPDV/jp5Sdqapww8ws1Km6HkIsYXt4OJue8AkrGYDpN9+ld/9CZwwdGfI45CuTzn+o+FlkaM+DWuB5zICMJ2/ApGy6WloDGldBK2z38m4XSqTHiqzPOyQlZqQU7qH6Uxxfqf+ymWwBPOVqplLzoZJhiNv6+L5+CQ+NWZ41QBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPrPgQZM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d91397bd22so19944275ad.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708104923; x=1708709723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWuu4IaCb+ecu+2X4FcUxgf2SPat8siMwG6Oun2YK2w=;
        b=KPrPgQZMwL1HCPXC7wBU5oYFvj++78+R55108VsQBi9jWS3x1PBHwgZBUJwMGjt/Xv
         WVjSaOp7tOYhLOP8O6I0ZLqJ4/Wu4fg/CkBFN8IyfO5ycTtacmT9czYIuhMMhjPKJVia
         4h95pCe9D530v3bQIKJ+XaL0xamOufrpXZUtpbssjW+t8I1RHatNGdiudZkqkMjtW9q6
         VfT7l2oCkFqsAJEa9U1KrPRxjlj+O9vPKqtcpRA58/2JEf5wlDoF0ry+Opw7fH6EmOin
         32bAYoR8TAcbdnquUDA6xZeNuJnknd9ZgmUAebdqOR29ir+Rdega9Q9mrcqdCcXQatGd
         QPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104923; x=1708709723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWuu4IaCb+ecu+2X4FcUxgf2SPat8siMwG6Oun2YK2w=;
        b=eDnFRWcI8Cnn83Sz0uLXuDxlnFuekMS31fjqNvPWEAxjX2365dTCl7q2+Ed+l1eUci
         ls0EWLqQYEIzQB71/g8UbGAfI5omS4ZbawZGsLWark8bOOO0WmqTKgIKsstBO9HvdhSt
         FOIc11byaj/dRLt4Ho8z0fE5IKNZ5mNpx2nqXYr6eATplP1aiA7ckEqKVOmOfs66r0HK
         SKsFYI7+8RAyAQMLt6EVXlROt0HCINpHcy8Gfw1d6U2G07hx+XSq3JE3k+JJlnN26y0c
         oB6ZB8G+3VCHMxLYTlqT2RYFL7BgxV1q7LC796rUiWCzlDG8HQtCsEwhrwL0febwD+Py
         VLLA==
X-Forwarded-Encrypted: i=1; AJvYcCUHSgKcT9L5pILo1RCoXigyGX/coK6yB728G1WUn83Bq8+emdyoxsQZy7CSpKfMaZbadK2UyXkqpDSDjtPjj81ok6UGsSmPxbR+
X-Gm-Message-State: AOJu0YwV2fakZjyyLkvxSCObp9NCIoVXNG9Dr2ceF0UPPVVxSqqVkq6l
	G4Duy6N048/yiunf7hMm/WKKITR2pi9UVC8a6ien7NYWjsCNovZoPmyQ3IvQZg==
X-Google-Smtp-Source: AGHT+IGdCXZredO/BC7qQxhRij/KCAb3j/MIg4DPBT6lo3YCmbYRREkXZE3AZg1N6MirSxETbxerBw==
X-Received: by 2002:a17:902:ea12:b0:1db:ae5f:a38d with SMTP id s18-20020a170902ea1200b001dbae5fa38dmr2114924plg.5.1708104923231;
        Fri, 16 Feb 2024 09:35:23 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001db5241100fsm118592plz.183.2024.02.16.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:35:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 16 Feb 2024 23:04:44 +0530
Subject: [PATCH v2 5/5] PCI: epf-mhi: Enable HDMA for SA8775P SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-dw-hdma-v2-5-b42329003f43@linaro.org>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
In-Reply-To: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=l9TZl5f3ruMfAhDvync60x+vuqThCg8E95q3H1HbSYw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlz5y+NwBcDBvMsgLY/9ArhUeU4RtpAOkSNOPA0
 cL+6HT1tTCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZc+cvgAKCRBVnxHm/pHO
 9YdiB/9TA+DKLXxIZYpi/4hnMyIkUsM2WJIWyQ6w7vRVyPe9xkvRVouAEDo3kakdlZprxiUhdRE
 RVaU7JFkgelmHQuyS7am0hGDZJpDmEmPrmuGigJlrygDliRLE85n5WP2vnnN7WKQuYN+W8HQnv0
 l0f9zuR0+G+HEp9D1og10j/2BOueS6fmgssxK8rtfpi2VW+6FgY0KiiqpsWdUq7od5/Ucw2nR1F
 NbjzPj1POiJNg12Bi3HrhcTLZjvb0KwfS/lV5Mj1NKvbtl2anyrbqaqqbejjAuqCSzx91cCovSW
 ddbe/L2NDfdpqcgHjOuBkoP+92IIH3SP4KN6C52nTmQjmNqV
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

SA8775P SoC supports Hyper DMA (HDMA) DMA Engine present in the DWC IP. So,
let's enable it in the EPF driver so that the DMA Engine APIs can be used
for data transfer.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
[mani: reworded commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..570c1d1fb12e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -137,6 +137,7 @@ static const struct pci_epf_mhi_ep_info sa8775p_info = {
 	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
 	.msi_count = 32,
 	.mru = 0x8000,
+	.flags = MHI_EPF_USE_DMA,
 };
 
 struct pci_epf_mhi {

-- 
2.25.1


