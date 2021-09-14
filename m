Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D840BAB9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 23:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhINVwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhINVwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 17:52:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF6C061574;
        Tue, 14 Sep 2021 14:51:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so511227wrc.11;
        Tue, 14 Sep 2021 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OPJbwAqXrMsOcJb8XAwTNGK0vR2vI1IDCcn49AAPJO4=;
        b=Ppa4tQ0IHeC1CBzsb5Q2dWHqx6eT4d6nrNQpswjlK/uQOfT/GzFdJQiXnl2/OIWdXm
         OkLOtMHuo1Ol8eNByFXSMlheJiyy4oUs19c2Fbs5xbdXZPNRGkwqMWu1SXnnF3/xwe3M
         v1aM3VvdgTsYjJgD0gcqDTk86wj+uS6+Rd60tc/5ZhyIpgMVIwiEZD0DSZxzOm4GOXxc
         fltX/85Xw8ScOlpsPiHS0wVC37TL+EnBriY5wtj9zX01CEhDETXV+kDSaIDHentrH0Xl
         N56QbInFtK3hXWp6iL3sDGFsGkZgpS7mvTqsLztNzIpSUy0dFEHYJPtSQxJcdnlZ6WWa
         cTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OPJbwAqXrMsOcJb8XAwTNGK0vR2vI1IDCcn49AAPJO4=;
        b=R7PRP/RZHg3YDiRmnYXCTU8emC+ExlClBkIPdw3wovioTk3Z5nb6OIfprWxONHcLD3
         PEWxbbXtrd6MBaQ+K7TbCDyfkKSh7cKo4IWp9FlafFrKvN2+hULSRhcs9w2I3lQ4ZjQG
         gyZr++ourSUsthI9KMRdOQGCTpYvbhyILfxjkYtPs7DhOvqbILV87sFsQ0hWeXMBbtyY
         nas9+TWhpVJsAg4Ow71LWw6mYt9uLJevVA3+Zz5izYZ27oSv0K3iLlxPnomb6aR4LMDM
         cfe2InT4wR5qB7fsdpLTL0XoX6E5VEpX7o/xGp/bTwbf1iD26++WieTIyD1LlLFok042
         5jug==
X-Gm-Message-State: AOAM533K/8BlGUwpUsV/ilt5PJ1AX9EoFVFDepV1veqQiecezoQ5Qmyj
        WpiWfkBz+1qjKPVydZxevWk=
X-Google-Smtp-Source: ABdhPJymQCXOlgRMbpJLVZXHTSg6rLwtJXzFYryP5jXD71XOResbDlsr+VDOxvGA8SVZJ/HS1R9R7g==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr1279748wrp.349.1631656295628;
        Tue, 14 Sep 2021 14:51:35 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:452c:df07:20dd:cf7b? (p200300ea8f084500452cdf0720ddcf7b.dip0.t-ipconnect.de. [2003:ea:8f08:4500:452c:df07:20dd:cf7b])
        by smtp.googlemail.com with ESMTPSA id w14sm2861964wro.8.2021.09.14.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 14:51:35 -0700 (PDT)
To:     Hisashi T Fujinaka <htodd@twofifty.com>,
        Dave Jones <davej@codemonkey.org.uk>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
 <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
 <20210914142419.GA32324@codemonkey.org.uk>
 <c02876d7-c3f3-1953-334d-1248af919796@twofifty.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
Message-ID: <80718d5e-a4d2-ff85-aa8f-cd790c951278@gmail.com>
Date:   Tue, 14 Sep 2021 23:51:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c02876d7-c3f3-1953-334d-1248af919796@twofifty.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.09.2021 22:00, Hisashi T Fujinaka wrote:
> On Tue, 14 Sep 2021, Dave Jones wrote:
> 
>> On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
>>
>> > > Sorry to reply from my personal account. If I did it from my work
>> > > account I'd be top-posting because of Outlook and that goes over like a
>> > > lead balloon.
>> > >
>> > > Anyway, can you send us a dump of your eeprom using ethtool -e? You can
>> > > either send it via a bug on e1000.sourceforge.net or try sending it to
>> > > todd.fujinaka@intel.com
>> > >
>> > > The other thing is I'm wondering is what the subvendor device ID you
>> > > have is referring to because it's not in the pci database. Some ODMs
>> > > like getting creative with what they put in the NVM.
>> > >
>> > > Todd Fujinaka (todd.fujinaka@intel.com)
>> >
>> > Thanks for the prompt reply. Dave, could you please provide the requested
>> > information?
>>
>> sent off-list.
>>
>>     Dave
> 
> Whoops. I replied from outlook again.
> 
> I have confirmation that this should be a valid image. The VPD is just a
> series of 3's. There are changes to preboot header, flash and BAR size,
> and as far as I can tell, a nonsense subdevice ID, but this should work.
> 
> What was the original question?
> 
"lspci -vv" complains about an invalid short tag 0x06 and the PCI VPD
code resulted in a stall. So it seems the data doesn't have valid VPD
format as defined in PCI specification.

01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
        Subsystem: Device 1dcf:030a
	...
	        Capabilities: [e0] Vital Product Data
                *Unknown small resource type 06, will not decode more.*

Not sure which method is used by the driver to get the EEPROM content.
For the issue here is relevant what is exposed via PCI VPD.

The related kernel error message has been reported few times, e.g. here:
https://access.redhat.com/solutions/3001451
Only due to a change in kernel code this became a more prominent
issue now.

You say that VPD is just a series of 3's. This may explain why kernel and
tools complain about an invalid VPD format. VPD misses the tag structure.

> Todd Fujinaka <todd.fujinaka@intel.com>

