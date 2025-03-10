Return-Path: <linux-pci+bounces-23305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19363A59251
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2563A62DE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BFC227E89;
	Mon, 10 Mar 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bghbTDUv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B728EA
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605053; cv=none; b=SROw7AI8EFsNbfp17NTuxrGD+k6IvYePFQlLJV+qRqgwmSthKOki4YtqJrAvZpD7xvYyqoSAQv+gAhB74NXaDf2AflsPPJJ7a1GmVrA71eVuJguxXW0Nvgk4a7U82SUZUDY2XWLDjXpBqlIQGKkk+kTr15rrYAWRcgDS6uyl57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605053; c=relaxed/simple;
	bh=UK/dCYky07X9+cp+PfUtaAqR6aGqK+DrT/lV5+WgypE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqZYpBjxF5870QsQktlN6j5xR3Xt9FVoNhLy+z4n5YdFl2Js+AeLFKfO5B+WTqBsOvyZRFNzvU8cwhGZS071BzhR81i+anXRJDhTWBKtCxF0he95n9653hEARi9b+jNncAcycIHM/ka6kXS9x7hIchG2ybzTfsIto+mCyCm5tPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bghbTDUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBADC4CEEE;
	Mon, 10 Mar 2025 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605052;
	bh=UK/dCYky07X9+cp+PfUtaAqR6aGqK+DrT/lV5+WgypE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bghbTDUvdBTMC1/YnO4xPbBG1KwmHpj0boowSM1yTjG37U5KRq/78cxrwZzci/CvV
	 4A977dBOsrB9q9ebHwPxeqEg8VLjKvPVQep6RT9Fn1J76EIsW73N3iyZ0GXir7m7RS
	 XYYoHQ0eUQIRmBlapH5+pXEPzvRQxLIi3KEUAqJt3DK3ne9Bglt9Sco2Hib48EEWkL
	 97CbXtYw7HpXun9Xc70y/BzoXptJq/5pBpbi5Hg86xdWywSquymGPajy85gatanVds
	 WW7EtYrwDkff8KSNu8WhwR8jN0gId+u3r8sTOCpj4qxSeD0L3bgH4kme7wfyJTLHAu
	 v2SsdnCSvMRtg==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/7] PCI: endpoint: pcitest: Add IRQ_TYPE_* defines to UAPI header
Date: Mon, 10 Mar 2025 12:10:18 +0100
Message-ID: <20250310111016.859445-10-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111016.859445-9-cassel@kernel.org>
References: <20250310111016.859445-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=cassel@kernel.org; h=from:subject; bh=UK/dCYky07X9+cp+PfUtaAqR6aGqK+DrT/lV5+WgypE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZjHvGSlv3d0ueSUX0srNlx+fLDhfuOs69eUJls5X PkroXggpaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATCehj+J/is+CqmZQg39+0 /htng7M7rOwPfPNvrSxdlb+R0YPlejsjw45HHvvlRRbvepQaXpbyXjmJq/P7YzupO+vW9hzjcWr u5QMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

These IRQ_TYPE_* defines are used by both drivers/misc/pci_endpoint_test.c
and tools/testing/selftests/pci_endpoint/pci_endpoint_test.c.

Considering that both the misc driver and the selftest already includes
the pcitest.h UAPI header, it makes sense for these IRQ_TYPE_* defines
to be located in the pcitest.h UAPI header.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/uapi/linux/pcitest.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index acd261f49866..304bf9be0f9a 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -23,6 +23,11 @@
 #define PCITEST_BARS		_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
+#define PCITEST_IRQ_TYPE_UNDEFINED	-1
+#define PCITEST_IRQ_TYPE_INTX		0
+#define PCITEST_IRQ_TYPE_MSI		1
+#define PCITEST_IRQ_TYPE_MSIX		2
+
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
 struct pci_endpoint_test_xfer_param {
-- 
2.48.1


