Return-Path: <linux-pci+bounces-40893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0BC4DD97
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989853A395D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041533123C;
	Tue, 11 Nov 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRZLot2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40168324708;
	Tue, 11 Nov 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864089; cv=none; b=dwKxnzRDVRunKWyn1enRDcZgsSGSS29xZdEiK/R2xfvlkFtj4VZa1uRA/VH/zAswiiMgE/fpNLEml27HO6CNuqy/XMzoU/EOhIMubwkDcZnul+81F28s4Uvj8Ic7qNj87K8mE4+TD+WadieFjHiJxFK5mSYVPVK5Y+NwVppZs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864089; c=relaxed/simple;
	bh=Owa/uZSyQflLahGS6CmSwDqgbO1CL5jfKyID5Cl9frQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIuMPpbPcVD7BF5Bh0cs1bBbN5M8hCqsuUyiiNFBTAbVKjsbJ3sltb1VYBf6MpLoTsE0PAJrQQEgjtoybX4q/6c1DdxId3KQcSPBO3/0URbz4Rrs3iaoeUTIWziOHeYeZbF7ze8/3Syv9qis9s3KUdUTNCfnVw4xCOZVmi/ECoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRZLot2b; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762864088; x=1794400088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Owa/uZSyQflLahGS6CmSwDqgbO1CL5jfKyID5Cl9frQ=;
  b=QRZLot2b/gXccdhg/nUWTuGmMNBsQF1Mjc+gFadCupxnhR9p60atuY/F
   QP6j7ulJtUWirQzjhjJ5QG95AiRXTgvwQZZrZfDrB0I8V6qMhZt58ifQI
   7th4rm7qpYPUKbLS3gvmBMxcMreZEppAHOk/FHrrpqAKdCIOonJ/h2PvY
   WlHA/ODFWcEncnk0NSiaLB51+Vbsee0uosRIFTXoBIePGlEA9jZQqAePG
   hBndzjmJ3xWk6wTKXQEnFk4Hv+A2DtWcKwOwWSmX2K874X0NBUUsYyZIe
   6DEJBkIQpAynXdU1tytjBEYhPCG1firBnepQjioEdEidi7+ScuDUd18iJ
   A==;
X-CSE-ConnectionGUID: z7/Q23ZWSuK31/PGlzPXAw==
X-CSE-MsgGUID: 7YLYhXwLSc2KYMZAck+2+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75606980"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75606980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:28:04 -0800
X-CSE-ConnectionGUID: QpOvoTP2TYKT5V9dhrKvZA==
X-CSE-MsgGUID: DJfjMKFlRSW8JzjS12Rp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188592916"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2025 04:27:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 10F139F; Tue, 11 Nov 2025 13:27:38 +0100 (CET)
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
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
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
Subject: [PATCH v2 09/21] e1000e: Switch to use %ptSp
Date: Tue, 11 Nov 2025 13:20:09 +0100
Message-ID: <20251111122735.880607-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111122735.880607-1-andriy.shevchenko@linux.intel.com>
References: <20251111122735.880607-1-andriy.shevchenko@linux.intel.com>
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
 drivers/net/ethernet/intel/e1000e/ptp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index ea3c3eb2ef20..ec39e35f3857 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -229,14 +229,11 @@ static void e1000e_systim_overflow_work(struct work_struct *work)
 						     systim_overflow_work.work);
 	struct e1000_hw *hw = &adapter->hw;
 	struct timespec64 ts;
-	u64 ns;
 
 	/* Update the timecounter */
-	ns = timecounter_read(&adapter->tc);
+	ts = ns_to_timespec64(timecounter_read(&adapter->tc));
 
-	ts = ns_to_timespec64(ns);
-	e_dbg("SYSTIM overflow check at %lld.%09lu\n",
-	      (long long) ts.tv_sec, ts.tv_nsec);
+	e_dbg("SYSTIM overflow check at %ptSp\n", &ts);
 
 	schedule_delayed_work(&adapter->systim_overflow_work,
 			      E1000_SYSTIM_OVERFLOW_PERIOD);
-- 
2.50.1


