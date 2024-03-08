Return-Path: <linux-pci+bounces-4643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A1875EE3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C577B21105
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AAE1CD09;
	Fri,  8 Mar 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="EgUGfN7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27B4F8A2
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884492; cv=none; b=mJYxTDUO6ixPwwRdzWSbM9DW+ea5Ac1Yp+kP12Pt874trsC5MWAZC3QosBrL3aC7ASL4VuWDl9i1t7HZNI4MzFoGtna4mr+zZZkFUVJ2spC49EgU8i5XunnJ58dBSLwJO2gS0ylGga/wWVdwVaJWNpWpzwUXqQRjNIWxpCK9Jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884492; c=relaxed/simple;
	bh=7sGFa73YvUsh56tBOSlWGiWVpCL5H1QzUUu9I4pxqQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmzFPEkmSc5L0WFzL3B0y0LZVoGrlSoVHWJSzMBgTIwAIPM+ZM3Pps5HYT1tyssRXE6dMhmyAri7E46f+mbeWdBMOtEUrHRZKDw6uT7xYVXVpJFphXPKMIaODWudLwvI5UfIZ1xHwroPltiI74VpNpdkt5MncO7tpEHZzPkU+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=EgUGfN7r; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4465B4412E;
	Fri,  8 Mar 2024 08:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709884488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mn7k/r/QoyP6k/ZG5Wnx3NURMydMDOnQ2y5n082MRkk=;
	b=EgUGfN7rOt3i9PfZeVQpNLbk7BrQRyPqBb2SLLg9lX/gH6keP7IERFElzM3cJQURDZy1rA
	UJIW1XIATdmN14zlNIQoKOXKq49lVOATuuxGZ6YWXQZY/JBLpuIFcLf73lUb0IU4IWpFd2
	PW6sfBjJKOMAyVYqxhs7+vp0HYlz2tyQ4uUJG2FqXoBALrJcArEYcdKBRA73ygz7EH0j4n
	Q5ZsthsqdywDWXe2o5RnwEvTn3PHZqk+taSvUJ1yfhZB+YDnVYkt6gRFhu//AOdmol5sYR
	jgJ7dBRQa6rZP3FZ3mm82tHa/Fx3vZA096Jtz8LeztdxRWSrjCTTVSVebK+IKg==
Message-ID: <73ce2e075b909881b6396cacefeb2746f38ef618.camel@exaion.com>
Subject: [PATCH 2/2] Add better warnings about invalid VPD data
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hannes Reinecke <hare@suse.de>
Date: Fri, 08 Mar 2024 08:54:47 +0100
In-Reply-To: <91f9ddd07cc2a426bf7c0dbebcb31229f5f7dcf9.camel@exaion.com>
References: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
	 <0132edfec66a6bd413823d43ccdf1c4d6aae2b60.camel@exaion.com>
	 <91f9ddd07cc2a426bf7c0dbebcb31229f5f7dcf9.camel@exaion.com>
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

Some Mellanox Connect-X 3 cards have firmware bugs which return
unfinished VPD data. This change helps to diagnose such issues
with clear warning messages.
---
 drivers/pci/vpd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index daaa208c9d9c..fc38a611dd3e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -87,10 +87,11 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 				return off;
 		}
 	}
+	pci_warn(dev, "missing VPD_STIN_END at offset %zu\n", off + 1);
 	return PCI_VPD_SZ_INVALID;
=20
 error:
-	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
+	pci_warn(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
 		 header[0], size, off, off =3D=3D 0 ?
 		 "; assume missing optional EEPROM" : "");
 	return PCI_VPD_SZ_INVALID;
--=20
2.39.2



