Return-Path: <linux-pci+bounces-17168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DE9D4F9F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEB1F23176
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F31D90DB;
	Thu, 21 Nov 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDJE/RZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144D1D7E5C
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202612; cv=none; b=DCY7m/ONISc50IBjgaucAQ7lKST5h78Shd4E5w5rOM6L4vr/dLD9Mx8Auk3+C35DXSL+sA7NE3DKf6/QcsmWbj3Y03fP8FkzBMTbJlWiT2SzaBILvdkoYl3vRxc2bHEAhsTlRxAYr/JJjfo2dvn3IeJS+mMLwj3Its/51AHAXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202612; c=relaxed/simple;
	bh=ECq6wpQ0AN0bDXRwRXP6kJXS7nsmVo35sDAj5RbJCJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hv9K0swCA0GjfGc99QFMkHHoHL7CgedFPy/EnPm+siMHQ1r7NivU8fxt9tPH1cfcyA32LCJG6Csvag95nLzJfnAftgwrj0VDFmtq/C4GSesulsOPNnw3ATEj2acNhcG511BrH5Zu8lyHz6YxHhkDngtGTLvGApF6jkmyNt31P0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDJE/RZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3A9C4CECC;
	Thu, 21 Nov 2024 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732202611;
	bh=ECq6wpQ0AN0bDXRwRXP6kJXS7nsmVo35sDAj5RbJCJw=;
	h=From:To:Cc:Subject:Date:From;
	b=eDJE/RZI7YfpoU1Q6lVB0ci9KlpsNdbnis/ZQKsOmU/r5J1pNO2eVrVdfVLAPnqZ1
	 35ANiuKk9beeT22MiDiM5g0RtBdf9OmjPU28Imcq7t+iiH6yi99waxW+ICEMotk0TV
	 FqHFjDcqcxafnDpq2gz+f4fTtLCdNSMfIUpiPIWH+QIgWPOaO9Oe3OgNPZONuiOcsg
	 ZQbabDnan7JGrVr3ZSceMo7Ik3OzDzsZg1kKbp/EL5ImaX5B+pxPQ/kmwIbDiJ5Gql
	 KhCFG4prS45mjGwrOUQxnm6gCCkAgtXF2Giov8fPf4zWc659Yi6SmnRUrhMj0v2+2M
	 ZqUwSvPEg/baQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Date: Thu, 21 Nov 2024 16:23:19 +0100
Message-ID: <20241121152318.2888179-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=cassel@kernel.org; h=from:subject; bh=ECq6wpQ0AN0bDXRwRXP6kJXS7nsmVo35sDAj5RbJCJw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLtA9KezVl7epNl0NLFwfWTOhdMNl0VF6SwyUZzXunJ1 aIL9mw62VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJyPIxMizWm8PH7340ZfKy v6LJwrl+bc8Mo44+OT1d6tezqZOiWkoZ/kr1xW14cFdh2evcg6smiYbL7Xpb9rHnZq9ja8Gu/k1 eq9kB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
This API call handle unaligned addresses seamlessly, if the EPC driver
being used has implemented the .align_addr callback.

This means that pci-epf-test no longer need any special padding to the
buffers that is allocated on the host side. (This was only done in order
to satisfy the EPC's alignment requirements.)

In fact, to test that the pci_epc_mem_map() API is working as intended,
it is important that the host side does not only provide buffers that
are nicely aligned.

However, since not all EPC drivers have implemented the .align_addr
callback, add support for capabilities in pci-epf-test, and if the
EPC driver implements the .align_addr callback, set a new
CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
allocate overly sized buffers on the host side.

For EPC drivers that have not implemented the .align_addr callback, this
series will not introduce any functional changes.


Kind regards,
Niklas


Changes since v1:
-Improved commit message (thank you Frank)
-Renamed CAP_HAS_ALIGN_ADDR to CAP_UNALIGNED_ACCESS (thank you Damien)


Niklas Cassel (2):
  PCI: endpoint: pci-epf-test: Add support for capabilities
  misc: pci_endpoint_test: Add support for capabilities

 drivers/misc/pci_endpoint_test.c              | 21 +++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.47.0


