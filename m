Return-Path: <linux-pci+bounces-40743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F8C48CA3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06E83B3BCB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D133A00F;
	Mon, 10 Nov 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeSDHzB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FE334C36;
	Mon, 10 Nov 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800484; cv=none; b=CyHsTmsU//74qafZqF4+/HJW+7xreV0HoPfUHBL3iUQNcvqB+RFSR63a2tL2ASb49qQ94hMUY604Ol4XHVtq54DmIpfEmV1F+0b+KdNmOJstEUdCCz+lUIDIakfWlebmZD5gJ+EDXVjIGU5p2Hn191fx7IXyAUa4iwZNtDfut8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800484; c=relaxed/simple;
	bh=oiUH/MiG9bvVHCRWpyZuJmqnh7B0oNIzC+jHMWYJItY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyMJffwynwJSEf++AFtXoR4c2i1Ko1RIZvRA+H5HLZHl/NPR5C15cjTR3CrjrCh10h9dEVdIEOlULNvBNgxzjieR0zHmxZtIQdnlW3CwkgVFdrlIw17V4U15tdZm1haNUhaFaeU/v3L5R0nO5W4++FVna9Rr5AAS6Ql623OHMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeSDHzB/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762800481; x=1794336481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oiUH/MiG9bvVHCRWpyZuJmqnh7B0oNIzC+jHMWYJItY=;
  b=DeSDHzB/RoCMKAyS/fjqsJKQ3sfwZ8C36nDtW7SlAs2JL4Wit6gwwjRN
   GYGoTlmCWSdLzVqyeDdBi/FIXUk+hDomyLSnHd6t30ypQj0+UuwqQRxg4
   iAPJAvSxLGwZPYxtS7HokM8ZnyRwVt7WOQmYlJfIZJHyD22434F1d2f3T
   5iu+VFUXuLs+56Nlvk1Q2u9quACHKDK3f8oJk2NpVzsgIE5vTlyS7VpLn
   320mhQ7q2xGHmiTZcO/9gbl306862Tdl0ANABQefyhOQXOr58kbAxlGpT
   Vzjm5QlwBsTcV6M4Si84zwJhePNEWfNFoaYk3551M1WP+UeFA2MDFjeUL
   A==;
X-CSE-ConnectionGUID: NEJCxpmBQ5q5y8HZW+sn/g==
X-CSE-MsgGUID: Tp2ZxQWqRX+5qdvNWK27BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68705399"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68705399"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:47:59 -0800
X-CSE-ConnectionGUID: MuEJTZ4URW+LdYzVyf898w==
X-CSE-MsgGUID: Dj/AQkpFTdO4UAI/pAx3Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188705041"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 10 Nov 2025 10:47:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 57559A4; Mon, 10 Nov 2025 19:47:29 +0100 (CET)
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
Subject: [PATCH v1 15/23] mmc: mmc_test: Switch to use %ptSp
Date: Mon, 10 Nov 2025 19:40:34 +0100
Message-ID: <20251110184727.666591-16-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/mmc_test.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index a74089df4547..c17b7b200798 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -586,14 +586,11 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
 	rate = mmc_test_rate(tot, &ts);
 	iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
 
-	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
-			 "%llu.%09u seconds (%u kB/s, %u KiB/s, "
-			 "%u.%02u IOPS, sg_len %d)\n",
-			 mmc_hostname(test->card->host), count, sectors, count,
-			 sectors >> 1, (sectors & 1 ? ".5" : ""),
-			 (u64)ts.tv_sec, (u32)ts.tv_nsec,
-			 rate / 1000, rate / 1024, iops / 100, iops % 100,
-			 test->area.sg_len);
+	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took %ptSp seconds (%u kB/s, %u KiB/s, %u.%02u IOPS, sg_len %d)\n",
+		 mmc_hostname(test->card->host), count, sectors, count,
+		 sectors >> 1, (sectors & 1 ? ".5" : ""), &ts,
+		 rate / 1000, rate / 1024, iops / 100, iops % 100,
+		 test->area.sg_len);
 
 	mmc_test_save_transfer_result(test, count, sectors, ts, rate, iops);
 }
@@ -3074,9 +3071,8 @@ static int mtf_test_show(struct seq_file *sf, void *data)
 		seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
 
 		list_for_each_entry(tr, &gr->tr_lst, link) {
-			seq_printf(sf, "%u %d %llu.%09u %u %u.%02u\n",
-				tr->count, tr->sectors,
-				(u64)tr->ts.tv_sec, (u32)tr->ts.tv_nsec,
+			seq_printf(sf, "%u %d %ptSp %u %u.%02u\n",
+				tr->count, tr->sectors, &tr->ts,
 				tr->rate, tr->iops / 100, tr->iops % 100);
 		}
 	}
-- 
2.50.1


