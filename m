Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C16320D7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKULjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiKULjI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:39:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548D13D02;
        Mon, 21 Nov 2022 03:37:47 -0800 (PST)
Received: from frapeml100008.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NG50d1zJkz6H7YQ;
        Mon, 21 Nov 2022 19:35:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 12:37:45 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 11:37:44 +0000
Date:   Mon, 21 Nov 2022 11:37:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rostedt@goodmis.org>, <terry.bowman@amd.com>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v3 08/11] cxl/pci: add tracepoint events for CXL RAS
Message-ID: <20221121113743.000075b6@Huawei.com>
In-Reply-To: <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
        <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Fri, 18 Nov 2022 10:08:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add tracepoint events for recording the CXL uncorrectable and correctable
> errors. For uncorrectable errors, there is additional data of 512B from
> the header log register (CXL spec rev3 8.2.4.16.7). The trace event will
> intake a dynamic array that will dump the entire Header Log data. If
> multiple errors are set in the status register, then the
> 'first error' field (CXL spec rev3 v8.2.4.16.6) is read from the Error
> Capabilities and Control Register in order to determine the error.
> 
> This implementation does not include CXL IDE Error details.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
With the stuff Steven raised tidied up this looks good to me now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> ---
>  drivers/cxl/pci.c          |    2 +
>  include/trace/events/cxl.h |  110 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9428f3e0d99b..0f36a5861a7b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -13,6 +13,8 @@
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
>  
>  /**
>   * DOC: cxl pci
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..f8e95d977133
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_EVENTS_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define CXL_HEADERLOG_SIZE		SZ_512
> +#define CXL_HEADERLOG_SIZE_U32		SZ_512 / sizeof(u32)
> +
> +#define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> +#define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
> +#define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
> +#define CXL_RAS_UC_CACHE_DATA_ECC	BIT(3)
> +#define CXL_RAS_UC_MEM_DATA_PARITY	BIT(4)
> +#define CXL_RAS_UC_MEM_ADDR_PARITY	BIT(5)
> +#define CXL_RAS_UC_MEM_BE_PARITY	BIT(6)
> +#define CXL_RAS_UC_MEM_DATA_ECC		BIT(7)
> +#define CXL_RAS_UC_REINIT_THRESH	BIT(8)
> +#define CXL_RAS_UC_RSVD_ENCODE		BIT(9)
> +#define CXL_RAS_UC_POISON		BIT(10)
> +#define CXL_RAS_UC_RECV_OVERFLOW	BIT(11)
> +#define CXL_RAS_UC_INTERNAL_ERR		BIT(14)
> +#define CXL_RAS_UC_IDE_TX_ERR		BIT(15)
> +#define CXL_RAS_UC_IDE_RX_ERR		BIT(16)
> +
> +#define show_uc_errs(status)	__print_flags(status, " | ",		  \
> +	{ CXL_RAS_UC_CACHE_DATA_PARITY, "Cache Data Parity Error" },	  \
> +	{ CXL_RAS_UC_CACHE_ADDR_PARITY, "Cache Address Parity Error" },	  \
> +	{ CXL_RAS_UC_CACHE_BE_PARITY, "Cache Byte Enable Parity Error" }, \
> +	{ CXL_RAS_UC_CACHE_DATA_ECC, "Cache Data ECC Error" },		  \
> +	{ CXL_RAS_UC_MEM_DATA_PARITY, "Memory Data Parity Error" },	  \
> +	{ CXL_RAS_UC_MEM_ADDR_PARITY, "Memory Address Parity Error" },	  \
> +	{ CXL_RAS_UC_MEM_BE_PARITY, "Memory Byte Enable Parity Error" },  \
> +	{ CXL_RAS_UC_MEM_DATA_ECC, "Memory Data ECC Error" },		  \
> +	{ CXL_RAS_UC_REINIT_THRESH, "REINIT Threshold Hit" },		  \
> +	{ CXL_RAS_UC_RSVD_ENCODE, "Received Unrecognized Encoding" },	  \
> +	{ CXL_RAS_UC_POISON, "Received Poison From Peer" },		  \
> +	{ CXL_RAS_UC_RECV_OVERFLOW, "Receiver Overflow" },		  \
> +	{ CXL_RAS_UC_INTERNAL_ERR, "Component Specific Error" },	  \
> +	{ CXL_RAS_UC_IDE_TX_ERR, "IDE Tx Error" },			  \
> +	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
> +)
> +
> +TRACE_EVENT(cxl_aer_uncorrectable_error,
> +	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev_name, status, fe, hl),
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(u32, status)
> +		__field(u32, first_error)
> +		__dynamic_array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +	),
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->status = status;
> +		__entry->first_error = fe;
> +		/*
> +		 * Embed the 512B headerlog data for user app retrieval and
> +		 * parsing, but no need to print this in the trace buffer.
> +		 */
> +		memcpy(__get_dynamic_array(header_log), hl, CXL_HEADERLOG_SIZE);
> +	),
> +	TP_printk("%s: status: '%s' first_error: '%s'",
> +		  __get_str(dev_name),
> +		  show_uc_errs(__entry->status),
> +		  show_uc_errs(__entry->first_error)
> +	)
> +);
> +
> +#define CXL_RAS_CE_CACHE_DATA_ECC	BIT(0)
> +#define CXL_RAS_CE_MEM_DATA_ECC		BIT(1)
> +#define CXL_RAS_CE_CRC_THRESH		BIT(2)
> +#define CXL_RAS_CE_CACHE_POISON		BIT(3)
> +#define CXL_RAS_CE_MEM_POISON		BIT(4)
> +#define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(5)
> +
> +#define show_ce_errs(status)	__print_flags(status, " | ",			\
> +	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
> +	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data Ecc Error" },			\
> +	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
> +	{ CXL_RAS_CE_CACHE_POISON, "Received Cache Poison From Peer" },		\
> +	{ CXL_RAS_CE_MEM_POISON, "Received Memory Poison From Peer" },		\
> +	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
> +)
> +
> +TRACE_EVENT(cxl_aer_correctable_error,
> +	TP_PROTO(const char *dev_name, u32 status),
> +	TP_ARGS(dev_name, status),
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->status = status;
> +	),
> +	TP_printk("%s: status: '%s'",
> +		  __get_str(dev_name), show_ce_errs(__entry->status)
> +	)
> +);
> +
> +#endif /* _CXL_EVENTS_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>
> 
> 

