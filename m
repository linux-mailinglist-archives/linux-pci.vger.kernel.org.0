Return-Path: <linux-pci+bounces-4603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F1F8753F3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3328818C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68912DDB9;
	Thu,  7 Mar 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="mzGBe4SD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7112FB23
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827851; cv=none; b=gqKvkLRWKkXd/9kQVxeBbpWBu/w8POIqdap8EAWnCtPJQTRN5DkIfVaoVlFri730nQqRVT0BAYXU41jB0PTvsm+hM1HnlzDRz9P0eqX/LamBtFk3eZaxZF5DO0MxhaQ4FdLeKxiSlpFFL15aUhWXyHDQdP2FoPA6vg9uBCvOakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827851; c=relaxed/simple;
	bh=upIFTatwDagvNzJYZFB4IaVrlROkF0ASELX/671dWHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXnFx4nKOtn+dWLZIATiiabFwdVT/g/l0vMBJziOQL2xL1ellp4LfMPNfBN3wlMrHGjdW1rqaq+b3Rp8pRcYs9Jvx24ADPYwvV8f4p62CFiDqcvPb9M0IQFafO40R9ErcgzE8h+fCZmqH9AMiTv+Lbds35m+E+VghgAsG7xVxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=mzGBe4SD; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E1B64412B;
	Thu,  7 Mar 2024 17:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709827846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m8U7poDu3qqEW+mNNxq49GL3/UNmH5Nci5YiMPbS/xE=;
	b=mzGBe4SD64u2GSqsqy1qSUFXA92n1/UrNUaRzQkKx5DG+2LcZHbByWtjW/u+Oxm9nzpyS4
	0T+jxMA/Q9NMPzpM0GeTez8fxWn+3hG/dufeQRNq/xsIPzQVIKp4QKUnxcNS7VePcTwITX
	yt5SVk8v16q/EcDMzjizM8/2HL0Z1/jGCd9G+sG8SJO7ABinOdntrC2tbyeq32n0KS+8fr
	lUBbi6tWwAe5kSv36bfGyk2xYagDerTPBO4YnsNorCffg7FTC9nByuFu33NQbFUetMSX16
	3Mz3vZFpsaTbTBnQEg+PRwbiLYsJpcJc6PUswVvyw7FVKcgnY9PAOou6rhfmyA==
Message-ID: <6fcc9a22e89a11dec1f769d74482592c681e526c.camel@exaion.com>
Subject: [PATCH 2/2] Add better warnings about invalid VPD data
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 07 Mar 2024 17:10:46 +0100
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
+       pci_warn(dev, "missing VPD_STIN_END at offset %zu\n", off + 1);
        return PCI_VPD_SZ_INVALID;
=20
 error:
-       pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset
%zu%s\n",
+       pci_warn(dev, "invalid VPD tag %#04x (size %zu) at offset
%zu%s\n",
                 header[0], size, off, off =3D=3D 0 ?
                 "; assume missing optional EEPROM" : "");
        return PCI_VPD_SZ_INVALID;
--=20
2.39.2


