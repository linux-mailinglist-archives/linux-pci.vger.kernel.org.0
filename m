Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B16867FD
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjBAOJ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjBAOJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 09:09:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718165CFD3;
        Wed,  1 Feb 2023 06:09:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6NwG19ZDz6J7Z5;
        Wed,  1 Feb 2023 22:05:02 +0800 (CST)
Received: from localhost (10.45.150.75) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 14:09:16 +0000
Date:   Wed, 1 Feb 2023 14:09:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Matt Fagnani" <matt.fagnani@bell.net>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, <linux-pci@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230201140915.000024a0@Huawei.com>
In-Reply-To: <Y9nQK9P3HOxEeZ4U@nvidia.com>
References: <030e66e0-fb54-b77d-5094-4786684ba97d@linux.intel.com>
        <20230201001419.GA1776086@bhelgaas>
        <Y9nQK9P3HOxEeZ4U@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.150.75]
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

On Tue, 31 Jan 2023 22:36:27 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jan 31, 2023 at 06:14:19PM -0600, Bjorn Helgaas wrote:
> 
> > > AMD GPU is one of those devices.  
> > 
> > I guess you mean the AMD GPU has ATS, PRI, and PASID Capabilities?
> > And furthermore, that the GPU *always* uses Translated addresses with
> > PASID?  
> 
> I'm not versed in the spec lingo, but the GPU issues MemRd/Wrs with
> the translated bit set and no PASID header - which is the correct form
> for an address that was translated by ATS.

FWIW there is a capability bit and enable bit in the PASID cap/control
registers that says whether a device can/should add a PASID to a
translated request or not.  I think the intent is that a host can
sanity check AT requests to make sure the device isn't making them
up. To do that it needs the PASID.  Not sure any hosts do this yet
though ;)

Not worth much, but I thought it always sent the PASID so dug out spec
to check (I was wrong as it is both optional and configurable).

> 
> To get to that it issues ATS requests, and only the ATS related
> requests will carry the PASID.
> 
> ATS related requests always route to the root port, which is why it is
> functionally equivalent to ACS RR/UF in these cases.
> 
> Translated requests always route where they are supposed to go, even
> with P2P and things.
> 
> > And this applies even if there is no ACS or ACS doesn't support
> > PCI_ACS_RR and PCI_ACS_UF.
> > 
> > The black screen happens because ... ?  
> 
> AMD GPU driver bugs blow up if it cannot setup PASID.
> 
> > I couldn't figure out the NULL pointer dereference.  I expected it to
> > be from a BUG() or similar in report_iommu_fault(), but I don't see
> > that.  
> 
> IIRC it is a buggy error unwind handling in the AMD GPU driver.
>  
> Jason

