Return-Path: <linux-pci+bounces-33049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1227B13C4C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9423B3300
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7532701D8;
	Mon, 28 Jul 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS8wbfHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322562701C8;
	Mon, 28 Jul 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710859; cv=none; b=GtFRlqxJKLiwjvkw3Y6+oh8ogNfJ78UOApGBkZj0N7TaWLJkZpTOXmMnrXJelzP6z76WJl/aM5csoxNJtPPoWg1bKty/I4U5kFcC3UGXK/ceJkgaQE7kIn134LayhLdK8A0FYYmknW3+0RS20uJRW29lTAuJsilwOjesDYmRUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710859; c=relaxed/simple;
	bh=tQeo2gHr3WzOtcNTI9kRaE714QohDLHrOKasMXl+XLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukvIclqya2fmHuTC+FBIBacBSOvH/v+FmU1j8s8jl4L5Yr32H3a/8Et1eHTR1o99orSYCOmj+eWmGznSaYgXtvZX5Jf3W2VVDdGItbEqDX3pLcBqyUfzLa5zb2mwOdHMtwRY+XHYx3F6M6cosP1aj4z99vtUQmR3jfH/wtteIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS8wbfHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D468CC116B1;
	Mon, 28 Jul 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710859;
	bh=tQeo2gHr3WzOtcNTI9kRaE714QohDLHrOKasMXl+XLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CS8wbfHd63SixPN09zu+HTRf9TJeLndhmm0Osw+BHGeC7d7LAe+lC5vA7Pzj3eq9O
	 2Ck9Wmd9FjBZvVRR+b/byx1tqKJxQbDc4p0oiO853/EI4Rf52TQEI8Ad0y1T9FOyII
	 b8sSs4ukqHtc5X2P9SMOM5l94X72UtLnvE5J0aNUc3OW3Mjt1S2y1Crhxgm3ip+PLc
	 eQoiFu5lsv0ZCYgWnz3r1RsC3jjIrNoIMuJswt83o1ReiNCuBhqRZrNyLiH1/Rep3U
	 I/mDd7X5zqwZROVTitGUNQW6akS9ixrbkZC+lpnR6vpu/hU+g1viZn/e8prPbJN8zx
	 5JS/inHOtTaeA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH v1 17/38] X.509: Parse Subject Alternative Name in certificates
Date: Mon, 28 Jul 2025 19:21:54 +0530
Message-ID: <20250728135216.48084-18-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
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
index 2ffe4ae90bea..ac8a01c2b9fc 100644
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


