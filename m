Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358262F0F6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiKRJUq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Nov 2022 04:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbiKRJUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 04:20:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D4C75A
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 01:20:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-127-s_i65QyxOm-BfoHKhLWIYw-1; Fri, 18 Nov 2022 09:20:38 +0000
X-MC-Unique: s_i65QyxOm-BfoHKhLWIYw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:20:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 18 Nov 2022 09:20:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'ira.weiny@intel.com'" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Thread-Topic: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Thread-Index: AQHY+uF8IwLsQKEiakO+LlTXtrnK365EZJiQ
Date:   Fri, 18 Nov 2022 09:20:38 +0000
Message-ID: <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
In-Reply-To: <20221118000524.1477383-1-ira.weiny@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: ira.weiny@intel.com
> Sent: 18 November 2022 00:05
> 
> Work item initialization needs to be done with either
> INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> allocated.
> 
> The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> 
> Jonathan suggested creating doe task allocation macros such as
> DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> function is not known to the callers and must be initialized correctly.
> 
> A follow up suggestion was to have an internal 'pci_doe_work' item
> allocated by pci_doe_submit_task().[2]  This requires an allocation which
> could restrict the context where tasks are used.
> 
> Another idea was to have an intermediate step to initialize the task
> struct with a new call.[3]  This added a lot of complexity.
> 
> Lukas pointed out that object_is_on_stack() is available to detect this
> automatically.
> 
> Use object_is_on_stack() to determine the correct init work function to
> call.

This is all a bit strange.
The 'onstack' flag is needed for the diagnostic check:
	is_on_stack = object_is_on_stack(addr);
	if (is_on_stack == onstack)
		return;
	pr_warn(...);
	WARN_ON(1);

So setting the flag to the location of the buffer just subverts the check.
It that is sane there ought to be a proper way to do it.

OTOH using an on-stack structure for INIT_WORK seems rather strange.
Since the kernel thread must sleep waiting for the 'work' to complete
why not just perform the required code there.

Also you really don't want to OOPS with anything from the stack
linked into global kernel data structures.
While wait queues are pretty limited in scope and probably ok,
this looks like a big accident waiting to happen.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

