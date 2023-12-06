Return-Path: <linux-pci+bounces-594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3319807B94
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 23:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB771C211B3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59848364;
	Wed,  6 Dec 2023 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhTQWFdf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD32EAF9
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 22:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733F9C433C7;
	Wed,  6 Dec 2023 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902558;
	bh=AslNTUin8A7oCwTbelMTlAy+9pa9TfyKW5/4wcsAbRw=;
	h=From:To:Cc:Subject:Date:From;
	b=IhTQWFdf1AXHLSIWjF8+LMVdOY/5SERFx7VHdptcjqC5f3sD9K8qN+kR3vE7GcFgG
	 gEBVlOIO7gMo4k7JDoUCuW8I9sOv0gLMn01oGMlG1VPeKc+pg0t7UwDaRewoWRqZyC
	 O3kx/NF9hOlB254Ym2oAJvxF6ET38tC2rVnGFWMBbMzBtx8NfLUJBZSBAbf+DRq9qm
	 mzE9fi6SsMhhlmsLgGJ0dznNA8Ar+5yTYo8hgdG4mSZDQ3Ee1qACRaOmyggBByEu3d
	 86VrMNRTNBp4kfuavMKXyzcuGrocPZVocOyVXu/0r+rwTU+wDy1buiwv6DhcOlk2ko
	 CPbeQ6AVLgrww==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/AER: Clean up logging
Date: Wed,  6 Dec 2023 16:42:28 -0600
Message-Id: <20231206224231.732765-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up some minor AER logging issues:

  - Log as "Correctable errors", not "Corrected errors"

  - Decode the Requester ID when we couldn't find detail error info

Bjorn Helgaas (3):
  PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
  PCI/AER: Decode Requester ID when no error info found
  PCI/AER: Use explicit register sizes for struct members

 drivers/pci/pcie/aer.c | 19 ++++++++++++-------
 include/linux/aer.h    |  8 ++++----
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.34.1


