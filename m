Return-Path: <linux-pci+bounces-37186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E63BA8917
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A33AAFCE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5D2676F4;
	Mon, 29 Sep 2025 09:15:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0A286894
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137356; cv=none; b=Cva9QUrPNNY8GzX5XFeDmObV4fxO5aI9TKSpe6sJW4Fov01ZgmSm7uo1wxAb696HHia23nHDqu0g34G7dcJ5IgVXVUx63ucJ04V71QwoXCyTfDJ8HV43zoGpgl7VTtUVY6rIJpxIaFZrPWT7cvG3dWCNNWeA6YA66E2U2hWV/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137356; c=relaxed/simple;
	bh=R9u55K8LEYMCF9T8YoRD0SE7dnNGouw1ZbsiBle69qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yyk9kaZ0oyROvo9sdkx9plQrAPcDtYieGf6olIJPoJX4ZBF7Bn+vyA1ezhZfs//aGUwhEQqLFmjEWQ8DD2L5yDGfHhTOoqDhLz01Z/uk1V3Go+SAq/33s9UofvO74C77nDVHrXkz3+PyyBr+J9EEmFWxP5goUZWLP4Dm8LJUVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e9d633b78so185339166b.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 02:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137352; x=1759742152;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/ySJWiSpFmZf4ki4sz6ItaQY50Q4llbhd6F9+5mYqA=;
        b=G72RMcvgOkfklug8jsmk+NodK3DROlJMzrlMT/Q349Hk0+jSKCASNZ1dLfLJCIBnHR
         b2dKXnM0/qzNzTrNbTFmYeaCYnxx+qKW8Z1GPJsqojWSR03bqSQNU4bb8vTZKs1jIOlz
         /GdsUk/2Lhrj7vsruuaO5hSFm1GckisGBSnxRCSUbcpQDD52LuJNVHX0J0SDK8OuIKjp
         Xhc/gkrtSRRHnxzqxX+NO6wg8czSM1aEgajGCQ9/7jRC/idv+5v2R913JtqPmM4Dzz7j
         ryXsQ42P/tBo3U7bnBVQ4vcIb+a0VspsiODyuM8ehUw1yaM46i+t+Jevq2haZ2WGqTmS
         jgCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/BDpkw1PyiQL2ykPekHGbSPabUU7qoorh/s8Seig4mqDWoIWn79DnCyuqmomsYkeXXcgrm/M2lyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LFO50U9Gro0s9xfJZb8elDld7+Cuiu/prKo30cCqfJzYmvCk
	ifmWtoq01LruUdzZpJdN6cVe02/U+JYSTbBPigkVCSBZvf4Bn62Wvys7
X-Gm-Gg: ASbGncsQIJlvClT6VhDRhjjKa8TF1uGpgs+z5QXYE+Z2WSTz7pl0O/C2hzxkGEzubBC
	GfBCNs6Eo6Oz7I+ZfZUp828xQxmG26K8FfOY8YoUOC123a9f2JU7N/zJgNcAF8I6nrHFdfUnBmn
	ZjgYWxMC2Iqk1Y1xH/dNCr73TpvOTpB2SeW8ou9SKMxLAn54gSlFcbh+fBlvP+jVRyPqjMLeRSj
	Xs+FE7B3ofDGrfl73it2IaJZvZsL4HBhiTaygNauLLypUXp5vgbae+lruP4TQg0rLXCKb1xNIJ1
	/viR8NlH3Wf13+3QJFTJYTieZHr6LEvtKiI/2Qy8m7KRl2J4erjJ/pDsBo7ESTk04bGBuUPAtf3
	JiUuXwTA/8hCbdqdWUF/H2P+y
X-Google-Smtp-Source: AGHT+IEC99o6I5U43x9BBzmjUVvHusJBZH+ekQ9yM0YzCDDYFnPxzInOLc7bxYYRuE1LOgqfOeyByg==
X-Received: by 2002:a17:907:72c2:b0:b2a:10a3:7112 with SMTP id a640c23a62f3a-b354c244b09mr1746488166b.24.1759137352124;
        Mon, 29 Sep 2025 02:15:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b401d3d4124sm73171066b.75.2025.09.29.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:15:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 29 Sep 2025 02:15:47 -0700
Subject: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
X-B4-Tracking: v=1; b=H4sIAEJO2mgC/1XNsQqDMBCA4VcJN5tyF1TEqUNdO7RjEYnJqbdou
 RRpEd+9IF06//D9GyRW4QS12UB5lSTLDLWhzECY/DyylQi1AYeuwArJetYuqE9T52zvKATHA0Z
 EyAw8lQd5H9oDbs29uV6gzQxMkl6Lfo7JSkf9efmft5IlO0Qsi9IFqnx+jtyLn0+LjtDu+/4FS
 7EPWq8AAAA=
X-Change-ID: 20250801-aer_crash_2-b21cc2ef0d00
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=leitao@debian.org;
 h=from:subject:message-id; bh=R9u55K8LEYMCF9T8YoRD0SE7dnNGouw1ZbsiBle69qs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo2k5GJj10pwZeQhabxuZAbcMVQsml8bUkcz4E+
 uow6oJeyWuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaNpORgAKCRA1o5Of/Hh3
 bernD/wLDmkL54OkzUb+m61lGMHj30To7QCHn/pKBW3LjFUzHdsfPC/WPjAtG16FZUFGQD373ko
 vqogdRC36R/Cd3umTq7Rw+Vg0rKhmqaqdfGsKmWUQyNgDI3XwmKmNnBFHfWfMjAOi8bSjsN9PNj
 Y3cML4P2gFuQGkdhAcI/Hhyc43UvRAqZB/T2R+4uz/jQdi+6Icg0qPVzMOw6/AIhg6QPStFayZl
 9c8/LNHcphpjuH8MMz7H1PPEb5dkpotusBK20Wzakvo0rhtUhN/GDprXoILypTRlTlstl97JVSd
 3sdj8/maZdbMNLtcT1LFNqRg40L41Sfb2X8a90aIJe2JHnRKfiy4ja/ISGeOgc9fG0D9YCA3o8z
 rZTKK7jLhgd9hrkTp77nI6/gDoiKU/g5XXHYCtA5AEiD9mFFXW+2d/3UCm9+M9VJdKbdIpxU+8y
 HFVCz2x4TKz9vr2tNea2Md9/m1GUhriYdrOKT/qj7FUpt8/dKZwsIi99BYyul1P42u4UXerh6Hn
 j5UfcNFRODwlmCq+62PsRjUZ13UWAQK5CGgS5OGj/lslHqNmocE822/74Y66pITfKBAzun4FaUz
 XOOcyLobFtZQJVjhSnHcuAureBrxPBESEGKI31kGTArSOMVm4yhrp8ilJIWkI0O9OVKyUzf1dAf
 jPjB5zbIZkILgqA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
does not rate limit, given this is fatal.

This prevents a kernel crash triggered by dereferencing a NULL pointer
in aer_ratelimit(), ensuring safer handling of PCI devices that lack
AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
which already performs this NULL check.

Cc: stable@vger.kernel.org
Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
- This problem is still happening in upstream, and unfortunately no action
  was done in the previous discussion.
- Link to previous post:
  https://lore.kernel.org/r/20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d7167..55abc5e17b8b1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 
 static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
 {
+	if (!dev->aer_info)
+		return 1;
+
 	switch (severity) {
 	case AER_NONFATAL:
 		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250801-aer_crash_2-b21cc2ef0d00

Best regards,
--  
Breno Leitao <leitao@debian.org>


