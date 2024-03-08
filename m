Return-Path: <linux-pci+bounces-4642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B16875EE0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 08:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65661F2328E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465DF4F5FC;
	Fri,  8 Mar 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="YIjUYNVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECD4F891
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884429; cv=none; b=RGzrxTnpDmnKhZkBCfoQEAWf//aP7BtWwkILGj6nqKAC/GC9soaPBXP9GuWE0an+h6CXowxCEMoA4Ng0SZhsJxEUKDrPXcuwLvNDZjD+7r9vagOdRy05bZmTyIPB9/lqyxSarBnghrCAcJJ7gfAaloOUCLLGU12Wcsk8Lrj2ZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884429; c=relaxed/simple;
	bh=gIIK0cIRaOIWfuLOCxilE4/f+ZCgbDQ+QIzQzyg5KjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTbEbZGaItbsW5spAAWnEkHet83pRcUQi4rHfsZyEnPtnF8hIbzi+6+qbVOAq4xoDEtiAko7ng3gdUz3TVsC1viEDeBhBxXkymH985BdPmpWkfUDy1Yrtpk0kob6GSPzL0Ie+t2YtJgO5CBk8SiPV9tf3Io0UtT9YIjIA9ihL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=YIjUYNVt; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69DBC440ED;
	Fri,  8 Mar 2024 08:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709884423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BMdC0BxFsO5uiu8+V08flk2OAAF9FVpf/fAGgMtvYKA=;
	b=YIjUYNVtEkekg7UF3oEiO5dH1j5M+ClQ5aHvScXwR3mJLUEDSthftkq3OFrvEr1wI1Z/cX
	mT/vYcroFhq442JSFQj473tN3/Sy9sbpbn+sqhtfW7GoTvK8PxpcCbrS+CjAPxNYt0b2Fe
	JrzhHxZ1vwMIhg5MPOb7XRoihghQeQKYKWp0iK3iBPaObziCM9H7oYmZVYJgNPUfr6OHyZ
	GcIkqjvIvR+6Y8xtY16GqZGsSDR5PjYIwBmsuinbPELyAodb27NHK51BDXWpMgS5NU0kJn
	Ori5x2aja7WAzdzWX0/9sp/pCibrOipjzoUCAAj/2rXHgjkisXe9Pxc4iHAcQQ==
Message-ID: <91f9ddd07cc2a426bf7c0dbebcb31229f5f7dcf9.camel@exaion.com>
Subject: [PATCH 1/2] Revert "PCI/VPD: Allow access to valid parts of VPD if
 some is invalid"
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hannes Reinecke <hare@suse.de>
Date: Fri, 08 Mar 2024 08:53:39 +0100
In-Reply-To: <0132edfec66a6bd413823d43ccdf1c4d6aae2b60.camel@exaion.com>
References: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
	 <0132edfec66a6bd413823d43ccdf1c4d6aae2b60.camel@exaion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

(Sorry about the resend, this time with correct patch formatting.)

When a device returns invalid VPD data, it can be misused by other
code paths in kernel space or user space, and there are instances
in which this seems to cause memory corruption.

There is no sensible reason why the kernel would provide userspace
or drivers with invalid and potentially dangerous data.

This reverts commit 5fe204eab174fd474227f23fd47faee4e7a6c000.
---
 drivers/pci/vpd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 485a642b9304..daaa208c9d9c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -68,7 +68,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 			if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) !=3D 2) {
 				pci_warn(dev, "failed VPD read at offset %zu\n",
 					 off + 1);
-				return off ?: PCI_VPD_SZ_INVALID;
+				return PCI_VPD_SZ_INVALID;
 			}
 			size =3D pci_vpd_lrdt_size(header);
 			if (off + size > PCI_VPD_MAX_SIZE)
@@ -87,13 +87,13 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 				return off;
 		}
 	}
-	return off;
+	return PCI_VPD_SZ_INVALID;
=20
 error:
 	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
 		 header[0], size, off, off =3D=3D 0 ?
 		 "; assume missing optional EEPROM" : "");
-	return off ?: PCI_VPD_SZ_INVALID;
+	return PCI_VPD_SZ_INVALID;
 }
=20
 static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
--=20
2.39.2



