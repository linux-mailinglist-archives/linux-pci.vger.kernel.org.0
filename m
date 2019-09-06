Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD3AC360
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406237AbfIFXsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 19:48:38 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41532 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405441AbfIFXsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 19:48:37 -0400
Received: by mail-oi1-f178.google.com with SMTP id h4so6415586oih.8
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2019 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zgzwkt+5f1+/iBFBVoRN90jtDmZfYNKs9pY9DhgTDjc=;
        b=JEEmEyZFTTQooYacCcG91OmWsvF7c3cq/rhjtA3a/nTuS6Ga+HEx7++8VnoK7w8wRL
         AYj+NwydiEpRVewLjZ7o9w66FI7RCnkCHk70oKhqZeJ3dUB8GTdwBR+olMJrflH8LDVo
         2R4yWPZY4VSBojDe5SjL/we465450kyr0QmNBAAPnDi22NTTWwtGTTFR+53vrNaAsTOS
         HUT7ppkyFoHJeB/Z0JVBhJBH0CQuA+eKkqmhoew12kiuYyrcapIVPUIVZfjVp4Vsp7/7
         F/OEzr7lPo5HnlJNCs7VsEXHwndntesEGmr4RzS7N3D1Zf/xNmTPXT+5fZ0ChrWgBSmL
         VN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zgzwkt+5f1+/iBFBVoRN90jtDmZfYNKs9pY9DhgTDjc=;
        b=fQSiX/8ekQKnIQ7xfsm9M1vyjvk45Pxeh3+YHKfBEbQnvUYnI8Cs/W33eo+qKOthWe
         gzUAaQUrskfCmzsFdy2vGEsQlESdWZTQUk4Nc9X2BnQ8bRfxb9FXm32hCrvuAp7upN0A
         gZaUkl2OLNcS65jyFzCR8VbOxXTybrVC9vr0vm5TotZXEfPaJrdu/7S7UlUJ5xpODZHu
         bhJxocgEVIioY8i+9dFnOHfzkbH3JxjaJ1b2oCuOwyAxofLBm6eyBgw0rCilRXxTt8DC
         +4SkeSmp2Mq+B25Qv8Qj0qk+W+sRKjzgACwVdZ0T3HjApjJ2Qg5BaLxKDrj7KXIwiKC2
         DYug==
X-Gm-Message-State: APjAAAVjo4avMhQBlHr77opGxAvtRNT1iPdKHHYjBhdmyEwO2KEEwNyD
        RmCgjYv2EWtZpiJ+ETwIEBi9lA==
X-Google-Smtp-Source: APXvYqwPNSpBLERK5GgL8C24yZ3QXvoJEelDepgsSvqfBDQjtuEXeygHb1WD9ypJTeyyK/iEFY8+Qw==
X-Received: by 2002:aca:1004:: with SMTP id 4mr8798928oiq.92.1567813716654;
        Fri, 06 Sep 2019 16:48:36 -0700 (PDT)
Received: from [192.168.71.78] ([12.235.129.34])
        by smtp.gmail.com with ESMTPSA id 23sm2218038oiz.8.2019.09.06.16.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:48:36 -0700 (PDT)
Subject: Re: AMD Epyc iperf perfomance issues over NTB
To:     linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
 <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
From:   Kit Chow <kchow@gigaio.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "Eric Pilmore (GigaIO)" <epilmore@gigaio.com>
Message-ID: <d719f986-f9ce-a0c3-f9a1-1fe06a3cc0cc@gigaio.com>
Date:   Fri, 6 Sep 2019 16:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a follow-up of the initial problems encountered trying to get 
the AMD Epyc 7401server to do host to host communication through NTB. 
(please see thread for background info).

The IO_PAGE_FAULT flags=0x0070 seen on write ops was in fact related to 
proxy ID setup as Logan had suggested. The AMD iommu code only processed 
the 'last' proxy ID/dma alias; the last proxy ID was associated with 
Reads and this allowed Read ops to succeed and Write ops to fail. Adding 
support to process all of the proxy IDs in the AMD iommu code (plus 
adding dma_map_resource support), the AMD Epyc server can now be 
configured in a 4 host NTB setup and communicate over NTB (tcp/ip over 
ntb_netdev) to the other 3 hosts.

The problem that we are now experiencing, for which I can use some help, 
with the AMD Epyc 7401 server is very poor iperf performance over 
NTB/ntb_netdev.

The iperf numbers over NTB start off initially at around 800 Mbits/s and 
quickly degrades down to the 20 Mbits/s range. Running 'top' during 
iperf, I see many instances (up to 25+) of ksoftirqd running which 
suggests that interrupts are overwhelming the interrupt processing.

/proc/interrupts show lots of 'ccp-5' dma interrupt activity as well as 
ntb_netdev interrupt activity. After eliminating netdev interrupts by 
configuring netdev to 'use_poll' and leaving ccp, the poor iperf 
performance persists.

As a comparison, I can replace the ccp dma with the plx dma (found on 
the host adapter card) on the AMD server and get a steady 9.4 Gbits/s 
with iperf over NTB.

I've optmimized for numa via numactl in all test runs.

So it appears that the iperf NTB performance issues on the AMD Epyc 
server are related to the ccp dma and its interrupt processing.


Does anyone have any experience with the ccp dma that might be able to help?

Any help or suggestions on how to proceed would be very much appreciated.

Thanks
Kit

kchow@gigaio.com
