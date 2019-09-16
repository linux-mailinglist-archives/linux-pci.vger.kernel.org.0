Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5528B33A0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 04:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfIPC63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 22:58:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfIPC63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Sep 2019 22:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GVblmzz3plDyZtzevh+6JM/SYfAETob1wlVIQfguZMY=; b=Q5znqb7FLZyKO6G3Fd8YkzOdS
        gBtErLvRHK6K+fuDcQ14TIKk2mS3fqbsPc/9fXX0DONyfDqzCj4uoVnNlvOQG160mZSF2N/SH/Mod
        HqKkcPLzsabRH0rBKg+uK2CprPJX7X/iiEbCkYPcNRSAWZSMjEaPApVHQnwX11ThyYUzx4d0C2mXu
        RnFzj2P4/alRvj8v0W16o7fuZJHK8CMi+2mEowU/0J7v2SD+DKsAtc6GhSRHyJe3ox4MIDrN35IjB
        IpUi3OmrODCCyA/jA967/spy6CIXR1FJ76yxQ7Jhg/5GQbpymTgtRinUgmPTB+JpvgiR7W8fOs91y
        LLUylJDBQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9hDc-00080R-Eq; Mon, 16 Sep 2019 02:58:24 +0000
Subject: Re: pci: endpoint test BUG
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20190916020630.1584-1-hdanton@sina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc884b12-c083-2d9f-0ec5-95c293931ed2@infradead.org>
Date:   Sun, 15 Sep 2019 19:58:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916020630.1584-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/15/19 7:06 PM, Hillf Danton wrote:
> 
> On Sun, 15 Sep 2019 09:34:37 -0700
>>
>> Kernel is 5.3-rc8 on x86_64.
>>
>> Loading and removing the pci-epf-test module causes a BUG.
>>
>>
>> [40928.435755] calling  pci_epf_test_init+0x0/0x1000 [pci_epf_test] @ 12132
>> [40928.436717] initcall pci_epf_test_init+0x0/0x1000 [pci_epf_test] returned 0 after 891 usecs
>> [40936.996081] ==================================================================
>> [40936.996125] BUG: KASAN: use-after-free in pci_epf_remove_cfs+0x1ae/0x1f0
>> [40936.996153] Write of size 8 at addr ffff88810a22a068 by task rmmod/12139
> 
> Fix fb0de5b8dcc6 and ef1433f717a2 if the current group::group_entry
> used by pci epf does not break how configfs uses it.
> 
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -153,9 +153,11 @@ static void pci_epf_remove_cfs(struct pc
>  		return;
>  
>  	mutex_lock(&pci_epf_mutex);
> -	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
> +	list_for_each_entry_safe(group, tmp, &driver->epf_group,
> +							group_entry) {
> +		list_del_init(&group->group_entry);
>  		pci_ep_cfs_remove_epf_group(group);
> -	list_del(&driver->epf_group);
> +	}
>  	mutex_unlock(&pci_epf_mutex);
>  }
>  
> 

Fixes the problem for me.  Thanks.
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Please make a proper patch.

-- 
~Randy
