Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA55605A5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiF2QUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiF2QUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:20:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783A2338B9;
        Wed, 29 Jun 2022 09:20:07 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY67X61l6z6H6jL;
        Thu, 30 Jun 2022 00:17:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:20:05 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:20:04 +0100
Date:   Wed, 29 Jun 2022 17:20:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 23/46] tools/testing/cxl: Add partition support
Message-ID: <20220629172003.00004e30@Huawei.com>
In-Reply-To: <165603887411.551046.13234212587991192347.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603887411.551046.13234212587991192347.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:47:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In support of testing DPA allocation mecahinisms in the CXL core, the
> cxl_test environment needs to support establishing and retrieving the
> 'pmem partition boundary.
> 
> Replace the platform_device_add_resources() method for delineating DPA
> within an endpoint with an emulated DEV_SIZE amount of partitionable
> capacity. Set DEV_SIZE such that an endpoint has enough capacity to
> simultaneously participate in 8 distinct regions.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c      |    7 +-----
>  drivers/cxl/cxlmem.h         |    7 ++++++
>  tools/testing/cxl/test/cxl.c |   40 +--------------------------------
>  tools/testing/cxl/test/mem.c |   51 ++++++++++++++++++++++--------------------
>  4 files changed, 36 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index dd438ca12dcd..40e3ccb2bf3e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -716,12 +716,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>   */
>  static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>  {
> -	struct cxl_mbox_get_partition_info {
> -		__le64 active_volatile_cap;
> -		__le64 active_persistent_cap;
> -		__le64 next_volatile_cap;
> -		__le64 next_persistent_cap;
> -	} __packed pi;
> +	struct cxl_mbox_get_partition_info pi;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index db9c889f42ab..eee96016c3c7 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -314,6 +314,13 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +struct cxl_mbox_get_partition_info {
> +	__le64 active_volatile_cap;
> +	__le64 active_persistent_cap;
> +	__le64 next_volatile_cap;
> +	__le64 next_persistent_cap;
> +} __packed;
> +
>  struct cxl_mbox_get_lsa {
>  	__le32 offset;
>  	__le32 length;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 599326796b83..c396f20a57dd 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -582,44 +582,6 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  #define SZ_512G (SZ_64G * 8)
>  #endif
>  
> -static struct platform_device *alloc_memdev(int id)
> -{
> -	struct resource res[] = {
> -		[0] = {
> -			.flags = IORESOURCE_MEM,
> -		},
> -		[1] = {
> -			.flags = IORESOURCE_MEM,
> -			.desc = IORES_DESC_PERSISTENT_MEMORY,
> -		},
> -	};
> -	struct platform_device *pdev;
> -	int i, rc;
> -
> -	for (i = 0; i < ARRAY_SIZE(res); i++) {
> -		struct cxl_mock_res *r = alloc_mock_res(SZ_256M);
> -
> -		if (!r)
> -			return NULL;
> -		res[i].start = r->range.start;
> -		res[i].end = r->range.end;
> -	}
> -
> -	pdev = platform_device_alloc("cxl_mem", id);
> -	if (!pdev)
> -		return NULL;
> -
> -	rc = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
> -	if (rc)
> -		goto err;
> -
> -	return pdev;
> -
> -err:
> -	platform_device_put(pdev);
> -	return NULL;
> -}
> -
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
> @@ -722,7 +684,7 @@ static __init int cxl_test_init(void)
>  		struct platform_device *dport = cxl_switch_dport[i];
>  		struct platform_device *pdev;
>  
> -		pdev = alloc_memdev(i);
> +		pdev = platform_device_alloc("cxl_mem", i);
>  		if (!pdev)
>  			goto err_mem;
>  		pdev->dev.parent = &dport->dev;
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index b81c90715fe8..aa2df3a15051 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -10,6 +10,7 @@
>  #include <cxlmem.h>
>  
>  #define LSA_SIZE SZ_128K
> +#define DEV_SIZE SZ_2G
>  #define EFFECT(x) (1U << x)
>  
>  static struct cxl_cel_entry mock_cel[] = {
> @@ -25,6 +26,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
> +		.effect = cpu_to_le16(0),
> +	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
>  		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
> @@ -97,42 +102,37 @@ static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  
>  static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
> -	struct platform_device *pdev = to_platform_device(cxlds->dev);
>  	struct cxl_mbox_identify id = {
>  		.fw_revision = { "mock fw v1 " },
>  		.lsa_size = cpu_to_le32(LSA_SIZE),
> -		/* FIXME: Add partition support */
> -		.partition_align = cpu_to_le64(0),
> +		.partition_align =
> +			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
> +		.total_capacity =
> +			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
>  	};
> -	u64 capacity = 0;
> -	int i;
>  
>  	if (cmd->size_out < sizeof(id))
>  		return -EINVAL;
>  
> -	for (i = 0; i < 2; i++) {
> -		struct resource *res;
> -
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -		if (!res)
> -			break;
> -
> -		capacity += resource_size(res) / CXL_CAPACITY_MULTIPLIER;
> +	memcpy(cmd->payload_out, &id, sizeof(id));
>  
> -		if (le64_to_cpu(id.partition_align))
> -			continue;
> +	return 0;
> +}
>  
> -		if (res->desc == IORES_DESC_PERSISTENT_MEMORY)
> -			id.persistent_capacity = cpu_to_le64(
> -				resource_size(res) / CXL_CAPACITY_MULTIPLIER);
> -		else
> -			id.volatile_capacity = cpu_to_le64(
> -				resource_size(res) / CXL_CAPACITY_MULTIPLIER);
> -	}
> +static int mock_partition_info(struct cxl_dev_state *cxlds,
> +			       struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_partition_info pi = {
> +		.active_volatile_cap =
> +			cpu_to_le64(DEV_SIZE / 2 / CXL_CAPACITY_MULTIPLIER),
> +		.active_persistent_cap =
> +			cpu_to_le64(DEV_SIZE / 2 / CXL_CAPACITY_MULTIPLIER),
> +	};
>  
> -	id.total_capacity = cpu_to_le64(capacity);
> +	if (cmd->size_out < sizeof(pi))
> +		return -EINVAL;
>  
> -	memcpy(cmd->payload_out, &id, sizeof(id));
> +	memcpy(cmd->payload_out, &pi, sizeof(pi));
>  
>  	return 0;
>  }
> @@ -221,6 +221,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_LSA:
>  		rc = mock_get_lsa(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_PARTITION_INFO:
> +		rc = mock_partition_info(cxlds, cmd);
> +		break;
>  	case CXL_MBOX_OP_SET_LSA:
>  		rc = mock_set_lsa(cxlds, cmd);
>  		break;
> 

