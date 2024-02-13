Return-Path: <linux-pci+bounces-3387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CB852AE6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 09:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491DA1F20F1F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D12179A6;
	Tue, 13 Feb 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e3Frrq6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64414225CE
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812469; cv=none; b=LFBD3f9B2GC7qOMq2Qn5VuJ++wPc5dD+O4DYTHk1B9yaLJzkyxOH4/+4PXx07K8JKIBepusAYvo5N+GKY+v35rUhoIa19WmLZwmjE3YPnWqUmOgVO60ymuZReF/jiB6PhiiQF2mExPm3/4QQzy41x9nO8fqzgUZPliCf5hKlsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812469; c=relaxed/simple;
	bh=cFeJ49ozuDHgvVdgMByqtpMP0RchPUnBC6gtca+4OqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=b7ZZvxuAhHayT69SI8zuphEXlcOJPBa7bsQCFha5buYrscUUUFbaV8LtVJ2d0W52BmoECMeCm6VO3qxppEjf8YTIv9C2vS7RYrCEasNhVXkPN8vjo6tjg28JkhgJ47qZiwHf8Ji88nXN/gTuzuzQyNqL+Hk/hWssHiTDZW0nZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e3Frrq6E; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240213082105epoutp0441fe0310056fa3c7775f83e7a70d90cc~zXmOSoXQF0364803648epoutp04I
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 08:21:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240213082105epoutp0441fe0310056fa3c7775f83e7a70d90cc~zXmOSoXQF0364803648epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707812465;
	bh=92Ux7FtbDU/8AIHbTeinFsj9GB+AdwJ5W6wN/FBK/xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3Frrq6Eh2ga+UxktN6l6QBQuOO0iP1rTsreMaEmLeVl+pDn6FCRYAC/ySUZmlPtz
	 AA7rglbyUiGY8sWXEKOR4FMDgHmHZq/0NYew+4Z/khDBMQ4gTAxoLjuVolLcwYkDLJ
	 YDoNCTkDJO/w9rPZqoo4xHx5FFEpO010zNnWPfWY=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240213082104epcas5p3a08eac06f25b1f052c54e4fa1f8ca47c~zXmNoDO281141011410epcas5p3Z;
	Tue, 13 Feb 2024 08:21:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.E3.09634.0762BC56; Tue, 13 Feb 2024 17:21:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240213074436epcas5p4757b38265bea29c3bb6f1e0aa90f602a~zXGYB3Tj_0248002480epcas5p43;
	Tue, 13 Feb 2024 07:44:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213074436epsmtrp145ceff6af741c1bfddf992dff802ea0f~zXGYAoL9r1967419674epsmtrp1c;
	Tue, 13 Feb 2024 07:44:36 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-32-65cb26702eba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.94.08817.4ED1BC56; Tue, 13 Feb 2024 16:44:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240213074432epsmtip2e975d3ca0a810946d70ecb4ffe1ff68e~zXGUKwsyY1391213912epsmtip2C;
	Tue, 13 Feb 2024 07:44:32 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com, helgaas@kernel.org,
	Onkarnath <onkarnath.1@samsung.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v3 2/2] cpufreq/schedutil: print errors with %pe for better
 readability of logs
Date: Tue, 13 Feb 2024 13:14:16 +0530
Message-Id: <20240213074416.2169929-2-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213074416.2169929-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmlm6B2ulUg7dTNS2WNGVYXHp8lc1i
	+stGFounE7YyW7w6s5bN4m7/VBaLnQ/fslks39fPaHF51xw2i7PzjrNZfO49wmhxeH4bi8Xk
	d88YLS4dWMBksaLnA6vF8d4DTBYb72VbzP0yldliX8cDJouPezYwWnQc+cZssfGrh8XWo9/Z
	HcQ91sxbw+jRsu8Wu8eCTaUem1doeWxa1cnmcefaHjaPeScDPd7vu8rm0bdlFaPH5tPVHp83
	yQVwR3HZpKTmZJalFunbJXBlHNvzjrngEkfFkwXX2BoYl7B3MXJySAiYSBzvP8UCYgsJ7GaU
	uLVSrouRC8j+xChxtLWHCcL5xigx51QnK0zHjqk/2CESexklLvyYyAbhfGGU2HP5EFgVm4CW
	xIw7B8DaRQS2MEksuXQQrIVZYDaTxLpv38E2CgskSvzacQfsEhYBVYmHLZ/ZQGxeATuJW42L
	WSD2yUvMvPQdrIZTwF5iT8sDFogaQYmTM5+A2cxANc1bZzODLJAQaOaUePXwD1Szi8TXxasZ
	IWxhiVfHt0C9LSXxsr8Nys6XaJk9C6iZA8iukbj6VBUibC/x5OJCVpAws4CmxPpd+hBhWYmp
	p9YxQazlk+j9/YQJIs4rsWMejK0q8WvKVKgLpCXu/57LBmF7SCx5dBEappOAAbzrJMsERoVZ
	SN6ZheSdWQirFzAyr2KUTC0ozk1PLTYtMMxLLdcrTswtLs1L10vOz93ECE6hWp47GO8++KB3
	iJGJg/EQowQHs5II76UZJ1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ875unZsiJJCeWJKanZpa
	kFoEk2Xi4JRqYJqoumutkfbNxw+kJMLbnvJH7T/lybLk14v7Zqza8UZed7+XKnd/kJfsvqO2
	+Ji+7JXHOmmhoh+SDlmuKVBSPvxfZe//x/ILpj0L0FRcacKpdvji8WVGgpf1/O8eO66sf71o
	08lrc91eLJlycSrLMV/2H/on509pW/ftvsn36sq1p+Yv/ajzvaZX5f5dTe5lhffPGh2S1e6u
	b7TUKj/N9ra7wjyZq5ZTqnyW2Nxu2UlFv68tNZ4peFTAavfin+v2rYxsW7llCtuChy69cj+u
	ZxtuZVp9VO+/5YOGf7oHdlzwOanq/v7HIber83+GrO8zrvyxmuuCUuzMX4IvsudlNzzmYPf+
	/J1TSF34ZZHvNkEHJZbijERDLeai4kQAwhAP8xAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvO4T2dOpBpu+6lgsacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJYkXPB1aL470HmCw23su2mPtlKrPFvo4HTBYf92xgtOg48o3ZYuNXD4utR7+z
	O4h7rJm3htGjZd8tdo8Fm0o9Nq/Q8ti0qpPN4861PWwe804Gerzfd5XNo2/LKkaPzaerPT5v
	kgvgjuKySUnNySxLLdK3S+DKOLbnHXPBJY6KJwuusTUwLmHvYuTkkBAwkdgx9QeQzcUhJLCb
	UWLdwodsEAlpiU+X50AVCUus/PccqugTo8SjaXuYQBJsAloSM+4cYAJJiAgcY5KY1r+RBcRh
	FljMJLGxewEjSJWwQLzEh++LwTpYBFQlHrZ8BlvBK2AncatxMQvECnmJmZe+g63jFLCX2NPy
	ACjOAbTOTuLCciWIckGJkzOfgJUzA5U3b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zy
	Usv1ihNzi0vz0vWS83M3MYLjVEtrB+OeVR/0DjEycTAeYpTgYFYS4b0040SqEG9KYmVValF+
	fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUzW/EytRU6esp/iv7gs5H60
	4dW5WW2ea+bIHPg+7VH45XDDzVbr5vTda9vzmn3+2Z82n7/EVHbMfJ5rfen3pAs8R93fS8k0
	xrt/99mmf+gfI0taWk7+72nuzj27lwWzP2JySVtWePNXr1NDyJkz3qxfTojrrnng4PMjh3ny
	ojxpJ+f/2X2HLB8fSPHLvVBv19RftdjZ519fzCv2hVO3zH0TpPJPY8eDRxHr0mYWHE6QsYq6
	msPdX1zbdN70gATnYacTKtPPne7n8vzcEHl/3v9XjxazT4/hvhDixjpd+DNzpNjSl46ZIkry
	PzkSG7xnesZMEhM9UVMRySh24XX7MjuvyCndqW/O+H+/fVdc9pkSS3FGoqEWc1FxIgDDbtDE
	QgMAAA==
X-CMS-MailID: 20240213074436epcas5p4757b38265bea29c3bb6f1e0aa90f602a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240213074436epcas5p4757b38265bea29c3bb6f1e0aa90f602a
References: <20240213074416.2169929-1-onkarnath.1@samsung.com>
	<CGME20240213074436epcas5p4757b38265bea29c3bb6f1e0aa90f602a@epcas5p4.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

Instead of printing errros as a number(%ld), it's better to print in string
format for better readability of logs.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v1 -> v2: Updated subject as per file history.
v2 -> v3: No change in this patch, change done in PATCH v3 1/2.

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


