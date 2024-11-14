Return-Path: <linux-pci+bounces-16748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4769C891D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7949AB31171
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FFB1F77B8;
	Thu, 14 Nov 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyDJqIlh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C61F6688
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582217; cv=none; b=bUfEYj/wF+3iL+ZZnGeYmKeO/l9QAa5fle7GR8sqiSlfXAsuBC4kVFhwcPVJJpQx9dQMkMMf0ZRY7TEInrayraRyKcn77OUmLKdIDbrL409zexpS3kQhQRgY6Ijt3RTlAV8dRmEJ5fWVg4Rht6yMwCTOH8V2YK9as8UkrbHc3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582217; c=relaxed/simple;
	bh=cU/CTbA3tK+TShcjaAlz9mTOWSXtmcbEwFf3BTPJajc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s48T5Zc0jkgSWmk/Bg53FXQsDfwKefi7y5C/T3zK7awj12k2ez3r5DLpjhJXYVD/nZ+L9H6DcW3kOODfrLxHM3uugrY9uhzS9BAu2OI+92+7Zoe33PPvJde0mHC2SCaK2AgKADjHpEdfNjmaH/cTkoG4DN6a8rC/1ry3TT5aaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyDJqIlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FACFC4CECD;
	Thu, 14 Nov 2024 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582217;
	bh=cU/CTbA3tK+TShcjaAlz9mTOWSXtmcbEwFf3BTPJajc=;
	h=From:To:Cc:Subject:Date:From;
	b=KyDJqIlhHYPLsnUNVQwMJeal4WOvwpTixSEv//pwYHffyUt6byB/v1579gT+NB0rE
	 p/j1s+2lIrZ66bI6jLlsF/K2GQ9SCjtmrZo9lMRCCF5QYlLhy7qVYHFbj0GTyIcklQ
	 +GFkTf4rxfYraHrwpzP5ZWb+O2sqSoLZCKwN5LuxJx55ZqpqiAXrEqPaYfIBX7hAAy
	 Rp3k+VncftHYtsSWhmuf+3zZ+dCLzv3fKiB2PCUgdkXHEzXA0CF5g9R7navlB5Iqz+
	 UA+8xa/TtgupGzYrMztOavfaoS6bSj4o/9FViGhMXrxKRdObt9oQ/PTuAsuFSgli9y
	 F5YKYoFfdhDRA==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI endpoint additional pci_epc_set_bar() checks
Date: Thu, 14 Nov 2024 12:03:26 +0100
Message-ID: <20241114110326.1891331-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=cassel@kernel.org; h=from:subject; bh=cU/CTbA3tK+TShcjaAlz9mTOWSXtmcbEwFf3BTPJajc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJNb/z7VM36pWeZ6X3BiL/G3VZv/c8z+Ge6GfYWF4sum tinzSLeUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlUGjH8T4hQMqp7yhxUskFQ tfXevFLPHRUlJd6ppbGZZyt+df/WZWT46Rfj4brv0vEO0U9syvEnNRZP+z538mqn4wviNzxsK47 lBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series adds some extra checks to ensure that can not program the iATU
with an address that we did not intend to use.

These checks would have given resulting in an error when testing some of
the earlier revisions of Frank's doorbell patches (which did not handle
fixed BARs properly).

With these checks in place, we will hopefully avoid unnecessary debugging
in the future.


Kind regards,
Niklas


Niklas Cassel (3):
  PCI: artpec6: Implement dw_pcie_ep operation get_features
  PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
  PCI: dwc: ep: Improve alignment check in dw_pcie_prog_ep_inbound_atu()

 drivers/pci/controller/dwc/pcie-artpec6.c       | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c |  8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c    |  5 +++--
 drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
 drivers/pci/endpoint/pci-epc-core.c             | 11 +++++++++--
 5 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.47.0


