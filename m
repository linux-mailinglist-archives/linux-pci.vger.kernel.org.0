Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BD3464E3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhCWQU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhCWQU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 12:20:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078BBC061574;
        Tue, 23 Mar 2021 09:20:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso10327091pjb.3;
        Tue, 23 Mar 2021 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C/wsOsHKAQ1XBRFwha550Qx3YH4mgBDe2e9NThAGXek=;
        b=VK9xjlPofk3BwoLQgbj31mIWYYlmii7xIsdbNXoGlPSPVrIBUSVbqctOkOrSLCHZtm
         NLyq/rOMQtwCxGBT42ueF74WLk1Jq0fMbZ5uV74KRarUdbJCETtces7bwlkIuIwCPBFt
         Qk4Gh9tErGJyh2tRK/jOJ3rm0qqyMzNe0TdR2eNTqyNhaNzraRRBs3m+LzXWOZ2HTyuW
         4KYE7Z8i6uz0t56ufTLIXpATmpK9UWlqmVJry1QH6YPdY7XlLYFZCwegK+6KMpOiOyQX
         XK3OI6xiNUXBgZcgdRW0Cxl0TXV5TywUGE9UVGMps9mZj7ptGusVgFXOVOO72SaCckdO
         K0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C/wsOsHKAQ1XBRFwha550Qx3YH4mgBDe2e9NThAGXek=;
        b=N2CbVshOXnaBA2gFY6WHeNpAhMdH+ki8XH7Yuaj27aBMBXaPEU9sDid8NnYI7UT4We
         sMHC4azz+8zvFus4FSmdkYmC5XCa4BPCbixTFRDhAYBdMH7rDRkMclkhQX47c4evx9kX
         +OJhpCXyym+pJsOFm6w73xEJEKdgnRY3o8DCMF2noys0m+pnDvDfMzY/OjyYYaswassV
         +2RbSpSi+h1z07v5szsP18qIFeBTJrXyywml3QozDy5xek0Y4T3aSKf5ImWQlfLlA3Xg
         RkrGLyXUoLmC5aHzVsmWiTg9Vcwh9w4odSEC/D6ltfVxWgfgxQJSob8vDHK85+yGtZJc
         MD1g==
X-Gm-Message-State: AOAM5322AeMFLxiKXSQOWQ46/dvjQO//2gQgDG81QJvw3/5Le602+ZJX
        +lZxpR0kEWC5Bk1OzepN8lk=
X-Google-Smtp-Source: ABdhPJzszYg5j4ZmGwF5H1N4Z0ZTDZX7slOHg7r6GpQ1D2ykDq4UPdCh41SnHBdaCYRvRqgCb3JbOQ==
X-Received: by 2002:a17:90b:360b:: with SMTP id ml11mr5099805pjb.98.1616516428582;
        Tue, 23 Mar 2021 09:20:28 -0700 (PDT)
Received: from localhost ([2401:4900:5298:bb2f:6d40:6041:a658:f52a])
        by smtp.gmail.com with ESMTPSA id f2sm17981129pfq.129.2021.03.23.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:20:28 -0700 (PDT)
Date:   Tue, 23 Mar 2021 21:49:41 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     alex.williamson@redhat.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, kabel@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: How long should be PCIe card in Warm Reset state?
Message-ID: <20210323161941.gim6msj3ruu3flnf@archlinux>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310110535.zh4pnn4vpmvzwl5q@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/10 12:05PM, Pali Rohár wrote:
> Hello!
>
> I would like to open a question about PCIe Warm Reset. Warm Reset of
> PCIe card is triggered by asserting PERST# signal and in most cases
> PERST# signal is controlled by GPIO.
>
> Basically every native Linux PCIe controller driver is doing this Warm
> Reset of connected PCIe card during native driver initialization
> procedure.
>
> And now the important question is: How long should be PCIe card in Warm
> Reset state? After which timeout can be PERST# signal de-asserted by
> Linux controller driver?
>
> Lorenzo and Rob already expressed concerns [1] [2] that this Warm Reset
> timeout should not be driver specific and I agree with them.
>
> I have done investigation which timeout is using which native PCIe
> driver [3] and basically every driver is using different timeout.
>
> I have tried to find timeouts in PCIe specifications, I was not able to
> understand and deduce correct timeout value for Warm Reset from PCIe
> specifications. What I have found is written in my email [4].
>
> Alex (as a "reset expert"), could you look at this issue?
>
> Or is there somebody else who understand PCIe specifications and PCIe
> diagrams to figure out what is the minimal timeout for de-asserting
> PERST# signal?
>
> There are still some issues with WiFi cards (e.g. Compex one) which
> sometimes do not appear on PCIe bus. And based on these "reset timeout
> differences" in Linux PCIe controller drivers, I suspect that it is not
> (only) the problems in WiFi cards but also in Linux PCIe controller
> drivers. In my email [3] I have written that I figured out that WLE1216
> card needs to be in Warm Reset state for at least 10ms, otherwise card
> is not detected.
>
> [1] - https://lore.kernel.org/linux-pci/20200513115940.fiemtnxfqcyqo6ik@pali/
> [2] - https://lore.kernel.org/linux-pci/20200507212002.GA32182@bogus/
> [3] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
> [4] - https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/

I somehow got my hands on PCIe Gen4 spec. It says on page no 555-
"When PERST# is provided to a component or adapter, this signal must be
used by the component or adapter as Fundamental Reset.
When PERST# is not provided to a component or adapter, Fundamental Reset is
generated autonomously by the component or adapter, and the details of how
this is done are outside the scope of this document."
Not sure what component/adapter means in this context.

Then below it says-
"In some cases, it may be possible for the Fundamental Reset mechanism
to be triggered  by hardware without the removal and re-application of
power to the component.  This is called a warm reset. This document does
not specify a means for generating a warm reset."

Thanks,
Amey
