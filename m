Return-Path: <linux-pci+bounces-3132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D29084AE23
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 06:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C961C2382F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C46F7F7CE;
	Tue,  6 Feb 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fqmBHa2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A86E2D0
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198056; cv=none; b=cwdodyG5XKZ3YHF8AdQv+sTnFPcQp0dtNVvN2Q4qdTXQIJx+vS8f+HSuYjNUf+AQChHEyIQPAeMQOpP6Pf6DLu3N9/38WQ7Y3fVT6dJAUoEUOfRCfAWw9Rqp9mRMF7Nl1BD6mYa/sa0It2RrEfbRvW7soQ9DrW2IvplcOh6sReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198056; c=relaxed/simple;
	bh=7kqaAO5rz0MEVvOXWXpuWW96op5KATV3atJvwKX3jyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MKm8h7hDD1PP1HEFT3mGvsCBPn+z3zLEXCI0MBgefn8oVn4oqhu5CX1oE1+QB56FAEpy/vf9bx8oBpACq5w2f7TZBSVU8APRcKS6LAMXu+s5Vnp+pXyxbUm0nvwvcGb5FjeFqL86kW0EgxfjYqoZbApBV90x3QNR4p5bMgHq6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fqmBHa2e; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240206054046epoutp04085ecdc6ff64a128df65992d8c78e4c6~xL5QaDEQT0957909579epoutp04F
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 05:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240206054046epoutp04085ecdc6ff64a128df65992d8c78e4c6~xL5QaDEQT0957909579epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707198046;
	bh=CC2djjTAEnwzIDHn32zkRPNrPPr+7uiinCUTrzq6knI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqmBHa2eqPQRK4hP6YyVGHLO8kfqovIkqZwKXQS4Qi4IXt7WubXGGwtAW9kBBV9T2
	 kE+zxwWgJl9+78nxH38ZZnowFuI77aIeduDJJZ/22eTOXp4DNqxW/cOgPC34P9IXkS
	 uW0ZvCCTYCV5xGmEh1VKTO4kYujDwsh0rfTF9WvA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240206054046epcas5p17a49d75ee048c41f92d09fea50eae215~xL5PwKSX-1405414054epcas5p1M;
	Tue,  6 Feb 2024 05:40:46 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.14.10009.E56C1C56; Tue,  6 Feb 2024 14:40:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2~xLh6J0uhi2514425144epcas5p2j;
	Tue,  6 Feb 2024 05:14:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240206051402epsmtrp1e846e1dc8329b4db9a0c630751b964a5~xLh6IkgN_1680416804epsmtrp1G;
	Tue,  6 Feb 2024 05:14:02 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-f4-65c1c65e2b6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.64.18939.A10C1C56; Tue,  6 Feb 2024 14:14:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240206051358epsmtip2d28793c007873284be3cf44a8dffc8e0~xLh2oJEDX1683016830epsmtip2E;
	Tue,  6 Feb 2024 05:13:58 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com, Onkarnath
	<onkarnath.1@samsung.com>
Subject: [PATCH 2/2] kernel: sched: print errors with %pe for better
 readability of logs
Date: Tue,  6 Feb 2024 10:41:20 +0530
Message-Id: <20240206051120.4173475-2-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206051120.4173475-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmum7csYOpBie6OSyWNGVYXHp8lc1i
	+stGFounE7YyW9ztn8pisfPhWzaL5fv6GS0u75rDZnF23nE2i8+9RxgtDs9vY7GY/O4Zo8Wl
	AwuYLFb0fGC1ON57gMli471si7lfpjJb7Ot4wGTRceQbs8XGrx4WW49+Z3cQ9Vgzbw2jR8u+
	W+weCzaVemxeoeWxaVUnm8eda3vYPN7vu8rm0bdlFaPH5tPVHp83yQVwRXHZpKTmZJalFunb
	JXBlnN/qUfCEreL7hPUsDYy3WbsYOTgkBEwkrl8s6GLk4hAS2M0o8WbbFeYuRk4g5xOjxLLF
	LhAJIPvboUVsIAmQholPu6GKdjJK/NpoA1H0hVHi8+1VLCAJNgEtiRl3DjCBJEQEtjBJLLl0
	kB3EYRY4xyhxY/IWsN3CAlESZzZEgzSwCKhKnJuwhB3E5hWwk3jzo4EFYpu8xMxL39lByjkF
	7CWmbuaEKBGUODnzCVgJM1BJ89bZzCDjJQSecEj8v/sP6lIXiW27/rFD2MISr45vgbKlJF72
	t0HZ+RIts2cxQ4KiRuLqU1WIsL3Ek4sLwa5kFtCUWL9LHyIsKzH11DomiLV8Er2/nzBBxHkl
	dsyDsVUlfk2ZCnW9tMT933OhrvGQ6Lx9mA0SVpMYJf4ufMM2gVFhFpJ3ZiF5ZxbC6gWMzKsY
	JVMLinPTU4tNC4zyUsv1ihNzi0vz0vWS83M3MYKTo5bXDsaHDz7oHWJk4mA8xCjBwawkwmu2
	40CqEG9KYmVValF+fFFpTmrxIUZpDhYlcd7XrXNThATSE0tSs1NTC1KLYLJMHJxSDUz+/oey
	ZfLaHs1JMhJedTm/jPvymd9Fkdt1djSsPlz0UdHByqKhIzxO91LKI1bTqalJ7fXnF1m1qiny
	vWaQW7j21/a+Qvk7+oEL5NYnZ2vwmratPv353jTRpyuuSMruEXikyVwVeLFHQWTiwTNX/1za
	KT7JPVQyo/a6kuWkvdZ5n8r+/204/Hs9c8+2tGMvdhxJfsc/9XyGaVbGTedpknUbatfc4Jt7
	/uXy9dMPV0pw7fed9OsD998lecvefN23vfSFd3Dt60QdN1tGn16+ngV1LpJMYTybe1bvjtA7
	Zbt9W9kUh6Rl/nXTLKsPyE00+cXjbSj5hv8n1xwtyfnrWnw3/prCePfIme/RMst/8bgosRRn
	JBpqMRcVJwIAiVfevf0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvK7UgYOpBif+CFgsacqwuPT4KpvF
	9JeNLBZPJ2xltrjbP5XFYufDt2wWy/f1M1pc3jWHzeLsvONsFp97jzBaHJ7fxmIx+d0zRotL
	BxYwWazo+cBqcbz3AJPFxnvZFnO/TGW22NfxgMmi48g3ZouNXz0sth79zu4g6rFm3hpGj5Z9
	t9g9Fmwq9di8Qstj06pONo871/awebzfd5XNo2/LKkaPzaerPT5vkgvgiuKySUnNySxLLdK3
	S+DKOL/Vo+AJW8X3CetZGhhvs3YxcnJICJhITHzazQxiCwlsZ5Q42qoIEZeW+HR5DjuELSyx
	8t9zIJsLqOYTo8SjmxvZQBJsAloSM+4cYAJJiAgcY5KY1r+RBcRhFrjCKDHr9DawKmGBCIkD
	S54zgdgsAqoS5yYsARvLK2An8eZHAwvECnmJmZe+A8U5ODgF7CWmbuaEuMhOovfqNKhyQYmT
	M5+AlTMDlTdvnc08gVFgFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGC408r
	aAfjsvV/9Q4xMnEwHmKU4GBWEuE123EgVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivck5nipBA
	emJJanZqakFqEUyWiYNTqoEpq/NmM5OftMz/pw867l7Kf3x/1fwlpgmF+9fZexnp65TnXOjc
	0re8VGTX61yT/J3dW7J/TM3U7fl6/WbgjZexYnuNrq6pbBCUD2HZkGa7rtF9WbTjo2QJ6Zat
	l4u/385/oDAx665bPuORBdvj3M2/Kqxm57eTmZVzyMlxxr3FaRtVF/8Skfcs1j+xS31azuae
	DXnveAzktzxmY3c+8PSJ47ur20/ObFU+dl8y8YH//Kmf/0ie6Y4TbQpWW++30vmb9DRXycD+
	M2tbPimmdzvqOPfoVktfEWxn9f7b/vXQGuZnW//GHFpeUt+m9LdVPqaraErArEXr89bEP995
	4da3xvT+r39FBOLeLp/x+kOnEktxRqKhFnNRcSIANHpWqC4DAAA=
X-CMS-MailID: 20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2
References: <20240206051120.4173475-1-onkarnath.1@samsung.com>
	<CGME20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2@epcas5p2.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

instead of printing errros as a number(%ld), it's better to print in string
format for better readability of logs.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..2c42eaa56fa3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -671,7 +671,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 				"sugov:%d",
 				cpumask_first(policy->related_cpus));
 	if (IS_ERR(thread)) {
-		pr_err("failed to create sugov thread: %ld\n", PTR_ERR(thread));
+		pr_err("failed to create sugov thread: %pe\n", thread);
 		return PTR_ERR(thread);
 	}
 
-- 
2.25.1


