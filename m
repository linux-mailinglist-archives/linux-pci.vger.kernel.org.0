Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1381C1EBF
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 22:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEAUmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAUmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 16:42:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D924AC061A0C;
        Fri,  1 May 2020 13:42:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so972744wmb.4;
        Fri, 01 May 2020 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQ7M29FKDRXrS5WyabdRDK8yQBctozgCq2gxMgqjNhw=;
        b=Oa/CIuVNGXc4I4qB1x0r+CbWkUBG8vSqAuBTMbSP9iU4EpmULrI4InbSp1bxqgQwBY
         P3om+WZbPKkCm31ybUVPmmka/mtkYy8iuR7SoPi8/XQCIoq6+CJobuwCuTSr3QIboxiJ
         bV1DzdHCaaCwmPnqZr6qBuJ6wUFoAAM9d8vwRIQKZaYSpBqs+vTzpXoLW58eOJdk7Yg2
         Hs1jpT1ccth54rxvWKfPvc76/M0HcBZOXo6x8c4CAIIih130szXD7k3ew45kFwfCs2b7
         /Ki7WVZS57m2oAm8N1MbCBQ3TtlEbyweLPO2wd2dNU83P1oCTUAJ0TTaZFW71Q2d4EvK
         jthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQ7M29FKDRXrS5WyabdRDK8yQBctozgCq2gxMgqjNhw=;
        b=cjDJa0OcMfjlSS7cajQ5QOjtDvfnQWslQBgHhUSQtF++FDlhMIrzqvQ1lDf5+Z/row
         0ApCThkYqz3TkmlF44TKMrEbDQVIesPDYgmy5oB1ieGnvxANkS2IVnFq7vqLoMLZ9jsf
         7IdbePawhHhQOLaJ1HzBaDtWVKbnlqK1rprU0P5/CoDmqxB2UCnYj0WKS72bKaW23jX4
         ktV4ETqKLz7Xt18RBW8x5bR0EdQG2FHI5CLBVCvcfUVYarQiZjfouVSvsCGQceb+Q4S5
         +dKIoCZD3euuk1Og1pDc8UKVL347TdSJ+vIGf4XF7UTJyQHY2X2kk/X2b2SLtmTCY0Qz
         XcVA==
X-Gm-Message-State: AGi0PubAubO5dPXVmv/zk42GQDmvear5LqLS////2AWhMmF0WNd4ZkZI
        ci7/xce2SK+aA0Qe0qZ8/vtEGA9b
X-Google-Smtp-Source: APiQypKf00e9p2RvGXodLF2vQTADXDVns2QFEA94mMJpftJibjwPJqHYr/yF77SGsUWcrVHawQ5Q/w==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr1424069wmk.68.1588365728152;
        Fri, 01 May 2020 13:42:08 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id s14sm1018920wmh.18.2020.05.01.13.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 13:42:07 -0700 (PDT)
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20200426123148.56051-1-marek.vasut@gmail.com>
 <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com>
Date:   Fri, 1 May 2020 22:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> The PHY initialization function pointer does not change during the
>> lifetime of the driver instance, it is therefore sufficient to get
>> the pointer in .probe(), cache it in driver private data, and just
>> call the function through the cached pointer in .resume().
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>>       branch pci/rcar
>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Squashed in https://patchwork.kernel.org/patch/11438665

Thanks

> Do you want me to rename the $SUBJECT (and the branch name while at it)
> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> the commit subject tag renaming from this cycle (and in the interim you
> send a rename for the drivers files ?)

I don't really have a particular preference either way. I can keep
marking the drivers with pcie-rcar and pci-rcar tags if that helps
discern them.
