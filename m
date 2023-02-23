Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89C6A0B68
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjBWOAq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 23 Feb 2023 09:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjBWOAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 09:00:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883355C01;
        Thu, 23 Feb 2023 06:00:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMvgW6Ct9z6J6K5;
        Thu, 23 Feb 2023 21:55:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 23 Feb
 2023 14:00:39 +0000
Date:   Thu, 23 Feb 2023 14:00:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brian van der Beek <bbeek@marvell.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Christophe Therene <ctherene@marvell.com>,
        "Lukas@wunner.de" <Lukas@wunner.de>
Subject: Re: Question on DOE requirements for CXL/CDAT and CMA/SPDM
Message-ID: <20230223140038.0000534d@Huawei.com>
In-Reply-To: <SJ0PR18MB496423534AC55973B92E3913B3AB9@SJ0PR18MB4964.namprd18.prod.outlook.com>
References: <SJ0PR18MB496423534AC55973B92E3913B3AB9@SJ0PR18MB4964.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
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

On Thu, 23 Feb 2023 13:06:47 +0000
Brian van der Beek <bbeek@marvell.com> wrote:

> Hi all,
> 

Hi Bryan,

> I posted the following question to the PCI-SIG protocol group:
> 
> The Base Specification Revision 6.0.1 paragraph 6.31.3 'CMA/SPDM Rules' includes the following statement:
> 
> The instance of DOE used for CMA/SPDM must support:
> 
> ·         the DOE Discovery data object protocol,
> 
> ·         if IDE is supported, the IDE_KM data object protocol using Secured CMA/SPDM (See § Section 6.31.4 ),
> 
> ·         and no other data object protocol(s).
> 
> Whereas the Compute Express Link (CXL) Revision 3.0 paragraph 8.1.11 'Table Access DOE' states:
> 
> A device may interrupt the host when CDAT content changes using the MSI associated with this DOE Capability instance. A device may share the instance of this DOE mailbox with other Data Objects.
> 
> For a CXL device that support both CMA/SPDM and CXL Table Access DOE (CDAT) data objects, is it mandatory to have a dedicate DOE instance for the CMA/SPMA protocol data objects? Or is it permitted for the CMA/SPDM and CXL protocols to share a single DOE instance?

Whilst my reading of what is published would be that the CXL spec is saying about restrictions from
the CDAT side of things (so if other protocols don't specify restrictions, they may share a DOE instance),
ultimately to get an answer on that take it to the relevant folk in the CXL consortium.

> 
> PCI-SIG replied that the requirement of a dedicated DOE instance for CMA/SPDM was an intentional choice based on the idea that the software attached to the DOE instances would be different.  However, that thought model for how DOE would be used by software has evolved, and it may not be necessary for hardware to implement separate DOE instances.

It's certainly possible, though from hardware side I'd be worried that some usecases might require that separation
and you'd be building hardware where it wasn't possible to support it.

> 
> I am reaching out to you, as I am hoping you could provide some insight on the Linux CMA/SPDM implementation and whether it allows for a DOE instance to be shared with CXL/CDAT data objects.

One for Lukas, though I suspect Linux will at most warn on this happening unless there is an implementation subtlety or
security risk that means we should error out if this happens.

Jonathan

> 
> Best Regards,
> 
> Brian van der Beek
> Senior Principal Engineer
> [cid:image001.jpg@01D94783.E04A16A0]<http://www.marvell.com/>
> Marvell Netherlands B.V., Laan van Diepenvoorde 4, 5582 LA, Waalre | The Netherlands
> Mobile: +31-6-4775191
> 
> www.marvell.com<http://www.marvell.com/>
> 
> 

