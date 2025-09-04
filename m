Return-Path: <linux-pci+bounces-35471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF065B44551
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC9C5824C9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE971342CB0;
	Thu,  4 Sep 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWx34TaZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55C3431EF;
	Thu,  4 Sep 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010404; cv=none; b=PL/AfLRFPOGFSNZTdEd/mu56BTf3H+DYKzcjGbRI9lCHj/zCMxbmOQOAL8RKjbqe4OY9yLgSVgIH3NZw+GYPsZTCqF4i7DzUwps7I9hgfjeJOZoYKPOzQ8Maioc8kY2btpeQAwyUjxLFPqV5zYD+WJ+wto6/YDzS1AvME+Ycf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010404; c=relaxed/simple;
	bh=t+syarZDi1v9WBn5tcamTydTuUePpgpeHA+K39U6Pzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWdLooG9kpIWTlbU9/3sXrxx4CXwJNcABw4fsdwS548IdhW2JHYofXOWxKggfqxRrRXT/G/LKTgdxZqXO/3CqCEt8RhFw7Di2lj0g1xwk8+pBSJ3TImVotey6PC8A7YuEgrp9w684SJ2VJhbTXgURKjeFu2jK4RzXPouY5R5zZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWx34TaZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722bcb989aso1032909b3a.1;
        Thu, 04 Sep 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757010402; x=1757615202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gdcw5+kk8GJYnq26nabHq+jr0MaRzxnpeLi3OPAGLE=;
        b=UWx34TaZKXcS34Z0zrJUmHbjdf8wbUOryHUknmfH4brWcwnPNuaxaZmXGoIKxK7psM
         qDeflU8B/pGYekWdKvZU0ivtmpfasaqVdKWBwC6WlLX9yckVIJma7vT8Ar7uuVx6Qaeg
         vXygTOkb2JXAZYahkVmBTMUCalM7Uf4BU8y9tbEXl7s106/vx0z3NqVQS+aDuvt4raHr
         Ft6jTC4nuWVqnlYrhGHQhrSY1oVdYrtWuo9nJnxgXBoA3auZ7n5m9lEHAADa5DFDiaWx
         f4saXIGRvytfU2Ls1xwRXOVKQmoIgM8hErrBZnRF9yoLx1g/RlPCIrL72hSJSm5Z9/8I
         yjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010402; x=1757615202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gdcw5+kk8GJYnq26nabHq+jr0MaRzxnpeLi3OPAGLE=;
        b=Tj1zSjfrekyyShIF4eLGwpgt48cNwlUUawC/63lRYe0yRWSHNW/nyHt2uj68SzONEW
         TPcRPlRWiC4K2ktQoSZ7RWnuYzLEhbLYiUEu+GZjd9MdvKnZtu0IRvQb0PJ5WnW9nkNM
         Cd6CLJTnNDzkeLbDlFS4chYOjghKB1+EZLHkpx4ICryb7vv7wKcvrM5ly1onrdVuzsIh
         RGTze3Dm5fYHp33WaOg1KXuTlmI3wp2qdWdtfePEVhxnf/Lat2Ri0iunOM/uj3NvuA4E
         Rgu7HkLGgQC8jLFo6EnaeQy0DY20aOeUs4qeoNRPHBZEIGRtjFHFe7YaCInzsZzIe5QJ
         M8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJ/OH103ZK43t0Ua08MwTmc9C0PzU0JIKPVp+N/fj39qNVT1c5FxzPQPmVbMX+dlJgT8WNQw9ss3fQjI=@vger.kernel.org, AJvYcCWd8OhegFUrioy4hj3ZHeZLwg2Pp1DWychHqvKVUuuSbHo3CKcHRSP0jSca3a7plukunr01n0twM7vw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rXG1g8Y6SJ8XBhDH6PqAHfzDiTjCc/y7eV2ChOQAiTJ7xPzS
	3VYkz6YhHMz9Qzu+Ur8Yxr8pmLyQUabwhuOXWnYJ68g0JwXu3AV5ewZc
X-Gm-Gg: ASbGncvhxBlnGwANK/9BH2wf0vMH5S2tvo6YM/YQhJLr0LwA76b4VNTtN2m5iTf9pBe
	aTicFRMqomyRr9nUOEvtgx/RUiMAxeRXovW3VwIkmJmsvKFC6xZOx+UO8mhWCHq/tLkbnMPodJV
	1xFvl1TtjjV6gN0KvOdOg60IldR86mc3AizLvdRXNxfjGwEXkZuAAuiF2kg8xyN/+kU3j4DigXP
	QqgH1vuiN8sSy3m9nFLxtm9vpoi72v653cv19Vy3Q3aPPsxwHk3PhncKeaq5xMjUL9C/71nOMMk
	upn5FICwKdbWevqzDtTcauwtpppEN5XW5O7nL4sDcfXYULs5oZH1ZBNdjBMxAqAvPcRhJxMaUPP
	pUCtKMP36NfUXJndoRpAHinRs0TdE1d+nwLi3MC5TjmXhwQ==
X-Google-Smtp-Source: AGHT+IH81PMCdp/2u2qs34vVDtDTssGYFzTlxqvPTinJ+Y0m3QBdAADZkUB6nGb/7qYroCr76cYnXg==
X-Received: by 2002:a05:6a20:2588:b0:248:1d25:28b1 with SMTP id adf61e73a8af0-2481d2531demr10262298637.21.1757010402072;
        Thu, 04 Sep 2025 11:26:42 -0700 (PDT)
Received: from localhost.localdomain ([180.121.189.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006dd49sm17883117a12.5.2025.09.04.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:26:41 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com,
	oohall@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH] PCI/AER: Fix NULL pointer access by aer_info
Date: Fri,  5 Sep 2025 02:25:27 +0800
Message-ID: <20250904182527.67371-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

The kzalloc(GFP_KERNEL) may return NULL, so all accesses to
aer_info->xxx will result in kernel panic. Fix it.

Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 drivers/pci/pcie/aer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d716..aeb2534f50dd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -383,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
 		return;
 
 	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
+	if (!dev->aer_info) {
+		dev->aer_cap = 0;
+		return;
+	}
 
 	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
-- 
2.51.0


