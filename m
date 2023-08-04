Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603476FFF6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHDMJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHDMJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 08:09:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E546A6;
        Fri,  4 Aug 2023 05:09:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPYn5P3Rz67RYs;
        Fri,  4 Aug 2023 20:05:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 13:09:30 +0100
Date:   Fri, 4 Aug 2023 13:09:29 +0100
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
Subject: Re: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Message-ID: <20230804130929.00007dfb@Huawei.com>
In-Reply-To: <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
        <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
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

On Thu, 3 Aug 2023 23:01:27 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> of AER should also own CXL Protocol Error Management as there is no
> explicit control of CXL Protocol error. And the CXL RAS Cap registers
> reported on Protocol errors should check for AER _OSC rather than CXL
> Memory Error Reporting Control _OSC.
> 
> The CXL Memory Error Reporting Control _OSC specifically highlights
> handling Memory Error Logging and Signaling Enhancements. These kinds of
> errors are reported through a device's mailbox and can be managed
> independently from CXL Protocol Errors.
> 
> This change fixes handling and reporting CXL Protocol Errors and RAS
> registers natively with native AER and FW-First CXL Memory Error Reporting
> Control.
> 
> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> 
> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>

I'd be tempted to add a comment on why this returns 0 rather than an
error.  I think that makes sense but it isn't immediately obvious from
the local context.

Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
> v2:
> 	Added fixes tag.
> 	Included what the patch fixes in commit message.
> v3:
> 	Added "Reviewed-by" tag.
> ---
>  drivers/cxl/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..2323169b6e5f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  		return 0;
>  	}
>  
> -	/* BIOS has CXL error control */
> -	if (!host_bridge->native_cxl_error)
> -		return -ENXIO;
> +	/* BIOS has PCIe AER error control */
> +	if (!host_bridge->native_aer)
> +		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)

