Return-Path: <linux-pci+bounces-3342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2870851102
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 11:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A901C22060
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97C28387;
	Mon, 12 Feb 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="haSv7bqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C022B9C0
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734127; cv=none; b=kmsoeykBCLcIEy9hqF4Bvbm1bjbbR5uLaAOHirtlZf+1j1lq843fvgWWuZEsalvCmLOAC67SEs9WpbPbIyhY0VdVds9R8uQ9uDXQuQr02AEJIDo6YydGM0hG3khJK/l08qj5yTf8b3bTkxWq1zv7ksWcBGPEDlZvZep+4raAUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734127; c=relaxed/simple;
	bh=oEN+dwSDlX4Wf7XHSwlhkxtlCib+wj4mwpgMAlW6/PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YldJGgDCXPwmyxyu1gUyeQ6JsLvFh9BufVBkJ5PSPl/cgk5T0XrPOTa+IbLt7xOJ6R2cZF4ygIg4REfXt3Y+9ScrJfESgZLzR2fD8CtX8A8k+QUMAyvvwUtFxP/BYq1XNf/zVJdVGwfhEgId34a5XM4S6qH5urTLgOwllkMUey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=haSv7bqJ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240212103524epoutp043d1c9aa3466e79290680b84b4dfbc66e~zFyNREoCX1479314793epoutp04O
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 10:35:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240212103524epoutp043d1c9aa3466e79290680b84b4dfbc66e~zFyNREoCX1479314793epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707734124;
	bh=hE+eDG2GxhJPpLaElEHIROodVE8STJFl+Q2ht+hx3xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haSv7bqJZE4ZeskYWr0X7iOFvchScxYZGegfCG956YjPFhLb6iHZ8GJWKbh8XKcHu
	 hDp5eBt6RKU1cohYqdWR5bbv5p6RhRdUWkb067LDGbUXqorYxOf1TKHfsxQXL+5YS9
	 YWZZkXRllnp7zbGpqbMmjFKcwS2AlFRbcItpke/c=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240212103523epcas5p34acfeaf02bab59f0263b944dfb9d320c~zFyMS6TqR1499914999epcas5p3d;
	Mon, 12 Feb 2024 10:35:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.07.09672.A64F9C56; Mon, 12 Feb 2024 19:35:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240212102425epcas5p176017ab3c94d39af29bbeaa72a43a996~zFooENVFL3127531275epcas5p1a;
	Mon, 12 Feb 2024 10:24:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240212102425epsmtrp188e8822434c2a4d1347dabb50dbbc173~zFooDNwj10772407724epsmtrp1j;
	Mon, 12 Feb 2024 10:24:25 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-f4-65c9f46a0f1b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.88.07368.9D1F9C56; Mon, 12 Feb 2024 19:24:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240212102421epsmtip22276b86b88307151f59ab9ad28d86385~zFokQfgB_1200912009epsmtip2I;
	Mon, 12 Feb 2024 10:24:21 +0000 (GMT)
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
Subject: [PATCH v2 2/2] cpufreq/schedutil: print errors with %pe for better
 readability of logs
Date: Mon, 12 Feb 2024 15:54:04 +0530
Message-Id: <20240212102404.1900708-2-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212102404.1900708-1-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmum7Wl5OpBtsPWFssacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJYkXPB1aL470HmCw23su2mPtlKrPFvo4HTBYf92xgtOg48o3ZYuNXD4utR7+z
	O4h7rJm3htGjZd8tdo8Fm0o9Nq/Q8ti0qpPN4861PWwe804Gerzfd5XNo2/LKkaPzaerPT5v
	kgvgjuKySUnNySxLLdK3S+DKmLtjLltBH0fFpCeHmBsYP7J1MXJySAiYSJy72skEYgsJ7GaU
	mD1BqIuRC8j+xCgxb9IzFojEN0aJnRfFYBrm9FxnhSjayyhxrWMuE4TzhVFi5vfpYB1sAloS
	M+4cAEuICGxhklhy6SA7iMMsMJtJYt2372BVwgKJEn/XvgOzWQRUJV4uec4OYvMK2Elc+v2L
	EWKfvMTMS9/B4pwC9hKP1i1jhqgRlDg58wlYLzNQTfPW2cwgCyQE2jkl9i3cAPWdi8ScvdvY
	IWxhiVfHt0DZUhIv+9ug7HyJltmzgJo5gOwaiatPVSHC9hJPLi5kBQkzC2hKrN+lDxGWlZh6
	ah0TxFo+id7fT5gg4rwSO+bB2KoSv6ZMZYGwpSXu/54LdY2HRP+in9Cgm8QosfD+TfYJjAqz
	kLwzC8k7sxBWL2BkXsUomVpQnJueWmxaYJyXWq5XnJhbXJqXrpecn7uJEZxAtbx3MD568EHv
	ECMTB+MhRgkOZiUR3kszTqQK8aYkVlalFuXHF5XmpBYfYpTmYFES533dOjdFSCA9sSQ1OzW1
	ILUIJsvEwSnVwOTmc0G6KGd/MhOTx+rilx8m9FWblUS5t7sLzPHzVp5/6Lf4x6Vb/S7Zbny0
	tajD9FSK8RQLNl+DVb/vc/Tusy5df0hzg5umovK8zil7LnvWhnvsOmlfv/f5PMZEdqPaxAts
	QiETv/FE/g7ayhSzSafL6N7bXnafvbt+SSpsWNggE39kc5D1gYtnbjnLrlD+rOKtwmJUy27v
	elAyNL2Sd8n3nqXuh3+2823IV7LfHPbsiNaRYpPnMvyW829svc8/If2+cHQGh66ozVeVR+xT
	GDf6zqy5zv83s6xAoG1iymE1l06h2bGrHjm/mxm3SpHhxun2vvxpt/M/6kv80OxR3tl6b9+7
	zr1+FooVFx62KbEUZyQaajEXFScCAE7tRGsPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvO7NjydTDbrOqlksacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJYkXPB1aL470HmCw23su2mPtlKrPFvo4HTBYf92xgtOg48o3ZYuNXD4utR7+z
	O4h7rJm3htGjZd8tdo8Fm0o9Nq/Q8ti0qpPN4861PWwe804Gerzfd5XNo2/LKkaPzaerPT5v
	kgvgjuKySUnNySxLLdK3S+DKmLtjLltBH0fFpCeHmBsYP7J1MXJySAiYSMzpuc7axcjFISSw
	m1HiyqVbUAlpiU+X57BD2MISK/89Z4co+sQocXv6E1aQBJuAlsSMOweYQBIiAseYJKb1b2QB
	cZgFFjNJbOxewAhSJSwQL7Fx4UIwm0VAVeLlkudgY3kF7CQu/f7FCLFCXmLmpe9gcU4Be4lH
	65Yxg9hCQDV3d91hgqgXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PTTYs
	MMxLLdcrTswtLs1L10vOz93ECI5ULY0djPfm/9M7xMjEwXiIUYKDWUmE99KME6lCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MOkIHX6y69juhXJKF3Y/
	N1kSLbCLc9+cm0wlj0KtLszbbqcWudBztWGXs/WRmHtWqm49cY8Xq7YE3VXOme20rPv3J3Yf
	fpfF4heboyezTPgvsvpI1SMlg7aktZfdfD3/WZ8K3SZlumdLjv7ps1aO4SdOFlophz8J+tZ+
	/qbi4buVvXei//7XDefabWXjUyG6M31d6c79ttx/Ig8IrdXey3DgsP5Em79fU4+eO/NP8v93
	o+mXfu+a3zjl8xuXx/v2+cZe8zZ2myFv8ujp7n4GTg/Btj1+FU82H9vlqfrub0PXXLZzSxnd
	5r2MTEpuSb6lleEb5+eRn13ys+iGm7vQjrzjcoLxmesMz191i/vj2a3EUpyRaKjFXFScCACn
	w033QwMAAA==
X-CMS-MailID: 20240212102425epcas5p176017ab3c94d39af29bbeaa72a43a996
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240212102425epcas5p176017ab3c94d39af29bbeaa72a43a996
References: <20240212102404.1900708-1-onkarnath.1@samsung.com>
	<CGME20240212102425epcas5p176017ab3c94d39af29bbeaa72a43a996@epcas5p1.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

Instead of printing errros as a number(%ld), it's better to print in string
format for better readability of logs.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v1->v2: Updated subject as per file history

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


