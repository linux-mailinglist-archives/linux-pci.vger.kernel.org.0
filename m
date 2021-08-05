Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182BE3E1C2F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbhHETLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbhHETLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 15:11:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBADC061765
        for <linux-pci@vger.kernel.org>; Thu,  5 Aug 2021 12:11:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b128so4017622wmb.4
        for <linux-pci@vger.kernel.org>; Thu, 05 Aug 2021 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnNoHdgLfAXM9hxSl9L4gAXKVNQQhOQnnAVZG/sqDio=;
        b=CUpqpACKyVjcZ8MYB7QSKW5upvrl1pswMYJ6am9GRkRI3P4YLRG5Pvr89/5wGs4O1p
         ySWvNDoBVBq55gGyMxEPgc+IwZhf9sKwOvSKg+twt1fV9IbtOxWkG08nOZjTS2hWmHY3
         I79LZiRHC8urznhWJEGrIawkWYJnPvHe9py4xlKXsH86IWRNdaGNj+JLnvFay9fxQRve
         T99MxByGhui77ABQ3gPQJdP4hcByK0+MZ4D3P2teLCvBzg46hu0iqCaxsA6Hi8Yjz2Qc
         XeZsHKFxWXScXwqT/7WV2L8Inl5g+XDlhcUjOdKR5ShoADIqnK41jv7rVSpEOtzNFEnX
         alLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnNoHdgLfAXM9hxSl9L4gAXKVNQQhOQnnAVZG/sqDio=;
        b=jjR5nyH/zBM+F+S1emLmAugaDCcn+bjIoe6WDMcxbUjH7J4k8HyWcyRGC7O4xTgGGo
         D9nNDkSe/ZqNmn8GG7kRJ81yktXfXDDp1gG1dkoR6QCZ+w5Oh33IhU3o421fBFM7ME9r
         gK/hrYmqB3hZARJz9LVTPTrQ5YT7PbHXJBlfmyahEEELqOMWIcR1tkZsqXmlNkXdwP+m
         FjcBCOcEHtDMmQeZj1jAeLv0E/4KRU55FqSBGLtcxJ63zD7uAGJfnb5aw3dn29fuVuPu
         04iLOEeP7FdrjoDIzIYErh0YEPlAgayZbjMDfJ2uJ6ZG74myBHCTNVI5xTYeB6iddli9
         9rew==
X-Gm-Message-State: AOAM531NFQfJI+sYxts5DGsNjmIdfKLzs5tPQjh5FNbFVBCdeVGi1UML
        Oc2NWdGYNZIPn5eJ1qacKrfxzxD26k5QTg==
X-Google-Smtp-Source: ABdhPJxt+kc54L+BK7lZHQ9fZ18EmuQvxhPVsPiNiyL2JDsNnxpnivEG1Mr6kSgjx+JCmVRr29z1TQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr16682545wmg.130.1628190660651;
        Thu, 05 Aug 2021 12:11:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:75d1:7bfc:8928:d5ba? (p200300ea8f10c20075d17bfc8928d5ba.dip0.t-ipconnect.de. [2003:ea:8f10:c200:75d1:7bfc:8928:d5ba])
        by smtp.googlemail.com with ESMTPSA id c10sm10780092wml.44.2021.08.05.12.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 12:11:00 -0700 (PDT)
Subject: Re: [PATCH 0/5] PCI/VPD: Further improvements
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210802223258.GA1470946@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b22a2ef2-2a32-410a-2680-ca05d7b52df3@gmail.com>
Date:   Thu, 5 Aug 2021 21:10:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802223258.GA1470946@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.08.2021 00:32, Bjorn Helgaas wrote:
> On Thu, May 13, 2021 at 10:53:44PM +0200, Heiner Kallweit wrote:
>> Series with further improvements to PCI VPD handling.
>>
>> Heiner Kallweit (5):
>>   PCI/VPD: Refactor pci_vpd_size
>>   PCI: Clean up VPD constants and functions in pci.h
>>   PCI/VPD: Remove old_size argument from pci_vpd_size
>>   PCI/VPD: Make pci_vpd_wait uninterruptible
>>   PCI/VPD: Remove pci_vpd member flag
>>
>>  drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
>>  include/linux/pci.h |  43 ------------------
>>  2 files changed, 37 insertions(+), 112 deletions(-)
> 
> Applied to pci/vpd for v5.15, thanks!
> 
pci/vpd hasn't been merged yet into next, is this intentional?
