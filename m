Return-Path: <linux-pci+bounces-213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B07FB3C4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B9B2822E7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A01179AD;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc8TG5Uy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410516416;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58596C433C9;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=i/EHkRtVuPQPs5OIMVcI6ZSMpjBbo9UrT0fH07edjzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gc8TG5UyJ9xcrTjk67G3eNwL38tdLdf5NMSifIzV8q+o4CpN5IWL2j9WEJcMiqMIs
	 pcqQ6UBN8X9Ft6teNQegKrQL5sKl1e0bKPOvO77pHIMTL/F9O8lSVFeSYS6JlCmzqQ
	 4bLqpW5F30uN8aiYqvyBBV6x2ESrOt/mR4KRWJVUCWdzFdhtSlqvPcnAObwVJPzwHO
	 iSctaJFdrns5imocLhcx3C/3aGH14F8A1OTx5kYkJmVEfuJUcmG2P8aWx5DbcTWGJm
	 OgFx07/0N80angxPUpx2esF8c33jk14HftNEJUzZvfScYx0d87nyNyoOC7z2LxEE+q
	 RlKwAeE3Vo5qQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG4-00053z-2x;
	Tue, 28 Nov 2023 09:15:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/6] PCI/ASPM: Add lockdep assert to link state helper
Date: Tue, 28 Nov 2023 09:15:12 +0100
Message-ID: <20231128081512.19387-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a lockdep assert to the locked disable link state helper which
should only be called with a pci_bus_sem read lock held.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d7a3ca555cc1..5dab531c8654 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1090,6 +1090,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
+	lockdep_assert_held_read(&pci_bus_sem);
+
 	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
-- 
2.41.0


