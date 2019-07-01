Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27EC55F6D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 05:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFZDPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 23:15:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6685 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZDPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 23:15:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d12e3520000>; Tue, 25 Jun 2019 20:15:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 20:15:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Jun 2019 20:15:31 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Jun
 2019 03:15:29 +0000
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
 <20190619192719.GO9374@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <29f43c79-b454-0477-a799-7850e6571bd3@nvidia.com>
Date:   Tue, 25 Jun 2019 20:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619192719.GO9374@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561518930; bh=mFKCj/TnJw3viqoDN0No22dYQzshEvjZPsHuzsScphE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JWS56c7LDNZO2C+L8KR37PAJV/JNwy2VsATo0Y9o97x2OREZOXY1kW16CqdsdCF3p
         h75heFhKUb3QKsr9tb1bJDlBPd+kZrKl1GNfPhJxKLLAVmTvovjBcLyjGppIJCVNJz
         e/bL0Uz9WCABzn+s82NDbBpQtU8Quft0swt7Nfb9yv1tVnj/v8mVsJUeumTOsJqbpo
         ejbFTmycRLy12cjephJ1Av4haOtY2fOQCECnDpWB4huqII/lRxMlc4SxDkKG4nThLq
         s7yoeCAPZH4BEFoJuCbXa874ODwp/FlzUTE8v3eEQjQt1UYj/uSTcnPhWHZ0P2eSt5
         drw5jV+XaTi+A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/19/19 12:27 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
>> On 6/13/19 5:43 PM, Ira Weiny wrote:
>>> On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
>>>> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
>>>>>
>> ...
>>> So I think it is ok.  Frankly I was wondering if we should remove the public
>>> type altogether but conceptually it seems ok.  But I don't see any users of it
>>> so...  should we get rid of it in the code rather than turning the config off?
>>>
>>> Ira
>>
>> That seems reasonable. I recall that the hope was for those IBM Power 9
>> systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
>> memory, and so the memory really is visible to the CPU. And the IBM team
>> was thinking of taking advantage of it. But I haven't seen anything on
>> that front for a while.
> 
> Does anyone know who those people are and can we encourage them to
> send some patches? :)
> 

I asked about this, and it seems that the idea was: DEVICE_PUBLIC was there
in order to provide an alternative way to do things (such as migrate memory
to and from a device), in case the combination of existing and near-future
NUMA APIs was insufficient. This probably came as a follow-up to the early
2017-ish conversations about NUMA, in which the linux-mm recommendation was
"try using HMM mechanisms, and if those are inadequate, then maybe we can
look at enhancing NUMA so that it has better handling of advanced (GPU-like)
devices".

In the end, however, _PUBLIC was never used, nor does anyone in the local
(NVIDIA + IBM) kernel vicinity seem to have plans to use it.  So it really
does seem safe to remove, although of course it's good to start with 
BROKEN and see if anyone pops up and complains.

thanks,
-- 
John Hubbard
NVIDIA
