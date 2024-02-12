Return-Path: <linux-pci+bounces-3341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E6851101
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D8D1C217B5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B52575B;
	Mon, 12 Feb 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tsRvo5XF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC825632
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734126; cv=none; b=qKsfI3n0wzLi62tDOgaa49KNoVS6Qr3x0mGNP/mWwxt+SwsSNdia3hSMzSFSb9RAyPZ8LfsqU/sYq0kyJRXeAizbJ/RiSBRW0s1mh6IaGD/KWhM7chezNBIhj9XxQjOPrDmW+WLnJW9CusJTvzgLgfBJwtJeuS769+Wq+eC5j7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734126; c=relaxed/simple;
	bh=Ny+DBifyKyXAz2F/UFQ1+Xjj9V0tXAdi8v8PFXVQZ3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=krkmYRabYyfnfQJnaEmQ2D/wK3uQxAJ2d0/BpGIA064E5ria6KIXuwGdQBkwBBi0iv7SmA6a7DrVC6Kz+gxqOxSKMtJHT5DXjoR8SAsrk1rr4r+Uem6/vaG/NO9t9ma8103xAb/qe9VAnFHvQh1J6nZOVQwzfFUHuZtv0ZE/txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tsRvo5XF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240212103516epoutp0134351632913cbddaed1ed30999d2a0d9~zFyFu3myU0730107301epoutp01O
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 10:35:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240212103516epoutp0134351632913cbddaed1ed30999d2a0d9~zFyFu3myU0730107301epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707734116;
	bh=wX5Y9NIxXbSlgIWh11+vw5uicM2wfMs5ez2NdzS/V6E=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tsRvo5XFQpSnypXCoVDvymQ6F/GD4qjsByO59Q3AYLoDyhLAjTzEZwJ9I0j52wL9C
	 Wpwlf/aqUsI8vNXzxTm4PvgdhdTokVU5xAdr4XHBQe81PpMawyHv6wi6QgtviOPvIu
	 KK5YdGxOnwRQnnLnvqB6RmN5CmuwU7Ufj71Yyjm8=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240212103515epcas5p153badaf7f7ce587fc7d9bc415dcfd4b8~zFyFBoxj91433214332epcas5p1U;
	Mon, 12 Feb 2024 10:35:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.BE.09634.364F9C56; Mon, 12 Feb 2024 19:35:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240212102417epcas5p31745b234ab239009c7ff29d0f59c1126~zFogiJnfL0631406314epcas5p3n;
	Mon, 12 Feb 2024 10:24:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240212102417epsmtrp28115ed66ef2231ea12f9b577b9c524cf~zFoggw2Bi1178511785epsmtrp2j;
	Mon, 12 Feb 2024 10:24:17 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-93-65c9f4636f94
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.14.08755.1D1F9C56; Mon, 12 Feb 2024 19:24:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240212102413epsmtip2ba84ef33e822b2456c2c3afb1a2f8550~zFocuQrGZ1282812828epsmtip2h;
	Mon, 12 Feb 2024 10:24:13 +0000 (GMT)
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
Subject: [PATCH v2 1/2] ACPI: use %pe for better readability of errors while
 printing
Date: Mon, 12 Feb 2024 15:54:03 +0530
Message-Id: <20240212102404.1900708-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmlm7yl5OpBmcX81ksacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJYkXPB1aL470HmCw23su2mPtlKrPFvo4HTBYf92xgtOg48o3ZYuNXD4utR7+z
	O4h7rJm3htGjZd8tdo8Fm0o9Nq/Q8ti0qpPN4861PWwe804Gerzfd5XNo2/LKkaPzaerPT5v
	kgvgjuKySUnNySxLLdK3S+DKmH/7EnvBa8GKJTsvMzUwTubvYuTkkBAwkTj6tpMJxBYS2M0o
	8Wy5QxcjF5D9iVHi57lLrBDON0aJQ5cvM8F0XFwziREisZdR4v2ySSwQzhdGiSl3f7KDVLEJ
	aEnMuHOACSQhIrCFSWLJpYPsIA6zwGwmiXXfvrOAVAkLhEts/zEBbC6LgKrEt+eTweK8AnYS
	a9cvh9onLzHz0nd2iLigxMmZT8BqmIHizVtnM4MMlRB4wSFxsfMhO0SDi0TTrrtQtrDEq+Nb
	oGwpic/v9rJB2PkSLbNnATVzANk1ElefqkKE7SWeXFzIChJmFtCUWL9LHyIsKzH11DomiLV8
	Er2/n0CdxiuxYx6MrSrxa8pUFghbWuL+77lQmzwkzl28zA4J4FiJxqb7rBMY5Wch+WYWkm9m
	IWxewMi8ilEytaA4Nz212LTAMC+1XK84Mbe4NC9dLzk/dxMjOFFqee5gvPvgg94hRiYOxkOM
	EhzMSiK8l2acSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTO+7p1boqQQHpiSWp2ampBahFMlomD
	U6qBKVS13FRSXvR45SmFfoFk/1+xDVZVIhfzPPwXHnppon7xUqTkv48CFmnbzbr0D5cqmonv
	42sUiZK5ZLPbaJJuW1NKfPDtyXMnpNnpifpvuGO20nHpuhvTWlcudJu1M6GM4Y/Z+bzi4lf/
	DKqCbFaE/ljtZ/1Abe1ShfbgWe4v7Hc9FZ5Tavdoy+8Aq5ryvqCHVdcue5xnr9DTn9LXU8rG
	siv31zm/MCWOq+lOcV849zzaaOrpfs/ULzJ3/weGeM6w7cHWR93nifMa8vz8bWf/bl6gmMWF
	/WqiCq4OS5XebN28ta9fvEhbVWUyX0yHv3PZnW0zjsQcWMyzJr3lrdi9XUae+44sfTTnd/jn
	vAdKLMUZiYZazEXFiQBbRB9xAwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvO7FjydTDebfkrFY0pRhcenxVTaL
	6S8bWSyeTtjKbPHqzFo2i7v9U1ksdj58y2axfF8/o8XlXXPYLM7OO85m8bn3CKPF4fltLBaT
	3z1jtLh0YAGTxYqeD6wWx3sPMFlsvJdtMffLVGaLfR0PmCw+7tnAaNFx5BuzxcavHhZbj35n
	dxD3WDNvDaNHy75b7B4LNpV6bF6h5bFpVSebx51re9g85p0M9Hi/7yqbR9+WVYwem09Xe3ze
	JBfAHcVlk5Kak1mWWqRvl8CVMf/2JfaC14IVS3ZeZmpgnMzfxcjJISFgInFxzSTGLkYuDiGB
	3YwSB3b8YodISEt8ujwHyhaWWPnvOTtE0SdGiTVL7jKCJNgEtCRm3DnABJIQETjGJDGtfyML
	iMMssJhJYmP3ArAqYYFQiZ6z75hBbBYBVYlvzyezgNi8AnYSa9cvZ4JYIS8x89J3doi4oMTJ
	mU/AapiB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M
	4MjT0tzBuH3VB71DjEwcjIcYJTiYlUR4L804kSrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xF
	b4qQQHpiSWp2ampBahFMlomDU6qBSbSo1nLGLMlc88hDyW4yX1yuLZGefnCaQtYzl5h5zzMz
	PT3lpDdFbc0+tFWsyMwpxOur9/NFK/d0PVZffpMtdRYXu7Fd7Fn/W4/mc3PcseKZ8fVWl79M
	+qKbhtNNDAryuaK+i3w+MuPgK+5JO546phasTF0+rUA4MvHZpAjDt0WHZu/+Ynai9kVTfF34
	rZVnAhfN9p5RxjJ7XULfZye3JYG9GgtsHO7MXiAlXaHNOntjo8eVxclJ9yZnbTkfeFJS3iJ+
	csGPKa9fnPV9WHUs5+yM5u5zuyJr82QFmeoKbSdVfUiYxbkzsH9m/Syu4PLr3ys1pNgLAyL9
	n8WfWzRP8UzfWmEm4c6/7PE5FuablViKMxINtZiLihMBEMFtiisDAAA=
X-CMS-MailID: 20240212102417epcas5p31745b234ab239009c7ff29d0f59c1126
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240212102417epcas5p31745b234ab239009c7ff29d0f59c1126
References: <CGME20240212102417epcas5p31745b234ab239009c7ff29d0f59c1126@epcas5p3.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

As %pe is already introduced, it's better to use it in place of (%ld) for
printing errors in logs. It would enhance readability of logs.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
---
v1->v2: Updated subject line as per file history & corrected spellings
in description.

 drivers/acpi/acpi_processor.c | 2 +-
 drivers/acpi/acpi_watchdog.c  | 2 +-
 drivers/acpi/pci_slot.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 4fe2ef54088c..2ddd36a21850 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -161,7 +161,7 @@ static void cpufreq_add_device(const char *name)
 
 	pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(pdev))
-		pr_info("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
+		pr_info("%s device creation failed: %pe\n", name, pdev);
 }
 
 #ifdef CONFIG_X86
diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 8e9e001da38f..14b24157799c 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -179,7 +179,7 @@ void __init acpi_watchdog_init(void)
 	pdev = platform_device_register_simple("wdat_wdt", PLATFORM_DEVID_NONE,
 					       resources, nresources);
 	if (IS_ERR(pdev))
-		pr_err("Device creation failed: %ld\n", PTR_ERR(pdev));
+		pr_err("Device creation failed: %pe\n", pdev);
 
 	kfree(resources);
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index d6cb2c27a23b..741bcc9d6d6a 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -111,7 +111,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	snprintf(name, sizeof(name), "%llu", sun);
 	pci_slot = pci_create_slot(pci_bus, device, name, NULL);
 	if (IS_ERR(pci_slot)) {
-		pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
+		pr_err("pci_create_slot returned %pe\n", pci_slot);
 		kfree(slot);
 		return AE_OK;
 	}
-- 
2.25.1


