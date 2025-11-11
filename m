Return-Path: <linux-pci+bounces-40904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCDC4DF1B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 128994FC080
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AD366550;
	Tue, 11 Nov 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYVFL/wa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFC361DCC;
	Tue, 11 Nov 2025 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864098; cv=none; b=tQCzpeGYSxq52vkT2PBfpLvW0J/qkzH8pVr1F1B2RNpZXoZuvgmjj92brH18SlCyY/qhFvo7ZNecxPl0k6AR2Q9R1+HVkfIsGJuNR+PX1OGUiFg5tkTIIFo2emzWQigFfoYWXS7BveSvzVztYnhqiVuMCA/xexnJESe0L59GAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864098; c=relaxed/simple;
	bh=OtFs4nYXEH1ThWKykhpKfwgYG7osOn2qi/Z49bIrWUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bowNWiOjJhq+gQkmnAlgGKjlhyo81omPuMooKC4spaOIfs2w8wmDgM5K9tuiZr2onDxYAbjMnkAafQi2PQNEknUe/07gkYaxdcouRBZFOiI5du0wVN9TtI0UdP/WCGeXyFA7VG9oMaQT5esL2FAIaqluKxH8zMC1hxdqcb7qgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYVFL/wa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762864096; x=1794400096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtFs4nYXEH1ThWKykhpKfwgYG7osOn2qi/Z49bIrWUw=;
  b=BYVFL/waIEA8DYye86BSPQEDB9l2CJ+IICWo51yTstEGSP4HUzXiH1fY
   KnvkL4MZ70TyyrJeESLb+5Orcm8pxk1h0eyMHLjXreWmYeu+D4TJRYInm
   +k8Yh/P4ZhyXfqOMws3ckgjny/7sZS4mfxTIAn4CkN1722UTT0GJCeTUH
   DsEQ6xMJq9uqcS/cTW2T5dMZnJJojPjrtuuShoDunOqaK5zOuqcX58TGJ
   lXtyKKU1CwGO1oi4C3ckk7yBlVnctVdFH+u9hLbtAXwx+xuwfOo2MIz29
   jc5wUM32tfXbQBlBgkhEPv5YnojKF5LM/AyXCtUFf+U95xoahPHCAwNCH
   A==;
X-CSE-ConnectionGUID: HOShL0rVTROT+/juwYNR/g==
X-CSE-MsgGUID: 6nLtbYHKQdObDHEGzxpnxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75607210"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75607210"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:28:13 -0800
X-CSE-ConnectionGUID: tMUh47YlR0iztmLUL7ZOeg==
X-CSE-MsgGUID: n8CanOcvRy2xvoMOm6Z2iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188592937"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2025 04:28:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5E57DAB; Tue, 11 Nov 2025 13:27:38 +0100 (CET)
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
Subject: [PATCH v2 21/21] tracing: Switch to use %ptSp
Date: Tue, 11 Nov 2025 13:20:21 +0100
Message-ID: <20251111122735.880607-22-andriy.shevchenko@linux.intel.com>
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

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/trace/trace_output.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ebbab3e9622b..cc2d3306bb60 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1490,12 +1490,12 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, entry);
 
-	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%lld.%09ld count:%d",
+	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%ptSp count:%d",
 			 field->seqnum,
 			 field->duration,
 			 field->outer_duration,
-			 (long long)field->timestamp.tv_sec,
-			 field->timestamp.tv_nsec, field->count);
+			 &field->timestamp,
+			 field->count);
 
 	if (field->nmi_count) {
 		/*
-- 
2.50.1


