Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207EF690819
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBIL6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 06:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBIL46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 06:56:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC48199D7;
        Thu,  9 Feb 2023 03:47:52 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCF0y2bpfz6J7Ts;
        Thu,  9 Feb 2023 19:25:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 11:30:21 +0000
Date:   Thu, 9 Feb 2023 11:30:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <bhelgaas@google.com>,
        <robert.moore@intel.com>
Subject: Re: [PATCH 02/18] ACPICA: Export acpi_ut_verify_cdat_checksum()
Message-ID: <20230209113020.00002ac9@Huawei.com>
In-Reply-To: <bd978172-a774-b914-04a1-8e878dddfb92@intel.com>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571657859.587790.12435839081602248140.stgit@djiang5-mobl3.local>
        <CAJZ5v0hO-FthRSRD5LPL1Onz7DaRG8zBo=GBDBR+k1_upYHVBQ@mail.gmail.com>
        <bd978172-a774-b914-04a1-8e878dddfb92@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 7 Feb 2023 08:47:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 2/7/23 7:19 AM, Rafael J. Wysocki wrote:
> > On Mon, Feb 6, 2023 at 9:49 PM Dave Jiang <dave.jiang@intel.com> wrote:  
> >>
> >> Export the CDAT checksum verify function so CXL driver can use it to verify
> >> CDAT coming from the CXL devices.
> >>
> >> Given that this function isn't actually being used by ACPI internals,
> >> removing the define check of APCI_CHECKSUM_ABORT so the function would
> >> return failure on checksum fail since the driver will need to know.  

Seems unlikely this won't cause problems in usage of
AcpiUtVerifyCdatChecksum in the upstream ACPICA code.  So you may need
to leave that alone.

You will probably want a linux wrapper to export rather than
the acpica function.  That should let you avoid an acpica change I think.
There are no exports from within acpica code.

Jonathan


> > 
> > If you want to make ACPICA changes, please first submit a pull request
> > to the upstream ACPICA project on GitHub.
> > 
> > Having done that, please resubmit the corresponding Linux patch with a
> > Link tag pointing to the upstream PR.  
> 
> Ok will do. Thanks!
> > 
> > Thanks!
> >   
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   drivers/acpi/acpica/utcksum.c |    4 +---
> >>   include/linux/acpi.h          |    7 +++++++
> >>   2 files changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
> >> index c166e4c05ab6..c0f98c8f9a0b 100644
> >> --- a/drivers/acpi/acpica/utcksum.c
> >> +++ b/drivers/acpi/acpica/utcksum.c
> >> @@ -102,15 +102,13 @@ acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
> >>                                     "should be 0x%2.2X",
> >>                                     acpi_gbl_CDAT, cdat_table->checksum,
> >>                                     checksum));
> >> -
> >> -#if (ACPI_CHECKSUM_ABORT)
> >>                  return (AE_BAD_CHECKSUM);
> >> -#endif
> >>          }
> >>
> >>          cdat_table->checksum = checksum;
> >>          return (AE_OK);
> >>   }
> >> +EXPORT_SYMBOL_GPL(acpi_ut_verify_cdat_checksum);
> >>
> >>   /*******************************************************************************
> >>    *
> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> index 5e6a876e17ba..09b44afef7df 100644
> >> --- a/include/linux/acpi.h
> >> +++ b/include/linux/acpi.h
> >> @@ -1504,9 +1504,16 @@ static inline void acpi_init_ffh(void) { }
> >>   #ifdef CONFIG_ACPI
> >>   extern void acpi_device_notify(struct device *dev);
> >>   extern void acpi_device_notify_remove(struct device *dev);
> >> +extern acpi_status
> >> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length);
> >>   #else
> >>   static inline void acpi_device_notify(struct device *dev) { }
> >>   static inline void acpi_device_notify_remove(struct device *dev) { }
> >> +static inline acpi_status
> >> +acpi_ut_verify_cdat_checksum(struct acpi_table_cdat *cdat_table, u32 length)
> >> +{
> >> +       return (AE_NOT_CONFIGURED);
> >> +}
> >>   #endif
> >>
> >>   #endif /*_LINUX_ACPI_H*/
> >>
> >>  

