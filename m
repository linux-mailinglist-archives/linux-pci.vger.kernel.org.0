Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAD1024B
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfD3WYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 18:24:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33043 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3WYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2019 18:24:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id l1so10776428oib.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2019 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZ1PM87ohnji9r872rj74D6Fq0/brGlUbTKwwr5a4q4=;
        b=nFOLQnmPRb0/JY/yvlCkC3oJJBGeUK8FlyZN3L1GY5xyfkwe9bli7sUi3VEPO0lwe2
         mUvOrBq5ZhzEytWPtts8NVsji1tKsp9ntb1GB2V94eNJFLbmJcM2nzBUFMoXykIJqvXm
         DNLV4wmm4WP9NaQX8R5aHTil2Wmo7jbh9D0/eg3OcAm7oQGfPcVHnuMKVPV7ZyAz0Qe0
         /aWIjUnObS1IiTkkwNenowUmzwYGwnYi+Y05WmQG+MPEfQvE20qs1AWTaAiUdHOk2m9a
         LRg0JdbAzKMXlJs9AkugORRXVQi03QBKd3aKOrm2Jo9GSe2PeFnNh6aEAHgbJ11WeQwe
         nTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZ1PM87ohnji9r872rj74D6Fq0/brGlUbTKwwr5a4q4=;
        b=VbAhsEUNYFo69lc0XXOcDrK7DgUIjSH3PlS5vFMWn+Dj34NFqvADIvZhsNZwxImLIB
         kUvDZ9wftkcr/9grm1rmdbrusTeT8cedoCcLBis+8WHRUJyavYtD6oWQp01Ok8flwkNv
         NUvM/Dg3zi1hGoLRGm6D4h/sAJYBK4rMzwNV2DfCz+FYvzO6LEfwo7tZ4sgZKutmFAZ9
         Ons7rVZlbDPQLSaBrAsn8x+oKslhlnSsfdMtxVkVpWsRpZDgb0cV9Do7atQTZ51/wQPJ
         7oqXprdXP0t9a8t75odKNQ8NxymkairGht5OecgutT6RImiRzya3g/Qv+gr/jJIRu0Qu
         rlwA==
X-Gm-Message-State: APjAAAXu+IAfDbTbeP4xvbRs0y5/2L/3L1Jp7hJIymHKeU30PdcIC4VP
        b9YyXrWAIZf0lvkKfNJSbCv7GA==
X-Google-Smtp-Source: APXvYqyz6UUC1VeOH+MU0VesR8d3jpajolEW8TlyLuBJR+0sciV/7J3SsuS7ITWRFimevejVWQBOVg==
X-Received: by 2002:aca:c696:: with SMTP id w144mr1836254oif.126.1556663074332;
        Tue, 30 Apr 2019 15:24:34 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:18a0:11d0:99ba:d92:93c8:8fb9])
        by smtp.gmail.com with ESMTPSA id k65sm16084979oia.16.2019.04.30.15.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:24:33 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
 <20190428154339.GT9224@smile.fi.intel.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <a15490fb-3afc-868a-117e-351cd9726bf2@fredlawl.com>
Date:   Tue, 30 Apr 2019 17:25:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.14
MIME-Version: 1.0
In-Reply-To: <20190428154339.GT9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy,

Andy Shevchenko wrote on 4/28/19 10:43 AM:
> On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
>> From: Frederick Lawler <fred@fredlawl.com>
>>
>> Replace remaining instances of dev_*() printk wrappers with pci_*()
>> printk wrappers. No functional change intended.
> 
>> -		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
>> -			   e_info->id);
>> +		pci_dbg(parent, "can't find device of ID%04x\n", e_info->id);
> 
> These are not equivalent.
> 
>> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
>> +		pci_dbg(pdev, "alloc AER rpc failed\n");
> 
> Ditto.
> 
>> -		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
>> -			   dev->irq);
>> +		pci_dbg(pdev, "request AER IRQ %d failed\n", dev->irq);
> 
> Ditto.
> 
> And so on.
> 

Thanks for the review. Clearly this was an oversight on my part and I'll 
have that corrected. Thanks!


Frederick Lawler

