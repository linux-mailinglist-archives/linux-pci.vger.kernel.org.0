Return-Path: <linux-pci+bounces-3386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363EB852AE3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 09:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B314B207A6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26C125B2;
	Tue, 13 Feb 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pvGFJWeB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6D225CE
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812450; cv=none; b=a2lBgJ39OjV9DNZV8qA3w+G9jE6GqcL11iNX1Qatk9R8ZOIFIuMOPFwvQhqmdNvapqCh6jCkq+Se3zxAUKNAOQ/wVcI20ernUyR5ppUUwlQ0uw3Fzc+gyvArZ6CHkym9uOkIoUkvXMljgopBa9MUElJ6xS02XC/YWRcOKQwFjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812450; c=relaxed/simple;
	bh=T83TRgd0Cjf5ynLdLQ0SWNVs+GGT60Q/tSZKRDeff98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=e/xvAapWN/Pl9hTucODS2+yOEluTmK0m/X0IO5XdYIrW9/kh7xcBZpXK6CTZg/w2Umi4VdcZdibXJlZoXgEtrf1Z9HrVkFs43+07JZO4hGexkPtS3rFA19i+A6KB96TI3cpO/uta91hsuAvWRQ/6RXMWkdsf96OFiW8zOWB5dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pvGFJWeB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240213082046epoutp03399044bf21a3957847de51286295a6de~zXl8qgNDt1768617686epoutp03F
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 08:20:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240213082046epoutp03399044bf21a3957847de51286295a6de~zXl8qgNDt1768617686epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707812446;
	bh=tP9U4WVHKg76vR7mUi19VCVh+QzhgevyK2/XdTYMSMk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pvGFJWeBVVk02TIDmRM+Jiu4VI3h0nJDZK9jYNHOhr3WQTdmvSazZtN47/eP9iF2y
	 txOEF0cS0hNvhjBo/8g6L/xtE6zJsabH/qm2MRjqqi4GShGSe0BX227NhWmzbLXWrg
	 5ehKL4DjZQUdNxU8utBp3u6HAxHOsObpYT16KTY4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240213082045epcas5p1532ea50b9e7d9d32b141088ae8e36953~zXl8CS_iD2381423814epcas5p1V;
	Tue, 13 Feb 2024 08:20:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.E3.09634.D562BC56; Tue, 13 Feb 2024 17:20:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8~zXGR3T-aL0248002480epcas5p4o;
	Tue, 13 Feb 2024 07:44:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213074430epsmtrp18dab30bc2dd3525cec43a89f50c1a5b6~zXGR0nU2X1967419674epsmtrp1X;
	Tue, 13 Feb 2024 07:44:30 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-0c-65cb265d3e08
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D8.B1.08755.EDD1BC56; Tue, 13 Feb 2024 16:44:30 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240213074426epsmtip2c1e6479e8e49708f262c952e3296c5d6~zXGOAdNaV1017610176epsmtip2Z;
	Tue, 13 Feb 2024 07:44:25 +0000 (GMT)
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
Subject: [PATCH v3 1/2] ACPI: use %pe for better readability of errors while
 printing
Date: Tue, 13 Feb 2024 13:14:15 +0530
Message-Id: <20240213074416.2169929-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmpm6s2ulUg5WLdS2WNGVYXHp8lc1i
	+stGFounE7YyW7w6s5bN4m7/VBaLnQ/fslks39fPaHF51xw2i7PzjrNZfO49wmhxeH4bi8Xk
	d88YLS4dWMBksaLnA6vF8d4DTBYb72VbzP0yldliX8cDJouPezYwWnQc+cZssfGrh8XWo9/Z
	HcQ91sxbw+jRsu8Wu8eCTaUem1doeWxa1cnmcefaHjaPeScDPd7vu8rm0bdlFaPH5tPVHp83
	yQVwR3HZpKTmZJalFunbJXBlbLvewFTwQLDiYdMn1gbGFv4uRk4OCQETiYa1z9hAbCGB3YwS
	pzbFdjFyAdmfGCWeXX/BBuF8Y5RoeH+AHabj16y9TBAdexkltm3JgCj6wigx8eMTFpAEm4CW
	xIw7B5hAEiICW5gkllw6yA7iMAvMZpJY9+07WJWwQLjEkpUTwGwWAVWJ3jVXwcbyCthJ7Fs8
	DWqdvMTMS9/ZIeKCEidnQmxgBoo3b53NDDJUQuANh0TfznnMEA0uEiv/TmSEsIUlXh3fAjVI
	SuJlfxuUnS/RMnsWUD0HkF0jcfWpKkTYXuLJxYWsIGFmAU2J9bv0IcKyElNPrWOCWMsn0fv7
	CRNEnFdixzwYW1Xi15SpLBC2tMT933PZIGwPiQ/Ht7JDQitW4tWTVpYJjPKzkHwzC8k3sxA2
	L2BkXsUomVpQnJueWmxaYJiXWq5XnJhbXJqXrpecn7uJEZwmtTx3MN598EHvECMTB+MhRgkO
	ZiUR3kszTqQK8aYkVlalFuXHF5XmpBYfYpTmYFES533dOjdFSCA9sSQ1OzW1ILUIJsvEwSnV
	wLT8oO0xtqurN2nM/P0z2HJCjZP9ek2+4JMuJV9OVly9W7GjSkz2w6bimDXSOzgEPhgYp+xe
	MLMgaW/AX0W3c5/7tqr4bK/x9C5x/iNzXmeCw9E58t1XG64L/+le7Dih/51m41afyTtvrd5y
	caIgk9rf9GpXZ0GlI05pcZ9z31Qc9ZwjmKA/waZi6slMpc0Ht4iuma9es6ff0b6h1yErr/Nb
	0LsJ9jMfxLVclsrj0YjnecfD8bn014LNh5O3H3p1MPF7Z8aSaakf3WfN+vvm5qplL1V6mf3v
	xv/YOOmq765GgVWiL+wvfDOeNM1+rYmkZI5zg7/qobb8ZVyxXsvMoo5d0zU4/rO9xtfXqeqd
	xVQlluKMREMt5qLiRAAK7N2/AgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvO492dOpBt+vs1ssacqwuPT4KpvF
	9JeNLBZPJ2xltnh1Zi2bxd3+qSwWOx++ZbNYvq+f0eLyrjlsFmfnHWez+Nx7hNHi8Pw2FovJ
	754xWlw6sIDJYkXPB1aL470HmCw23su2mPtlKrPFvo4HTBYf92xgtOg48o3ZYuNXD4utR7+z
	O4h7rJm3htGjZd8tdo8Fm0o9Nq/Q8ti0qpPN4861PWwe804Gerzfd5XNo2/LKkaPzaerPT5v
	kgvgjuKySUnNySxLLdK3S+DK2Ha9ganggWDFw6ZPrA2MLfxdjJwcEgImEr9m7WXqYuTiEBLY
	zSjx4v1CNoiEtMSny3PYIWxhiZX/nrNDFH1ilLh6eC4rSIJNQEtixp0DYN0iAseYJKb1b2QB
	cZgFFjNJbOxewAhSJSwQKvH1+AcWEJtFQFWid81VJhCbV8BOYt/iaVAr5CVmXvrODhEXlDg5
	8wlYPTNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR
	HHlamjsYt6/6oHeIkYmD8RCjBAezkgjvpRknUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/o
	TRESSE8sSc1OTS1ILYLJMnFwSjUwZU25Z3BOoaygeWmLvFyr0SXmU6uXzzFKsnmgtUXq3cUt
	Dzdz/nu/LTlla3na42tqa8+p33pg9WHWU3e9BwXVpenz0hS6l7K+/XNw/uUeAU8PuVNnZCJ7
	zl3h2HLv8aw1XIwXg6UvRdcyl2e+b5P7d/3yhOyvXzb/LdnQUvpgXtmBSb+VdmZvvrDcR4vP
	c9mHf2y7NIwV22TWZvgVPj5/RWdNuJbw3ymONzh/+06Nu5nGtv3+3OiXU++3qt04bbFnS+wW
	Xa5mpj2VLvqnWO2Njmxybuus+/NH5d/2mYZKuy/VmFdnG+15Jrt/8+HHSR8Ult4JCUi/2S69
	bN7klWvS86s6xIvEvq5/v3PxT00eDx4lluKMREMt5qLiRAAGccV1KwMAAA==
X-CMS-MailID: 20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8
References: <CGME20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8@epcas5p4.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

As %pe is already introduced, it's better to use it in place of (%ld) for
printing errors in logs. It would enhance readability of logs.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
v1 -> v2: Updated subject line as per file history & corrected spellings
in description.
v2 -> v3: Updated Reviewed-by tag.

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


