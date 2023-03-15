Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE66BBA53
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 17:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCOQ6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCOQ6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 12:58:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6F559F7;
        Wed, 15 Mar 2023 09:58:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcGHL0hYwz6J9fG;
        Thu, 16 Mar 2023 00:36:14 +0800 (CST)
Received: from localhost (10.126.171.21) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 16:39:16 +0000
Date:   Wed, 15 Mar 2023 16:39:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alexey Kardashevskiy" <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 01/17] cxl/pci: Fix CDAT retrieval on big endian
Message-ID: <20230315163915.00004275@Huawei.com>
In-Reply-To: <3051114102f41d19df3debbee123129118fc5e6d.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
        <3051114102f41d19df3debbee123129118fc5e6d.1678543498.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.21]
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

On Sat, 11 Mar 2023 15:40:01 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The CDAT exposed in sysfs differs between little endian and big endian
> arches:  On big endian, every 4 bytes are byte-swapped.
> 
> PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
> such as pci_read_config_dword() implicitly swap bytes on big endian.
> That way, the macros in include/uapi/linux/pci_regs.h work regardless of
> the arch's endianness.  For an example of implicit byte-swapping, see
> ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
> (Load Word Byte-Reverse Indexed).
> 
> DOE Read/Write Data Mailbox Registers are unlike other registers in
> Configuration Space in that they contain or receive a 4 byte portion of
> an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
> They need to be copied to or from the request/response buffer verbatim.
> So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
> byte-swapping.
> 
> The CXL_DOE_TABLE_ACCESS_* and PCI_DOE_DATA_OBJECT_DISC_* macros assume
> implicit byte-swapping.  Byte-swap requests after constructing them with
> those macros and byte-swap responses before parsing them.
> 
> Change the request and response type to __le32 to avoid sparse warnings.
> Per a request from Jonathan, replace sizeof(u32) with sizeof(__le32) for
> consistency.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org # v6.0+

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
