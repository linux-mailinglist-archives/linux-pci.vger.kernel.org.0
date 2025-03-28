Return-Path: <linux-pci+bounces-24954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72711A74D31
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C653A3B852D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9041C3BE6;
	Fri, 28 Mar 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="okOKEWfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AC1C7013
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173633; cv=none; b=rFoUB73kK8vvXZ0XH2sLbkqW6YOuiXRVjiE52o9R71Ax/k9MM3CDrHnShNt+66JJoLdCO4mWMa43L5hmV9+BAoDv61Q/mvKHM5H/PQ9z32Gr1wejXK05jhrpLtHkRcugatZuN+012P0DljCgWQR3CYFIfpHSm5ZPLzIKxcVwBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173633; c=relaxed/simple;
	bh=5oAHlbTAcauldOWi9cMUgYioWN6gScafeHZfYPLkyRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JacecIgAL7dq7sN8hd7aFySbSpsUgz2yNphE4F2bI+nsS2NclG6ZIpI/PJSMhNht7bhxTf94hV1RVGMzerLGGijiA4ooFqhxsaQ6157PkaqSfOXZP/97Ho4iqRqrrECAO62mMvO9YzvGyb6mGiISD5ceuf5hSnI0c+X8T1o/5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=okOKEWfn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso16665105e9.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743173629; x=1743778429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om5WJnI/3Srzz6KnBz+MWEytyGjHkNFH1uylSroKmIg=;
        b=okOKEWfnhIchaZtaYWp60UK0xpayqqgpB5D4b0i+I8ukqG/Sk8+XjXnMU5ZSXHHiWz
         d+g2HYuLBHn4gdO1t99+6/VlFsAG8+rpBzFqtPiXz5SGk2/0i6RQ1rOOCbJs6bsuyxoH
         7gtOPvckR+YJzU57+nMxEPPLKbxmeXtFd8F9IRCpGI9uhEZKSdJYU4vSQ1ALG/1LTIUc
         WhR9jfS0yWdziivczKntuGWlNSgvLfHnMrkbxpcZBZmjrR7HCUOqGoQesHaKT6AysUTz
         MTF2me2ZBw9HO20Hs6nTz1Rjm51UQmvK5r0MSnTi7suVo1vwTrdOlNyekhXtbPISj2Pp
         7N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173629; x=1743778429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om5WJnI/3Srzz6KnBz+MWEytyGjHkNFH1uylSroKmIg=;
        b=K1hx7VfM+kNpwvYknEUXhIwt0KZzz/AEaQI3kSm6OVM5CkAvkpEh1T6Vr6zhfqquWK
         ykIMLp7wXdmOkXvNBW1YJK0CZVEfqjvScoha7tpnOB6rvDV1o5nW34xzBN9YuLLtcvhw
         G5vqibjT6Q98W9k8oB+wl0pyC0ibInYk9mSXlKwd1rjbWIlVUYwXKApj6+9XcF7+0pE/
         tPSssjBdXYFJ1D0BxQ9Do4Eokxy8Hqg96qoAewhaljL0cbrQTox2HqDhObbdB+6HVoQY
         E5HaQ5jFqs4pQZ7Wo4L9ERX2rsv3mfiaWlecZIcJgSTyhHet42uZYcKnkPAk9c9DO2w/
         048w==
X-Forwarded-Encrypted: i=1; AJvYcCWPUosh7Z6OcDosa4HxXOiFPGmFdwA5No5NrPtAcrIUbn/ZiLQUrkaLwaHIU0KeItqRHeYlc85NkYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSTHS+zSfJm10fpT1orh0lQdf8s1jHaWrmcdDh1ggjpD2BPhC
	BdGAPOe3t8C6VPX5XXu2G9zkSmbluc1qQtxS2/x3YpJgF0VgKiIy9QqLHd8Hm04=
X-Gm-Gg: ASbGnctqjaTtr/iHh3GzXrB0xls6VH6oZD+HguyPjeD2CRilNYMWND8RRzK9im6yXiY
	cSjXBVlCjvznkJMyzSIhBWEOvM1MKkRuw0swi6PbVS7gYtstr2ymcvI0c5Bem4X//eZVetjuosA
	0DzBXajXz4ylVZYSOhfBEkC2Vs65MqdCnFtoWEYhBBN49Cb445Vk6y5xu0T7HQi1x0XEjq/gufh
	mqde4pMKLVGZV5jwZb9Fam2Ipaj65DUoLy3JqFkdRNKtJsEGZDWLLKJHt2jZsSjjUjdkiQufxOO
	SH7HRO5yglMK381BP6bz7m/2Hwfv0LeoYpk981mFi9wOzsjKpRIy5Piccag=
X-Google-Smtp-Source: AGHT+IHxpmdIjzZ3NBy6ZKDeIo2oJ9uzZLQK6IFavRFuRv86Y+8cRv+dnKeq1VLQiY8bi9c3dCFsFQ==
X-Received: by 2002:a05:6000:22c7:b0:391:4889:503e with SMTP id ffacd0b85a97d-39ad17503e8mr8632876f8f.33.1743173629528;
        Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8314e110sm75219615e9.39.2025.03.28.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 28 Mar 2025 15:53:43 +0100
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space
 allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
In-Reply-To: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=5oAHlbTAcauldOWi9cMUgYioWN6gScafeHZfYPLkyRw=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rf5tteiMGeKSx358xJ2+154PVr7k7RAJ8OqE
 x2hmwLHlNeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+a3+QAKCRDm/A8cN/La
 hX1yD/sHaWYMETTJwDgxrGxRlNsQF+Rc9Q5oMX73ZbvDomTMBb5/EiuCjNA+WGqvLAaxZPnInYb
 gbgbOiq3WmzHn+nEp/DGRjxo8UlUCwJEE0w+E+D89smicnQpIelt4t7+C/M+ImfP/AUC7bxZfiJ
 aJqVUT1ya+PnF0xTs2X1txWYxCtLvr1ez3Zpq7tWgPbvlZzrQgQX1Gs5NkYGemnRj4CdKAwWwc/
 WdPQ6RD2QjKbsur4fqR5Mm5Ykd+yveBedPVUDb2otNDQSi+P+8ACxZ9wn2ZpFbQeSdWa/wrxgFS
 uaKxglM4i8uT7qLrWJWP5we/cAKLPVTI3n11V36Zs8g2ppjfZgAwIhZckxcPGaBFNStjI3em2DX
 y1oAkpi56w/B7itaLGgQ2OnANTCeZ74U/9RJe80a4dq7rHsZcbs8yeIxhhnIWjN/fRvO4nqpH09
 B/XqYI18bYdgYLJ4zPvixPbtVhvoAxCpY7xJPyOhrJR27m0njeWb/dugQjI+03LABwI5PstLYYl
 qtDWRm0pg2/TA/v5JTTzpqK2BbEG2ST+9Htlt/UeGLN54VADr9qtKB/C4PCkqs0HoHNRJpX6ufm
 2UoJI+sD12dRMYYnCviwxrBt7KSVPuWTN5lnUmnHqTOFDl6WfqoPgNvu3mAsPJfqPMpvduOzCNN
 hJsCtJfdABnSOEg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for the underlying BAR, whether it
is fixed size or alignment. This is already handled by
pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Just drop all the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


