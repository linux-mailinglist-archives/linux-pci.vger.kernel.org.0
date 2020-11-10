Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626422ADCAD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 18:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKJRQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 12:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKJRQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 12:16:44 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DDC206D8;
        Tue, 10 Nov 2020 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605028603;
        bh=g/UWtySntj16F43aRh9osgw8ibcoGZIQgYjcZ4dRZ/0=;
        h=Date:From:To:Cc:Subject:From;
        b=sOsfS/v3tIbGJ9z5HSUAmLVMZmmN68GHN+BXSSoOpF+E92YJBlQcVMG0lz8UEWVxO
         UoLJL67+dpk61sBIbdQTRgKrxTaWQ1/BDVtLPOlIvbN6X1q7Exsp7w3KURDOxKe/bD
         UPveXzS3J6dDkTxVl6gnKM1MHV0ttMb/V+8IjPOQ=
Date:   Tue, 10 Nov 2020 11:16:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: New Defects reported by Coverity Scan for Linux
Message-ID: <20201110171641.GA679781@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

New Coverity complaint about v5.10-rc3, resulting from 9fff3256f93d
("PCI: dwc: Restore ATU memory resource setup to use last entry").

I didn't try to figure out if this is real or a false positive, so
just FYI.

----- Forwarded message from scan-admin@coverity.com -----

Date: Mon, 09 Nov 2020 11:13:37 +0000 (UTC)
From: scan-admin@coverity.com
To: bjorn@helgaas.com
Subject: New Defects reported by Coverity Scan for Linux
Message-ID: <5fa924618fb3b_a62932acac7322f5033088@prd-scan-dashboard-0.mail>


** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
/drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()


________________________________________________________________________________________________________
*** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
/drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
590     
591     		/* Get last memory resource entry */
592     		resource_list_for_each_entry(tmp, &pp->bridge->windows)
593     			if (resource_type(tmp->res) == IORESOURCE_MEM)
594     				entry = tmp;
595     
>>>     CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "entry".
596     		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
597     					  PCIE_ATU_TYPE_MEM, entry->res->start,
598     					  entry->res->start - entry->offset,
599     					  resource_size(entry->res));
600     		if (pci->num_viewport > 2)
601     			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
