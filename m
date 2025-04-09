Return-Path: <linux-pci+bounces-25594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21332A82FC0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F40D7B0B82
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6327815A;
	Wed,  9 Apr 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YfJq30qN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBA27932A
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224869; cv=none; b=kuQOL3DdP8M44nQ+Jr/O3xnxrOVso56VgQll/NLNaO0Sz+l6yHzzqyhsubmHn9jhfEl7hErsPw9cFSSUUYA+IsyLhC5X5dNadJjcGC1Mt/yU8FCY6oE4TNmWnc1QudR5kMpVqexX6dTN6Gq/Vma0qB3DYj4cIo9T9DDk2V/EYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224869; c=relaxed/simple;
	bh=syPUBIzkEdarCp+N7WDiwHDCNIOV6P5QwWnIfqZVWLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDP/1Be15/lwuJCiKDaTXqhJvFred+b/bn8KKC1Mtm1Uifn0aTvzUT98VYQfdT/jFdjN3arIUa0d6cUlsU/e8UPgxikkwBaADxUic94LwTC/o3yhIl5ZftgWoMg1lhjwSt//TOjk8jTUB6vEdrDzLxqUBuFULK2ajpZhSJr7sJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YfJq30qN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso5053094a91.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744224867; x=1744829667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuoB16/glHZs8DH9yStavq4EmyDzORTC/5S9hgU6uRQ=;
        b=YfJq30qNt2eazDQvF4ru6jdllvyjlGpTAJzqLbUOFSL9VSJev4ElvKMvIME1R3GiYq
         sXqMHcoeeSoA3hSqgdrihAOmz9gs/eIVuSZ4cCKjCC+iD/q0MGfQKRTDe2ncYB+nl2HQ
         zBllJMa6NnDp0usZ/Xi2qxLHOhUYAUYJ5cpXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224867; x=1744829667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuoB16/glHZs8DH9yStavq4EmyDzORTC/5S9hgU6uRQ=;
        b=gN/q5LGHDG+zVr9l5Wl/Beg/sSuTnpbkwY8wTR7fz2Xddsk+8OUUr6NyHYbQnTXSAe
         g8npydWVuhzb9leDLWYwHaiywia0v7aQ7LiAWSRu6YzE5JR15DoE7ObnZWrnbyvsmmd7
         /G+0scechC3aDnKJXqr3gRnStWQLVvnCCW4ZuMvJLIVJjHQcWfRoqxGwnwLGNq5IuJ++
         v8NDJ2MPFjwv3uOSnvUq/Q8oaxAa3oo980Va6m3mRPHulUMYO+dE2QRC2cuKSrNL8E3u
         /fFaSuS6EPw4VnhmIOYbf6OTNyIz47gWtSXiU4Y022t9CuKT/a+dtoUR012V2ChlpZMA
         5Mig==
X-Forwarded-Encrypted: i=1; AJvYcCXJTyG7FzN9iXxNUOryk2mtOZALU+FeEEKbap046k3LGsmHRxChiURbNlJyBLIEiDpwFJcjU25IJBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzgdIK3/nTlDFZBZiwi4ujVTGoC4qZ7bYAq30SjwRhj1iDC3g
	LZDDRUomHdOyw3RWHWjT+mRDx9Jygix32xuiDnQSTVu1u7zpSIRjivEVwUQWog==
X-Gm-Gg: ASbGncs3zzzpfvXJ1LIeEoglVa+jyilOC13ARHTOEhyo4qIFkmavX5l7sm7SEUM5lPl
	FUh2sjxoheKgfosGKaWqVUewfOxIFDRBcyw14edLPiNYcvhCeDyMOi70IiOuDwSbclhG6sHtvHe
	UmCM7D8uZeA/i0nud4PgjWmwL96AEdGQxR0AXCoPwK9x2kcLz1OgXPwu3fSR7DFltZ0aSXSl8xT
	siBJm9fF6wmnFkUoaLHH+Et780XwcdZzAhjUNVkesI0+rv3A0AFbSrcCA//5w+jVldG4vWQpKc1
	gwjCW5CCgpqeamWOauVqh9sgDtB7Zf7EtJefZNaQz1SlqGUhMlLJ6pfa3d6BbmtCI8bgjMVXkTh
	iGg==
X-Google-Smtp-Source: AGHT+IFaHlE9ZoUh5364MdBMCmTSlfQCXd+iwEWJTQuSiqhbGD8ldtSoWxeJNBTDXaBLlDhuQihS0Q==
X-Received: by 2002:a17:90b:53c8:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-30718b83034mr77258a91.20.1744224867680;
        Wed, 09 Apr 2025 11:54:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:461b:92cc:c320:f98])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7b642besm15656375ad.46.2025.04.09.11.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:54:27 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/pwrctrl: Cancel outstanding rescan work when unregistering
Date: Wed,  9 Apr 2025 11:53:13 -0700
Message-ID: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

It's possible to trigger use-after-free here by:
(a) forcing rescan_work_func() to take a long time and
(b) utilizing a pwrctrl driver that may be unloaded for some reason.

I'm unlucky to trigger both of these in development. It's likely much
more difficult to hit this in practice.

Anyway, we should ensure our work is finished before we allow our data
structures to be cleaned up.

Fixes: 8f62819aaace ("PCI/pwrctl: Rescan bus on a separate thread")
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pwrctrl/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 9cc7e2b7f2b5..6bdbfed584d6 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -101,6 +101,8 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
  */
 void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
 {
+	cancel_work_sync(&pwrctrl->work);
+
 	/*
 	 * We don't have to delete the link here. Typically, this function
 	 * is only called when the power control device is being detached. If
-- 
2.49.0.604.gff1f9ca942-goog


