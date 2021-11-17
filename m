Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A51454F98
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhKQVxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhKQVxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 16:53:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DE4260F9C;
        Wed, 17 Nov 2021 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637185845;
        bh=12bBRp3Kd6xWyPSV8o/1HgC8rO/LOUpDVmkQv2UHwo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uauHmzYP2wtOVm9oDx0SC25cqFjVjFFoa961tjye7z5h14oscIl1LW9Iy+FzE6svJ
         HNKwr78f4gOfXeLQFNsaongaeoK8rgoGOXU8hFuErQ7KWsT9aA+91XssNL2Bg3dZ89
         elbf+sCZoDv2cSrWBfcN+T1CLK+y+B8y33lS1ue6w5WZver6q6qgOEbFD57D10dho7
         EkMoAXp2r9KiJSeaAfWFk+BEVOvRBH5r7jRaixkEVbuFk0ECtgjbR3H4roTHd+/h4/
         m3DicuMrlBjf7tkVMvz20JX8O96J5s7uQS3Kfdxl1R5qiUg9ktG7X4phfGna20SuWw
         VDtj0TRTAmNSg==
Date:   Wed, 17 Nov 2021 15:50:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Add vendor ID for the PCI SIG
Message-ID: <20211117215044.GA1777828@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105235056.3711389-2-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 05, 2021 at 04:50:52PM -0700, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This ID is used in DOE headers to identify protocols that are defined
> within the PCI Express Base Specification.
> 
> Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..849f514cd7db 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,7 @@
>  #define PCI_CLASS_OTHERS		0xff
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> +#define PCI_VENDOR_ID_PCI_SIG		0x0001

We should probably also use this in pci_bus_crs_vendor_id().

>  #define PCI_VENDOR_ID_LOONGSON		0x0014
>  
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
