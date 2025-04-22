Return-Path: <linux-pci+bounces-26447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC3A97AF1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 01:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B2D7A5169
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9F25CC5C;
	Tue, 22 Apr 2025 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqq6ynyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4211FFC4B
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363645; cv=none; b=G99/XDkczr6b033tvEpze5A1JmilcOH5KKLh3D11yZJjJy87XgBFy8Nlvs2G9D/vi1upxah5mPpPFlfZrUmHlOGnBTkvoWIvhWKDiho046OkksdFzogZ4ij2uVGZo/jvHuxFO6LHtNo2JCMtAqzYwTn2SufB/NGbN5SFcrX/N1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363645; c=relaxed/simple;
	bh=0H0uKZ693mlpOCVqBXLPrlDdTN8NIHveQOdXj53aAW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNjzsmNwFtl88my1H8vHCDpf5pj+Bx12BqoQ+XRqLB+hnUlLlMKNyiYmk+kztk5OOpmcfKBWamqwB1I9Up1kehtv/VZ0CsPVs3rGUy8nnzkyKsKJ26f4qfxjFUkQnuBlexld/PAs6PGUs/4aLExcxInhUkI0sVrqzYc9zWpjSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqq6ynyd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745363642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eA2dPJ7kUmIfz4lKYy/AXLtHSVSq2pKZ9vTXMKbDLTg=;
	b=dqq6ynyd0wIICjfI9147NguRCB1gUFxcJrOk798NoYyCrgSvnXBA9jBX8d4Jiv4RPns9yP
	yh2b/Fbrb7rnZT6pCkcr2VobKjhNecQu8WGb4/RVIOJZofxcFStmo5GMTFyykmuD6c+Q1/
	YTtG6IRSwHpu1PusMcHLF4NEgHCFW7I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-zFzYHi_wNxSfo9fhPr4raw-1; Tue,
 22 Apr 2025 19:05:40 -0400
X-MC-Unique: zFzYHi_wNxSfo9fhPr4raw-1
X-Mimecast-MFC-AGG-ID: zFzYHi_wNxSfo9fhPr4raw_1745363139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0C3C180048E;
	Tue, 22 Apr 2025 23:05:39 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3381418001DD;
	Tue, 22 Apr 2025 23:05:38 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI/PM: Elevate PM usage during reset probing
Date: Tue, 22 Apr 2025 17:05:30 -0600
Message-ID: <20250422230534.2295291-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I encountered a confusing scenario where a device reports NoSoftRst- and
doesn't have any associated quirks to set PCI_DEV_FLAGS_NO_PM_RESET, but
it refuses to probe for PM reset support using the sysfs reset_method
attribute.  The reason turns out to be that we don't increment the usage
count while probing, the driver has the device in D3, where this system
seems to support D3cold, and the PM control register is read back as
0xffff.

The cleanup __free helper seems to be the cleanest solution here, versus
refactoring to a common exit point or wrappers around reset_fn, but feel
free to suggest otherwise.  I see a couple potential other use cases for
this helper in the vfio code.

Please review.  Thanks,

Alex

Alex Williamson (2):
  PM: runtime: Define pm_runtime_put cleanup helper
  PCI: Increment PM usage counter when probing reset methods

 drivers/pci/pci-sysfs.c    | 3 +++
 include/linux/pm_runtime.h | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.48.1


