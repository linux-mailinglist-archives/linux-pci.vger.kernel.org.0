Return-Path: <linux-pci+bounces-29563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D3AD77D4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998407B250B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10B29A323;
	Thu, 12 Jun 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dPq9n5FS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3E299A82;
	Thu, 12 Jun 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744786; cv=none; b=Slzm3cvswmQTUhG2mRs868laL8v8enBEGkunhYDo+tJL1KeWbTORgGi4KS44IVRA1GmjC3cnJC8YSCubyXrlp3LyOR9DBdYjRIcSY9oCyol4+r48jAlV10NFLu8CnTrHxsfiecY5rmESyFuJLFY4EV3W7EBpuNLdoTe54Bppe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744786; c=relaxed/simple;
	bh=zAVkyIooyMat1eNJwc2FV9L0fbEJZLL7QPWVbExBqdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufT3jeZqm/Cet3hIEWe2D3kwKL2ZUMTsnUbyvFtj8mlRQwKuN/1naYUwEsBQdmMd0v2ziMX1T2wTj+0uRJQ7yeFJgCPLiXsUpwJGQzPTq9HGz4x2snaD3dv4xXA5i9OCFjM7fJFjBEOv6AymZnsltfsQ9YDJMHhqXNt2WCw4+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dPq9n5FS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7r
	ztfc6dZ+PrkFfJa9/o6oD1yqpDmBSs0eJuIxIy4h4=; b=dPq9n5FSzlngOtGcPJ
	zIsC2FrZzSRhp05F2FiO5sOc03biHtqOkujDa61eWjdwVW6FLa7ZueuE6FRv+aJL
	UCPHeauLIPw+rqzC21XayVFKwJWwbL1aWmkv+lZtwcrhgA/rq5C55sqG3Uuy2mGi
	Qx55kVS3xkVB2VhyDYW22DnTE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3J19t_EpodUoJHw--.37531S2;
	Fri, 13 Jun 2025 00:12:30 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: Simplify boolean condition returns in debugfs
Date: Fri, 13 Jun 2025 00:12:26 +0800
Message-Id: <20250612161226.950937-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J19t_EpodUoJHw--.37531S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy5Ar48Cr48Kr47AF45Awb_yoW8Kr45p3
	y8ZFWFyFs0ya45ZFs3A3WfZF1Skr93AF1DJasxta4xu3W2gFsrWr1DA34a934ftrWUWr17
	Ka1xAFWxAr1ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEl1vDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxdqo2hK9tiWLAABsq

Replace redundant ternary conditional expressions with direct boolean
returns in PTM visibility functions. Specifically change this pattern:

    return (condition) ? true : false;

to the simpler:

    return condition;

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index c67601096c48..6f438a36f840 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -814,14 +814,14 @@ static bool dw_pcie_ptm_context_update_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_EP_TYPE;
 }
 
 static bool dw_pcie_ptm_context_valid_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_RC_TYPE;
 }
 
 static bool dw_pcie_ptm_local_clock_visible(void *drvdata)
@@ -834,35 +834,35 @@ static bool dw_pcie_ptm_master_clock_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_EP_TYPE;
 }
 
 static bool dw_pcie_ptm_t1_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_EP_TYPE;
 }
 
 static bool dw_pcie_ptm_t2_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_RC_TYPE;
 }
 
 static bool dw_pcie_ptm_t3_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_RC_TYPE;
 }
 
 static bool dw_pcie_ptm_t4_visible(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
 
-	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+	return pci->mode == DW_PCIE_EP_TYPE;
 }
 
 const struct pcie_ptm_ops dw_pcie_ptm_ops = {

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


