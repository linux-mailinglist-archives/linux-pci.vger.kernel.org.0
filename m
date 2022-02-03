Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45A4A898A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiBCRLc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 12:11:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44118 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbiBCRLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 12:11:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82324B8350F;
        Thu,  3 Feb 2022 17:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09989C340E8;
        Thu,  3 Feb 2022 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643908274;
        bh=0T1PX8l3N5+kpFJQ2G3e1jvblpArQwCSGcG+5Ha2rW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pT+7q6bbM5mpD1l386q6kNXft6lRRzlAvvqXVMD4LCNn/CbwgDiLB9PiKvFWVevAv
         9aGjtPtyklCPRRZJ8Xcl7oBPf9+x14Q8KqhtNwVrALB1cSk2G7BLSL2WZORA4djUkZ
         GhJEwAspdhRrLXpVt1Jm2xN3XtWhEzVNyT+Y/2BNTpKuQgMtkZ8KNsWfkvpxN6tawO
         shlB49dHKNOTAWvl5JDsYgEaMBVdMZZwhauK6Wh4fWfAKxY4byYDWmcU/GPXCc5H6b
         HM8FqWVLznEMjoVay+WeAsdCvkW1MTUxeW6vXWJo/BB8QqHEGATLEfeZe4Q+8vn9EJ
         T9CJTqanVsfdw==
Date:   Thu, 3 Feb 2022 11:11:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 01/10] PCI: Add vendor ID for the PCI SIG
Message-ID: <20220203171112.GA103601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-2-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 11:19:43PM -0800, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This ID is used in DOE headers to identify protocols that are defined
> within the PCI Express Base Specification.
> 
> Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143

Please update this citation to PCIe r6.0, sec 6.30.1.1, table 6-32.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
>  
>  #define PCI_VENDOR_ID_LOONGSON		0x0014
>  
> -- 
> 2.31.1
> 
