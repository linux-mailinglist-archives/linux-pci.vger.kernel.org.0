Return-Path: <linux-pci+bounces-13679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67798BA8D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBC2284E49
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F411BF80A;
	Tue,  1 Oct 2024 11:03:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FD1BF7E6;
	Tue,  1 Oct 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780626; cv=none; b=PxHTarO0bGDS4LqbIWOwMesQsPz7rgGwLB6bL0URsCq42aVi6Uzs1+suUy1PSUc2nuVe+/nDguTzpv3aItTha2t3PJceFfZs1LU3Rgt2Cizg9m9YuBT9Ok7n4MH5MNYdQzAQ8E+69XGyhO49rtnHMsXTex24Vw2SzZ6CYURoDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780626; c=relaxed/simple;
	bh=Uc7eU7l0AwozFueAWyfQnQwHemTU8GzdeDPUgQrcgx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuRgTTH2BuFz9fFP3e8g4S6OT8sjFPFqZFRAn/HF8jRjo8r+eRLlrgEIPTH7bGPjVYlfh0XeW1rv9s4sW5ZXrgvsQ6bIeHjs6IebeFFpCB5f8M1CSZ5X/N8po1qwQK3I8F8KF53Pf+eFSmYxd7VbvSdVNwrdyECfikoDp5VUm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9943D300002A6;
	Tue,  1 Oct 2024 13:03:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 935E43972E6; Tue,  1 Oct 2024 13:03:41 +0200 (CEST)
Date: Tue, 1 Oct 2024 13:03:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <ZvvXDQSBRZMEI2EX@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
 <Zvf7xYEA32VgLRJ6@wunner.de>
 <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvW1ua2UjwHIOEN@wunner.de>

On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > -       if (pci_get_dsn(pdev) != ctrl->dsn)
> > > +       dsn = pci_get_dsn(pdev);
> > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > +           dsn != ctrl->dsn)
> > >                 return true;
> > 
> > In my case, the pciehp_device_replaced() returns true from this final check.
> > And these are the values I got
> > dsn = 0x00000000, ctrl->dsn = 0x7800AA00
> > dsn = 0x00000000, ctrl->dsn = 0x21B7D000
> 
> Ah because pci_get_dsn() returns 0 if the device is gone.
> Below is a modified patch which returns false in that case.

Sorry, forgot to include the patch:

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e6..957c320 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev)
 static bool pciehp_device_replaced(struct controller *ctrl)
 {
 	struct pci_dev *pdev __free(pci_dev_put);
+	u64 dsn;
 	u32 reg;
 
 	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
 	if (!pdev)
+		return false;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
+	    reg != (pdev->vendor | (pdev->device << 16)))
 		return true;
 
-	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
-	    reg != (pdev->vendor | (pdev->device << 16)) ||
-	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
 	    reg != (pdev->revision | (pdev->class << 8)))
 		return true;
 
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+	    pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) == 0 &&
+	    !PCI_POSSIBLE_ERROR(reg) &&
+	    reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16)))
 		return true;
 
-	if (pci_get_dsn(pdev) != ctrl->dsn)
+	if ((dsn = pci_get_dsn(pdev)) &&
+	    !PCI_POSSIBLE_ERROR(dsn) &&
+	    dsn != ctrl->dsn)
 		return true;
 
 	return false;

