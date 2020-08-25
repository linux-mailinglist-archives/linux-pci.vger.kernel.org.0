Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D73251E84
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHYRkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYRkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2020 13:40:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03BC061574;
        Tue, 25 Aug 2020 10:40:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nv17so1622242pjb.3;
        Tue, 25 Aug 2020 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2CIAlEB0sn0czmBCstmmbk0rRRc0a7Q7Eg5uRFK+DTM=;
        b=OWtTyCh4mBkSanD+KT2LmsSmys9GdgNPDuMOUrEMBvirSVEpgWaccxzuVDCSUPzr+g
         UL3d/b/WhkUnWbhm0C+dKAbICczXHeEay6JEghnYPq1AWGXV0OqUHZVzSR0vH40qB4T7
         CvKheJOKe1bLwlHMjKz6V1TnFYQX/QwQ3zFo3OtKNBualjgvS3McIxk5bZckCXdHUxPn
         y5cllopsvswApow32o5Hqk8i69l4DMq5zNUIBV31X/TRx3SDq4RkHJpDQFbpdjwtNLEK
         YafzqTXU3/pyTiKmRDgRCRX9RrujtgeJf8Hbr9VBxTZRL/Jzkqt3LfmQHxV5h/PRKVwB
         vyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CIAlEB0sn0czmBCstmmbk0rRRc0a7Q7Eg5uRFK+DTM=;
        b=A+n5alUnkz/m6ra9z01JjGdiTqBX2TkMKr+7HXDFTg3kAk/S9CB/sx3PWn5pwDE//w
         E0udbLC4dIkRkpqP+mP3LpnwsHVbaDtCBYoERoxyfNhqCpkx5qTVIr8VbwfNplNjyUnc
         TLEe326HQmGKldC5HAUaE2tnNqaUG6YS2NSXuyDWlGmD1+unY73jHrGvtnrsqTLElEEt
         NOmdun1c9d+56PUgqH52I1tbYpCStzB9W/8RJkln+YQeEBQvxxATtKRjS7mFlITLMVP6
         QWZGWEjuBd5i9DXMwhCZj7EpzpFWSWEjvPMUIziUy0oz+fkQ6fhh0Y1Unf9eHj8Hz2Kw
         nTnA==
X-Gm-Message-State: AOAM530Z0c0qybj+uBNWhb82MQyzUWm8EaxcTLm1K+XFlM2U8K6JRHiE
        lg1AH3tWBwuRc1JMlJAcl2g=
X-Google-Smtp-Source: ABdhPJygG/iRoMRtYkc62+6+vovnxiIUBYXGvz6sXIt/PP/MjnVCr6wdHgCpE82t+Egu2LRmdgvskQ==
X-Received: by 2002:a17:90a:eb17:: with SMTP id j23mr2403499pjz.151.1598377230639;
        Tue, 25 Aug 2020 10:40:30 -0700 (PDT)
Received: from [10.69.79.32] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b6sm3378574pjz.33.2020.08.25.10.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:40:29 -0700 (PDT)
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Julien Grall <julien.grall@arm.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com>
Date:   Tue, 25 Aug 2020 10:40:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200824193036.6033-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/24/2020 12:30 PM, Jim Quinlan wrote:
> 
> Patchset Summary:
>    Enhance a PCIe host controller driver.  Because of its unusual design
>    we are foced to change dev->dma_pfn_offset into a more general role
>    allowing multiple offsets.  See the 'v1' notes below for more info.

We are version 11 and counting, and it is not clear to me whether there 
is any chance of getting these patches reviewed and hopefully merged for 
the 5.10 merge window.

There are a lot of different files being touched, so what would be the 
ideal way of routing those changes towards inclusion?

Thanks!
-- 
Florian
