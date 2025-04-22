Return-Path: <linux-pci+bounces-26446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C24A97AE4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8664611EB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662162D1F67;
	Tue, 22 Apr 2025 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEolNArr"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4702D026E
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363150; cv=none; b=kTyOcCxmXzpcti5CN4IUkGTk4x+o8NpAOfXzNLOA5Y5mlEh1sNx5/Hc57C91GlbZ2NeczCX9ck0Wm2p3cZwuunb11h4OFkQzLJRpdGR00Q/mFjH1JrxNPyAk6osBMJIerP++llxEsANEsB4MgkTIwlnnD3U9l6Cwvvpoab8C17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363150; c=relaxed/simple;
	bh=/3WEb+dygs+eWmYWF81aQ8qVlo9Y+tikEAZ8KqHjMzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLOzubSWrzbFthhqh7gpxfbgxwUIr1iM3DF4gQTRRWkHefZi1E6v/AeUjcjM+42JXEAIEFvBjbAwWXY5xVg2kw89It47Arb5nvfFnTDLF9+f+p1n+FxSl++8HrNjKDj1kmtpCoNTkLN3NJ5VSm0r1eMvb13syjEecD1zKSDN13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEolNArr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745363147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkXnoeRkH2y5k80MjXEwQDOBw2xFVOkQ0IU4jNVrWtY=;
	b=JEolNArrm/9hKMt3Ag6klCK0vJq34b8qrsWECx7wO7/+JeqLgNPObFJviPgDdk1Xh6qwZ1
	xS45H6d0YQ7voW4C+oZP5wf6jTdP009yanSsP2NrUWImAtPJl8fOxn0Vfosk176j8NgOG2
	Fx/JMszXh+N1yp+PIqHAliE+oZFNRv4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-ZIHoqVFGOqKgNcgFLbFd5A-1; Tue,
 22 Apr 2025 19:05:44 -0400
X-MC-Unique: ZIHoqVFGOqKgNcgFLbFd5A-1
X-Mimecast-MFC-AGG-ID: ZIHoqVFGOqKgNcgFLbFd5A_1745363143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 369121800368;
	Tue, 22 Apr 2025 23:05:43 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC0E518001D7;
	Tue, 22 Apr 2025 23:05:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Increment PM usage counter when probing reset methods
Date: Tue, 22 Apr 2025 17:05:32 -0600
Message-ID: <20250422230534.2295291-3-alex.williamson@redhat.com>
In-Reply-To: <20250422230534.2295291-1-alex.williamson@redhat.com>
References: <20250422230534.2295291-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

We can get different results probing reset methods for a device
depending on its power state.  For example, reading the PM control
register of a device in D3cold will always indicate NoSoftRst+,
preventing us from correctly probing PM reset support.

Increment the PM usage counter before any probes and use the cleanup
__free facility to automatically drop the usage counter out of scope.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c6cda56ca52c..71a36f57ef57 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1475,6 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
 		return count;
 	}
 
+	pm_runtime_get_sync(dev);
+	struct device *pmdev __free(pm_runtime_put) = dev;
+
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);
 		return count;
-- 
2.48.1


