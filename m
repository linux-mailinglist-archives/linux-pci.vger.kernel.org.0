Return-Path: <linux-pci+bounces-33353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016FB19EA4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BED3B44CC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D923FC66;
	Mon,  4 Aug 2025 09:17:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145F23497B;
	Mon,  4 Aug 2025 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299068; cv=none; b=o7GW9fVsJKvumP5IGIh0pw/Lp0+PR4h0js3tgEu5TG/NS4KlcDXYwDIGyBNm7MZqPhDiKaaffZlJbwoMuMdLY4rDHMYnTznMqb1c8dEATED6PFqJnnj+psc1LBPPxxDpfLS7UA5CQGVwWifxf4TUro46HP2rtDvEKbSe45eGqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299068; c=relaxed/simple;
	bh=i0OFIqRZ+2MCROlqNGaAy7Gthq89bO35bHAcnJh3VlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MD/NSltBDWhZQOyUpDQzLOFPGrOabW7285pJK80T+uV8cw0rxASLUFmxA97/KI+1wlGOxI8ejNipF75s3v8ncmYtFXrparFwO1FCiY37kpGc6NXozW7K8PkQgGUVxsVk0s9yTsZt6vPQ95/sm5Me6HeCOOe1z8TNM9Q69PwxoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so688456566b.2;
        Mon, 04 Aug 2025 02:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299065; x=1754903865;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xamvBtEdKuAbOd1z+jRRJHYAkrTu7JX4mmKkjKPIws0=;
        b=dJ4chnUie+7evyoBz74WZGq6bN8oEL8KelLSBJZw+eBaRC571yvtqKidrYeY5BpcdJ
         b19m5qYL9fcAR5jw9TM09RQ2TcVOtdbcPbQ5IeCftXl0z6CEgXw6IbOFbGGqDW6WFKm8
         kF3cOzU3Uw4NN/2P5Gdp53fMPf2fuJmlaPPskcaCDPVAMEWkV7gaiqSfa5bcrmZYKfRv
         XMabyfIAeJ456WICt5YkDlKDkbOGOEMtvMcL+fxjAYsT97cDFnjceCciEqo1ZcpiHK2b
         ZQm5iO0wUj32lWE1RPv8EiCJqBirGSXSlMoo9FGA2wgqA9y1iMZ1vmnnnIGgaKf0bZcG
         GE3w==
X-Forwarded-Encrypted: i=1; AJvYcCUDZ/8wQ3oJcDBgKd3zBbp9GZWAT+kYx/cSIkP3bHT8YYUgPMOjoi7D1Ya0ZO/6T/maUEAY0Abx686/kJE=@vger.kernel.org, AJvYcCWLzaAfPSw4BAYkAWNo5+YHL+TQ7Rm7C1GS8Smz7tFGyFb9tErVUvS91iYB4HaUL/oa3fr4rM1ZL9DY@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxzBKyWrYalI9QTczsYb0nwR3zp9NjA7b3OAVtAw++6B+oqb1
	3MJEJ9xZ+V/wXxmgJmQ1ktZTTrKQJAWIEvOx6M/evA1gcIgRbTJz6omwWTk4hA==
X-Gm-Gg: ASbGncso2GC5p+nWqsd5Xl8fIkzqV/JNyiPMyDvn2g8fOKS5D4FjixhitdDK/fRbqiO
	1l/wncRSm2EDHaaVJeL1C+C7Oy9GRyI+Cgew1XuyPDSEKL8HqBGTwhcJFFkUAlSnBjlHXOpYsVN
	iRcfoUqgtRRVp0a1sOnxAFe1XymiErBZjmgQrGgkGnP+3g2lcrYf8aYvR8ty0MBT0nUJl6mdT3V
	iLxqep41ofRbVrVQMQO+vIXdYj2mLq2umU0AvcR22b2l3FSh7G/oWWk8OzgJYLLzwwlIHqndBb0
	gZK2TQ9VmrbFhIrMcWexER/ZWHlksjsIz/kiJjfFFmNr6+Gx6DhtZNkQ4DvXZQNpOCfflgVrY1+
	KferMZEWPLo1V
X-Google-Smtp-Source: AGHT+IEbHhIr5xiJI4WCsuusUsNAMV+ToZt7UWotIYnSTg2xxYU2vexFSF+WiWH8cmp0UryOEkWQ3w==
X-Received: by 2002:a17:907:8688:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-af94008422dmr1005072366b.18.1754299064846;
        Mon, 04 Aug 2025 02:17:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0ccsm703510666b.111.2025.08.04.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:17:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 04 Aug 2025 02:17:22 -0700
Subject: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
X-B4-Tracking: v=1; b=H4sIAKF6kGgC/x3M0QmAMAwFwFXC+7aQBgTpKiJSa9T8qKQggri74
 A1wD6q6aUWiB66XVTt2JIoNoWx5XzXYjEQQlpY7jiGrj8Vz3UYJk8RSRBeemdEQTtfF7n/rh/f
 9AKuzfaNdAAAA
X-Change-ID: 20250801-aer_crash_2-b21cc2ef0d00
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=leitao@debian.org;
 h=from:subject:message-id; bh=i0OFIqRZ+2MCROlqNGaAy7Gthq89bO35bHAcnJh3VlA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBokHq3J6RaxpQfmijCmhT8xwiAfy7q4+tdEwFP4
 yJyxN2RFW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJB6twAKCRA1o5Of/Hh3
 bQd3D/405/+BXCq8MZtdnT0v0HPlyz++xhl/hpeSOvxquiUiEEfkaHiUL2uqGxGtZtApFaz24gn
 JXC6Ncm8AhRJWEcLw0n830Iuo+eE+UOLzV9LVe3tJG0mrs05AMXRzKIB9gC1qAhWeCY/mcd7ZaO
 hMgXwO4gEuhKA6wAJBqwKo/NYaTNsWj/rWxwqnjYBWC1GW0CPAk/lBVVww+0RGKx1WJIZAmRVxB
 /fEecTarqVnj0ouyvEc2763i6GMm2AhDnNdDQ8qCMN6qH6EPWnEbflBEbVgKVetq2YqrbaFGvGe
 wv/ULHHRlR/HNb4K7YJmTjUeg164O6RWtwJwU6UoHQXIwqJ+hig4UznuTRFbS7UV9x+Rg0+x8P5
 /V35p2mr49zxy1OhQRp4+olU2Y+d/bARyi4Se5hxXZU41d2qlzSaKIiwSWXmyhcHaScUZNz2CPy
 Be+BcociZDT/+b1CDjtImSEZ0+kWMihnXlhSPbgM+TfwZA3quoFcMK/DXdEjSpWQTDyCLx3GHYN
 E+vpmi0oueXyU+j98iYBOJ42zeyvxHJk5heWaqkxmR7XRrpYAdNdp3XVM/z+HFW9VCCJ51aSl1H
 wPd2WKlvGnRMSeqH490icMf0RRGqATNaJoeOL3Y/NQZjCL4bt4cHL+arcgZ7+kYsOQdt+XnWkuK
 lxgZ3D9L1RwM4MQ==
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

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac661883672..b5f96fde4dcda 100644
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
base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
change-id: 20250801-aer_crash_2-b21cc2ef0d00

Best regards,
--  
Breno Leitao <leitao@debian.org>


