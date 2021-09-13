Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE0409EB9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbhIMVAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbhIMVAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 17:00:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083FC061574
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 13:59:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so16667356wrr.9
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Vk8QpZziBmUt20DKs53wgm7+uEyjOVwLFr+epORcRQ=;
        b=mQOHTKdJXSwboI2ykP/b7PQNNbbnWECgAtqsWPNj5PpcnEvGKk9yCeEeaCgTFgDjMS
         Hbqijf4DLGzJHeSslLCLeuu6OBIGlglxAYGeitWV6lvMddG85Xl5dch1VQXEdStOfELN
         KJkvjXFRMmegGGf3DXmK7fy98PWffrha6Po1zWSBSpygpRoWoZvP0GdHcKBnpWTzs1fx
         C6OTzfwb/rBDmk4wEEjdOLZaxauEHDc5ek+9qASUu3LI40cK6SYOsnls3kYyBxCdyH5B
         mDN0apWDyUZGJXUdBzZYZKndxIvukH1ctaiSHq+NC8DE7QDjDUuQfiwgZVVadXN9Ielj
         OsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Vk8QpZziBmUt20DKs53wgm7+uEyjOVwLFr+epORcRQ=;
        b=jYvXgfJtpIIimBnqSvTjm1KBkz+twEyllfE+ySeP0FYtPg1dJAlr2BVchS1oX5Rdqi
         9zpSsKAraMlHs7QJK4lRKEmevebZZap+VWlRAZxBgrTuej8LpYZkkVUDfPcPTuOlEWMS
         pNiWnFGbjZdwY3gTvCGfc8Xb2OeeGwjS9yOctNl7YC/lMbeaZgkcB7JdgHfJd2yG3Pll
         Pa1R9vSk2ek5NSvC5u3b5JEF48rw8b5kS49m1dwUbuHhRs59NDZyfwcIFABf6jg9QWKx
         LI4zUsNpWNfAZpQ56CBQRhn8fWQcD55ao8xetSz5pK3UOVWhzuWsL64ZB5hOhfBIew/1
         PN2Q==
X-Gm-Message-State: AOAM532BkQdSZcJNN50H4PPR3da8W0tlpQyacTRNct5rmleGmtEOrax3
        Ada8qmvZrBTwcTfwn0F1qoCGCtK8KcU=
X-Google-Smtp-Source: ABdhPJyikxrz8Wd572Uk87xMOffCbWpqADcNgyZNOCN3byiKzqdn46UD/VLg7KH1lm1apteIgC2L2Q==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr14995293wrq.260.1631566755414;
        Mon, 13 Sep 2021 13:59:15 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id n18sm7371793wmc.22.2021.09.13.13.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:59:15 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1
Message-ID: <0a8e8186-741e-a92f-9507-448d574ae7ca@gmail.com>
Date:   Mon, 13 Sep 2021 22:59:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913203234.GA6762@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.09.2021 22:32, Dave Jones wrote:
> On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
> 
>  > > This didn't help I'm afraid :(
>  > > It changed the VPD warning, but that's about it...
>  > > 
>  > > [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
>  > > [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
>  > > [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
>  > > 
>  > With this patch there's no VPD access to this device any longer. So this can't be
>  > the root cause. Do you have any other PCI device that has VPD capability?
>  > -> Capabilities: [...] Vital Product Data
> 
> 
> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>         Subsystem: Device 1dcf:030a
> 	...
> 	        Capabilities: [e0] Vital Product Data
>                 Unknown small resource type 06, will not decode more.
> 

The stall being discussed would have been prevented by the VPD tag
verification in pci_vpd_size(). It seems that now random data is
interpreted as VPD tags what results in VPD access to an address
that makes the device stall.
I do not really follow Linus' argumentation that VPD shouldn't be
accessed during boot because other slow "VPD-like" devices are
accessed too, e.g. DDR SPD via I2C.

> 
> I'll add that to the quirk list and see if that helps.
> 
> 	Dave
> 

