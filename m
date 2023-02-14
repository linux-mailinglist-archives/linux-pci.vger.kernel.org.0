Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92369627D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjBNLbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 06:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjBNLa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 06:30:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29EC17151;
        Tue, 14 Feb 2023 03:30:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGJn90Xd0z6J74W;
        Tue, 14 Feb 2023 19:26:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 11:30:55 +0000
Date:   Tue, 14 Feb 2023 11:30:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, "Hillf Danton" <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 03/16] cxl/pci: Handle truncated CDAT entries
Message-ID: <20230214113054.00004cb4@Huawei.com>
In-Reply-To: <5b4e23f256b3705360d84eccb9652e4b558a77b5.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <5b4e23f256b3705360d84eccb9652e4b558a77b5.1676043318.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 10 Feb 2023 21:25:03 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> If truncated CDAT entries are received from a device, the concatenation
> of those entries constitutes a corrupt CDAT, yet is happily exposed to
> user space.
> 
> Avoid by verifying response lengths and erroring out if truncation is
> detected.
> 
> The last CDAT entry may still be truncated despite the checks introduced
> herein if the length in the CDAT header is too small.  However, that is
> easily detectable by user space because it reaches EOF prematurely.
> A subsequent commit which rightsizes the CDAT response allocation closes
> that remaining loophole.
> 
> The two lines introduced here which exceed 80 chars are shortened to
> less than 80 chars by a subsequent commit which migrates to a
> synchronous DOE API and replaces "t.task.rv" by "rc".
> 
> The existing acpi_cdat_header and acpi_table_cdat struct definitions
> provided by ACPICA cannot be used because they do not employ __le16 or
> __le32 types.  I believe that cannot be changed because those types are
> Linux-specific and ACPI is specified for little endian platforms only,
> hence doesn't care about endianness.  So duplicate the structs.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
One trivial suggestion.

Glad to see this tightened up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 13 +++++++++----
>  drivers/cxl/cxlpci.h   | 14 ++++++++++++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 11a85b3a9a0b..a3fb6bd68d17 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -547,8 +547,8 @@ static int cxl_cdat_read_table(struct device *dev,
>  
>  	do {
>  		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
> +		struct cdat_entry_header *entry;
>  		size_t entry_dw;
> -		__le32 *entry;
>  		int rc;
>  
>  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> @@ -557,14 +557,19 @@ static int cxl_cdat_read_table(struct device *dev,
>  			return rc;
>  		}
>  		wait_for_completion(&t.c);
> -		/* 1 DW header + 1 DW data min */
> -		if (t.task.rv < (2 * sizeof(u32)))
> +
> +		/* 1 DW Table Access Response Header + CDAT entry */
> +		entry = (struct cdat_entry_header *)(t.response_pl + 1);
> +		if ((entry_handle == 0 &&
> +		     t.task.rv != sizeof(u32) + sizeof(struct cdat_header)) ||
> +		    (entry_handle > 0 &&
> +		     (t.task.rv < sizeof(u32) + sizeof(struct cdat_entry_header) ||

Slight preference for sizeof(*entry)
so that it is clear that we are checking we can do the next check without
getting garbage.

> +		      t.task.rv != sizeof(u32) + le16_to_cpu(entry->length))))
>  			return -EIO;
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
>  					 le32_to_cpu(t.response_pl[0]));
> -		entry = t.response_pl + 1;
>  		entry_dw = t.task.rv / sizeof(u32);
>  		/* Skip Header */
>  		entry_dw -= 1;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 920909791bb9..104ad2b72516 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -62,6 +62,20 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> +struct cdat_header {
> +	__le32 length;
> +	u8 revision;
> +	u8 checksum;
> +	u8 reserved[6];
> +	__le32 sequence;
> +} __packed;
> +
> +struct cdat_entry_header {
> +	u8 type;
> +	u8 reserved;
> +	__le16 length;
> +} __packed;
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);

