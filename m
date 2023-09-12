Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F279CE2E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjILKZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjILKZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:25:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649710F4;
        Tue, 12 Sep 2023 03:24:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKSm70kXz6K6k2;
        Tue, 12 Sep 2023 18:24:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:24:54 +0100
Date:   Tue, 12 Sep 2023 11:24:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] PCI/treewide: PCIe Link Width field access cleanup
Message-ID: <20230912112453.000015f6@Huawei.com>
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 15:14:53 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Instead of custom code to extract the PCIe Negotiated and Maximum Link
> Width fields, make the code more obvious using FIELD_GET/PREP().
> 
> Ilpo Järvinen (8):
>   IB/hfi1: Use FIELD_GET() to extract Link Width
>   media: cobalt: Use FIELD_GET() to extract Link Width
>   igb: Use FIELD_GET() to extract Link Width
>   PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
>   PCI: mvebu: Use FIELD_PREP() with Link Width
>   PCI: Use FIELD_GET() to extract Link Width
>   scsi: esas2r: Use FIELD_GET() to extract Link Width
>   scsi: qla2xxx: Use FIELD_GET() to extract Link Width

I'd like to see this done more generally rather than just
for this one field, but I guess it's a step in the right direction.
I'm particularly in favour of the cases where 4 was used
rather than the define.

> 
>  drivers/infiniband/hw/hfi1/pcie.c          |  5 +++--

As an example, immediately above the link width code is link
speed code.  Using FIELD_GET there as well would avoid people
having to 'know' that field is at 0 shift.

So for what you have 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
but I'd like to see this taken further.

A few minor comments in some of the individual patches.

>  drivers/media/pci/cobalt/cobalt-driver.c   | 11 ++++++-----
>  drivers/net/ethernet/intel/igb/e1000_mac.c |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c |  9 ++++-----
>  drivers/pci/controller/pci-mvebu.c         |  2 +-
>  drivers/pci/pci-sysfs.c                    |  5 ++---
>  drivers/pci/pci.c                          |  6 +++---
>  drivers/scsi/esas2r/esas2r_ioctl.c         |  8 ++++----
>  drivers/scsi/qla2xxx/qla_os.c              |  3 ++-
>  9 files changed, 28 insertions(+), 27 deletions(-)
> 

