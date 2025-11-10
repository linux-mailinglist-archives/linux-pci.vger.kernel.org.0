Return-Path: <linux-pci+bounces-40752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6BC48DEE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD623BE447
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BD231D72D;
	Mon, 10 Nov 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xr+xfnAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CA343D76;
	Mon, 10 Nov 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800492; cv=none; b=SB09FTRGdn5ylZBjmmFvudU1c8xS+04vBBczZLk5In93LeikQViBI3aHOgParwuldiYCSHwPrZLFRnaEgRUF234ahJObdXWt5YGK5J7qBO7ElGyDMFw5ifVBVp/0eDSXM1ra2ez38FgO1nPEQJWKwz4EnTZYiTIxxOThyE5U9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800492; c=relaxed/simple;
	bh=2GLm4NVkdUuOv+K7T0bT1SYFkvMIdVSo+0VB+hLNaFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXXacTMIbQ1lqJEN2fF+7ThLit1g35fOanYMOMCzSjB2M1dgSUTnj8ZDl2b9LXItiWVWbvJijoVAE8AIvsXX1oRKndr7uO9rGcS273UPNX4wBiTxfHVWEjL0Tn4IaOkPUDJLP0Q3E/eLBkc8llxSeFhZsPdGZO1zwMJ9QW2Mj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xr+xfnAY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762800490; x=1794336490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GLm4NVkdUuOv+K7T0bT1SYFkvMIdVSo+0VB+hLNaFU=;
  b=Xr+xfnAYCxe6MhlF0FQVyvroEoodza+3zQHhG5UOIG/Gfb8q94Epgg5B
   wAZ45kaq0pRGU1Iu2hWVtf/WPTAfK/MVIwX4XUM7oIZWYQGgDoYdzXKfA
   Mgq66IjrkrtCIK+gS0jzXUknnIjiskEM4t5YRCzLS+2STRJNcFPGR2bKD
   Fckq8z534e6b3qRwXtIloMhEX/afk2NU/Nf7Jbzb+Kicxupv5XyJ0wTll
   LZ9Vs6Z7igbRCKG8lLs6IJIcEw5AzR3DPG4wmbhcL0G2ak9QIAj/KC9j7
   GoUofSAjQXufth9awgckdiQDFPF63HkRBMdoSldsSH/i9EQS1eQ9cYdKg
   g==;
X-CSE-ConnectionGUID: HTrrBqHJR1OuiBUhZjvStw==
X-CSE-MsgGUID: gkzU4w97SOOl0WpoEoTRgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68714896"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68714896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:48:06 -0800
X-CSE-ConnectionGUID: T9JvXfd2RP6uhr7fMRGrgQ==
X-CSE-MsgGUID: Pv4wkjngReqizgRny5HiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188985842"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 10 Nov 2025 10:47:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 71F03A8; Mon, 10 Nov 2025 19:47:29 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Corey Minyard <corey@minyard.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Calvin Owens <calvin@wbinvd.org>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 19/23] ptp: ocp: Switch to use %ptSp
Date: Mon, 10 Nov 2025 19:40:38 +0100
Message-ID: <20251110184727.666591-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %ptSp instead of open coded variants to print content of
struct timespec64 in human readable format.

While at it, fix wrong use of %ptT against struct timespec64.
It's kinda lucky that it worked just because the first member
there 64-bit and it's of time64_t type. Now with %ptS it may
be used correctly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index a5c363252986..a0bb8d3045d2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3261,7 +3261,7 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
 			   signal->duty, signal->phase, signal->polarity);
 
 	ts = ktime_to_timespec64(signal->start);
-	count += sysfs_emit_at(buf, count, " %ptT TAI\n", &ts);
+	count += sysfs_emit_at(buf, count, " %ptS TAI\n", &ts);
 
 	return count;
 }
@@ -4287,11 +4287,9 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 		ns += (s64)bp->utc_tai_offset * NSEC_PER_SEC;
 		sys_ts = ns_to_timespec64(ns);
 
-		seq_printf(s, "%7s: %lld.%ld == %ptT TAI\n", "PHC",
-			   ts.tv_sec, ts.tv_nsec, &ts);
-		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %d\n", "SYS",
-			   sys_ts.tv_sec, sys_ts.tv_nsec, &sys_ts,
-			   bp->utc_tai_offset);
+		seq_printf(s, "%7s: %ptSp == %ptS TAI\n", "PHC", &ts, &ts);
+		seq_printf(s, "%7s: %ptSp == %ptS UTC offset %d\n", "SYS",
+			   &sys_ts, &sys_ts, bp->utc_tai_offset);
 		seq_printf(s, "%7s: PHC:SYS offset: %lld  window: %lld\n", "",
 			   timespec64_to_ns(&ts) - ns,
 			   post_ns - pre_ns);
@@ -4499,9 +4497,8 @@ ptp_ocp_phc_info(struct ptp_ocp *bp)
 		 ptp_clock_index(bp->ptp));
 
 	if (!ptp_ocp_gettimex(&bp->ptp_info, &ts, NULL))
-		dev_info(&bp->pdev->dev, "Time: %lld.%ld, %s\n",
-			 ts.tv_sec, ts.tv_nsec,
-			 bp->sync ? "in-sync" : "UNSYNCED");
+		dev_info(&bp->pdev->dev, "Time: %ptSp, %s\n",
+			 &ts, bp->sync ? "in-sync" : "UNSYNCED");
 }
 
 static void
-- 
2.50.1


