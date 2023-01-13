Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A416698A7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 14:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAMNew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 08:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbjAMNdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 08:33:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45B60CCD;
        Fri, 13 Jan 2023 05:27:08 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nthw807hfz67Ls2;
        Fri, 13 Jan 2023 21:24:24 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 13:27:04 +0000
Date:   Fri, 13 Jan 2023 13:27:03 +0000
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
Subject: Re: [PATCH v6 6/8] cxl/test: Add generic mock events
Message-ID: <20230113132703.0000664a@Huawei.com>
In-Reply-To: <20221216-cxl-ev-log-v6-6-346583105b30@intel.com>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
        <20221216-cxl-ev-log-v6-6-346583105b30@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
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

On Mon, 09 Jan 2023 11:42:25 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Facilitate testing basic Get/Clear Event functionality by creating
> multiple logs and generic events with made up UUID's.
> 
> Data is completely made up with data patterns which should be easy to
> spot in trace output.
> 
> A single sysfs entry resets the event data and triggers collecting the
> events for testing.
> 
> Test traces are easy to obtain with a small script such as this:
> 
> 	#!/bin/bash -x
> 
> 	devices=`find /sys/devices/platform -name cxl_mem*`
> 
> 	# Turn on tracing
> 	echo "" > /sys/kernel/tracing/trace
> 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	# Generate fake interrupt
> 	for device in $devices; do
> 	        echo 1 > $device/event_trigger
> 	done
> 
> 	# Turn off tracing and report events
> 	echo 0 > /sys/kernel/tracing/tracing_on
> 	cat /sys/kernel/tracing/trace
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks like it will test the kernel functionality in this
patch set correctly to me. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

