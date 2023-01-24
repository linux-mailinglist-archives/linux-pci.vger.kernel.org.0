Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43493679827
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjAXMhb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjAXMha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:37:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB3E3B4;
        Tue, 24 Jan 2023 04:37:29 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1Qvq5RFWz6J73m;
        Tue, 24 Jan 2023 20:17:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 12:21:31 +0000
Date:   Tue, 24 Jan 2023 12:21:30 +0000
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
Subject: Re: [PATCH v2 07/10] PCI/DOE: Create mailboxes on device
 enumeration
Message-ID: <20230124122130.00000493@Huawei.com>
In-Reply-To: <5b03b8f4d2d04cf7e4997c71daee667c73eb427b.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <5b03b8f4d2d04cf7e4997c71daee667c73eb427b.1674468099.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Mon, 23 Jan 2023 11:17:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> Currently a DOE instance cannot be shared by multiple drivers because
> each driver creates its own pci_doe_mb struct for a given DOE instance.
> For the same reason a DOE instance cannot be shared between the PCI core
> and a driver.
> 
> Overcome this limitation by creating mailboxes in the PCI core on device
> enumeration.  Provide a pci_find_doe_mailbox() API call to allow drivers
> to get a pci_doe_mb for a given (pci_dev, vendor, protocol) triple.
> 
> On device removal, tear down mailboxes in two steps:
> 
> In pci_stop_dev(), before the driver is unbound, stop ongoing DOE
> exchanges and prevent new ones from being scheduled.  This ensures that
> a hot-removed device doesn't needlessly wait for a running exchange to
> time out.

Ah. I didn't have to go far to find answer to my earlier query!  This
needs to be two step - hence the split in the previous patch.

> 
> In pci_destroy_dev(), after the driver is unbound, free the mailboxes
> and their internal data structures.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Very nice.  One comment on a possible future need inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +/**
> + * pci_find_doe_mailbox() - Find Data Object Exchange mailbox
> + *
> + * @pdev: PCI device
> + * @vendor: Vendor ID
> + * @type: Data Object Type
> + *
> + * Find first DOE mailbox of a PCI device which supports the given protocol.
> + *
> + * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
> + */
> +struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> +					u8 type)

This is good for now.  We may want eventually to be slightly
more flexible and allow for a 'find instance X of a DOE that supports Y'.
Can solve that when we need it though.

> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		if (pci_doe_supports_prot(doe_mb, vendor, type))
> +			return doe_mb;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_doe_mailbox);
