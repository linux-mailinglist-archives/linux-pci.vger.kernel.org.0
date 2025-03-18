Return-Path: <linux-pci+bounces-24033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17325A6715E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3407AB1B4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8E206F3E;
	Tue, 18 Mar 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfYdJfsJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F5202997
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294082; cv=none; b=WZypFQnuDDzWyLbdMbdBdj1nXqKKftvhsrOIS7L0mMu40vJFNddxnMbdaCu9gXeSYCGVak8UHg+A6A14AqYkM3b3m4/UwEeriF99R8Nx/hUpozo4HhGvIK3YO+pJ4c/du2KYCwe24BcTR4z1AxDO8M/N+5UU/YjDOqueZ7hLf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294082; c=relaxed/simple;
	bh=Hn3a50caPjHwEhvgOzgY5BJZ5MSlTQ1RdiNpAAsMLwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KS2PL1vePfkN/Yp3uSMyxqTk4z/gTSLfMgWhnH3o6KW2F5zDl4QjhP4HCPdXJi0FAbD9kvCgQOGG66vt33wtA8L7IModHURRE8MsHnTmMPDkJBYXkiPBX8t5iersnwenzZWTvlkNp1KQ1gdCv+rqFH8mgqJ1KAnn49K9vaglGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfYdJfsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BE6C4CEDD;
	Tue, 18 Mar 2025 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294081;
	bh=Hn3a50caPjHwEhvgOzgY5BJZ5MSlTQ1RdiNpAAsMLwk=;
	h=From:To:Cc:Subject:Date:From;
	b=bfYdJfsJs0Q+qzysBFRQ1uPJsrV3Z+UPxI8i7Qdral8j+qT8ZGBCZQeYyqVHvrs/N
	 Y9E9P+oKg/8gGSof7z4vNRCKlbRmqsDn/A31iLkn3mrAA5OGPgwiOEfB/0BjsuF+d8
	 1AJHnoXPrWRr86icY78hOIxhlhG5xJG83dlMOLxiZ3cw1I2mQ7P/UqSOUrN4gHbUji
	 JpLC9oULNDA8Gfr0ETHfThi2EuGfDQ3EBp50TQDSPK1iYA1HuD2CO/We/XeNpCfLBX
	 b15gn6Me2VTDix2FGDajUxMCKtT9BKUipv3sCBxrbe1DDde6rr1vwV9bVmfvmkFcUU
	 +/zt3+kGJiqBA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/4] pci_endpoint_test: Let PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Date: Tue, 18 Mar 2025 11:33:31 +0100
Message-ID: <20250318103330.1840678-6-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=cassel@kernel.org; h=from:subject; bh=Hn3a50caPjHwEhvgOzgY5BJZ5MSlTQ1RdiNpAAsMLwk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvev/a2jLPaTfv/qbC0qDTql/PMZx+k2WzkmPGtAP3l y/bmXTSuqOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATYVrPyLB57eelApOzNea8 83KtNtzlVhWj2VEq+4Sx6XdB7aMZEkyMDMe3vEr9qvC42YVx/VK/p7GHxZpYfuwvPrsy75LcZ83 7e3kA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

From recent feedback from Mani, he did not like PCITEST_IRQ_TYPE_AUTO,
thus rework the solution and let PCITEST_{READ,WRITE,COPY} set the IRQ
type themselves.


Kind regards,
Niklas

Niklas Cassel (4):
  Revert "misc: pci_endpoint_test: Add support for
    PCITEST_IRQ_TYPE_AUTO"
  misc: pci_endpoint_test: Fetch supported IRQ types in CAPS register
  misc: pci_endpoint_test: Let PCITEST_{READ,WRITE,COPY} set IRQ type
    automatically
  selftests: pci_endpoint: Remove PCITEST_SET_IRQTYPE ioctls for
    read/write/copy

 drivers/misc/pci_endpoint_test.c              | 138 +++++++++---------
 include/uapi/linux/pcitest.h                  |   1 -
 .../pci_endpoint/pci_endpoint_test.c          |   9 --
 3 files changed, 68 insertions(+), 80 deletions(-)

-- 
2.48.1


