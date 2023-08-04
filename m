Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AD770004
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHDMPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDMO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 08:14:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E646A6;
        Fri,  4 Aug 2023 05:14:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPhL3SYBz6J6sL;
        Fri,  4 Aug 2023 20:11:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 13:14:55 +0100
Date:   Fri, 4 Aug 2023 13:14:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v3 3/3] cxl/pci: Replace host_bridge->native_aer with
 pcie_aer_is_native()
Message-ID: <20230804131454.00000622@Huawei.com>
In-Reply-To: <20230803230129.127590-4-Smita.KoralahalliChannabasappa@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
        <20230803230129.127590-4-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Aug 2023 23:01:29 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Use pcie_aer_is_native() to determine the native AER ownership as the
> usage of host_bride->native_aer does not cover command line override of
> AER ownership.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>
I hope there aren't systems getting this wrong but make sense to support
same override as for other cases.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> 	Replaced pcie_aer_is_native() at a later stage for automated
> 	backports.
> v3:
> 	Added more context to commit message.
> 	Added "Reviewed-by" tag.
> ---
>  drivers/cxl/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2323169b6e5f..44a21ab7add5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
> @@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  	}
>  
>  	/* BIOS has PCIe AER error control */
> -	if (!host_bridge->native_aer)
> +	if (!pcie_aer_is_native(pdev))
>  		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);

