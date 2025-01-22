Return-Path: <linux-pci+bounces-20214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07440A189D9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 03:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3FE3A4EDE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 02:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB352E628;
	Wed, 22 Jan 2025 02:25:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6866148857;
	Wed, 22 Jan 2025 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512702; cv=none; b=jAfDcMYIvhHjTSeRgS4DYg9R8hBc6EXQwXe2dOThj7dC+9X+PjeioRf1s6Mi4vnEHJPpomzUKogF7D4hfK6hnHYFZX1BNCP5lc4AD/7SdqcEmdlDC2svzygn063p4HrzT3IYB7RKPiG5eNnRD7trIFNP08cb025UH+BOBiR5sF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512702; c=relaxed/simple;
	bh=FM7Z9l2VSkl6cp6dkU9cBS8hXVDU4nsxcEZVla+EyCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2bj1GWDWshbIPcTTIheur1hY0x5E9qmGHFOfXnze/kpeBv4aiVDTu/ZMBFrjKoRZxeV1kwHJgM5JVNzKIFzNZLA/pQ3MbNq/Qw+Vhv0hTyGljs2dVqXLojjuFeMFEI3FHgI9CDhPLVVbNxnuMJUJM+pcliJFLDE+eIV3gfvpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Jan 2025 11:24:52 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5EFC82009097;
	Wed, 22 Jan 2025 11:24:52 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Jan 2025 11:24:52 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 69399C3C1E;
	Wed, 22 Jan 2025 11:24:51 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=8F=AB=CDski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/3] Fix some issues related to an interrupt type in pci_endpoint_test
Date: Wed, 22 Jan 2025 11:24:43 +0900
Message-Id: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series solves some issues about global "irq_type" that is used for
indicating the current type for users.

In addition, avoid an unexpected warning that occur due to interrupts
remaining after displaying an error caused by devm_request_irq().

Changes since v1:
- Divide original patch into two
- Add an error message example
- Add "pcitest" display example
- Add a patch to fix an interrupt remaining issue

Kunihiko Hayashi (3):
  misc: pci_endpoint_test: Avoid issue of interrupts remaining after
    request_irq error
  misc: pci_endpoint_test: Fix disyplaying irq_type after request_irq
    error
  misc: pci_endpoint_test: Fix irq_type to convey the correct type

 drivers/misc/pci_endpoint_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1


