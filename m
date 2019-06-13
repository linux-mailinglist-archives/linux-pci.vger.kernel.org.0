Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6744C9C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFMTxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:53:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17053 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfFMTxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 15:53:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02a9a20000>; Thu, 13 Jun 2019 12:53:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 12:53:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Jun 2019 12:53:06 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 19:53:02 +0000
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
CC:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
Date:   Thu, 13 Jun 2019 12:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190613194430.GY22062@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560455586; bh=Jb4g90Z1ba65oKYjTxGpf+f/32abJWQiXQLuIbWbzvY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fX5tey0oBNTieShQOoS4gHfsvizLQIZuWaHc6dzOwFFJidyDqIYU2AUhp266HRFrN
         XrtOPBnaSUAKElzDHFexziLEsf0mgRvYpwoaL4sSYsIU1LcKrpDAHjizgl/yJjcdl3
         p6Pf6shBbCxBVGLYCn7p1Sc7R72zptzPvDHZbEr82hLm46tnMp65GrRnZ3EbGnwLJz
         23lgDPGqY/fbBOf3AXToJKAO/Z8B9A4BRpstqapMwDkQOz+kz4JCB2SNVDQH0ir2MJ
         WzkLVK43aAga/2HoikuGF1iJ+5COBwso/r1BhSmM63r0HyIcQnSmXduf+EERM53rtq
         kwroL2mZCH2Jw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/13/19 12:44 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:21AM +0200, Christoph Hellwig wrote:
>> The code hasn't been used since it was added to the tree, and doesn't
>> appear to actually be usable.  Mark it as BROKEN until either a user
>> comes along or we finally give up on it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>   mm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0d2ba7e1f43e..406fa45e9ecc 100644
>> +++ b/mm/Kconfig
>> @@ -721,6 +721,7 @@ config DEVICE_PRIVATE
>>   config DEVICE_PUBLIC
>>   	bool "Addressable device memory (like GPU memory)"
>>   	depends on ARCH_HAS_HMM
>> +	depends on BROKEN
>>   	select HMM
>>   	select DEV_PAGEMAP_OPS
> 
> This seems a bit harsh, we do have another kconfig that selects this
> one today:
> 
> config DRM_NOUVEAU_SVM
>          bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
>          depends on ARCH_HAS_HMM
>          depends on DRM_NOUVEAU
>          depends on STAGING
>          select HMM_MIRROR
>          select DEVICE_PRIVATE
>          default n
>          help
>            Say Y here if you want to enable experimental support for
>            Shared Virtual Memory (SVM).
> 
> Maybe it should be depends on STAGING not broken?
> 
> or maybe nouveau_svm doesn't actually need DEVICE_PRIVATE?
> 
> Jason

I think you are confusing DEVICE_PRIVATE for DEVICE_PUBLIC.
DRM_NOUVEAU_SVM does use DEVICE_PRIVATE but not DEVICE_PUBLIC.

