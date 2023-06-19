Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF077351E7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjFSKVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjFSKVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 06:21:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CF339B;
        Mon, 19 Jun 2023 03:21:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944CF150C;
        Mon, 19 Jun 2023 03:21:59 -0700 (PDT)
Received: from [10.57.86.121] (unknown [10.57.86.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CFF3F64C;
        Mon, 19 Jun 2023 03:21:14 -0700 (PDT)
Message-ID: <90823b33-1f44-8789-9a38-282407fd9f15@arm.com>
Date:   Mon, 19 Jun 2023 11:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZIyxFpzh3WG+ifws@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-06-16 19:59, Jason Gunthorpe wrote:
> On Fri, Jun 16, 2023 at 05:34:53PM +0100, Robin Murphy wrote:
>>
>> If the system has working ACS configured correctly, then this issue should
>> be moot;
> 
> Yes
> 
>> if it doesn't, then a VFIO user is going to get a whole group of
>> peer devices if they're getting anything at all, so it doesn't seem entirely
>> unreasonable to leave it up to them to check that all those devices'
>> resources play well with their expected memory map.
> 
> I think the kernel should be helping here.. 'go figure it out from
> lspci' is a very convoluted and obscure uAPI, and I don't see things
> like DPDK actually doing that.
> 
> IMHO the uAPI expectation is that the kernel informs userspace what
> the usable IOVA is, if bridge windows and lack of ACS are rendering
> address space unusable then VFIO/iommufd should return it as excluded
> as well.
> 
> If we are going to do that then all UNAMANGED domain users should
> follow the same logic.
> 
> We probably have avoided bug reports because of how rare it would be
> to see a switch and an UNMANAGED domain using scenario together -
> especially with ACS turned off.
> 
> So it is really narrow niche.. Obscure enough I'm not going to make
> patches :)

The main thing is that we've already been round this once before; we 
tried it 6 years ago and then reverted it a year later for causing more 
problems than it solved:

https://lkml.org/lkml/2018/3/2/760

Thanks,
Robin.
