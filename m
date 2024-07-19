Return-Path: <linux-pci+bounces-10548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84781937763
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87FD1C2101C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2C1353FE;
	Fri, 19 Jul 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLO0ElYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B12CD96;
	Fri, 19 Jul 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390301; cv=none; b=eHaSGhTyuzjV8+8Dk+y4zhCTvxzLYaPUSKiH5L8ANn7FWTK0dEtW8OzNPjYO2unUIu7cKLQWgS4mwsmboktrBCN0ycN0ckozS5L7xdSJ7wCac2bCYbPqOZ8trkG6yWxxNVUjbfk8X/+iJofCKAzApIPKrIx2SY0HpFFE94JxXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390301; c=relaxed/simple;
	bh=sLHmBEB6uBc7dNYSEPGdj0uIBt0mLK9vw20uIX/LM1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUdlfbdGF61zFAujt39+58lt9u/X9aqXMSTztCYC7dWdnSZCdvD8F4nklduZNjHIcPKhBWaW1jchg3S48mOrD6HYvcGMAaytix61B2XZjLco4I3D/H8HnFBB6S9pKK2lR2Aq7WOqo2ASVnpyaJiB20qpmj5xiGS3iMglO2WgQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLO0ElYh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so653352a12.3;
        Fri, 19 Jul 2024 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721390297; x=1721995097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMZ2vwWWPohWA8coYDDEnLa959ZR+LHUBzwjlRfaBv8=;
        b=eLO0ElYh1jr/ieef6lvjtsz3QBCFGtH+1Cw9cCY6TATpx0X72UVdTj/Im4JqLFR5Rp
         OhxfQlunlz4rU0z+Ot15IYRstC+bbjCYUueG9ozwCsQBniG0BiZH8vlaqx8R1AudkWfU
         kPq2VjM8UVRrNvwNsmB2apr1SEmBzdGxbQFvmsuW2XBQz2OZp7leKZTgnSlo3tys2JAo
         4tzhByld/lOz6UwOuFoTGvYMrO9V1R77uTjYCpYoRXYokuhXGM5rZ6DRBK86418y2HPd
         zuuFuDu1YbbVVMN86jpoqIqZpIsX7gQASHudZiuL4N86F1KPyawNTRG3BGtxHc8i/9Tr
         Xklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721390297; x=1721995097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMZ2vwWWPohWA8coYDDEnLa959ZR+LHUBzwjlRfaBv8=;
        b=aUdoIOGr42tJHltqXECC1Wuf41yv89TaNi2yRYg7G+kIPlwVf+VTeSHm3pIgbqJo6J
         bEm6U9Hs7sHBSBwxz8hh/6icqdkVm+O4NrLMbByvn2M4YxebbaUSIlaIQJUID6ErCs+m
         7RbB0KeYfQ3ZxEhv1wou85K/kPthU7CzGKZUGZY28EseDUK7uRJEassILLbknZPtnMwh
         T31c47s5BdbreawVP0FabGt0LhBRjpjl/Thj5ku+vLpYLA9AGlB5OE8RRHbKg7TW9gos
         UZB9eaQEn02W3CC/6hwUy6ieo+39mw9AfoTJ09i1MaNnWtfkwX/paPLGwf2OYNd7quHj
         3j8w==
X-Forwarded-Encrypted: i=1; AJvYcCVl4h8dyWiOeDAHQS11copEOD9XXWNAeEDXOPXGjo+Iozy8aE8W4v60swxQThsLnrT5T1uhE5+zdb74Q2VGe3T+Rh76eY1pm3mbf8DyBj7adzIYp519co2teiUUwRjLa5Mx2p42a3KH
X-Gm-Message-State: AOJu0Yyw1db4NsDnXruUDMNpivYWsfME/oELPhfD3kJPhxyEpO/MEq4i
	TQnRepH2VCwdA3d9GFtdZkcw5a0tkxt1UJlaw0X60Wfq7tuiJi3J
X-Google-Smtp-Source: AGHT+IGc6hAXUPZQKnBDnc0052YD3WK67HOr4rBNRgcSsKlruuZpUKTx5cO8Zv4m9lxTucgsDtNcBA==
X-Received: by 2002:a50:aa98:0:b0:5a1:a447:9f9b with SMTP id 4fb4d7f45d1cf-5a1a447a35bmr2700292a12.27.1721390297463;
        Fri, 19 Jul 2024 04:58:17 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f869dsm1093824a12.65.2024.07.19.04.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:58:17 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: damien.lemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-test: Add support for controller with fixed addr BARs
Date: Fri, 19 Jul 2024 13:57:39 +0200
Message-Id: <20240719115741.3694893-3-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch demonstates how the new 'get_bar' API for fixed address
PCI BARs is used alongside the previous 'pci_epf_alloa_space' and
'set_bar'.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..c6622894091c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -698,6 +698,9 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (!epf_test->reg[bar])
 			continue;
 
+		if (epf_test->epc_features->bar[bar].fixed_addr)
+			continue;
+
 		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
 				      &epf->bar[bar]);
 		if (ret) {
@@ -722,6 +725,9 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
 		if (!epf_test->reg[bar])
 			continue;
 
+		if (epf_test->epc_features->bar[bar].fixed_addr)
+			continue;
+
 		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
 				  &epf->bar[bar]);
 	}
@@ -829,6 +835,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	enum pci_barno bar;
 	const struct pci_epc_features *epc_features = epf_test->epc_features;
 	size_t test_reg_size;
+	int ret;
 
 	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
@@ -840,8 +847,19 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
-	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
-				   epc_features, PRIMARY_INTERFACE);
+	if (!epc_features->bar[test_reg_bar].fixed_addr)
+		base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
+					   epc_features, PRIMARY_INTERFACE);
+	else {
+		ret = pci_epc_get_bar(epf->epc, epf->func_no, epf->vfunc_no,
+				      test_reg_bar, &epf->bar[test_reg_bar]);
+		if (ret < 0) {
+			dev_err(dev, "Failed to get fixed address BAR\n");
+			return ret;
+		}
+		base = epf->bar[test_reg_bar].addr;
+	}
+
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -856,8 +874,20 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (bar == test_reg_bar)
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
-					   epc_features, PRIMARY_INTERFACE);
+		if (!epc_features->bar[bar].fixed_addr)
+			base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+						   epc_features,
+						   PRIMARY_INTERFACE);
+		else {
+			ret = pci_epc_get_bar(epf->epc, epf->func_no,
+					      epf->vfunc_no, bar,
+					      &epf->bar[bar]);
+			if (ret < 0)
+				base = NULL;
+			else
+				base = epf->bar[bar].addr;
+		}
+
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
-- 
2.25.1


