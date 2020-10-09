Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C3288B5A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgJIOcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbgJIOcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 10:32:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A4C0613D2
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 07:32:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 16so10356913oix.9
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/QR6qwLgORMJuCG90xSsPNmnRMfTjoqVz1zBHbtgN8=;
        b=OUwUTc78vd9Ub4lQXW7sw9y8Mosqbw1llTaYBvd0SAmpzb58pRJ+Vw9eswY4w3b+OU
         XMdwbNYn7npa76cq/CrWvgN7kVWyAN3wjXwfweuMsOCkVi2kk3LMtqnYloOWQ+zIYVCx
         aBXgJlYxCorePPUePLaBpcTUdTy4HfK42Ku5UJA+yyAhsofh7q1W+Tc6BDfVfa5tO5Hv
         fIa4oZf9zyfJLYybky1qhgxNh7E3ryJdmAqvxQvihwh8o1ZFSfAxCUvrAfYjKM5MBLhJ
         faqJSBkd8SqZku3TK5oQbSeQjKoEqh5TuTClIyAQWIRe7cT665yXr01leK3x08UYxYlz
         222g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/QR6qwLgORMJuCG90xSsPNmnRMfTjoqVz1zBHbtgN8=;
        b=qEuIBg32U3Idvuu8QWcGewo30vGiuTea3gxKOvlFUIEZCKB5XRN0pgNT/FtWf2REd5
         I7CjjMLlL7y4gqKPP43ji36cKk7RSFKyb6Awa4+axHd8Fo6JjngbfrEg7PV/ktDzWG6K
         UEbFkMIduZvxWZKXmdp59JwuFirCjClhmZEryGBPdaRF7/yJzryNvUs+7jMjNgrpbv5C
         PRgfi/TSmY11V0o3yiUTM7ZrnM3dAFhLMVTMknUiGCX6Ykl5M8DnjGhmwuCMx48/Vc3J
         Q24CKBuBIXa6xDd2Q/83uIeH5fzPoj4VvhD1ZUS6qgv0DqCjFFJDTiDvfnhjNxyzOYcb
         xcTw==
X-Gm-Message-State: AOAM533pW4RcX/sQld2KMkw0T9h+ZEAKLtIouMUq6ZErawik+QrjG/xm
        Jwh3ID0R8iwpy+dtojmuMTk=
X-Google-Smtp-Source: ABdhPJxrzM8teHONolhbCtG7VhcEGrff2mB/X42YCACZFjGOjWdNM4QRGX1BGun2aSCbYcZVciO7tQ==
X-Received: by 2002:aca:fd16:: with SMTP id b22mr2720430oii.13.1602253953475;
        Fri, 09 Oct 2020 07:32:33 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id u140sm7238660oie.41.2020.10.09.07.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:32:33 -0700 (PDT)
Subject: Re: spammy dmesg about fluctuating pcie bandwidth on 5.9
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-pci@vger.kernel.org, "Bolen, Austin" <austin_bolen@dell.com>
References: <20201007170200.GA3251244@bjorn-Precision-5520>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <e0b40eed-72a4-dde0-3622-2a9a28db1e62@gmail.com>
Date:   Fri, 9 Oct 2020 09:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007170200.GA3251244@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Austin]

Hi Bjorn,

That log looks like the PCIe registers spitting wrong values, but all I 
can do is speculate. Have we verified we don't have a race condition 
between ASPM and pcie_report_downtraining()?

I wouldn't be surprised if the cause of the messages is the device (or 
downstream port) faking all f's responses. I don't see how else we'd get 
links reported as x63 32GT/s.

Alex


On 10/7/20 12:02 PM, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Wed, Oct 07, 2020 at 06:09:06PM +0200, Jason A. Donenfeld wrote:
>> Hi,
>>
>> Since 5.9 I've been seeing lots of the below in my logs. I'm wondering
>> if this is a case of "ASPM finally working properly," or if I'm
>> actually running into aberrant behavior that I should look into
>> further. I run with `pcie_aspm=force pcie_aspm.policy=powersave` on my
>> command line. But I wasn't seeing these messages in 5.8.
> 
> I'm sorry that you need to use "pcie_aspm=force
> pcie_aspm.policy=powersave".  Someday maybe we'll get enough of ASPM
> fixed so we won't need junk like that.  I don't think we're there yet.
> Do you build with CONFIG_PCIEASPM_POWERSAVE=y?  Do you need
> "pcie_aspm=force" because the firmware tells us not to use ASPM?
> 
> Re: the messages below, they come from Link Bandwidth Management
> interrupts.  These *should* only happen because of a
> software-initiated link retrain or because hardware changed the link
> speed or width because the link was unreliable.  ASPM shouldn't cause
> these.
> 
> So it's possible you have an unreliable slot, but I doubt it because
> you said v5.8 works fine, and also the Link Bandwidth interrupts
> should only happen if something *changed*, but all the messages below
> look the same to me.
> 
> Something is also wrong with them -- there's no such thing as a "x63"
> link.  But maybe these are copy/paste errors?  I don't know where the
> "b.4" comes from either.  Oh, that probably belongs with
> "0000:00:1b.4" but got separated by copy/paste.
> 
> Obviously you can stop the messages by unsetting CONFIG_PCIE_BW.
> 
> The code (drivers/pci/pcie/bw_notification.c) is pretty
> straightforward and I don't see an obvious problem, but maybe Alex
> will.
> 
>> [79960.801929] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [79981.679813] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80002.001267] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80023.842169] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80045.763841] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80068.083577] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80090.351526] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80112.750350] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80134.749255] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80155.763411] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80178.457760] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80200.804896] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80223.311729] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80245.791343] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80267.870825] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80289.713123] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80311.978655] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80334.701124] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80355.658151] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80377.844362] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80400.538230] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80422.575182] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80445.282519] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80467.714932] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80490.148981] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80509.719262] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80531.764821] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80553.767613] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80574.943252] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80597.579091] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80619.711966] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80641.901453] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80664.592372] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80686.622715] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80709.291964] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80731.844729] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80754.541540] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80777.075171] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80799.794398] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80822.489116] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80844.934930] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80865.739007] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80888.219031] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80910.753669] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80932.989664] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80954.833210] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80977.477922] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [80998.699385] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81020.726597] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81042.750936] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81065.257417] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81087.767519] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81110.493829] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81132.617088] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81154.700420] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81177.363880] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81199.946937] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81221.794056] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81243.043378] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81265.709152] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81287.630090] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81309.763332] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81318.920797] EXT4-fs (dm-2): mounted filesystem with ordered data
>> mode. Opts: (null)
>> [81332.457364] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81354.404894] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81376.669492] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81398.964385] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81421.657484] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81444.243407] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81466.243845] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81486.750420] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81508.936351] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81531.285200] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81553.791276] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81575.793924] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81597.844229] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81620.550927] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81643.227381] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81665.900018] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81688.617113] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81710.952986] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81730.963752] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81753.669690] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81776.056524] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81798.212865] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81820.906623] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81842.002407] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81864.319510] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81887.016001] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81909.719258] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81931.279258] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81953.922625] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81974.239845] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [81996.957939] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82019.066339] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82041.651293] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82064.344822] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82085.977719] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82108.451266] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82131.141927] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82153.867813] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82175.818802] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82197.678494] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82219.947803] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82241.784890] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82264.480971] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82287.199484] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82309.863960] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82331.783480] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82354.189336] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82376.876548] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82398.800816] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82420.979857] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82443.678685] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82466.211265] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82486.823160] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82509.539779] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82531.808332] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82553.836533] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82576.049885] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82597.995713] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82620.691143] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82642.050409] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82663.891937] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82686.238435] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82708.929312] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82731.008511] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82753.730734] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82775.711219] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82798.370968] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82820.741946] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82842.931577] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82865.620923] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82888.350976] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82911.034043] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82933.743876] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82956.247764] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [82978.767434] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83000.796754] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83022.660145] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83045.353526] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83068.163036] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83090.793322] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83113.489363] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83135.812852] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83158.399350] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83181.118694] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83203.805756] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83225.945483] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83248.525805] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83271.217918] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83293.938688] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83316.177679] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83337.141733] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83359.831741] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83381.940645] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83404.657248] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83426.927612] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83449.646961] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83472.336930] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83493.830913] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83514.470154] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83536.790704] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83559.247431] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83581.943573] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83604.555801] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83626.769373] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83649.489632] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83672.182965] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83694.872527] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83717.082388] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83739.808368] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83762.122494] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83784.758621] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83807.488464] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83830.201485] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83852.894547] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83875.491085] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83898.078276] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83920.793717] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83942.740521] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83964.587599] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [83987.170436] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84009.893456] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84032.606254] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84055.329572] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84077.823293] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84100.519811] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84123.296376] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84145.935520] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84168.659294] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84190.605264] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84213.215194] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
>> bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b
>> .4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84235.938442] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
>> [84258.658162] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1
>> b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
