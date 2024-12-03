Return-Path: <linux-pci+bounces-17561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DF9E136F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 07:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B8160156
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2455166F1A;
	Tue,  3 Dec 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmob39ja"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12F3398B
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207944; cv=none; b=szBymRnPxZQuzbzTejayYivH9wCl+F/k/hI4bmnhEtkgZahH933FBb4OC+SIV635nispa29t8RjyNouNzekYO2bK7DRpWyRu5G3MtO/0IDvHQL9ZSKMlDvlsa+aiAUXATvtgOnxUAbKkhTLgo0vOWsEC4NiQPGxyKIp9i4Tefcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207944; c=relaxed/simple;
	bh=1FV1mjjkaeC0KktChbJ04RgLZisPX8PCVf4tmXpJXXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XrcAqHxdyvR3jIslHuot6ZroeihYMGPUNVGCGsNBNhEHKaix4P281YsfnwNC1ZnREosChZXXQa6v7nG7Ruz3lf2mR9Txfy4z1cTd3geLgNDYRZ00WLyqB6bE3ixQHebA0w4zvBdqFfUjNbCglOt5baiNC1zZejIx8Bw6sVTmeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmob39ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87788C4CECF;
	Tue,  3 Dec 2024 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733207944;
	bh=1FV1mjjkaeC0KktChbJ04RgLZisPX8PCVf4tmXpJXXw=;
	h=From:To:Cc:Subject:Date:From;
	b=Pmob39jaV0iuxyxAWy2J/OMW/BlG+MA9Y7nakFQAnV3KZQUVFRmNfyACfhjaJFzbl
	 /gTT3ZuJb1WUqr0dRHSWuGg7mDV/jsoh28A7Fub6Uu4GwwXBYZr33F8sVM40ZwRxy/
	 DEmYBGQ+FGsnTa4QrGeUNiJ2lrffG3pzmyjXFYYSvtwLGHPRt7iYMTiIkhz19SGkuR
	 6FjWa7j5235my7B6y3mlxoGLHCuJo2we/NMk5JCvHPWw60F/NUTfilua5VT5cQEwu8
	 cs8OY1A0Un73C/+5AKWgov7PVkdMoLIG4DW5C8feyCjJbAum7r3gjlSFAGqFLSfACD
	 aiVqJ4WfevZiA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/2] PCI endpoint test: Add support for capabilities
Date: Tue,  3 Dec 2024 07:38:52 +0100
Message-ID: <20241203063851.695733-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=cassel@kernel.org; h=from:subject; bh=1FV1mjjkaeC0KktChbJ04RgLZisPX8PCVf4tmXpJXXw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL9llfHzebIl0h7m7ysM4/7h5RBxipuIYcV8WqT+X+Hy VgofGXuKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwESOpTL8s9RTZdRPCjFpDDt7 /dPsW6+iJU9qZTQpXPlzjNfc+NGeQIa/og3Gv65N7V695R57yZwZO89Ot9ysmLHdoN3Isz41tWc VAwA=
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


Changes since v2:
-Picked up tags
-Changed debug print to dump the CAPS register instead of having a print
 per capability.


Niklas Cassel (2):
  PCI: endpoint: pci-epf-test: Add support for capabilities
  misc: pci_endpoint_test: Add support for capabilities

 drivers/misc/pci_endpoint_test.c              | 19 +++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.47.1


