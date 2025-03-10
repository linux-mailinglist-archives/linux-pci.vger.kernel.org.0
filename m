Return-Path: <linux-pci+bounces-23299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89FA59030
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94921188D132
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC919F49E;
	Mon, 10 Mar 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0j8zJyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606017A2E7
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600146; cv=none; b=H7aEj6zs2rpIKuuikg9q1DT9rbuE4/iuM+5AA68wksytGu5lga+CKEyroxo1MHyaxFs0jmu6ak9feHfPtXBHcV90zH/te0kBl0LZtO9Hik3X4XS0EfNgZLU1hJEnjFdY4L5foeJl+xFqEUTjdY9O8gMJNw3QhBYNwewYSC8zOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600146; c=relaxed/simple;
	bh=8mizgwqRIlps/wmW9ZM0NYMHVTcUp4zqPKkWqvWVlHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2hizSdUnM+qc4tvbELPq5yGId2ksp7ibGBwV33AukRd0EnI1Mtjo80k7EYlIISUP5ShlnJPtAyacnoCKx+voMqeD7WozDUHKWVDJnWdYCLoD6pX8BjrB5YuXVALfwjB/vQnDryfmFFl4+S9G0jQUIoPOOxYkyUYzz+StC/oQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0j8zJyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F2C4CEEE;
	Mon, 10 Mar 2025 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600146;
	bh=8mizgwqRIlps/wmW9ZM0NYMHVTcUp4zqPKkWqvWVlHY=;
	h=From:To:Cc:Subject:Date:From;
	b=W0j8zJyQnTnLhtRRmPnPFvthCiQvnRGus0WMEpK4ugXr+VLHzjChy3idi5KDBrJJl
	 jk5zvLHvo3pFsU1/QOvj0TVFYYXESs+UEr7ukQuAOfjXkFxTAPuO5PrN8Ug2/WgCxb
	 Ozrr696XGiWCAkh9pYk5BAMJyYfIR0jFiP4Cq//17QuWL7Xz4+EVx/FAO2Ljv8e69p
	 9RB3zWhsmdRWaji4L6mV1eOsiFHZzo4vEE4AP8fyNzPZXp7NlVHbvuDg8z4/kJ2lfm
	 AORYmcfNmYLR3BlvXkVxK96qYm0loYK6DQqgQMil33DPAiK4lQVcSYfejpQwzrpTg2
	 woibjJLH7nzyA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/2] PCI: dw-rockchip: hide broken ATS cap in EP-mode
Date: Mon, 10 Mar 2025 10:48:26 +0100
Message-ID: <20250310094826.842681-4-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=cassel@kernel.org; h=from:subject; bh=8mizgwqRIlps/wmW9ZM0NYMHVTcUp4zqPKkWqvWVlHY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPbc3yPjXTveR4We+FcuaiI2fYLj/1P7NH6zf3DhmFy MrF7wu7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARPldGhnVmrCoB/zZ6rOFP Mp11+O5rXq7AV4brz5jvjElYKj6hWZbhr0D0nNfaORk2R5ZmufW5PUrjFWDi5roizybWbt/iy1T ODwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

Address Translation Services (ATS) is broken on rk3588 when running the
PCIe controller in Endpoint Mode.

This causes IOTLB invalidation timeout errors on the host side when using
and rk3588 in Endpoint Mode, and you are unable to run pci_endpoint_test.

Solve this by hiding the ATS capability.
With this, we do not get any IOTLB invalidation timeouts, and we can run
pci_endpoint_test successfully.


Changes since v2:
-Added missing EXPORT_SYMBOL_GPL().


Niklas Cassel (2):
  PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
  PCI: dw-rockchip: Hide broken ATS capability

 .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++
 3 files changed, 73 insertions(+)

-- 
2.48.1


