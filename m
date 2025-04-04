Return-Path: <linux-pci+bounces-25298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56632A7C2BD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 19:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D32189A597
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D6321B9D8;
	Fri,  4 Apr 2025 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BMoSoKJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318B215040
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788798; cv=none; b=LZiROttsmKZupgmnYJ8Tt3jZZJbNUqzn7fbDd3kusDc5qL730+fQu+DdJH9TB3jAOEeWx8m45SJ5PUzm9KOiaOiW2PD5/i0VA20ZL+w4vtgfjFlfimguxZrvKDSusBIrV9oKtjst15zrMQoKcF9qsMlnvFvj8MmuNVqxIYtMsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788798; c=relaxed/simple;
	bh=n0KkujYCmFsi6TCmOtVdMu0bbfrL6UkgnMn4aw3JxJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTeAxTMzSZ6n/mMSzen1ldygNLe97lq9YCcCwp58xQB6p6WxVHR0mXTlm5Jdz9e5gN5sz4tu2L9FGxXgmJy7uG/WI65QHos3yRLDIaLq969jIInDMZWuAHJppwKFUCUMwscUT5fW2mOBpuBUS7bK5BSs/Ofv/MJlK+BObh3dTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BMoSoKJU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ac9aea656so2069115f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2025 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788794; x=1744393594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=BMoSoKJUykjQ5WSRyzd8htirdiEK14dt3XvqFsw9KyimfGSvmKgWqZ/dkMJgt4Lsyd
         A1s5iKJxukguw43AmboqYamrmD9SL4KeHSoTpaMryww/opnqBrCmnghHjbsP+9vu1bhX
         jRlcGWIyRTon2LZifHqtWdWslKYw+UseBhNHteFZCnWs/56D/7Fwx+VguxUH3rUF03Fa
         IEL6sooOKYuiJtO13US4u9VJGc40yvHkgJ5jGWR3Ms2gtyknbCzVpGssZZ9kHlF1TyQu
         Dv6o2nFUFzcdabqZgxpNSzkU27fXrJH7d01kozqEI+cqMhmN/JXYKuh/mn1M509zS8+T
         QcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788794; x=1744393594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=Ci/ndYxQRzeZJiFWDHm7PvzX1IBIlSXHZ0ao1UYz4gIZ7rDeRvkeKxifJ7Sksvw48e
         D0wvLP/KKYtkWa1ZxF0Q4ALBwxOaCEIq6a/ntWGBHj5hAvf9ZP1/N18cOKny6y/2CAph
         yVbobAqffpQW3qaRZGf9qYWfA1nl/xASpigOZ2DZe/9MHE9FJMR65B/Z1LgcTi1IopDD
         dQ1ZGJOSzliYtDlCe6axszZqBSjmtMsly/6dojXqSLMtQOI0nO9vjcy5t9dicDdE+8AL
         8rOfLXziUEf/ifxIUh2Hv4IkIi3leissg+LdgHb9hftDs9Gpp6hFcvIh5J7LAJPAs8+j
         jALA==
X-Forwarded-Encrypted: i=1; AJvYcCXSxhb+4+e9l4+AV5G5SSCJn5yVS+aZrNdoBERogtWxno3tSovhW93yFDEEyfXHzU+JirdgCWuJWK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WssW86gAfXiII1+KOHPU9JDMCjVMNEPQf7ThE666IqNOz8Zm
	TD4hkBiVueUmtNaiJG8yCPfOm7gUYGaJptMISWDzhBivcawcNwNotv9XMuTP2Tk=
X-Gm-Gg: ASbGncudCM3bDbVlu77gQSQngDBWmSLIVQ8Xh+A4JXa+ffA8iwhbQi2Ck0o162pzUbu
	8Uk1slXnTQMVOyi8INDzLcWRS8R0GtuWVG/5wlsXg+vutx6z83wTSU1RjikKiS7ESwT8/9OqUY5
	tuMvESDNLIyyhizG4lACLzhXBzobO6tJyF5wlNq2qqWKGdE1AquoWpjHcMJV9OvGf6JPRSQvBQq
	gm25UU74DMzJy5PX3Z3Yp6mEqwlbwD05TRBCMsOSrJMgjue1JDJdzaB1EKJcu5gvhE4QEBK9etM
	F6jKUgdhF3/YtxJhMflzedCWJ1Ab599rh+RG3LRpBVM1m62nfGMs0wbYhg==
X-Google-Smtp-Source: AGHT+IEmApi11yA6tOT0eemVOGBTN2LnrWT3UdKLD1oWXnbRDDDJhQjzlClW4YROw282/g4Zg8Ot9A==
X-Received: by 2002:a05:6000:290a:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-39d14662e92mr3389503f8f.51.1743788794420;
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 04 Apr 2025 19:46:21 +0200
Subject: [PATCH v2 2/3] PCI: endpoint: improve fixed_size bar handling when
 allocating space
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pci-ep-size-alignment-v2-2-c3a0db4cfc57@baylibre.com>
References: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
In-Reply-To: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=n0KkujYCmFsi6TCmOtVdMu0bbfrL6UkgnMn4aw3JxJA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br1H2IfezMlXrBbIxRkNQ3j+kTXSTGIJoiCl
 BJLVqqhDXiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9QAKCRDm/A8cN/La
 hbZnEACJzgxE9lKIX+NE+nV0iDTm/dKMyc9oMEMR7lXtubsne2ToqmweqeTyZ9sN7Ce+uRFA8SO
 b+32pA6IRIM3ZjjUcmYhG7ampJT3NowyeJUYVwHaAxUOuX3fPbPL5e28cRYLmMuucKj5O7QNwbI
 4dsui7riQUQMOD+zEYSTK3q0HTOc/VVFqSiDosRLVFit8fLfj42jbslafJuqP5DW0514nU1T1b5
 Z3fo4UB35RDZv3wRh3SzclMAzDs9cWD6XZSNOtctlN8uGx4wMMD1MD4R0Wnb+nqBlH04awxi4Xs
 j7PhQHtzCB38TvCJWiXb7BDHCg/H6stmAuTl4I7lmqUyI7YN71yC6kYD8UTpq3qPQl3GgEgChPN
 bdWlJQiid0+nH87x2lTEOeQWqI6pXFMyYu/Y/LiXLYNLxWcN/XxG6YvRy+y78TRY3XRzLHKkFw2
 HbwUX4KhLgmgnLKZYK3jft6zqDJHvpX5Zc/rk73yCo2iPCSQNpM4FjQvJ5WhcHlbMwhCDP90I4/
 HjFhT6t3ynCFcCfWG5h6xEILzloLvfAxALfIdT1u4YLGW+AVBbBYkfbhQUDXBKpJtVEbPKZVMPE
 DJnct5Ml6aKHyxZQA9+yw9e0nbae2XNd13vVFAQuByhwx/BLljKLlcTFp370RVzlcbC7DIbC9WG
 Q85YLg7u/YS3QiA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When trying to allocate space for an endpoint function on a BAR with a
fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
size. This is expected by pci_epc_set_bar().

However, if the fixed_size is smaller that the alignment, the size saved
in the 'struct pci_epf_bar' matches the alignment and it is a problem for
pci_epc_set_bar().

To solve this, continue to allocate space that match the iATU alignment
requirement but save the size that matches what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	struct device *dev;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc;
+	size_t size;
 
 	if (!addr)
 		return;
@@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 		epf_bar = epf->sec_epc_bar;
 	}
 
+	size = epf_bar[bar].size;
+	if (epc_features->align)
+		size = ALIGN(size, epc_features->align);
+
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
-			  epf_bar[bar].phys_addr);
+	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
@@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
 	}
 
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment requirement.
+	 * In most cases, this will be the same as .size but it might be different
+	 * if, for example, the fixed size of a BAR is smaller than align
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;

-- 
2.47.2


