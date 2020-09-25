Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1850278A17
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 15:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgIYN4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYN4c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 09:56:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F095C0613CE;
        Fri, 25 Sep 2020 06:56:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m12so2389078otr.0;
        Fri, 25 Sep 2020 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tPL5+IqJ4pnhnlzLD1QSMADwnFPQfAtE9Uj8Bz5oFz8=;
        b=TmkI26BqmXWq5stHcrAmvny+i44COr16qPKkM6ly5DuO0f1OGT5/eUagqBWB9ekkyn
         HRNjqQ17iQx5mu8BqlH5EvGM88ROdCajwQVt9Mcvuesa6mGsYBN6R2wuEPct1jAPeYtE
         bPF3flKeiUjBPvn5PNH1etBw/GehjEKw33rCM83H9wfDoTFScx7jlLPWNcte7Uu7gkGA
         vWHV0m32mpxG5SHR3j+N0lHNWNKG6E8gs1wJk/DpXo5pYwCkwFvMpb3IDnQeO2NasfKG
         fO9xwr5spuSffpBMQfBwOP8Np+UNFT9Vm8qhu96giuRbnyXiaaErb0XQ8zxQoI3aSQX1
         B4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPL5+IqJ4pnhnlzLD1QSMADwnFPQfAtE9Uj8Bz5oFz8=;
        b=iAQKKNZXEFHgIcD5PwvHAfqrofTdUfvwKSY7BJXhj/oI0FkSIA3E0g7MIFSewK0Nwr
         N4hSZB9yMfM99pDKACcTqvMrhgi4KjNJbrVRNXusJwxN1QA84hWC31NrqUQ9WrWRIX3E
         lvDrgVeCROCzc7s5LPyzn8OPumg/0jIVQEGTaNL5SW+sRmOi5aN9xzrZC7ivskW7Y+o4
         CPfY0s6JfcFU8WoyBIoBgcv+yBlUY5SZNiBeYB2OR1kvmM3SR1USMUjPUGit2hYOLYx3
         usChb+I3UqQ2G0jFFvGpoG/6rKL6HGp00v9AI2rJfHAjn/6xO4c7e47qF+DJi5oEcoN9
         l8DA==
X-Gm-Message-State: AOAM5312bf4W3PyE//d2Ox1lZ86flNHK9Bgw59+xoVttZpkrN7tZPnBd
        z966ntTgXW8YKUWmtwNp558=
X-Google-Smtp-Source: ABdhPJw/hinTELtp/Tq+o3w3o3mpGjdeRn4pbIBYdXHaevV9GmP07tJ7i2tPlMWrCdMgMYzFCH3DhQ==
X-Received: by 2002:a9d:6498:: with SMTP id g24mr358590otl.179.1601042191652;
        Fri, 25 Sep 2020 06:56:31 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id v12sm653094otn.6.2020.09.25.06.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 06:56:31 -0700 (PDT)
Subject: Re: [PATCH 4/5] PCI: only return true when dev io state is really
 changed
To:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-5-haifeng.zhao@intel.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <718244ed-9069-6ef9-9144-e7b80c03a6c6@gmail.com>
Date:   Fri, 25 Sep 2020 08:56:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925023423.42675-5-haifeng.zhao@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ethan,

On 9/24/20 9:34 PM, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
>     pcie_do_recovery()->pci_walk_bus()->report_frozen_detected() with
> pci_channel_io_frozen the same time.
>     If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>     The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> ---
>   drivers/pci/pci.h | 31 +++----------------------------
>   1 file changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..d420bb977f3b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -362,35 +362,10 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>   	bool changed = false;
>   
>   	device_lock_assert(&dev->dev);
> -	switch (new) {
> -	case pci_channel_io_perm_failure:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -		case pci_channel_io_perm_failure:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_frozen:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	case pci_channel_io_normal:
> -		switch (dev->error_state) {
> -		case pci_channel_io_frozen:
> -		case pci_channel_io_normal:
> -			changed = true;
> -			break;
> -		}
> -		break;
> -	}
> -	if (changed)
> +	if (dev->error_state != new) {
>   		dev->error_state = new;
> +		changed = true;
> +	}
>   	return changed;
>   }

The flow is a lot easier to follow now. Thank you.

Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
