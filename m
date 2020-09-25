Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5A2780C6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIYGfi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 25 Sep 2020 02:35:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYGfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 02:35:38 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLhKR-00012A-Lk
        for linux-pci@vger.kernel.org; Fri, 25 Sep 2020 06:35:35 +0000
Received: by mail-pj1-f70.google.com with SMTP id l3so1165959pjq.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 23:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ln5tX4yeIXG1vWB0JQCDh49WVbM2bVqoaH/7mBdZWuQ=;
        b=kJyFtY/0Ev2TgxBLf8NsdHzJmHG5nP9Z5mpxpJKnP4oiukKvmd5VpsumUpvDhmSlQI
         ZIxiyQB7nJPrWYw8gUzywwRHmeFGoZlEE950IY6VvFwOk6FA4Gbw6jpadUI2DI+//DwA
         OuX/bYV7V7AfQfuVqitv83mmxOkBBTAonMFpdoODqvRc1kZGkGwnn5KTIk9o/Mxr8Do7
         EeNmqaG456J6LsSyGem76WqJI3bmhK6XyRlzPilWoYy0opYAxDn2Wflt/JgPp9rc6yJM
         EYtuUhiGA1R4RlSeNvT5wi3ZGvb+XnQmrYu4d9CXQZKGy6BQM9YgwI9ZQvuIEURjiB3Y
         gBeg==
X-Gm-Message-State: AOAM5304y9bWFX6THRGEwXiHUP2BO8rUmfiys1MPhsuis2NzHkOJ3vjg
        cAq1hY7eBfYaAHVwtoubp3+B5Lbi+lxU4xMNFk5qP0QmL7rfXb2zsO4ZY/wZb0ryQOXY7v4Xyff
        ndQgbfroXEPY6+D7Zm+ooUhLKaOKo/a1ISpPzzw==
X-Received: by 2002:a17:90a:ead5:: with SMTP id ev21mr1194864pjb.188.1601015734205;
        Thu, 24 Sep 2020 23:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8MuHBZgL02bSNP/wDMTZTXNVYn/hmwUmkftK3PiogMdGhitdngDJ/ZY9ist3OCUOawC5KxQ==
X-Received: by 2002:a17:90a:ead5:: with SMTP id ev21mr1194830pjb.188.1601015733835;
        Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id s13sm1196585pgo.56.2020.09.24.23.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200924194437.GA85997@otc-nc-03>
Date:   Fri, 25 Sep 2020 14:35:29 +0800
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Jechlitschek, Christoph" <christoph.jechlitschek@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <085B7CD2-95BA-4540-8858-AB090463536A@canonical.com>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03> <20200924133938.6b93732f@x1.home>
 <20200924194437.GA85997@otc-nc-03>
To:     "Raj, Ashok" <ashok.raj@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Raj,

> On Sep 25, 2020, at 03:44, Raj, Ashok <ashok.raj@intel.com> wrote:
> 
> Hi Alex
> 
>>> Apparently it also requires to disable RR, and I'm not able to confirm if
>>> CML requires that as well. 
>>> 
>>> pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
>>> table, so i'm not sure why we need the other patch in bugzilla is required.
>> 
>> If we're talking about the Intel bug where PCH root ports implement
>> the ACS capability and control registers as dword rather than word
>> registers, then how is ACS getting enabled in order to generate an ACS
>> violation?  The standard ACS code would write to the control register
>> word at offset 6, which is still the read-only capability register on
>> those devices.  Thanks,
> 
> 
> Right... Maybe we need header log to figure out what exatly is happening. 
> 

Please let me know what logs you need.

As Bjorn mentioned earlier, there's currently no way to dump TLP header log?

Kai-Heng
