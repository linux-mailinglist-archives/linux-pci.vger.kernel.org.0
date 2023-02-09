Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E4690CF3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBIP3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBIP3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:29:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929238B55;
        Thu,  9 Feb 2023 07:29:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLN26nfsz6J9fS;
        Thu,  9 Feb 2023 23:27:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:29:12 +0000
Date:   Thu, 9 Feb 2023 15:29:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 14/18] cxl: Wait Memory_Info_Valid before access memory
 related info
Message-ID: <20230209152912.00001100@Huawei.com>
In-Reply-To: <167571668726.587790.16814881883553586342.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571668726.587790.16814881883553586342.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Feb 2023 13:51:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
> 
> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
> Low registers are valid. The bit must be set within 1 second of reset
> deassertion to the device. Check valid bit before we check the
> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
> the memory info is valid for consumption.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Fix?

> ---
>  drivers/cxl/core/pci.c |   25 +++++++++++++++++++++++--
>  drivers/cxl/port.c     |   20 ++++++++++----------
>  2 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 54ac6f8825ff..79a1348e7b98 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -111,11 +111,32 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	int d = cxlds->cxl_dvsec;
>  	bool active = false;
>  	u64 md_status;
> +	u32 temp;
>  	int rc, i;
>  
> -	for (i = media_ready_timeout; i; i--) {
> -		u32 temp;
> +	/* Check MEM INFO VALID bit first, give up after 1s */
> +	i = 1;
> +	do {
> +		rc = pci_read_config_dword(pdev,
> +					   d + CXL_DVSEC_RANGE_SIZE_LOW(0),
> +					   &temp);
> +		if (rc)
> +			return rc;
>  
> +		active = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		if (active)
> +			break;
> +		msleep(1000);
> +	} while (i--);

If HDM_Count > 1, there is a second range to check and I think we
need both to be valid here.



> +
> +	if (!active) {
> +		dev_err(&pdev->dev,
> +			"timeout awaiting memory valid after 1 second.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Check MEM ACTIVE bit, up to 60s timeout by default */
> +	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
>  		if (rc)
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d72e38f9ae44..03380c18fc52 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -99,6 +99,16 @@ static int cxl_port_probe(struct device *dev)
>  		if (rc)
>  			return rc;
>  
> +		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_await_media_ready(cxlds);
> +		if (rc) {
> +			dev_err(dev, "Media not active (%d)\n", rc);
> +			return rc;
> +		}
> +
>  		if (port->cdat.table) {
>  			rc = cdat_table_parse_dsmas(port->cdat.table,
>  						    cxl_dsmas_parse_entry,
> @@ -117,16 +127,6 @@ static int cxl_port_probe(struct device *dev)
>  			if (rc)
>  				dev_dbg(dev, "Failed to do QoS calculations\n");
>  		}
> -
> -		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> -		if (rc)
> -			return rc;
> -
> -		rc = cxl_await_media_ready(cxlds);
> -		if (rc) {
> -			dev_err(dev, "Media not active (%d)\n", rc);
> -			return rc;
> -		}
>  	}
>  
>  	rc = devm_cxl_enumerate_decoders(cxlhdm);
> 
> 

