Return-Path: <linux-pci+bounces-42150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C208BC8B9DA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 20:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5F4E76C6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54F3451B5;
	Wed, 26 Nov 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjLgK782"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846134028F
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185784; cv=none; b=qL4+Dn5QFJhoEQbR892R0pMqcery66X+S+ikBY808DST70sHW9f1FgsAfRzXuw1YVherH6W4v4Ax2/E/eg58vrO+2uM8W5+Ta60seLaiQF6UFvVeXmvoztuz+3XVF2EojXG2QoVMii7sKPL3VX4LYT6lMfmJ5EIJZI177gLzDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185784; c=relaxed/simple;
	bh=HzMrzWRCLtgSmquMMa2P4U7RJKBy8Y6HK2PaCjHpnGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZpGKl2pb8kmF/cN2nFa64vRNWzShCF7Jv9SFN9pYtHHTjIxXxpMlW2sl4xyHS/8KdSw/d03q+SRyL3o/VDjg6PJTTWUx2zoI2OQdkauAYEz/CzCih2mKi8n3jSGu3joKLuI2dw0XlxxD5ZamvnMjdKazqxy8YwdY1wxX1HEIH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjLgK782; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297d50cd8c4so4390185ad.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185782; x=1764790582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq/yr6BWXlg1Xcrv4iWHhg15TfmkXzU0vPtqwC0SJKQ=;
        b=KjLgK782aOUBR9A8sLsTlj9ZVqmwzXa6sndJ6BVc6Ymg+Z4ej4B4qo8prYXdW0dCjW
         OaVzINZquF6F21gmQHkwqH7FTDx5GVAwNqcxlD6cIG8gFemTVA069qzvZLo3d2B0t3oR
         lVzxIsoS87jQufLANOOrun2IoZIcN10BiTeMLS/yIog8LC/T+z2wSb3i3jXxG4O53E3A
         WHg6Z0ijzn+XDpFIecUzw6/HeeCRldYnEgt5+Ni6MSGhUYeddVss04W79iI9sefyF6bT
         aPUX6RH3m+Llj4SaGM/TkDTVqcfclb85+vLb44i6uPKBYPCm000PSGv4MCw4b296TNKA
         OR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185782; x=1764790582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq/yr6BWXlg1Xcrv4iWHhg15TfmkXzU0vPtqwC0SJKQ=;
        b=Kh0UHN44lbYZjpreF/BOMLEHpv+joJOtwx7auh1rUYUiPWC1T62pD4BCNcRZAa/KgX
         CYdXEOJKzLeY3flyz1VqQHCyH/RfyvQrxuK7ni1xgs2YfvAHQrnTeo6Iqe6X7pm9+qSX
         IS2SUUqigK4sv8WekpuB0pd6nQl7ie1eRe0OvXg7Mg+MqsJnkgFB3d+Rxe4Q9lJif7il
         nLwO2TRldiH1QwNg52lDmYMRqUo5ESydq3x5mm8VQWynjIn0i23a07QQk78c99lqebF5
         8H2ma0dQUT31D+S0GGagwylNSf+O42aCveu8JiW/u/zF/UYqpXLiAxsxPiUS5u4nRdvC
         vicA==
X-Forwarded-Encrypted: i=1; AJvYcCXCT2PiuONEWgR9/C2H+6ee9BsnyiLnhWKqni+/kGdOPoKRkFbVgMGmy1opbD5vJBzDIwbWBQ0qcLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSiUE5duRrF0/CYOlBszpWVZm5d34QjkCOlEJUoamqwmo1xyQ
	F5uqGI2rE0k/qOlRz+3YlC34sVETEcEaAzTZ3KMy8kFCCxPEKXYT0dHvBk+k6zMeGwMaxiJrfgf
	0rrFQW2CWh5mXyQ==
X-Google-Smtp-Source: AGHT+IFWOeNwF25aWnbYsfeGo4vdcfOTzNrl8hAriCkFnQsDtZekeoeRfF6D6GNT5dSECm+ci49u7/PdsBRstw==
X-Received: from plblq5.prod.google.com ([2002:a17:903:1445:b0:268:4e0:9c09])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac3:b0:299:e031:16d with SMTP id d9443c01a7336-29bab148c3emr87405365ad.33.1764185782017;
 Wed, 26 Nov 2025 11:36:22 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:54 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-8-dmatlack@google.com>
Subject: [PATCH 07/21] vfio/pci: Notify PCI subsystem about devices preserved
 across Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Notify the PCI subsystem about devices vfio-pci is preserving across
Live Update by registering the vfio-pci liveupdate file handler with the
PCI subsystem's FLB handler.

Notably this will ensure that devices preserved through vfio-pci do not
go through auto-probing in the next kernel (i.e. preventing them from
being bound to a different driver).

This also enables VFIO to detect that a device was preserved before
userspace first retrieves the file from it, which will be used in
subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b7451007fca4..7669c65bde17 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -64,6 +64,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (err)
 		goto error;
 
+	pci_liveupdate_outgoing_preserve(pdev);
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
 
@@ -75,8 +76,10 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser = phys_to_virt(args->serialized_data);
+	struct vfio_device *device = vfio_device_from_file(args->file);
 	struct folio *folio = virt_to_folio(ser);
 
+	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_folio(folio);
 	folio_put(folio);
 }
@@ -199,8 +202,11 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
 	struct folio *folio;
 
+	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
+
 	folio = virt_to_folio(phys_to_virt(args->serialized_data));
 	folio_put(folio);
 }
@@ -223,10 +229,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
 
 int __init vfio_pci_liveupdate_init(void)
 {
+	int ret;
+
 	if (!liveupdate_enabled())
 		return 0;
 
-	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret)
+		return ret;
+
+	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+	return ret;
 }
 
 void vfio_pci_liveupdate_cleanup(void)
@@ -234,5 +254,6 @@ void vfio_pci_liveupdate_cleanup(void)
 	if (!liveupdate_enabled())
 		return;
 
+	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));
 	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
 }
-- 
2.52.0.487.g5c8c507ade-goog


