Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6068C4630D3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhK3KTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 05:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhK3KTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 05:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638267344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTe64iah9Ee8NDbp7H/mB6tFciJzoxx/C9pk2Re+QDc=;
        b=cnTlafj0vdNZ9EToCplTJZvIiiNSk8dQLhu5nrV4coNCRoAR57lE2o8hC6of15Kdbsuzkx
        cAEANtL8sMAYomnPuqYw/FB9tdvW5VLCEKB6ifHuJJJauhWbQNcFD55qJZG7nLIsfP04xF
        pDxz8p8Iq6USFk470Pqu9Y7bSJKXltg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-zOCOHlmvPaayXsALDZRbUA-1; Tue, 30 Nov 2021 05:15:42 -0500
X-MC-Unique: zOCOHlmvPaayXsALDZRbUA-1
Received: by mail-ed1-f70.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so16433329edq.16
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 02:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VTe64iah9Ee8NDbp7H/mB6tFciJzoxx/C9pk2Re+QDc=;
        b=FK68jVwgMXVnSNmNCLg7M7XNw3TbyvdprOiYTko4MfBiI6n0WxXafLmwQZ8hUKtwNJ
         uXri+ITV3HdqemOlIJ9Yx7IIB7YS3kRPYn73t1kL/Nd64anqq4nhJU4ZW5GfXpIVbwvW
         yi55dXoTzCw1xtbdHs8pqxhHbZOB49jlpR+3khSbW8Sio0EH3pNx8cMcwV++3ACWtBxD
         f3Ievn3ij4KoszFeMz1Lm5rWhwuSRg2Zq/vfmMRpZNutLPMd8UZk6O0cxll6J5CB7X4n
         yHbS2CzkWKuZ7vS0m/7/icsPICpTmF38CXDhfcQftzcueDsIwrn3xOsgusMDpWdz1cm1
         9LHg==
X-Gm-Message-State: AOAM53087LCchbgeaTQZvEHIQPaWCoKIZDcrqwCGlc6kL9BedqdoB/uX
        nXIejvJpGO2yThvT/D/lDVo4Kr/PXdu01zgjKj7lB9BA+k5v0i//bk0JnuSY3ckumzKjw+YW4+V
        33i5f4I8E2ppUtbbP5ppE
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr67532696ejc.520.1638267341500;
        Tue, 30 Nov 2021 02:15:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjbQkl2A10ywTr2oj3Ze7Sopt+n+++p+NpSo+NPMh5loCoF1hZqAQ2nnDntszL/txSqoe4mA==
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr67532674ejc.520.1638267341336;
        Tue, 30 Nov 2021 02:15:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w22sm12001533edd.49.2021.11.30.02.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 02:15:40 -0800 (PST)
Message-ID: <0dcac663-4726-6deb-d518-3f29583b7baf@redhat.com>
Date:   Tue, 30 Nov 2021 11:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock)
 to fix lockdep errors
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com> <20211129153943.GA4896@wunner.de>
 <20211129185946.GA1475@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211129185946.GA1475@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

First of all thank you for the review and for all the remarks,
I agree with all of them, so I'll incorporate all of them in v2
of this patch-set including squashing the 2 patches together.

On 11/29/21 19:59, Lukas Wunner wrote:
> On Mon, Nov 29, 2021 at 04:39:43PM +0100, Lukas Wunner wrote:
>> On Mon, Nov 29, 2021 at 01:19:34PM +0100, Hans de Goede wrote:
>>> Use down_read_nested() and down_write_nested() when taking the
>>> ctrl->reset_lock rw-sem, passing the PCI-device depth in the hierarchy
>>> as lock subclass parameter. This fixes the following false-positive lockdep
>>> report when unplugging a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:
>> [...]
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> That's exactly what I had in mind, thanks.
> 
> Hm, I found the notes that I took when I investigated Theodore's report:
> Using a subclass may be problematic because it's limited to a value < 8
> (MAX_LOCKDEP_SUBCLASSES).  If there's a hotplug port at a deeper level
> than 8 in the PCI hierarchy (can easily happen, Thunderbolt daisy chain
> allows up to 6 devices, each device contains a PCIe switch, so 2 levels per
> device), look_up_lock_class() in kernel/locking/lockdep.c will emit a BUG
> error message.
> 
> It may be necessary to call lockdep_register_key() for each level or
> for each hotplug port and assign the lock with lockdep_set_class()
> (or ..._and_name() and use the dev_name()).
> 
> It's these complications that made me put aside the problem back in the day.
> My apologies for not remembering them earlier.

No worries.

I've been looking at how to rework things and this should be pretty doable.

My plan is to have a global static array of lock_class_key-s in
drivers/pci/hotplug/pciehp_hpc.c, one per depth level (say 32 of them ?)
and then use lockdep_set_class() and that looks like it should be pretty
doable.

When using a static global array of lock_class_key-s there is no need to call
lockdep_register_key().

Also see:

drivers/usb/storage/usb.c

Which does something similar to avoid issues when a single usb-device has
multiple USB-storage interfaces.

Regards,

Hans


