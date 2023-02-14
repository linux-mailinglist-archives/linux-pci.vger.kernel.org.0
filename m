Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9EC6962B1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBNLwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 06:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBNLwB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 06:52:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950612365E;
        Tue, 14 Feb 2023 03:52:00 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGKJp012Gz689lY;
        Tue, 14 Feb 2023 19:50:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 11:51:57 +0000
Date:   Tue, 14 Feb 2023 11:51:56 +0000
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
Subject: Re: [PATCH v3 11/16] PCI/DOE: Allow mailbox creation without devres
 management
Message-ID: <20230214115156.00002e04@Huawei.com>
In-Reply-To: <ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7.1676043318.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 10 Feb 2023 21:25:11 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> DOE mailbox creation is currently only possible through a devres-managed
> API.  The lifetime of mailboxes thus ends with driver unbinding.
> 
> An upcoming commit will create DOE mailboxes upon device enumeration by
> the PCI core.  Their lifetime shall not be limited by a driver.
> 
> Therefore rework pcim_doe_create_mb() into the non-devres-managed
> pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
> on device removal.
> 
> Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
> name.
> 
> The error path of pcim_doe_create_mb() previously called xa_destroy() if
> alloc_ordered_workqueue() failed.  That's unnecessary because the xarray
> is still empty at that point.  It doesn't need to be destroyed until
> it's been populated by pci_doe_cache_protocols().  Arrange the error
> path of the new pci_doe_create_mb() accordingly.
> 
> pci_doe_cancel_tasks() is no longer used as callback for
> devm_add_action(), so refactor it to accept a struct pci_doe_mb pointer
> instead of a generic void pointer.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

