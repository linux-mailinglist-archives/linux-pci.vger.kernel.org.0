Return-Path: <linux-pci+bounces-42870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA5CB14EC
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 23:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF5F3012BC2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2EE2EBB89;
	Tue,  9 Dec 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1Whoiqu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE322EC090
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319883; cv=none; b=PazDOch4XyYsAWF7p75MpJJM1LikAESAX11hhk4b89m7FCOU6Jp1oNV3bHwn+LZGYEi1U+SSVk1eHDUHNQkzWg5jug089RK7DX+m+zz4iJDSCGbWNCqa0R0IWUhXEI3Ra5gVZ6XpfYaON5HYUqPH3Un8WCKTrWuK75YbfToq1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319883; c=relaxed/simple;
	bh=sdXGJfBHkvwR6kjDlZOa2OqG/E8eoLySwLycL+bnfeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Bdj4x2JaFenClUprd3DPAfQQIMbS431Uf/qBq11rTnQTkpYQuJYFjoEmT7reB84WyfikhmPYJLyzkUF3MFd8DlFjtAPywzIaDVqziusqLZpBG3Rm2ElC8WFexAaGKK0Y/OpAqETrFYzXWsVhvaSJf34b9sfZOSj7NV0pObF86vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1Whoiqu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso7215926a12.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765319881; x=1765924681; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AMwjmsmi4mVv5vZzNSGwrM0RkjwLo+Rq8irZPLzhGz4=;
        b=I1Whoiqu2vP9ATedkb/VpjxcZOBNbI8BNYFe+J87ZvEAYb7DuqPzkp/YEpO+DRtlj8
         VxXVTJjvroyHEo7A21CE3LepBMWakww1uXpOvoXaFJUgDNeLUtO3xhQJ92aqzXe/ZwUv
         zx6+iFgOEPHskCt1VW13D/dE3ZiFWsTRH+6h02VAlRRf77auEa9yaWxl0AJ1Vb/c0xrx
         CYMW5EgA9HbBgeLzNFghj/PFAANotIuJtfV/AEvU19Fd8/5vEFdaBXsPEG9s3QwdzKtH
         /l7DriZD9SFj8Pvl2Jdd3u3j6XJCIUIttAipj0OuK99N6p07Dfczt91B0dRT+mHiEJx/
         QHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765319881; x=1765924681;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMwjmsmi4mVv5vZzNSGwrM0RkjwLo+Rq8irZPLzhGz4=;
        b=i4DecQBIlYxHwyVQAMK2zoetxEP3nSmP/roS+FZG3IvSTViGNtDyKx7G/HPEnQqNEL
         n1EWdlFegjT3AyVQfoAFjaDUD+3Njosl/dVqjE90vBOLQqqtrxSYqvFFAGIiRZa84v2i
         yt0hd8iWn00zLLPNveCK7KU4NOvfyicBMV7BP1Y7aFTrFvTLuLI+3NoarO94M0kZ1c9L
         SKuQBQ2W2qC14VDQtKahmWXMp8uA9RCZdVin204CREtZQqpuBHJ/N1+FDGkgP5QjERw2
         M9tnjEoZz1c7rJkLerGll1E9NnJ98BGe2UhaxzE6Gn4AwNBJZuflv1FYrAf51Kd/X8CN
         vWJw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjSQkDGjxvseUo6cMxkqbm5d8ejlO1nVWvCFi5udGK+S3c+KUJB981AavU5tdeZs47iUpw8/j1GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoG9dd8Kn/HpurASA1+9HoteUfEd8m+qV47Ecs4OCkqwR8va82
	BXc295nJgUZEZKkceL5On1ScwdhDeYDBHUH6gq7Pw5R3TUIim4Y9o2DmcLLKGb9I371TMbWZc1y
	7Tv8ZjTLgpw==
X-Google-Smtp-Source: AGHT+IGGxoI8LkWA0cg6HYhGeqQhcotQufROrVQ1zXABSXp1DJk1xVggP6NDezXDolKA1OIj/0pqvwbnikS8
X-Received: from dycrr5.prod.google.com ([2002:a05:693c:2c85:b0:2a4:6f9d:b3cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8050:b0:2a4:3593:ddf2
 with SMTP id 5a478bee46e88-2ac05625cf7mr517110eec.31.1765319881049; Tue, 09
 Dec 2025 14:38:01 -0800 (PST)
Date: Tue,  9 Dec 2025 14:37:56 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209223756.2321578-1-irogers@google.com>
Subject: [PATCH v1] PCI: Cadence: Avoid possible signed 64-bit truncation
From: Ian Rogers <irogers@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Ian Rogers <irogers@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

64-bit truncation to 32-bit can result in the sign of the truncated
value changing. The cdns_pcie_host_dma_ranges_cmp is used in list_sort
and so the truncation could result in an invalid sort order. This
would only happen were the resource_size values large.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fffd63d6665e..e5fd02305ab6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -414,11 +414,19 @@ static int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
 					 const struct list_head *b)
 {
 	struct resource_entry *entry1, *entry2;
+	u64 size1, size2;
 
-        entry1 = container_of(a, struct resource_entry, node);
-        entry2 = container_of(b, struct resource_entry, node);
+	entry1 = container_of(a, struct resource_entry, node);
+	entry2 = container_of(b, struct resource_entry, node);
 
-        return resource_size(entry2->res) - resource_size(entry1->res);
+	size1 = resource_size(entry1->res);
+	size2 = resource_size(entry2->res);
+
+	if (size1 > size2)
+		return -1;
+	if (size1 < size2)
+		return 1;
+	return 0;
 }
 
 static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
-- 
2.52.0.223.gf5cc29aaa4-goog


