Return-Path: <linux-pci+bounces-34555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6CB317E4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5885217E5D2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE441A01BF;
	Fri, 22 Aug 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2JBOCBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5252ED866;
	Fri, 22 Aug 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866054; cv=none; b=WtH7qjIkVFEN4EowIVx/D2YnAJ/3uQ2YKMsbScy2t61zIxZ+WuSuWI4rqjMwh2P4tbay3PhiLoR4QdSEtJYHIbi7D+WA4R6mj9n38LxvBb7S83k/6VfjHzgnf7dnqBQ3AbLnaAwHk31TLq2TgEMYGrPRPtdeZNsThT1q6arIHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866054; c=relaxed/simple;
	bh=ENqtVEK/qZKSy73VrE4hmvigVCZi+T8tLJajPBg4WNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uUrxTkP3X+WmgstYdMDEzrbKrMSJPlVbI6M+Ry/xp3pX/Z5gaQE2cZpKD0+ojkHXiK4L5WZBEiv5lX7lR5ozbvZA48y/xxLlRjo0C4eYSvYBpO4UqRVEIAVLRpLVJaq3H4o9rpzVXQXa3Yz/iVQnc3c5ab3DsSJpI2eZFR/xg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2JBOCBj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755866053; x=1787402053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ENqtVEK/qZKSy73VrE4hmvigVCZi+T8tLJajPBg4WNg=;
  b=C2JBOCBjK/Ue6aKCznTkEc5FND0IwSptxh6/FyJxUDiMTeMIMn5cFBep
   xBphJyoRrih3ysVdhtmf18UKrdTd8YGP+Zvs5T/pjT8sWrQ/faFhirmy+
   9XWPFAWiGk3ozLihv8S0K2t9vf7YuP+MADrXBKuT/n5WkXrsQnjEfWk8C
   OzWclVDvX3HFLpsAqSghizBT0Z4JGKsXSOMWaDmgVqUHBgm6bsSToXXK0
   wjjNSUFIoxoCxT+NEmY5DQdhVpjCxe7jRfUkBQSv4NPlR7G0USYR5wP8Y
   YoqkI0OtSW51QJPBB6s88uD0ROot5pr2ul6u7Gns+uwb1OKc8HcN30zrY
   g==;
X-CSE-ConnectionGUID: EWxRy01UQBCdTmBdA7GMEg==
X-CSE-MsgGUID: G2WQ/qrxSOyRPThSsjcRQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="83587570"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="83587570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:12 -0700
X-CSE-ConnectionGUID: 2/UcL2kBQaKUdUDRCQ7LSQ==
X-CSE-MsgGUID: ShV4bI8rRkKsh76J4c0+fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192360790"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/3] PCI: Resource fitting algorith fixes
Date: Fri, 22 Aug 2025 15:33:56 +0300
Message-Id: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3 corrects the max() parameters as noticed by Markus.

It would actually be nice if Rio could retest the first patch just
in case. While I expect his problem originated from the size0 block,
there's a small possibility size1 block could have played role in
which case the changed max() could impact the end result.

Once Rio has tested the first patch, these should replace the v2
patches in the pci/resource branch.

v3:
 - Correct max() parameter.
 - Added Rio's full name into tags.
 - Included Closes: tags from the applied v2 changes.

v2:
 - Add fix to resize problem (new patch).

Ilpo Järvinen (3):
  PCI: Relaxed tail alignment should never increase min_align
  PCI: Fix pdev_resources_assignable() disparity
  PCI: Fix failure detection during resource resize

 drivers/pci/setup-bus.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.39.5


