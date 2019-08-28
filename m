Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181919FCE1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1IZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:25:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1IZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:25:16 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2tGU-0005iR-7h
        for linux-pci@vger.kernel.org; Wed, 28 Aug 2019 08:25:14 +0000
Received: by mail-pf1-f200.google.com with SMTP id b8so1507021pfd.5
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yDQMhkjBqvMckIaETJ30I1V3/odVpy6UAuG1t5GavCg=;
        b=HvYcEJzTyRaNSY68iFtluM5o4FrQVlFdOlxDzyv3Xq+CBGDFXxAnovRtY6lik/rr1X
         y0n0Q6hrIYWWzK6WvZkKExle6ADIXFfWJYcRX8EOD+hwuliGqAtH9JteqBg++HR1T1a4
         MdLxUM8OwWOJAh9xIF46OezrcZjlQD4Y9InuISrmx8YwuLNTl+D57gt7I5ClwmNNNR/B
         AZiSLxjO13CIfesS96qxfIpUEOLiMLGBV26eIF9jWS2g9GGqO39NtDmpIgUZn7lgjXTv
         z0SZc/nyiMU/uIk40S2qeB9v9270EvblLoyFQwhMsympdZ6+2Dy17xcQtBwWAPpxEzTP
         QRjQ==
X-Gm-Message-State: APjAAAXwXzrwUvC20gO6xQpO+JgrfH/lcTIcmewmrQGYbDwhXE18wYmG
        ghuuLlMjWC9R+6Ybh/mi2skJs04cksP+95EjTkAcMFhgNtgWCKSAK321YSu6LmSfbamQ2SgTNy1
        xEv9l+pjHt90tH04t7/GrCuCDE9h1qw3em+4aOQ==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3053421plk.91.1566980712711;
        Wed, 28 Aug 2019 01:25:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg3xPhlxpHv0Jw3q47+NdHNvNzyyatg4MSCzNk9Lkvz07TQuVYjHaH9aQx5W+/tAUeIxm73Q==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3053407plk.91.1566980712363;
        Wed, 28 Aug 2019 01:25:12 -0700 (PDT)
Received: from 2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net (2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:f8f8:a260:49a8:d1ed])
        by smtp.gmail.com with ESMTPSA id y9sm1820302pfn.152.2019.08.28.01.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 01:25:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190827223125.GB9987@google.com>
Date:   Wed, 28 Aug 2019 16:25:08 +0800
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <66C43B81-0A08-437F-B099-1C757A42E912@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
 <20190827223125.GB9987@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

at 06:31, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Aug 27, 2019 at 09:47:56PM +0800, Kai-Heng Feng wrote:
>> It's a common practice to let dGPU unbound and use PCI port PM to
>> disable its power through _PR3. When the dGPU comes with an HDA
>> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
>> power can't be disabled.
>
> Just a terminology question:
>
> I thought "using PCI port PM" meant using the PCI Power Management
> Capability in config space to directly change the device's power
> state, e.g., in pci_raw_set_power_state().

What I meant is to use pcieport.ko directly.

>
> And I thought using _PS3, _PR3, etc would be part of "platform power
> management”?

Ok, will update the wording.

>
> And AFAICT, _PR3 merely returns a list of power resources; it doesn't
> disable power itself.

Yes, through its _PS3 and _OFF. I’ll update the wording.

Kai-Heng

>
>> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
>> discrete GPU") only allows HDA to be runtime-suspended once GPU is
>> bound, to keep APU's HDA working.
>>
>> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
>> the runtime suspend requirement for dGPU's HDA function, to save lots of
>> power.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1840835
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  sound/pci/hda/hda_intel.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 99fc0917339b..d4ee070e1a29 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>>  		dev_info(chip->card->dev,
>>  			 "Handle vga_switcheroo audio client\n");
>>  		hda->use_vga_switcheroo = 1;
>> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
>> +		/* cleared in gpu_bound op */
>> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>>  		pci_dev_put(p);
>>  	}
>> -- 
>> 2.17.1


