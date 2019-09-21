Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5CB9BBB
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2019 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfIUA5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 20:57:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389377AbfIUA5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 20:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ibKah86qfJa+k7wrtX/Du4Ejsuh4uymIntvn8KtXEOo=; b=j2lBIcHRUzKotrDDjaCr3Es/Y
        3oxst3DhVtyBg8hw3D3m5QvuBlTGE7SyrkgEEduKdThMdszPFe0vYYjZD2eodFN/2jBMNGP0Fgg+l
        fhfuDAkfwOuWLUEyLR2hWcdAxdBQ2e0A9Mgt3np6mNwbXFC4A6B6j/1m9zA7u683hPW0r6Lr85a/h
        KS5lJuA5uAwffcmVLsJzjNRF2sMKR81uYT85YH12xPS6MXXDon8VuqysLuxHos02SmhxV+kIjIs4t
        DbTW5+MwbJXxNBdQVb6lrvt/ae35QOzCMfMoztxEzTfp9kM+xwE5GZkp+rGMHv5hmomPiYpBntUAW
        j5GvEe7Xw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBTic-0000Ce-8n; Sat, 21 Sep 2019 00:57:46 +0000
Subject: Re: pci: endpoint test BUG
To:     Hillf Danton <hdanton@sina.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190916020630.1584-1-hdanton@sina.com>
 <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
 <815ad936-8b98-0931-89f7-b97922a7c77d@ti.com>
 <20190920152026.GC10172@e121166-lin.cambridge.arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1e7862c-d61d-6ecd-f70c-73870f343940@infradead.org>
Date:   Fri, 20 Sep 2019 17:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920152026.GC10172@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/19 5:38 PM, Hillf Danton wrote:
>>Kishon, Hillf, can you turn it into a patch and send it asap please ?
> 
>  
> 
> What was sent a couple of days before,
> 
>  
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cc: linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
> 
> Subject: [PATCH] PCI: endpoint: Fix uaf on unregistering driver
> 
> ...
> 
>  
> 
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> 
> Reported-and-tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> 
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Cc: Andrey Konovalov <andreyknvl@google.com>
> 
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> 
> ---
> 
>  
> 
> and it is certain that <lorenzo.pieralisi@arm.com> is on the Cc list.
> 
>  
> 
> It will be resent if no one saw the message.

I didn't see it and I can't find it on lore.kernel.org/linux-pci/.

-- 
~Randy
