Return-Path: <linux-pci+bounces-4602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305578753E8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EC61C250F9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0012F398;
	Thu,  7 Mar 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="XAo0XeB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E512EBE0
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827776; cv=none; b=bgo5EkQGGyfHlzMI11aWs2oaZS9zlRIZGqpTTP5a4NZiJx+HFdhtU56I6lIU5nM+VI+TgPT45XNiQ+ESRF8wSaoDz9gNw5xKi6ihGAD2yFoH3RafXnT/dpncue7TFJhIAQDnchgn3hOglwTtSlQUD11zGGrCk+7Vv9rgYU0hqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827776; c=relaxed/simple;
	bh=IW4P7UufERURwOpQebAlBISYHnckkjDTY2Krd0NhZoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQeIqxSlHAZVump2Onis7MIS0QkqRDgChu9EBjMO9Saw7APYRo8kBdgRUOpX4bhh3XCc2RJGmQw8XH3ZzcKOIibwOALJELrvj8tM+UtDB0nSwvES1G3+lh3h4rtENmC7y/xyKi7VnpwCwgEYKJErfsNsP35LaCNjKtVG+yk47qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=XAo0XeB7; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53F6244109;
	Thu,  7 Mar 2024 17:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709827769; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f6o04XfVZSwQLJurPnYWjB6YzlW8GQVmm6e1ooSnit4=;
	b=XAo0XeB7ENcMeEFmMhbEqMC9sOMtpQrqo2rHH0JBevZO2+9OMw9SWPR6jpTZy3bUTbQVg3
	KcWiZ7i8mzr0kWZ9FcF57xa4p19dKU7wXbfUlQnbMCZgC76IlnKhI7/zds3Bb+6daaCT+e
	IPQY7Llv0uiCWficEfozirN4OJmKRo04F8J6P5CG5sSNqNQF35AO/XyNiW4/SJOIFN/vpz
	V78mP6afEyoWnhQA1OxQHQzjp4akPb9f0MGy1e8jzfltRDheK1x48MJq3h0jmkCuFrZaAp
	NW2bxuO6LciRgMV05sKv/aE5ysqcOZcQlt0A6yZUYEyP4G0fWj+iVZbOQN68OQ==
Message-ID: <0132edfec66a6bd413823d43ccdf1c4d6aae2b60.camel@exaion.com>
Subject: [PATCH 1/2] Revert "PCI/VPD: Allow access to valid parts of VPD if
 some is invalid"
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 07 Mar 2024 17:09:27 +0100
In-Reply-To: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
References: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
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
                        if (pci_read_vpd_any(dev, off + 1, 2,
&header[1]) !=3D 2) {
                                pci_warn(dev, "failed VPD read at
offset %zu\n",
                                         off + 1);
-                               return off ?: PCI_VPD_SZ_INVALID;
+                               return PCI_VPD_SZ_INVALID;
                        }
                        size =3D pci_vpd_lrdt_size(header);
                        if (off + size > PCI_VPD_MAX_SIZE)
@@ -87,13 +87,13 @@ static size_t pci_vpd_size(struct pci_dev *dev)
                                return off;
                }
        }
-       return off;
+       return PCI_VPD_SZ_INVALID;
=20
 error:
        pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset
%zu%s\n",
                 header[0], size, off, off =3D=3D 0 ?
                 "; assume missing optional EEPROM" : "");
-       return off ?: PCI_VPD_SZ_INVALID;
+       return PCI_VPD_SZ_INVALID;
 }
=20
 static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
--=20
2.39.2


