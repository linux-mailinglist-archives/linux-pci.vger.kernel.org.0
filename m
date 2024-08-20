Return-Path: <linux-pci+bounces-11857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D01957F1F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20960282296
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CD16A39E;
	Tue, 20 Aug 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyvIS06c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307A175D53;
	Tue, 20 Aug 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137872; cv=none; b=PFirZqY2EJ2qaArnAsHdDRZRnihz0P6BNTQpT05gNKHxGTLoncxY1vBBErblBOKGZ486NZE2fHP+23/0mGuSXFkoAbGpYAUeeiIo7yvQl3C+pkO4qbVxxHeGserNuagLqEGGEj9MaHgtqYQE6KmmzYiMJL973gC2ll2W2OL0blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137872; c=relaxed/simple;
	bh=3ZWDWg1t1D+RPYXx8gzEfFQ5ALhL8sunlbJK3VRGTZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwRoMKgbeajToKnz6fxbVnxBiEnMYHX5vKvZHTNHh+dlb3PuViIa9+AzneAnrbNIwLmrCLflUNf1aTwp8p0eO0z6olJABK7XC7OauWSGZLOZqxEylyDKk2TY17PRalAQI2prpH9HjgZ/N4PDkLrRcjy09t5mljaSBgcOyh4yXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyvIS06c; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1974671e87.0;
        Tue, 20 Aug 2024 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137869; x=1724742669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sw1EjNYYqXKw/3E3cBIyLqgir2CEwE1gKz7qYZh+Og=;
        b=lyvIS06cxw4NfmxKfN7WwRs03xYajn/kQ32Mo25TuBQmAv694bTeBKhC+xmOyQuMoc
         oBf6SBl8KC9RUxChxpASSHgcPIVKAM0YY0J554ozEMrwHH868jsAO8R34UpFlOU/EvFh
         QWpVwJ+/oQcJE0E7hqlUyqm69SQ6854xVnWy3wDknq9m2jobtMr5dSZa7MHxIQjyqGgt
         IddpQGvsmtstOF5OJVCvclVhlkbXGSOLUqW2V6KkQujhdGZpHDFysqoqEv8rAV8eLTVc
         N1Z+eggYp3kCu+PRs9uWyK9itjOZd/uLBJHqZftQufBJwRRMKKh74cdKfSFvKJWwvp3r
         XoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137869; x=1724742669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Sw1EjNYYqXKw/3E3cBIyLqgir2CEwE1gKz7qYZh+Og=;
        b=HuL6Hpxc92WzjoLohNyOM+UL4OwxhlpaQ4qguFpI1PkeiN0WB4I+fiYzxSFjIXciWc
         NMtCmjIhWx3EbFbGEE5lt0Pd4hmXovyzNlzBGjlRKXGqri1sIaXyi/mhXAIfHXKgEK1W
         dGMacii8JWsdqYGBme7hwgVBskfm5QvTYNekiUKNe911tGmW9QxQoiiBvekAKFBFrko0
         LOiKWb4jVwcYHKXR0KQz43fmPy8aZfw5PWBHxMGBGgLvmVUtQGkd/KeU/91DJWzb6ncU
         aUuZP3pSWIOlOc+bEOpKN3tg2zBlzp/lkNuKKivE7FvheSxicusASqXmMZMMvIXM+YV4
         7wqw==
X-Forwarded-Encrypted: i=1; AJvYcCVjDww1HEujF3IoepVvoo/qhg/uGAoO5lgr55/BQC2ETOLool0lxlHmYqdH3TIu3p4KtYtEyXGMSVRs1ABBvFeI0NUDgyFv4S76BGTosTCjKnWMF16yABtNWsn6zeXc9BGJB8VbsCT3
X-Gm-Message-State: AOJu0YzSnq03kZI/KFf53HjySfm65oulp1qh1keWQKgYCKx5W1VFD9Ub
	Mp87bZKxyohI9wL610BLFX1CuDrLyDbfSEMa3yFijjy62DZkQj6X
X-Google-Smtp-Source: AGHT+IHVphgqtob1LvNuVkik6YiXOUNTJb0JOmhDREdgGVTXDU7L0ioy5P/bpyldI/ncOZmJHfX9OA==
X-Received: by 2002:a05:6512:2820:b0:52c:cd77:fe03 with SMTP id 2adb3069b0e04-5331c6a1794mr11560695e87.14.1724137868162;
        Tue, 20 Aug 2024 00:11:08 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6639sm721911666b.7.2024.08.20.00.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:11:07 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] PCI: endpoint: pci-epf-test: Call pci_epf_test_raise_irq() on failed DMA check
Date: Tue, 20 Aug 2024 09:10:58 +0200
Message-Id: <20240820071100.211622-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
References: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
is meant to be used in a PCI endpoint device connected to a host computer
with the host side driver: /drivers/misc/pci_endpoint_test.c.

The host side driver can request read/write/copy transactions from the
endpoint function and expects an IRQ from the endpoint function once
the read/write/copy transaction is finished. These can be issued with or
without DMA enabled. If the host side driver requests a read/write/copy
transaction with DMA enabled and the endpoint function does not support
DMA, the endpoint would only print an error message and wait for further
commands without sending an IRQ because pci_epf_test_raise_irq() is
skipped in pci_epf_test_cmd_handler(). This results in the host side
driver hanging indefinitely waiting for the IRQ.

Call pci_epf_test_raise_irq() when a transfer with DMA is requested but
DMA is unsupported. The host side driver will no longer hang but report
an error on transfer (printing "NOT OKAY") thanks to the checksum because
no data was moved.

Clarify the error message in the endpoint function as "Cannot ..." is
vague and does not state the reason why it cannot be done.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53a..b02193cef06e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -649,7 +649,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 
 	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
 	    !epf_test->dma_supported) {
-		dev_err(dev, "Cannot transfer data using DMA\n");
+		dev_err(dev, "DMA transfer not supported\n");
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
 
-- 
2.25.1


