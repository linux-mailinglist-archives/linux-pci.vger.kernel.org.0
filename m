Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8D40A656
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 07:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbhINF5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 01:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhINF5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 01:57:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A177C0617AF;
        Mon, 13 Sep 2021 22:56:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so18241672wrb.3;
        Mon, 13 Sep 2021 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73bi6it4gjJbrBuLDIJpdXx+yqm4ktFJ0GsBXEX9Zvc=;
        b=GEj2xA3+IC3xJS5HPubduuXygw3RWFJTkVXFCVJw+n3XPauG6l1Jn9C6LASqjefgp9
         UqEs5LIAOmfknADFilJ21dqXDxJivbpqjJncphkGrwWNgn67m74hVBNEQ+x9JBHYe1zx
         W+GmLzg1YXKJDXMiK3goBYU+NI5UFRXrXJ1W8SBmx5L23yFUH1CJgSnHNECSO5CIfaGn
         5ziweN1cXuuw5Qk/2FJcAWB3XSgF70Gdx2gCd8v/ocaj4PRobHw2BlJgT5M9kRBsKECh
         qUNT9CnbHpXyqnLKQHLcCH9Ga+k5lpGtzqdz0QkhxY3ciRyz8+vtQlBx0/GJ5N+Ho6Sc
         KDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73bi6it4gjJbrBuLDIJpdXx+yqm4ktFJ0GsBXEX9Zvc=;
        b=3/jnPzcqC9zIiBKJYffArtrruWPmSFd5gXRPz6X1wbzfqPTxxL1sfBBTI5DyeQDSj+
         5w6xcRbrBbWGz/cs8CfxmeGJGBhoUIggdDbZyMo04dsdzF9K1W3HobaWkPxtO/d5zUC1
         UUkIDihA1hRbth9IdAhS19iCmnlEq1G9jyas2z/mZRU8v87kZKIZGBoxFoq18yQCU3pA
         0wD8uj+OmBN6ZJzG85pIjkU0NLEkgqbqB6LkG803JwNE7dK2nukfX+VSgglyGxeCP1ar
         5hCzBZsT/vUEAfSpgDkszKRH7r1qzCf+QKQn96XpBgWjit6GMKv0DDROyOqyyU/LkPDg
         /2AA==
X-Gm-Message-State: AOAM531E9aZpl1gN5ZiMEXAEGwwoH8dA5W+aCgn++S92Ki3vRA4CkyD3
        CEj9BovaqyfC34EVN2FomBw=
X-Google-Smtp-Source: ABdhPJwZ6cvA3JEn4sBvohZdyDUgIeRcGsP/+NNKJLqf0RPrjWNdQ0LqDI/DYbbXyaqKgn7r6+GZ2A==
X-Received: by 2002:a05:6000:1284:: with SMTP id f4mr16839464wrx.88.1631598965742;
        Mon, 13 Sep 2021 22:56:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:d493:df4c:6694:d298? (p200300ea8f084500d493df4c6694d298.dip0.t-ipconnect.de. [2003:ea:8f08:4500:d493:df4c:6694:d298])
        by smtp.googlemail.com with ESMTPSA id h16sm9376626wre.52.2021.09.13.22.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 22:56:05 -0700 (PDT)
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
To:     Dave Jones <davej@codemonkey.org.uk>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>, todd.fujinaka@intel.com,
        Hisashi T Fujinaka <htodd@twofifty.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
Date:   Tue, 14 Sep 2021 07:51:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.09.2021 01:32, Hisashi T Fujinaka wrote:
> On Mon, 13 Sep 2021, Heiner Kallweit wrote:
> 
>> On 13.09.2021 22:32, Dave Jones wrote:
>>
>> + Jesse and Tony as Intel NIC maintainers
>>
>>> On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
>>>
>>> >> This didn't help I'm afraid :(
>>> >> It changed the VPD warning, but that's about it...
>>> >>
>>> >> [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
>>> >> [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
>>> >> [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
>>> >>
>>> > With this patch there's no VPD access to this device any longer. So this can't be
>>> > the root cause. Do you have any other PCI device that has VPD capability?
>>> > -> Capabilities: [...] Vital Product Data
>>>
>>>
>>> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>>>         Subsystem: Device 1dcf:030a
>>>     ...
>>>             Capabilities: [e0] Vital Product Data
>>>                 Unknown small resource type 06, will not decode more.
>>>
>>
>> When searching I found the same symptom of invalid VPD data for 82599EB.
>> Do these adapters have non-VPD data in VPD address space? Or is the actual
>> VPD data at another offset than 0? I know that few Chelsio devices have
>> such a non-standard VPD structure.
>>
>>>
>>> I'll add that to the quirk list and see if that helps.
>>>
>>>     Dave
>>>
>> Heiner
> 
> Sorry to reply from my personal account. If I did it from my work
> account I'd be top-posting because of Outlook and that goes over like a
> lead balloon.
> 
> Anyway, can you send us a dump of your eeprom using ethtool -e? You can
> either send it via a bug on e1000.sourceforge.net or try sending it to
> todd.fujinaka@intel.com
> 
> The other thing is I'm wondering is what the subvendor device ID you
> have is referring to because it's not in the pci database. Some ODMs
> like getting creative with what they put in the NVM.
> 
> Todd Fujinaka (todd.fujinaka@intel.com)

Thanks for the prompt reply. Dave, could you please provide the requested
information?
