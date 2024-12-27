Return-Path: <linux-pci+bounces-19079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6B9FD5CC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2535165918
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1F1F5403;
	Fri, 27 Dec 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvGiemKz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552E4595B;
	Fri, 27 Dec 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315738; cv=none; b=SFe+oJk/JGhMevp2xZtW7tuzkxHn9uEWnSE+7AlCNGafrE/kiawlGxhntyZumLmalO3X9+RRNsSP0lOD48u9LPO6oCd1uwqTMDZLWVaEAu3dYSvCuMxyDgSlmJ7lMbnVWVuqqlGG1vUVNc97nsIr51e3soSkJJYKteY0opwWNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315738; c=relaxed/simple;
	bh=PltFEjDqHG5VfA8K35i5/VIY2yfINgIG5OBgo6xoWqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3CgVJiYRSOUdFkya83Qg4oT/6I8nmGI0Chezff+Y3K71KYHcYywwFJFPsqk+jUD3vp+pZD8mP9IogpTx5OMD5wYmzQT+vQnISIZVjunwaOcaw2Wrnr7WyCe9h8WZeR/O2dGx4fqzSYJPbm11Fp/UMWAuSG/k33YOiIiUb77QMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvGiemKz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so9378096a91.3;
        Fri, 27 Dec 2024 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735315736; x=1735920536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg2aCUZdqxsG/egT9DByGidhKvdlW30bhC78Xj8syVw=;
        b=JvGiemKzBxi+RiVe5KUy4Hp70vJekIsOf+mxKytudfHpAMBEAzy0llZNXuyUcRHi79
         5rnzHNFSu+TRn4Yx2KBPCOTLb00IOaPj46oLCzaIMz21NJ6nrZpSUGUaMe6IWJ7RJcbk
         pm8HcKEiKCGR2pYePWUUoYIECFVDMWxsguk9Rd8DQwWJhoIdYbts8o+i9JqeY9H9aJQG
         Lq+NLq4mjSV6puaQisArBClqnUa4EDQUmG7WUbaOdeosn4s8RNFNzl9My8ySJ5SiPbuo
         XHCbIX2aVNnhI6e6Pg9iK80+RozZwY219lJrkRvJQa5xzkv134pcNm5T9So1IRcq93P3
         l6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735315736; x=1735920536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg2aCUZdqxsG/egT9DByGidhKvdlW30bhC78Xj8syVw=;
        b=eYjSbvyx/sQj0eSCYdo+AS2rwq0UvD/9T1BPn8TnR73XwMlNOlia6W0evl26svMiOP
         OsO7NdRJq9Oh3GWZZ+r+vB5MrRAySuDPTrOloR0+nYZ45eu/7BBH0hF0+30mgNOCX2qs
         B94dyzbaEIjxOXLmYoRWRHSzmY2Pv5Z4F2LzuH/iderN9rt6tkmiLcLC6G2Wfgjx0Clu
         Xi/p+0r/6msOCNfKqpnUnrhckp3U9m+K1nVjeyNYeet4wW+x9/IEpBE0PwaI0UIMD/zK
         hvRiqQdGnxXU94Rrq4vFEfSs4ApuhJW2oJy9Ud3BzolGK2f9IqyQkCj8XyC69MZAQFs+
         xGMg==
X-Forwarded-Encrypted: i=1; AJvYcCWLzPl2ebwhZzj1KmPY0Q/aIokaVU9cFwJ+rzVJhm6PwUK9nANhGSDN4OjoEK5gffvHtGfoYxkPVUhl/g0=@vger.kernel.org, AJvYcCXSdfntOjuPjwpfHKI+7+/OkpQLYUxzrk2H4w8+crVVvhG1fSFdHtN947ICDhy44OgGXcXQInBrJFjo@vger.kernel.org
X-Gm-Message-State: AOJu0YymJGCAi5WVb8SV+BGs8XD6Spx7BM5y8Irn9YozWv23lV0jbx90
	Cn1EITPenb8G1mJh+vp6JP1EPBnz9htcRxjpY7E7lhx+iv2kbbd5
X-Gm-Gg: ASbGncsfuvmUD9AUbMICnVBNAn5SSfh0qfKF1506GIbDIOhaL0Ou/gCxO3SOd0AXMMm
	wjsxwW2O9use0SjpXAJYCGFEcEk4EQg/bm4F6XxoVB4Y9n0GI72lYwW/ghaY9HMeavdBqFN+dW5
	gB4kc2dMiXYXIiUjFc+Eyerppf2q1Y8wH3ZB87hQyTPrh6VJgjcc80yD75A1m8qlttWKd4G02Ia
	NWAdbtMta/cc4r83APGJikuX4bjJ0SxGO8/dODIcjjTvoYyJGwkSNWrCD9M8qOKl7GQ3TX9IpqL
	hUua/Aw8XNlj7LnrMqvDl9MBEA==
X-Google-Smtp-Source: AGHT+IETJeKo9bLa/qcgi0hSdAP41gVfto3VstZr2dndZrmmjIg40AzbQDyFkSmWqVpUZwKdp+ADRQ==
X-Received: by 2002:a17:90b:6c6:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f452ee08f0mr36153124a91.32.1735315736095;
        Fri, 27 Dec 2024 08:08:56 -0800 (PST)
Received: from localhost.localdomain (c-24-7-117-60.hsd1.ca.comcast.net. [24.7.117.60])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f44779890bsm17687861a91.9.2024.12.27.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 08:08:55 -0800 (PST)
From: Mohamed Khalfella <khalfella@gmail.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	dlemoal@kernel.org,
	jiangwang@kylinos.cn,
	khalfella@gmail.com,
	kishon@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: endpoint: pci-epf-test: Fix NULL ptr assignment to dma_chan_rx
Date: Fri, 27 Dec 2024 08:08:41 -0800
Message-ID: <20241227160841.92382-1-khalfella@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
References: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dma_chan_tx allocation fails, set dma_chan_rx to NULL after it is
freed.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..d90c8be7371e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 
 fail_back_rx:
 	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_tx = NULL;
+	epf_test->dma_chan_rx = NULL;
 
 fail_back_tx:
 	dma_cap_zero(mask);
-- 
2.45.2


