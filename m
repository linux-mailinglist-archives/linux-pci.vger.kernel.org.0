Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C608B020
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 08:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfHMGuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 02:50:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41445 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfHMGuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 02:50:39 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hxQdh-0003ZZ-61
        for linux-pci@vger.kernel.org; Tue, 13 Aug 2019 06:50:37 +0000
Received: by mail-pg1-f199.google.com with SMTP id u1so66009203pgr.13
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2019 23:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jVQ2Gzp/+e8TohHkm7q7ETycYMK/SMdCbf9g5Irvyvg=;
        b=kZ4aMsFVWbd4iA47HJ0wgP0q3c3FozgAtQPR8ldrnl1bP826RajkIOLCpEyECHegI9
         LD1PlblnGSVdNfvtsWE7+kbwcXiU7fiMqnbhvDxh/lEd+oyYITdYJLpw5wg0Zoq/4d+M
         DTCykgvlD+E01g+ruq02DE+m69PEdpvv7sHDNaKUJxhl32KmDGwdWGpOnW41aLiIwb8D
         ixWlgdy4YOnRUEVCujRM2ecMIpxQ3JCL3UDq8vY5tS22s+En7fd1WjxI6FK+8TT4cWa/
         fBoTWVlrlT2Fl5bo1nEIJuqo6g1Rk1jy+ivyQmBboC+yiGykWDWgkQWnRebEOnlgQxMD
         9dwA==
X-Gm-Message-State: APjAAAW8WDPNRABJ9LaX9dLWlW23AxNenEe6dRsCKU1xXmnykr+lJRik
        C9QcCRrcKr8iZ3nrUl5iRINQNxJWvqJThu86EuftPYBVecCsnC0eI4JfnjhTVuTH28wcS33r8N7
        Vm0n+yJ3JGKmx8UOoT8nvyhXsv+v3lA6iDRzpJg==
X-Received: by 2002:a17:902:2be6:: with SMTP id l93mr36889592plb.0.1565679035897;
        Mon, 12 Aug 2019 23:50:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxV5JYh7OeuMp54v5e+FUiqIjAbEOKkw1M9m4C8tWlOvo6l1/zgoHx2bRdjtM4EG8QEJ730YA==
X-Received: by 2002:a17:902:2be6:: with SMTP id l93mr36889576plb.0.1565679035632;
        Mon, 12 Aug 2019 23:50:35 -0700 (PDT)
Received: from 2001-b011-380f-37d3-69dc-5ce4-19b8-561b.dynamic-ip6.hinet.net (2001-b011-380f-37d3-69dc-5ce4-19b8-561b.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:69dc:5ce4:19b8:561b])
        by smtp.gmail.com with ESMTPSA id q126sm113270436pfq.123.2019.08.12.23.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:50:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <203745C2-85AF-4A37-8628-636632D14564@canonical.com>
Date:   Tue, 13 Aug 2019 14:50:32 +0800
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <78466959-E500-4AA0-8440-CBF80DBFE260@canonical.com>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
 <1562759399.5312.6.camel@suse.com> <87pnm6sd10.fsf@linux.intel.com>
 <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
 <87blxqs3fh.fsf@linux.intel.com>
 <749516DB-65B6-4D59-8C77-7883649D1F25@canonical.com>
 <8113f4a4-e96e-9b73-cd7a-1dbb800d68bb@linux.intel.com>
 <203745C2-85AF-4A37-8628-636632D14564@canonical.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mathias,

at 21:24, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> at 22:45, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:

[snipped]

> Yes, disabling runtime PM can workaround this issue.

What’s next step here? Is it a firmware bug?

Kai-Heng

>
> Kai-Heng
>
>> -Mathias


