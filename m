Return-Path: <linux-pci+bounces-12723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8196B2C3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5293F1F27255
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A614659D;
	Wed,  4 Sep 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUo47ZNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A6145FE8
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434752; cv=none; b=sZGqqPxF2XeOcy2tv4B/LUu1b3p/4QYZkWjJHMRI/K1unPPZN46tqnujjG281G4PuCM9oppIrx21YZaIRDztUgn+En7CXuIEoycuXfHhChvMTsBJU5sF9qC+DFUskjGt+/aGr9AGxDiTMfyVOwD0l8uRSQGtFPfCo6pXuTEFPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434752; c=relaxed/simple;
	bh=ZtjWFy7AfO9EdyqhcgulwtDmU/bcKMsg/rppWMCn84g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ywge/psBq5I1l7gbcLTJAU5sRZE0n1oIRcHldM7z2AEQqlHvwQopmvb0fcijcH3vwkEaSI70CVKGQ2F+0PK2xf63iXKB3mA80IABnHdxCyKvtQYB576R40pPixQoYvYHCVbFMLiRPSZggzzB1xUH1dt3VN2nZRp9XegnEqeM+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUo47ZNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725434748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Ai0i48K+x75wE2opWN6H+yE5yaU/0owwcRJ41uJwPs=;
	b=PUo47ZNlqor3z4KcLgXGdK9Nh7zIsr1FlSsBTOiGFIanxVzNAdVPHAJshl4FznHq9Fk+fu
	V9S9pO3+FW2zzqs3hA3mXLGs+DFrlSzd/BjAM0GC47zGdZ88vyt7foEPOzEi953CD+j0JU
	dn7bPazUoD59BfgfIC7GNnRDpHxNOEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-t218rB35OfG3YlBl3Euhfg-1; Wed, 04 Sep 2024 03:25:47 -0400
X-MC-Unique: t218rB35OfG3YlBl3Euhfg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso9394425e9.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 00:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434746; x=1726039546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ai0i48K+x75wE2opWN6H+yE5yaU/0owwcRJ41uJwPs=;
        b=fXdHDX3uIaRSrBk5wbej/tHfiQjgmkuIUDiOtvWZtUk+ErTDmzvreG3lbgUkKM3aP9
         dtRu5v/EsqEmlg0lsfhEIM8skgbIDZCodCChilheThHEhW+1onOnOX+QGs8HkMgKkN49
         D3Qep6tJw6hIoj3J6NJBTf8dGi7eRSCkOvgN82RayIdHNoLCVgYK3yACCGBCQuadA6Bw
         bgSUU5A/wrXi0CGRNUY1yRRruAAc4v67JojGb19gmMdrRj8lpvogBzGzy6Nk8gUFlhq5
         IZNMIebPg/XIZRQdNvmwxi3ms9l/yVTsQuZB2Ag2zBdYdlo5KSesPHHTDS7gbHSSCfLX
         xECw==
X-Gm-Message-State: AOJu0YxeMqybp2etTM432n3jRrvdy7I40NjhQ6FVY0wULTT70CO6/VPw
	hPg6XYgyRsEsnGM9ZYK/vYqglKM53vClxUjczjux95ULhMm6QxpiC4LPgvSIVEoTHqEnIK8Ltxf
	gR2A1Pi+uymvC6UTgl5bEr7Yj9zxbbXs9IXcuPhhCVWv38IEnyYb3ti+2LiVy39KhXA==
X-Received: by 2002:a05:600c:1c83:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42bb01e5f83mr144896435e9.27.1725434746511;
        Wed, 04 Sep 2024 00:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEviBJFNrkQInUgxY9gMkRKTSBKIkiCknbrw34c2RvP/P4K3CeawHA8LFRYHivQqQ6/eeBWBQ==
X-Received: by 2002:a05:600c:1c83:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-42bb01e5f83mr144896215e9.27.1725434746012;
        Wed, 04 Sep 2024 00:25:46 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6f9b584sm193222905e9.16.2024.09.04.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:25:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix might_sleep() lockdep warning in pcim_intx()
Date: Wed,  4 Sep 2024 09:25:42 +0200
Message-ID: <20240904072541.8746-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
allocation step for pci_intx()'s device resource from
pcim_enable_device() to pcim_intx(). As before, pcim_enable_device()
sets pci_dev.is_managed to true; and it is never set to false again.

Under some circumstances it can happen that drivers share a struct
pci_dev. If one driver uses pcim_enable_device() and the other doesn't,
this causes the other driver to run into managed pcim_intx(), which will
try to allocate when called for the first time.

Allocations might sleep, so calling pci_intx() while holding spinlocks
becomes then invalid, which causes lockdep warnings and could cause
deadlocks.

Have pcim_enable_device()'s release function, pcim_disable_device(), set
pci_dev.is_managed to false so that subsequent drivers using the same
struct pci_dev do not run implicitly into managed code.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@redhat.com/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
@Alex:
Please have a look whether this fixes your issue.

Might also be cool to include your lockdep warning in the commit
message, if you can provide that.

P.
---
 drivers/pci/devres.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..c7affbbf73ab 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -483,6 +483,8 @@ static void pcim_disable_device(void *pdev_raw)
 
 	if (!pdev->pinned)
 		pci_disable_device(pdev);
+
+	pdev->is_managed = false;
 }
 
 /**
-- 
2.46.0


