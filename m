Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2994263C8BC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 20:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiK2Trh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Nov 2022 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiK2TrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 14:47:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3AB1D2;
        Tue, 29 Nov 2022 11:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B77B818D1;
        Tue, 29 Nov 2022 19:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D12C433D6;
        Tue, 29 Nov 2022 19:45:08 +0000 (UTC)
Date:   Tue, 29 Nov 2022 14:45:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
        bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        shiju.jose@huawei.com
Subject: Re: [PATCH v4 08/11] cxl/pci: add tracepoint events for CXL RAS
Message-ID: <20221129144506.41125a12@gandalf.local.home>
In-Reply-To: <166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
        <166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Nov 2022 10:48:53 -0700
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

From a tracing perspective:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
