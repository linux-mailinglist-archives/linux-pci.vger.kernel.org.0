Return-Path: <linux-pci+bounces-40745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F0C48BEC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 220E7343C72
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD833B968;
	Mon, 10 Nov 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrlLhdcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F0335071;
	Mon, 10 Nov 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800484; cv=none; b=UkHUcxO03Ma1vmwX4OjUA07Y5Sxwpwl5wBxJK42pShfhpPTrGo+uhYx5zOPYVJIp70cbZY857djE8+PqSeCU2+5T8nQGbJqyWMqYTlE0poKPufJNys50yIyPcpy6NIEgJNXrvyGOy1v4MWPHqtyPQgccOH00ObIIayVFabj+mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800484; c=relaxed/simple;
	bh=vfFJiF5Jws09gjgjKdTNrvEfoqRScmV1z1nMj3uwJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxpBX41H5dpWaLSKB1CjZg0qO5Wmd7XRclRBpCzCinN4r4sjXi2B2xg7OGlmbVgz5boVaW19rgH1u6Vc5vE4fVqq6Vt79fK9y5FfGP44jKAPgwg1EP3yomYoPnIeA6joDz9kDCnj0pfCuQZxPgB+DCRRNHT3j6HBt3p6N4w1Abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrlLhdcg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762800482; x=1794336482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vfFJiF5Jws09gjgjKdTNrvEfoqRScmV1z1nMj3uwJf8=;
  b=BrlLhdcgw2B/oP7t1nB1PHues2I/4/JevoMCMFwKV/dQUgYR4FWQ3qlM
   qUv+/b48qz3XUU5NZN5CmA5SqGGFvXd9RjENgCZWkwOaDQ2L9YrzXDu+L
   CJQ69RxKbvJeCnw8HR4n76DBaE13AgKm7tGA/K/rfGbk81i5RmYDMuGPc
   KQC/vBzV1FeSo/PMHcpvCGv9O0LHnHjyw3f/Am5ZVr5WCfCyNOO5ayoBn
   HTduP8vk3Nt0KrvRI985AzYb2+Ls3t1hIRnHupMyUsljfViUDv43Ia0dL
   1eFoJH6/1b4aaFYKesSxLo+Z0xbaq540mOODnkTzz/NFmmAeUW+707hFD
   w==;
X-CSE-ConnectionGUID: dnTV/qraSL2PP/B/39kpxw==
X-CSE-MsgGUID: 2W4Yz9SmTn6LbHKfGHxxig==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63861730"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="63861730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:47:59 -0800
X-CSE-ConnectionGUID: Ht2etEAvTa2/P79MAcMXVw==
X-CSE-MsgGUID: q70WGSfeRhCBG0Zd32Rwgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="226005244"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 10 Nov 2025 10:47:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 499D5A2; Mon, 10 Nov 2025 19:47:29 +0100 (CET)
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
Subject: [PATCH v1 13/23] media: av7110: Switch to use %ptSp
Date: Mon, 10 Nov 2025 19:40:32 +0100
Message-ID: <20251110184727.666591-14-andriy.shevchenko@linux.intel.com>
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
 drivers/staging/media/av7110/av7110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/av7110.c b/drivers/staging/media/av7110/av7110.c
index bc9a2a40afcb..602342d1174f 100644
--- a/drivers/staging/media/av7110/av7110.c
+++ b/drivers/staging/media/av7110/av7110.c
@@ -321,7 +321,7 @@ static inline void print_time(char *s)
 	struct timespec64 ts;
 
 	ktime_get_real_ts64(&ts);
-	pr_info("%s(): %lld.%09ld\n", s, (s64)ts.tv_sec, ts.tv_nsec);
+	pr_info("%s(): %ptSp\n", s, &ts);
 #endif
 }
 
-- 
2.50.1


