Return-Path: <linux-pci+bounces-40580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41713C4060E
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6481F564854
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636932937D;
	Fri,  7 Nov 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPdH/4Dw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4232A3E7
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525733; cv=none; b=Dz3xvLybfRvRtOfC7P+tUxFzenGFoLBNZAkWCbFnVUKVodxfWtBlJV+/oc33gTYE4V2PQHPId7HzIpulqrtOmRvmuS0h4pYng+7X+jptTyI2tnNy10spGLr0I4LvzQlMuqVRi/xgr03BBPREXfNcUp5myZaiO2+NqgKDDxuWcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525733; c=relaxed/simple;
	bh=3BhTKLrt8Wvihg8vp8choQ0z6FtpnObNcCgY0g7rt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RaMnRtC0lNEyqOPo3on5mLy6Cwh4zbWo5VJovQ20+U1kbDCwAimKY6J1GrRy7Q/iuSaPJteGtiwlqEbFEBsfqtQmM+0omNtislbRpSD13EAvTSJlkxDE8h3BYenNi/Ik5jdmDfmCkmiuVybyOZT5kX/ARTnPmej8EIau32couto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPdH/4Dw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47109187c32so3927075e9.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525730; x=1763130530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcbvvRs2xvl1u3FoZnWA9K4Q8QMEKWU1ON5YmKljc6k=;
        b=UPdH/4DwWdOBXzrhJR7At9cVPp7MoA5VMbzwNkD1qCgMeXlLmjtkIGcD0dCaw4rc5r
         U6daQOi2XupGPYhNYGcgtsKqenR2uzQugDAjcEeXBlh6IYDanL6R4M5sqLHOJyKgaCBh
         2zf0TrJ6+u1KUBqU+om3tEV6u+oyP9y2qypBvReywd6h5ad6lMSbOCMZoCz2tp6lM957
         5uejcsMQXepXY/F7BK4A25sAWCChtmILtmdgrp0X8ZT4rnJPtf2dbaHSfW/Jk0sIXHmD
         poAuIJb0nwbDhuMLP79i5lhV/z3e+K+JZFt/Wsyg7QMYK6UszNRnBjupqAqFSHiRo808
         2kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525730; x=1763130530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcbvvRs2xvl1u3FoZnWA9K4Q8QMEKWU1ON5YmKljc6k=;
        b=D7rSVbvBpi9FX3/i+42oChW3pc5mWK5mYeuAcchuz5J/a3CapUwpqO2v6xFI2dmmld
         l/DE7ufr2C7B+lt87Oh4474EgLaYyruZE0gmEfJzmGsOgcqv5IPFd9AqcU6uXYzKHxSz
         +6AxsMYmUjjU7Hx4MDT30JWdYS1bwMyOLRe5W4BW58w+29U9jyQmR8oskHwCSKVhQYz9
         F1Gaq8hibFuqGSiOsvxxYvnRSMpusDTfdo5Tkmp6kPqIKxGf7Z3QOuzhMEFT3YKHd9y3
         3N2grIzRDN8OKGHg2RVi/M2ArDnpWTRcTeHbt0j256XjxjFjyp01WFELaBkmmtUwencO
         GOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzx3Zj2ZVtkAu3y7ydz31Js/p+XLaLABElvSYvdGZVZEB5abRLLuvm7+uRo5HmLql5igS5KIMYez8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaozkU5JLk8lHDjSN81h80cGzOZAAb1PE/jiJww601CHoDtwY
	kwFqna2tz4FtNUZYEmPPyJGGSZRsuLtXX+m7SNCPAZdbF2RwJkOodEH6hM08HNy5pu4=
X-Gm-Gg: ASbGncs1Twtqtor3oZ+TJtvrHDEURi9b7GJvzfvzs2rH8KumumR6dult3nmYo2n/Oa/
	rmjgWe5fI8m8kBU8kae/CY2pOLkQrgg0ieNKiVf1PwexunUiHHi56MIWPY/mruVVEAKERU56Oei
	U+ckGaEpeNmap8tXT5Cp44kXjHLrff55gNGYz7nh+F9UsEfXC1plSvsLpVPMS4S7qNpfKy9iaYZ
	y7bjK53mPbnvrNmzSoF9RkvAju0g5kBf3YIrVks2yyYtY8yp7+5zWUhtgo9GyXedjbJjrMBEDX9
	qYk5rgnP6msm1O7AoJUQVz48WLlBc48wirMoyrrIzVYuOhOks2A4Y8FV6j6i/gSGltYLCNOHXqS
	ojoZYa2IacuJ1ZQiD4tqtB8Bl+gIGk2PzAY0TOHT7CfyVqnD9YTG1WeSjCfPb7VoZrxueScCy8v
	7ER5fdTMTbDgHbxsMhmokxkXjw
X-Google-Smtp-Source: AGHT+IGSUrN/hCHTEKNrK/nAtni+bSccTeEoJLzD46C+Lw2FCkxvsZIT3Eo/AVNFZdrzTW3STsHRog==
X-Received: by 2002:a05:600c:4fd0:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-4776bc886femr28359035e9.4.1762525729708;
        Fri, 07 Nov 2025 06:28:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm181970865e9.6.2025.11.07.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:28:49 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: epf-mhi: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:28:35 +0100
Message-ID: <20251107142835.237636-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0c..27de533f0571 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -686,7 +686,7 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
 		goto err_release_tx;
 	}
 
-	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", 0, 0);
+	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", WQ_PERCPU, 0);
 	if (!epf_mhi->dma_wq) {
 		ret = -ENOMEM;
 		goto err_release_rx;
-- 
2.51.1


