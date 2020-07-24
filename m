Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6F22C98B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXP4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 11:56:55 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57556 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXP4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 11:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gzDjJxP9G6lKPkDmU/12OxkP6YbdMfMKBEA31jhMTgI=; b=AdBphzVboE8kYWs2/6XvZ2V2UZ
        wlWyWzVkuSx+ERgBGrUCcdoVM9TfNB3Sw0dZnGl3o3bCX4JbOnZ1C64zG/+JrxG9fOp9W5Zl9Eyji
        zwQRdjKs8Au9B0ps8YbHEUhtKmYzFHz47KdKU63JInLIgZAVz2mZJ28oJ5jdDuxvCwvwJP0C7iUR3
        CI1wSC96IxbypIEr1pLc0h6xgzLZ8EuwwAJhv4tIUmV7VoPdv2bztHeW4MlW2et/zpiF8gegIc+Yo
        Wa2dCUKTKd6fa2ld4ivneWflQxFW9wp5wOqoG1Og3dW1q5X9kQHAGNB3RRFyUp2/kLq+xALf4s5Tt
        ZvwGB+sA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jz03u-0005Br-F1; Fri, 24 Jul 2020 09:56:43 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20200724150641.GA1518875@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <59b68da4-cd3c-bf65-6654-02d4feaede27@deltatee.com>
Date:   Fri, 24 Jul 2020 09:56:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724150641.GA1518875@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jonathan.cameron@huawei.com, hpa@zytor.com, andrew.maier@eideticom.com, ray.huang@amd.com, christian.koenig@amd.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alexdeucher@gmail.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jonathan]

On 2020-07-24 9:06 a.m., Bjorn Helgaas wrote:
> On Thu, Jul 23, 2020 at 02:10:52PM -0600, Logan Gunthorpe wrote:
>> On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:
>>> On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
>>>> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>>
>>>>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
>>>>> transactions between root ports and found to work. Therefore add it
>>>>> to the list.
>>>>>
>>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>> Cc: Alex Deucher <alexdeucher@gmail.com>
>>>>
>>>> Starting with Zen, all AMD platforms support P2P for reads and writes.
>>>
>>> What's the plan for getting out of the cycle of "update this list for
>>> every new chip"?  Any new _DSMs planned, for instance?
>>
>> Well there was an effort to add capabilities in the PCI spec to describe
>> this but, as far as I know, they never got anywhere, and hardware still
>> doesn't self describe with this.
> 
> Any idea what happened?  Is there hope for the future?  I'm really not
> happy about signing up for open-ended device-specific patches like
> this.  It's certainly not in the plug and play spirit that has made
> PCI successful.  I know, preaching to the choir here.

Agreed, though I'm not really hooked into the PCI SIG. The last email I
got about this was an RFC from Jonathan Cameron in late 2018. I've CC'd
him here, maybe he'll have a bit more insight.

Logan
