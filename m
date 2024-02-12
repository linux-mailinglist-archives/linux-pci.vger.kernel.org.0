Return-Path: <linux-pci+bounces-3347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9E8517A9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE71C219F4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390D3BB46;
	Mon, 12 Feb 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEwINpAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA63BB31
	for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750596; cv=none; b=dcxlz+Ns4yvoZZEUXqeBiM+DZ0R20BcscNWwbe10vQ2gdskEVa9XlzWS5L5yEWoGpAnZV7Xk/BApqVBwlr7Mg70Pq7EbaQgeyAcJg3orXtRqo87KS2keG1nKlMRoIH8up8RYne+xRBIAgYOGeAeC0oGE3yhNyrGpoTpN94jVgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750596; c=relaxed/simple;
	bh=3CtlPnrAIc9kCdFZyaIZYzpbe4Ll+a/xbmqDNliycXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knbRrN9ox1yWX5WZKikzaNCSerS9Mz2QoJ2io2QsC+I8vxw3lTzNnNSEaf2O7aWe/mOJqm28YPZZuVfyvn0OpJsV5spoizE8LnmiNvxCSEPFAFak/l33ps3QxeFuO29uFo9WFRTp9xtU2SOBfzA02cjQKqohBcFpdt+E6HAqtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEwINpAX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707750593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ItIfDGsC0enS4BsvR9I/hhCmejBlGx8oVDqvTbRAes=;
	b=bEwINpAXPPTQf5FaKbJwN0iabc+thy9q+xeUWngsPF1gmvcO5gzbGzYRr3L58lvRhKyfDH
	3u+XUuYLbjiUNW/KBWV0EYFpZ9XOpTipRYUzzFQT1UOvKVzKLldVpwznp2V+CheFNYLxp8
	csyn/ZqVsVl0iwjzf/QR52pcspM0cxg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-kgSMtjhYN2iU_Q4z_SmMrA-1; Mon, 12 Feb 2024 10:09:51 -0500
X-MC-Unique: kgSMtjhYN2iU_Q4z_SmMrA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42c6f7d83abso1422581cf.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 07:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750590; x=1708355390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ItIfDGsC0enS4BsvR9I/hhCmejBlGx8oVDqvTbRAes=;
        b=jhJ44cCI78RBf1gDRgsKMrYNriEktmEsQOo8JQSkP9Jg23xaUDOYHzK0/AtagrhufC
         D+Yk7/SazAecm4nxm2l/tCrIer14T5vQCv2A27Q6cmJmkYIhrYXtaGdpzJIKbWZsLPof
         czN1n5EsNNfRIMf+hWFzV45qq+Y6BKKKDXpIRTq2oRWC8BJaGB5Bn/UGn7n8FIqyltO4
         u3Suhpy8FY+xFXRhPkILawtOTqImrzOuxETcqjEGM95Yp+7zlXGXfMx5LyNK5HZbiMLs
         0rc5/diDLBO//JBnMQW8olG7mwkF6MiSX4WmrEBhGQN8mda6iuOy7d6IBnlZut1g5xC0
         ud5g==
X-Forwarded-Encrypted: i=1; AJvYcCXmBR02Xis1gI1lHVUbu4fxxJwoerCPGQ5m/bFf8xQoSRClinwPvvLz4lcy1picTV4aPAusHbtcFe8S8NxdrlFJOPD2m5UyF6oL
X-Gm-Message-State: AOJu0YyBUfOoFPPS/t/aVDeKpcu0cyDh7jbCkwn4f9QtaHqvjowuQTJE
	hXfUH9BYWF/5FEgYVii41j+QZZ/mFIXHQvBxQBB8Jscgy/M/VZ1/wLPnTgKKeFpi1NqxKyUeDre
	3+jroFosf56fozfxXi/xCfQxnTXnPP1cYSvLjFepnxfhdZ2YBDx/H8hP09w==
X-Received: by 2002:a05:622a:14:b0:42c:63fc:71df with SMTP id x20-20020a05622a001400b0042c63fc71dfmr8987670qtw.5.1707750590533;
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPknBjAVJNsaadO9yq2Eb2MRewXppMl85PQadkewZwkHwihhWG4rtXP8ycJskvQs6n+nNfXg==
X-Received: by 2002:a05:622a:14:b0:42c:63fc:71df with SMTP id x20-20020a05622a001400b0042c63fc71dfmr8987647qtw.5.1707750590230;
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5fCpx3BSGnayIIm+tvauvJ6kQuHOzJBxveyv9t2/FNcd5Ma2SwCiMHWI224C/xym8kyzWJN59dpa91PUVJNnOD5DHJxAcSTovV7ynV455KCyGxnPPkMideWar4HPSoN+mBf7RnrdrsGubvSQ/r1Kcc2EMh0B5t9zNfvO8DmxhpojDXYa9zr4ibJEaDIsbBN9YZ2to3FpiTFE0DmE3lz/Sd0sRQXlRm/s1gUJ5EgVRcUa3sA8mmIq8r+YAPLqfsjq/SrmNo+x2SyrytVkyJaZvcDmUm1AJGBXh2WASCrKRLCpTV49F5fKuSHWaBI4TvJP0eaOqTiU+TXx5hcdtOXSiaX7+RD4/
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32db:5d00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x8-20020a05622a000800b0042c6c103f7bsm213874qtw.37.2024.02.12.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Baoquan He <bhe@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Docu: fix build warnings for PCI
Date: Mon, 12 Feb 2024 16:09:34 +0100
Message-ID: <20240212150934.24559-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/pci/iomap.c was accidentally added to the Documentation
generation at two places.

Remove it from Documentation/driver-api/device-io.rst to resolve the
collision.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240205160908.6df5e790@canb.auug.org.au/
Fixes: 025bbeb5c880 ("lib: move pci_iomap.c to drivers/pci/")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
As discussed with Bjorn; this will be squashed into the series that
caused the problem, in PCI.
---
 Documentation/driver-api/device-io.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index d9ba2dfd1239..5c7e8194bef9 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -517,6 +517,3 @@ Public Functions Provided
 
 .. kernel-doc:: arch/x86/include/asm/io.h
    :internal:
-
-.. kernel-doc:: drivers/pci/iomap.c
-   :export:
-- 
2.43.0


