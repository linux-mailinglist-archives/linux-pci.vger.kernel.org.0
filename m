Return-Path: <linux-pci+bounces-39398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73DBC0CD1D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AD19A1322
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124022FDC5F;
	Mon, 27 Oct 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1LlDcvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21672FDC43;
	Mon, 27 Oct 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559044; cv=none; b=ap8QGVZSa6mpdZBcLQPoj9BamXJ4fDubxn7G/vA5UZM+GQulIo2f0lLwkj08boyyFwfRnp08OHSiJrZaHkbV99nQ/qdAVxLA4xxqver/fQ7QbV/br9NIFcbFb75LpNrs1mOZ0Y8ZzxaoMUY7NRCNWsHAMNWWhUdRndWvRXDwnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559044; c=relaxed/simple;
	bh=ZwxWW0luOHwrk3YhZSDx0yDOjLl070ZaGpU4yv5QUjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7iUyOkjvCWLs6uTdqUWyFqE2FrEzcLMH9F/1U5mPWSrQSeOl6vgx+EENFFu5EPvUEs4pRsGFZozzSngtf1zFbSRiqCSjZy0gqG4ESChu6TxeUOVvoOgtob4E3yWOjuxmEtBiG7FV23H04i4tIchV33gUv8+7TuL1pqDfHcp6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1LlDcvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFD8C4CEF1;
	Mon, 27 Oct 2025 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559044;
	bh=ZwxWW0luOHwrk3YhZSDx0yDOjLl070ZaGpU4yv5QUjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1LlDcvwTXxW06qjy3XDmvfDvXP91pdPM5d2IXrDmPBJlty0DPUFgh5f9uASxG8/l
	 4Tz6e5zAYP3z9AGRZ/ViAOdnA9KOAsJdt7hEPwImdZDyD3dol1BaLaKyk9cSJuEJsQ
	 ghfk8y/stkNMdQPriW03OqYLVq2Zco52ezqn28Lu+0iQ/lFRl9szPsnGi5W49zxPyg
	 dDwhwleBuFslD4qKGyZl5Ytw0w3bom7sbBtGzHxfBxlc4/tmkc8fnOQtQ4hPKaXbcc
	 7FkjpnHosWZ6xL2icrVdZUHtk33DU+kFN1VgHrHS6vUCG62jTfg2gBpwtyO6ayq1aG
	 5jcceteJqNRUA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH RESEND v2 10/12] X.509: Parse Subject Alternative Name in certificates
Date: Mon, 27 Oct 2025 15:26:00 +0530
Message-ID: <20251027095602.1154418-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
in X.509 certificates.

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 8df3fa60a44f..5942679f125a 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -571,6 +571,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_subjectAltName) {
+		if (ctx->cert->raw_san)
+			return -EBADMSG;
+
+		ctx->cert->raw_san = v;
+		ctx->cert->raw_san_size = vlen;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_keyUsage) {
 		/*
 		 * Get hold of the keyUsage bit string
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
index 37436a5c7526..8e450befe3b9 100644
--- a/include/keys/x509-parser.h
+++ b/include/keys/x509-parser.h
@@ -36,6 +36,8 @@ struct x509_certificate {
 	unsigned	raw_subject_size;
 	unsigned	raw_skid_size;
 	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	const void	*raw_san;		/* Raw subjectAltName in ASN.1 */
+	unsigned	raw_san_size;
 	unsigned	index;
 	bool		seen;			/* Infinite recursion prevention */
 	bool		verified;
-- 
2.43.0


