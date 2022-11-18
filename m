Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EE62FB6F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiKRRRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKRRRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:17:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643F27B2F;
        Fri, 18 Nov 2022 09:17:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A2A62691;
        Fri, 18 Nov 2022 17:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244F9C433C1;
        Fri, 18 Nov 2022 17:17:33 +0000 (UTC)
Date:   Fri, 18 Nov 2022 12:17:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
        bhelgaas@google.com
Subject: Re: [PATCH v3 08/11] cxl/pci: add tracepoint events for CXL RAS
Message-ID: <20221118121731.128df10c@gandalf.local.home>
In-Reply-To: <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
        <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Nov 2022 10:08:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> +TRACE_EVENT(cxl_aer_uncorrectable_error,
> +	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev_name, status, fe, hl),
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(u32, status)
> +		__field(u32, first_error)
> +		__dynamic_array(u32, header_log, CXL_HEADERLOG_SIZE_U32)

If this is a fixed size, you do not need to use __dynamic_array, but
instead just use __array()

		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32);

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

		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);

This will be smaller and faster.

-- Steve


> +	),
> +	TP_printk("%s: status: '%s' first_error: '%s'",
> +		  __get_str(dev_name),
> +		  show_uc_errs(__entry->status),
> +		  show_uc_errs(__entry->first_error)
> +	)
> +);
> +
