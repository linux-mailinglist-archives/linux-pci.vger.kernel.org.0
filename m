Return-Path: <linux-pci+bounces-14777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6D9A238A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804551C25A52
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD11DD55F;
	Thu, 17 Oct 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMWwZUIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B91DD552
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171266; cv=none; b=e1Owx9EZqQanMhDkPyWg5MI5glfkQwh2P85ijb7kX+C9MKUKlcsZLBA6KWM3kjmwI34S4i1stBE+JmJT8HsyWwqVpzQOJXo7csAXKRo4hyG5AN/+zcLkW1kX2JrAfp3CNBexLvzNZ7L7bu5BnLlSFelKC362Nnn09OSwcm4psw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171266; c=relaxed/simple;
	bh=E3hPpcm2gqsla6kHHs+1e9co94CmXLO+fIC2XuT7frU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMYtKpZZBXl8HqrJt7kHU4zSQfbQj+i766RpHPhXQKO0kDNULaq72BXXvVfUhhmto5BfF3qbdQdcAJBrJoKeHcv2ww0fXtNdfQmIdpaQyTDhFK27S/GpTafPpNnWJv29c+xeorZiTr0LsV2vx5ZEIg3NY5ZNCUfowsdy8+tThIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMWwZUIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35EC4CEC3;
	Thu, 17 Oct 2024 13:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729171265;
	bh=E3hPpcm2gqsla6kHHs+1e9co94CmXLO+fIC2XuT7frU=;
	h=From:To:Cc:Subject:Date:From;
	b=FMWwZUIGoUw6FJ2RDMyzcLb8JAqDPNdbdqaXSdNflKLv4uK0VnsIPLXos9IHdW1tl
	 eHHjWPqErVDj+zCa0Sg4TCJN+0+msU4et409oZLT9Yj+U9kc/7K5Dq39FG5/ZoLqiN
	 xNGcBzth37RKgebwJ9X2+wiqpQkFWCn1BELyy/5n2PvGSgLc+u8EBjDrMudvrJ8+yp
	 ImNhRpynK+4ogoZWx7buHwAxLbE0i3L/toYtJxvE5lwN008+qFnoPk3TQw5Zlb+Xhf
	 IYWNJNPhqnYKVsd63QlaB+ziMPbiNPeRyB2qmeIJaYKX/6mgAQ3SgIwr3D6PZnZnTW
	 kpLSSOwjywI7g==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/2] PCI: dwc: ep: Minor alignment cleanups
Date: Thu, 17 Oct 2024 15:20:53 +0200
Message-ID: <20241017132052.4014605-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=402; i=cassel@kernel.org; h=from:subject; bh=E3hPpcm2gqsla6kHHs+1e9co94CmXLO+fIC2XuT7frU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIF+U1qL/wPM/a4vO7tjHOXGN/4BBxT/LbL7DanhWDos d16jydGd5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiNtMY/ocFbmNPud/C/kjg BcPCgxem26odvHcsVibk1ctDU+YZrHzH8M+4QSX+UGLu4xdPxB+8f9VZcDbP8cGB5wwRG+2WdJU H8DEBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Here comes minor cleanups related to the new address alignment APIs.

Kind regards,
Niklas

Niklas Cassel (2):
  PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
  PCI: dwc: ep: Use align addr function for
    dw_pcie_ep_raise_{msi,msix}_irq()

 .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.47.0


