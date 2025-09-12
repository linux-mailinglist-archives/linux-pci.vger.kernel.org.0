Return-Path: <linux-pci+bounces-36072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632FB559DB
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AB3B4CD7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21E2877C1;
	Fri, 12 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oSfxH+7I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54128643F
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718599; cv=none; b=Ei06YDYWEvH6Cm7zWxd0o8qqQ2C47NpnYlEwCm7pHpnk8j1fOCo11tVpS+BQF27Y65PsR/0DC0fuNI9JkO3ACx2nEU+RhgB7uWTiAxnW4buK2sFxwoRL1clT5Xg/45n1VW+JXC2aw3/81f3im+5UBwE0HmDmZch6KiwXafpxZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718599; c=relaxed/simple;
	bh=wk+cDFX3JYEG9AqRvbMYfzyBlK7TsevKhe8uR7IxhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPObGMJU4KC6xEz+ueReBcN75NDPDhFv+frE5IS3YZa7nSONXYB5+DSKHGmAwtP8ypQb3w+sGV1MPGtAc15WdxzL2W0YUsMOZnzXkNurOGR26AT0Dq9e9B2s8BryRYv5FYrD4QCP3wgTUO8G2C6aKmViNyESc3FpPpp6yL/j20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oSfxH+7I; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32de2f8562aso1681753a91.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718597; x=1758323397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=oSfxH+7IGNGd4n6yensMZUHuSbXJ85ZRxqQ6AIN4hRhTUgIhz3PWx6rIbKq8FlOwB0
         3VWJmMPXWDRI1BumxDz7UkuPKrdNol6M3Psrloco6IzdRdHGtbh6SSD+cRFp9SaK2ejq
         q/Yl9ueMaqDzQbOVM/wBXwa88RixXeI0ZAGJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718597; x=1758323397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=kpxkGn68yw82zj+/l65bUCVM0FJRTUsWL0X6MxqFd8dgpn+yZsbLUXg24KRwhDHV6Y
         FffiWJy0qlgR2SFVQcbowgwoQm291k0pEF0zjt6cULV1ok3ddzMhuBnpw3nSZJgD9U7Z
         BRXTRVuEhbydn7VoCMGyG5U81S6S5Ve4dE+51ouBn8zKQb4JgWVLzVQ88B2eFSTQiQ70
         1FrLp+Js3jo3P1kPT+7Kb0t27d5ilnj90srOqTKCII78tDiiidzPjE98XVRSCg7HFokz
         jgc8BgHs5WU9s+4yKwjFEmkQqKsJQ6Jt/FIiozSXDumFQhIhARzGqEF9qTUQ13tnWhcr
         e22Q==
X-Gm-Message-State: AOJu0YwTx0vrh4WfdnJgE7gvgnLDYSb11j0eDiVZwpG54ludI5RLvg2R
	aEr6Eb9P/wEP5eMGMzGzPw7vwzySEny5ARkqt3ImpOMD0FRzMwkDToDIN7whrt0IZA==
X-Gm-Gg: ASbGncsFaBk0S8LjbnbHFt9qkbKGpHeIeMHHNjciQzHNn5/Vp5NBsEy5zHMB5yAOGTP
	5s2a5D3ue/A1z5KcqOQRqGjR90CzWZZahcwuYw75Ub5QzcfcHsx4D5uFYvmZlughqkbiwlstw4b
	6fNfGH69D1TjR3E3Sr+DstDo7ELDCNlZfupiJFG4G45Hf8tH5Peaw8TdY7QFR/83l16s9uE8ewc
	MdU+VXp6+bkSihs98qPNTQEZ39kGE9KU+neV9rdE199iFW5CBfruMac+D0d76AW9oG9Mzu1Nfyk
	3FhOIwtCuIMetPR/lWqUkc+NRssEKRy9Y2sLmsAtdQ0JcQg4O6bVyfftc/8Z23Gv5jNUUqb8ro9
	rtqyWVcJVAhUBU2AG/xKDHwgy8bTHxVHLdv5OdBSiwbcv1gWMm1A/eQJdXzQ=
X-Google-Smtp-Source: AGHT+IF2cmiYrFQ1xKWdEqefxU7NdVKHQQ304cYE/Le3s9iB7z7uuIXrlH2bNcZ2AM03GLoo+rEoOg==
X-Received: by 2002:a17:90a:fc4d:b0:329:e729:b2a1 with SMTP id 98e67ed59e1d1-32de4fa1c8bmr5042000a91.35.1757718597437;
        Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dea223ddasm1310790a91.2.2025.09.12.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/4] um: Select PCI_DOMAINS_GENERIC
Date: Fri, 12 Sep 2025 15:59:34 -0700
Message-ID: <20250912230208.967129-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful especially for KUnit tests, where we may want to
dynamically add/remove PCI domains.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..7fccd63c3229 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select PCI_DOMAINS_GENERIC if PCI
 
 config MMU
 	bool
-- 
2.51.0.384.g4c02a37b29-goog


