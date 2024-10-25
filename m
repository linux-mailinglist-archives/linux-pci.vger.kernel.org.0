Return-Path: <linux-pci+bounces-15380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F999B1291
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FC28303C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81172217F30;
	Fri, 25 Oct 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iMsHf9hE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAE1C878B
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895300; cv=none; b=KawLXCEyZig3293zPQ1gsRlrB/4aCdFjPtiEpO86oQ0i05Iam7EoTTY+6dnKmYFUWHWIP/INOrE2nsuDqGOV7hH5s1nxaS0TogWAwWbE8UrR6IUzcioVOL8dHcsTTqi9lQ4vDEiBhHC2xSY1GotU4gNJqr1mnUPKlK23/m53wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895300; c=relaxed/simple;
	bh=0eK/dd6OJXpr5ijnO/WQrIcOI/U0EkgCaFbRu/g0KmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyxGK7xh8V/bJWpD9Nw64IdpY/dFBmrjLAKwvfO7/PUlUCmzbZThI1zFPUJeh2U9SlFx7NvyMD057vYux8ek1XoOUj9l01GU+eJWJFVNu7ixBuqRyta2dgpSdeqwtf55bwqW2+Goq5CLmy1Civm9fNHXNKUmns6fG8O67JDDrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iMsHf9hE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49PMRRxS026387
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aXD3TDOgPWtnboGM/tkJTMJR/y3aBAYtg8PQxmzSvG8=; b=iMsHf9hEyUPY
	RedtMN+6ahq7wDEUZWhYCU19K8wFNZDPVGGxCcEj0ylXU2d5dkjzRmr96na35dIw
	0R7jeATTsvBqLP2LOamdtkEl4ywSAZ5thUDQizxzbsn3SKn2VcPTdO/TVl4dyOYo
	apPTAkSMcl9tWqM3OIP5pab9Y1EfWrmGcizPTxPe1jlRQunHMCZdUQEpPLsz0odp
	OAEH9bGvKmP816M+sVR3WheuvWtGD4iklNylREVuzQ6Eo4z0Nm2xGA71AKXW58PD
	HD/vF5pRiFcEI+ahWfhSYTh7qPaK3i/Fh2c0Fq9uAi19xlupfH6Y9h3sqqo1nxeL
	xrK6Ou0zJA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42gm4x8045-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:28:17 -0700 (PDT)
Received: from twshared4570.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 22:28:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1EE4D147715FC; Fri, 25 Oct 2024 15:27:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>
CC: <ameynarkhede03@gmail.com>, <raphael.norwitz@nutanix.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Date: Fri, 25 Oct 2024 15:27:55 -0700
Message-ID: <20241025222755.3756162-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OsIuDG4t4fGGhdquziis7OEg4a1U9c7d
X-Proofpoint-GUID: OsIuDG4t4fGGhdquziis7OEg4a1U9c7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

If a reset is issued to a running device with a driver that didn't
register the notification callbacks, the driver may be unaware of this
event and have an inconsistent view of the device's state. Log a warning
of this event because there's nothing else indicating the event occured,
which could be confusing when debugging such situations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 338dfcd983f1e..bbf12d4998269 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5158,6 +5158,8 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
 	 */
 	if (err_handler && err_handler->reset_prepare)
 		err_handler->reset_prepare(dev);
+	else if (dev->driver)
+		pci_warn(dev, "resetting");
=20
 	/*
 	 * Wake-up device prior to save.  PM registers default to D0 after
@@ -5191,6 +5193,8 @@ static void pci_dev_restore(struct pci_dev *dev)
 	 */
 	if (err_handler && err_handler->reset_done)
 		err_handler->reset_done(dev);
+	else if (dev->driver)
+		pci_warn(dev, "reset done");
 }
=20
 /* dev->reset_methods[] is a 0-terminated list of indices into this arra=
y */
--=20
2.43.5


