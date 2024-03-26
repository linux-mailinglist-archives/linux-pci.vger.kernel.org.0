Return-Path: <linux-pci+bounces-5162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6988BCD2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 09:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D471C2C461
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641112E71;
	Tue, 26 Mar 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5/DJVz7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70B125B9
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443102; cv=none; b=G1lQp1BV3G/y8w0jcLdsTPaLCuz7BW+m708+l+xnDtRmFcPVAIlcCzSQXdzmUVvUtgVSjthuNLpAY82XIhXGxv/rO1qF7AwwemU4ItGyzXTXzEtHqKnGPv0CGEwvndc+qFcCcHRkFL9Jy1rXWF9vlXi/0jBLd5lfq+O78mTNlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443102; c=relaxed/simple;
	bh=TAyIPDmi1GrLGPqsrMnh3L5g+mcIopQcCnigvu0gFv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stBEXjO9IU3+Ta98J5+8ckLq8Qbeh9WT3dy5jRc6NTQ/YLWG+T4y/xk+tNvxlVDf+tdGqkS7Ebl19FXdbyd8A4uuzi8UnR1so8AVE5WYVndcmGl5evc90bATPwtbzb4pnblw2Xd+BI1QCpzx0XIY0hA3QNps4x/vLgWNBYP0PAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y5/DJVz7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2575023b6e.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711443100; x=1712047900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uFHWqNrwlUXAKVj4cLzNrqDv+IX5Brk/fK4JneaZOM=;
        b=y5/DJVz7KYXtk/csC3egJkGGt/eYXVuItDs1Qg3vViAID/x/je4ayMbObFARGPwn/4
         9FDDWgTYCEfwpVV8fqxbgLaijtb3vaE2NeN+FIaiSAiaIDySLy+o4Vs8bbt2RqowjPlV
         eZyiOhONlgORnAJzZU15fLZUtK24k165ANJKe3ECe8Lm6WTpnCaQs0C9VIfiSCm9pq4o
         CBIdj753wJIWeeQpYwUG++UMq84hk7D4x6dDRliah2IekBPS3BIBbXS+wVMQHbDVJHH1
         dNwWlWYrMtf5cqbPkGprIK9Y6w1cs+A/MVcJeL5ZRrguRSzGVP7XoJZkD4Z6M73/kzhg
         BnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443100; x=1712047900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uFHWqNrwlUXAKVj4cLzNrqDv+IX5Brk/fK4JneaZOM=;
        b=la6VT5brNuZNWDoYtVztFpZi7JHY65qhETneNxxpx43ZxMZmVqdI6gmYV//w9Se94f
         YKhauVFTPC8aIuyoID9iV5WAgqhuu5+28ehCFicO9dgu84hO4VY9rcvbjKdJh3dGauUo
         2KrudLzJP0W8+QoRnVLxG7ZUvsIOQldp2WJBRofoUezPdqHyD91KPK6pN5cxOiN0RHei
         FgLNzYuKCSZEl71M6gfvI4OjHmbKVJx4iUmkVNP3kpsDdeT+j9O8639VUphA1xoKhqvv
         t3F5aScjugnTR8IdYOAwngpQ9+8qB/QeMTG37v3+/bfm4mR+EnDRWLyKEtp4xSkjGIQf
         cVyw==
X-Forwarded-Encrypted: i=1; AJvYcCWLmVhqxyoRXfyMpPY/HcqfslkUE5FWcZWQMNUpymd7Mwgt1ykdPNovy3ez5hLmiE3K8x3BkVcqMB+u3dBmE71T4xdMDqleCdkW
X-Gm-Message-State: AOJu0YxpiF1E6HJ74+4gAW4ORn4jgW/FFA6rOAuTrNhAxPWKEEg3O2j2
	+hZedhgKW2p5JrjVcbJcQlvb43gf5EmVPxtcH1qitozHxIxAB1q3Ql79dsKDZQ==
X-Google-Smtp-Source: AGHT+IFK6SwO2b3gQYpYOf8ZNDIOIbNJ/5w8Tdag6QREMUYwrwIp+4bbx4vSeMu2hitif60bq6e0VA==
X-Received: by 2002:a05:6808:19a7:b0:3c3:a000:50e3 with SMTP id bj39-20020a05680819a700b003c3a00050e3mr2576011oib.37.1711443100004;
        Tue, 26 Mar 2024 01:51:40 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id t128-20020a628186000000b006e04ca18c2bsm5679913pfd.196.2024.03.26.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:51:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: kw@linux.com,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as PCI DWC Maintainer
Date: Tue, 26 Mar 2024 14:21:30 +0530
Message-Id: <20240326085130.12487-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
And there is no indication from him expressing willingless to
continue contributing to the driver.

So let's drop him from the MAINTAINERS entry.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9038abd8411e..94cfebf41905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16965,7 +16965,6 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-- 
2.25.1


