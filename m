Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18CD6697C2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 13:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbjAMMza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbjAMMzA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 07:55:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650DAE48;
        Fri, 13 Jan 2023 04:41:43 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntgyg69p0z6J9YS;
        Fri, 13 Jan 2023 20:41:31 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 12:41:40 +0000
Date:   Fri, 13 Jan 2023 12:41:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 5/8] cxl/mem: Trace Memory Module Event Record
Message-ID: <20230113124139.000034c0@Huawei.com>
In-Reply-To: <20221216-cxl-ev-log-v6-5-346583105b30@intel.com>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
        <20221216-cxl-ev-log-v6-5-346583105b30@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 09 Jan 2023 11:42:24 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Typo inline.  With that fixed
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index b6321cfb1d9f..ebb4c8ce8587 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -439,6 +439,149 @@ TRACE_EVENT(cxl_dram,
>  	)
>  );
>  
> +/*
> + * Memory Module Event Record - MMER
> + *
> + * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
> +#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
> +#define CXL_MMER_LIFE_USED_CHANGE		0x02
> +#define CXL_MMER_TEMP_CHANGE			0x03
> +#define CXL_MMER_DATA_PATH_ERROR		0x04
> +#define CXL_MMER_LAS_ERROR			0x05

CXL_MMER_LSA_ERROR

> +#define show_dev_evt_type(type)	__print_symbolic(type,			   \
> +	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
> +	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
> +	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
> +	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
> +	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
> +	{ CXL_MMER_LAS_ERROR,			"LSA Error"		}  \
> +)
