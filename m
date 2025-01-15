Return-Path: <linux-pci+bounces-19837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2CA11B2A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B4188AD26
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D218952C;
	Wed, 15 Jan 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzYRvGoH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1035944
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927004; cv=none; b=twtW/FbgPYFadKYy5iULuLHrwMAqF1vWrOMM5DK3dc03LP2xQNSf30W4+qlG6b8b4hQ19ZeeshgYYz07v93xbvpJMt5m1DEk1ywkM5qYQX0IgqjngUoYitzr86BPrihQUUixpVQMq+62XidvuwqafeqYRus6uhpmtfDd4GARxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927004; c=relaxed/simple;
	bh=4ZyxmZewjNvkK8q//P2xmPYBRtGP4PbKOMZcgwIUnKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCqyyUOLOIA9bCjrom+0eAu3zs5x2wvB8u0JdUONwsn6UWUB520qc2SrURJM6Y4AiMkpQMGuxNaN2JJd5tKLOSWAOzEqUfd0S49cwnEKdNF7QMd/lwY7Cv80KmszFrld0qwBsQ6WP4Xithsyb15iqiciY+BdYSFQ41tcEuIwYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzYRvGoH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so11529594a91.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927002; x=1737531802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=00fdl5t/ss+33VkJUdI/h4fMuW4xZbqtiRqS2wEoBLg=;
        b=EzYRvGoHkR0Du/wumYbI+Z/cW6tidaQxQ9zvugST5zZ3aAgGSTCAlMe4AdDKiVL8rp
         QnBgBpJIPfmfEdHC4cmHePo+PmEYlIkmbqyxF4cYoziX0xGITKohG4/1Aml/CYqkrv2r
         sc43Si7u/NvYxHcW5/8cJcSMXGnzwRYOfdZ7ufCl2FKDJ62sVD1LhCQd2XjDsF4Pyrza
         F12Gu8dWL2hRQ66XIMRKeqhHthtmpm/5mLV2jahkewJwT3wpHWy8Php0YqgtbWQ5Mu8/
         WybLJlOWiq2b5xmVzvcG8pJHAzYJBf5FSBodyeKGxfMBuaNbkx0mwIzsIHhMoh6ulaRK
         Ek3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927002; x=1737531802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00fdl5t/ss+33VkJUdI/h4fMuW4xZbqtiRqS2wEoBLg=;
        b=CU9YnlzYLFAgLTzsqfc1iZJwpg4qxLi2U8hPnFI+nRhYGpYFj66dj0x3pGgBQsQdNM
         GzOHHisEcBwYq7dCMGEuZxrbceX0RrFhqAtP9VWzrKh907A+oK6ENq3TqbImt3CtK1t9
         G+X7vG2h0hKNsbgvAwGkBWRpUOflqGOXxxLU8XQJkzCFpx5jEcsOfKm/tISd8Kw/2LLA
         DXu1eHOKOTknmkyNvIPMB6mxl/a9q9MsV/0b8JhBaK8HVXbBrnSgKFQJxsxeDz2gNGnc
         /SnSWjSt+aUImSl4u4QKcCYAfZA2b1T6TJb9NH1By+WGENQLpE9ksNhAEGrEqv0sNiUy
         kxlg==
X-Gm-Message-State: AOJu0Yw/v2m9E16RZZBdQ42N6BnnOoxowvpHysUcFYz0S/j9ih9ESzhE
	iYtKvcMuLWTOj8YNRwN6Ad0z2MoqiM4+EJ8c2SSWYkNFXBFetQnRLnjNFcC8UU5K5LfqsF903Il
	5qA==
X-Google-Smtp-Source: AGHT+IHXVFOc71gEhKIhtB1AfHix+zxdGSLq7rwrmHrXvrfGflNOZp2zvUqoZ/OHuOeMFIdfSkPIV/Wv02w=
X-Received: from pjbse16.prod.google.com ([2002:a17:90b:5190:b0:2e0:aba3:662a])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a0e:b0:2ee:e113:815d
 with SMTP id 98e67ed59e1d1-2f548e98373mr39570900a91.8.1736927001881; Tue, 14
 Jan 2025 23:43:21 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:54 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-3-pandoh@google.com>
Subject: [PATCH 2/8] PCI/AER: Move AER stat collection out of __aer_print_error
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Decouple stat collection from internal AER print functions. AERs from ghes
or cxl drivers have stat collection in pci_print_aer as that is where
aer_err_info is populated.

Tested using aer-inject[1] tool. AER sysfs counters still updated
correctly.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba40800b5494..4bb0b3840402 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -695,7 +695,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
@@ -775,6 +774,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
@@ -1249,8 +1250,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
+			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
 			aer_print_error(e_info->dev[i], e_info);
+		}
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
-- 
2.48.0.rc2.279.g1de40edade-goog


