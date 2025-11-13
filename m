Return-Path: <linux-pci+bounces-41115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A3C58599
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089453BB22B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AB35A921;
	Thu, 13 Nov 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOnHEOyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1135A124;
	Thu, 13 Nov 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046206; cv=none; b=aiqz6rz02P/l44d9rkX82AO9pFJKSJLOsQm2xsAMauJou5VNx4OeCpyFxGMnGUU8ajvq0KDn3Nn9W/ETuoGk/GsbchB+s3PO+KY//ferWURMIOjRZ6gAFLU03jbZWdy5PtNejffQgv6NxPLNfw++dSH/eidKXEbGLgk6EKwd97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046206; c=relaxed/simple;
	bh=mKCfGvyzNhw96Cnh7FIRHLBI440Q6rRaNHGoDV+QYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR/JItHWTybglT/zn80dwwrwUDR+JLzXoDQl3Xab78qU+9+Bib7GxmQPttbfLynX93xzWhVoimalONzmoi230Te2VFgOKuzy0OjS5b2l6o9er0RbThTcgu0kOunJuwFDoMMKvQwaEWcHX/TdnVKg9yEustWieaoa9u5QhbpmXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOnHEOyk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046205; x=1794582205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKCfGvyzNhw96Cnh7FIRHLBI440Q6rRaNHGoDV+QYYs=;
  b=iOnHEOykLC/hrEuf4LeVHtkbp66GpB+xD4CE2hZBRSqDMTLdm2b8sT7S
   EfHnd3+mxPNaw7RoyWyER+eBs5skw3jbpmNs9PBIsoNHCkr9dkiJ0ZujM
   xnimJ+wpUPZ6uTgNGLmscE80ATMXORXV4aCyU1suml6A4XEyi833A12vy
   rAilHqqd5eMx5W0yaBg2Y+66Hwqq405M0NyoDY/FmG6wl2NciW9QqRDyp
   /X/pV3zA5c9WxRom57ad9QEy9pAh1iyXPjHBTC/xQwdmNGj6G0pKM43es
   /bt0Q9g00vZlwgntGwAi569lpOtrEdYJwptnEZArjMb2U2mTByS4WkhEz
   w==;
X-CSE-ConnectionGUID: WNSpEkyuRReFD8BaQYmwhg==
X-CSE-MsgGUID: XoLT583WSrup6mEuPuwVPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65054723"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65054723"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:03:03 -0800
X-CSE-ConnectionGUID: yKzzlJzzQWapQitGWcT/+Q==
X-CSE-MsgGUID: xLZAMTLNQZqO3A74MNxPAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220325230"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2025 07:02:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 81C62AA; Thu, 13 Nov 2025 16:02:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Corey Minyard <corey@minyard.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
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
	linux-trace-kernel@vger.kernel.org
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
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 20/21] scsi: snic: Switch to use %ptSp
Date: Thu, 13 Nov 2025 15:32:34 +0100
Message-ID: <20251113150217.3030010-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %ptSp instead of open coded variants to print content of
struct timespec64 in human readable format.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/scsi/snic/snic_debugfs.c | 10 ++++------
 drivers/scsi/snic/snic_trc.c     |  5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 9dd975b36b5b..edf3e5ef28a6 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -282,8 +282,8 @@ snic_stats_show(struct seq_file *sfp, void *data)
 	jiffies_to_timespec64(stats->misc.last_ack_time, &last_ack_tms);
 
 	seq_printf(sfp,
-		   "Last ISR Time               : %llu (%8llu.%09lu)\n"
-		   "Last Ack Time               : %llu (%8llu.%09lu)\n"
+		   "Last ISR Time               : %llu (%ptSp)\n"
+		   "Last Ack Time               : %llu (%ptSp)\n"
 		   "Ack ISRs                    : %llu\n"
 		   "IO Cmpl ISRs                : %llu\n"
 		   "Err Notify ISRs             : %llu\n"
@@ -298,10 +298,8 @@ snic_stats_show(struct seq_file *sfp, void *data)
 		   "Queue Ramp Down             : %lld\n"
 		   "Queue Last Queue Depth      : %lld\n"
 		   "Target Not Ready            : %lld\n",
-		   (u64) stats->misc.last_isr_time,
-		   last_isr_tms.tv_sec, last_isr_tms.tv_nsec,
-		   (u64)stats->misc.last_ack_time,
-		   last_ack_tms.tv_sec, last_ack_tms.tv_nsec,
+		   (u64) stats->misc.last_isr_time, &last_isr_tms,
+		   (u64) stats->misc.last_ack_time, &last_ack_tms,
 		   (u64) atomic64_read(&stats->misc.ack_isr_cnt),
 		   (u64) atomic64_read(&stats->misc.cmpl_isr_cnt),
 		   (u64) atomic64_read(&stats->misc.errnotify_isr_cnt),
diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index c2e5ab7e976c..6bad1ea9a6a7 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -56,9 +56,8 @@ snic_fmt_trc_data(struct snic_trc_data *td, char *buf, int buf_sz)
 	jiffies_to_timespec64(td->ts, &tmspec);
 
 	len += snprintf(buf, buf_sz,
-			"%llu.%09lu %-25s %3d %4x %16llx %16llx %16llx %16llx %16llx\n",
-			tmspec.tv_sec,
-			tmspec.tv_nsec,
+			"%ptSp %-25s %3d %4x %16llx %16llx %16llx %16llx %16llx\n",
+			&tmspec,
 			td->fn,
 			td->hno,
 			td->tag,
-- 
2.50.1


