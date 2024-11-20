Return-Path: <linux-pci+bounces-17114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FAF9D3FE2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DF1B3B339
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87514A62A;
	Wed, 20 Nov 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhxe0PTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D814A0A4
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118262; cv=none; b=V77jwDWfCSimXsVhfTwYh0RxRlSPS3MPrBTEYTLHDgMvSSawxnN1zQ3+AIdo63T4pOZiqftcEPuS7iKZLc8+zbT/GqS7s5up15eePxXpE98L1QK3KYQV4/M+wB/+d0cJZBmbTkfOEF+I05ghdrOgHK6cehiz0GJ5uW1jnRdPOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118262; c=relaxed/simple;
	bh=7aDW2NmZSvkRY+mvCb0Uav9QRnkbr0eGw5ih+2SioM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnYw+ocoZpp+MKrZlWmV9swHy1FxrJKA6hk4Tgnn2jcWUFvCxD4TIW/nxZwaAHEL6oSxwyaIl17osm/pMTUyAE9WVW62iknGgGGH6sn4Rbi78oCsqIZNGDCeRJg5+fSOz0idHSfCzqOfPHI3a58/VVF4CDn85oIvxk0lwg48mUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhxe0PTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539ADC4CECD;
	Wed, 20 Nov 2024 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118261;
	bh=7aDW2NmZSvkRY+mvCb0Uav9QRnkbr0eGw5ih+2SioM8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qhxe0PTtSJpr27g5jokcayQ+e7iTIV4CZKEmUHCTxt7fc0Ew1QlatcNuPXRn9d4Et
	 3dVdO2JCYTDpk9MBAEVhii1ZX8yMe+2U1QrUHiUu0uGxM0i8UpqpMLV2zGEzZhDVKp
	 kXBhGElCBoFeF61mXASAV23jLaipXZp6Eo3az1HKic2YU6fLofFDIbywfNGoRD16ze
	 PPigp8qJ4XtljM2ugDSkUKyJjJZ1+hS1CoUno0ckSvafA/uxx3wjKLGjhReJhRPJe4
	 dJ59z0sHi3TF8lXQexHgS3pUM6DIa+WKakMy0o6tdOYt2fiJLNYcwPhzjg38J1n5Ft
	 Mhj92rRxX8n5g==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] PCI endpoint test: Add support for capabilities
Date: Wed, 20 Nov 2024 16:57:31 +0100
Message-ID: <20241120155730.2833836-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=cassel@kernel.org; h=from:subject; bh=7aDW2NmZSvkRY+mvCb0Uav9QRnkbr0eGw5ih+2SioM8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLt2F7dSdr444Z1xX/Lr84f9k3NiwnfMXOmkvlc6QVfE vqNm84/7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE7ugx/BV7LlZ6ZHN4VYZD xaoyFum+ng0JJcee7VzSKBWr/dvqzjeG/xmsC2IUWidKTdtkkpEvH21emhdUmaFjKTR9nd3FOwp NvAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
This API call handle unaligned addresses seamlessly, if the EPC driver
being used has implemented the .align_addr callback.

This means that pci-epf-test does no longer need any special padding
to the buffers that is allocated on the host side. (This was only done
in order to satisfy EPC's alignment requirements.)

In fact, to test that the pci_epc_mem_map() API is working as intended,
it is important that the host side does not allocate only give us buffers
that are nicely aligned.

However, since not all EPC drivers have implemented .align_addr,
add support for capabilities in pci-epf-test, and if .align_addr is
implemented, set a new align_addr capability. If this new align_addr
is set, do not allocate overly sized buffers on the host side.

EPC drivers that have not implemented .align_addr will behave just as
they did before.


Kind regards,
Niklas


Niklas Cassel (2):
  PCI: endpoint: pci-epf-test: Add support for capabilities
  misc: pci_endpoint_test: Add support for capabilities

 drivers/misc/pci_endpoint_test.c              | 21 +++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.47.0


