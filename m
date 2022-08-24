Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D759F6E8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 11:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiHXJyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiHXJyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 05:54:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D297EE8;
        Wed, 24 Aug 2022 02:52:52 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCLwl3Ssqz67ZDL;
        Wed, 24 Aug 2022 17:52:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 24 Aug 2022 11:52:30 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:52:30 +0100
Date:   Wed, 24 Aug 2022 10:52:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <20220824105229.00006c79@huawei.com>
In-Reply-To: <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220822005237.540039-1-ira.weiny@intel.com>
        <20220822005237.540039-2-ira.weiny@intel.com>
        <YwMktMqN0oFgCeZn@kroah.com>
        <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 
> > What are you trying to protect yourself from, bogus bug reports by
> > people doing bad things and then blaming you?  That's easy to handle,
> > just ignore them :)  
> 
> I asked Ira to push on this to protect the kernel from people like me,
> :). So, there is this massively complicated specification for device
> attestation and link integrity / encryption protection (SPDM and IDE)
> that has applications to both PCIe and CXL. I do not see a path in the
> near term to land that support in the kernel.
> 
> DOE being user accessible though, lends itself to pure userspace
> implementations of SPDM and IDE infrastructure. I want to develop that
> infrastructure, but also have the kernel reserve the space / right to
> obviate that implementation with kernel control of the DOE mailbox, SPDM
> sessions, and IDE keys in the future.
Can't resist...

If anyone is at Plumbers (in person or virtually) the will be a BoF on
SPDM etc. Not scheduled yet...

https://lpc.events/event/16/contributions/1304/

Come join the Kernel vs Partly Kernel vs fully Userspace discussions.

Thanks,

Jonathan
