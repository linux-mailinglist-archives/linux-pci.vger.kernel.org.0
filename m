Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C95679808
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjAXM11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXM10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:27:26 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C745BDD;
        Tue, 24 Jan 2023 04:27:03 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1R5P3ZyNz6J9dM;
        Tue, 24 Jan 2023 20:25:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 12:26:25 +0000
Date:   Tue, 24 Jan 2023 12:26:24 +0000
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
Subject: Re: [PATCH v2 09/10] PCI/DOE: Make mailbox creation API private
Message-ID: <20230124122624.000066e9@Huawei.com>
In-Reply-To: <3dca6f956342707fb69cba94a771f3d4d2f5f3b4.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <3dca6f956342707fb69cba94a771f3d4d2f5f3b4.1674468099.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 23 Jan 2023 11:19:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The PCI core has just been amended to create a pci_doe_mb struct for
> every DOE instance on device enumeration.  CXL (the only in-tree DOE
> user so far) has been migrated to use those mailboxes instead of
> creating its own.
> 
> That leaves pcim_doe_create_mb() and pci_doe_for_each_off() without any
> callers, so drop them.
> 
> pci_doe_supports_prot() is now only used internally, so declare it
> static.
> 
> pci_doe_flush_mb() and pci_doe_destroy_mb() are no longer used as
> callbacks for devm_add_action(), so refactor them to accept a
> struct pci_doe_mb pointer instead of a generic void pointer.
> 
> Because pci_doe_create_mb() is only called on device enumeration, i.e.
> before driver binding, the workqueue name never contains a driver name.
> So replace dev_driver_string() with dev_bus_name() when generating the
> workqueue name.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
