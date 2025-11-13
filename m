Return-Path: <linux-pci+bounces-41105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD05C58466
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E199B3A21FD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1034DB62;
	Thu, 13 Nov 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiLnhQ3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034633DEF6;
	Thu, 13 Nov 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046180; cv=none; b=ZGVvwaNYZvVMaZ6uzGkKIUnvf4ouU6b+WV+l55EuIgduFQO0idrjzZ6HerLrT7NhyM8NWq9faIPg+8O1+GbC8oXfWq/1sqZujbUu2O4zswFpgfN7mjdsWjCX0ZZ5mfMddim3EcK5b3ZRWOuvHW88frYOsWm4a7JB/xiHf7Jm9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046180; c=relaxed/simple;
	bh=GOmlU8+AxY4qiyUG0euFaX4L/EDMDObrk8lwMAMh1Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbHnYDntefNCA+5j5Czg9LuaQE0Da2Wmcq4U3zc5XcJ+6HkrTlIZ2e4MPdi/X8NXkz+FPeOyqfwv+xBaEXzjdmx7rJcJRA4YiIvK0PUTcjEmPAd6WCxJjJApHhd3UU9bsfEtLO4c9P13nJef3JXR1Xn4Zt5Fmlz+BbbPRvkQvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiLnhQ3o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046179; x=1794582179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOmlU8+AxY4qiyUG0euFaX4L/EDMDObrk8lwMAMh1Z8=;
  b=YiLnhQ3otwj+Bhyk6lMOGhMM8k0i9kJJ3XTuEbUmt/CAMg63EUE2EmoR
   AVL7Pmlj7QCx7ACahUlxSXKbM8RJqVNQzV1x11jQJyvDH/X8AZXHNzsl6
   s1PwIbu7WzELbUTqKSLT9JuU7DinhYKCXDVKHeJMFM/7RVZt8Xw5zPUPx
   GqCBfN4RGLUHKCNIda0tqNlhSWSbALgNmyUeSxddn+ZnGSux3WFFcAKeQ
   UY3Y2lg08QflNsvA1O4x2+GKxYUYGMjyUXmn676K9fgXaJ8L/NqS55gJA
   vM9H6rb9LgcyXd9uu4iCDXnAwaREt/V+8QhUCloHBAk7sBY1M3Okfodhh
   w==;
X-CSE-ConnectionGUID: dPPbA7yHQD+SUvfzN9YWEg==
X-CSE-MsgGUID: qPs7wU40T+uH/HgdCEXz6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68991740"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68991740"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:02:58 -0800
X-CSE-ConnectionGUID: VoHVivOhTuuJ8F2T91fvwQ==
X-CSE-MsgGUID: aM4vg+x7RCGNGIIJNMHExw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="188810329"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 13 Nov 2025 07:02:48 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6DC70A7; Thu, 13 Nov 2025 16:02:19 +0100 (CET)
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
Subject: [PATCH v3 17/21] ptp: ocp: Switch to use %ptSp
Date: Thu, 13 Nov 2025 15:32:31 +0100
Message-ID: <20251113150217.3030010-18-andriy.shevchenko@linux.intel.com>
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

While at it, fix wrong use of %ptT against struct timespec64.
It's kinda lucky that it worked just because the first member
there 64-bit and it's of time64_t type. Now with %ptS it may
be used correctly.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index eeebe4d149f7..21a8109fae34 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4293,11 +4293,9 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
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
@@ -4505,9 +4503,8 @@ ptp_ocp_phc_info(struct ptp_ocp *bp)
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


