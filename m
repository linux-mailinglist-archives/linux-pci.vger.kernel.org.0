Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFFD1C6C67
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgEFJHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728704AbgEFJHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 05:07:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ECBC061A0F
        for <linux-pci@vger.kernel.org>; Wed,  6 May 2020 02:07:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so1254290wrt.5
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2020 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Aiduif4RtZ3ykWn249hRR5linftwParx0QJwaKRAtTw=;
        b=nhMQ/TAeFlNsi1DTivZ31i47dUo9jwW21xouSdv26IJNk7qWwO9+PA3TPagTtlo8Ir
         epWJcSi4HM504jBnP/yXrakH0qMIGPSgDV08HsdoJ53Izz/uqEcpr2RrjYkC9KOd6RNw
         MX2wOzkpo4s8EcC6FGSu70oFTTHBmnf9eQ3YLGXjBm9IgaoUjiMXJkvwPG8HchHt42Lf
         tgjV07MB89QmTzzfATJTh1+1iL1lVil/8dvZ0Kzg50FTB01MSbUb2SRCisvmazXaWpmr
         MHHq0jy+SOxWwM0tQt2oGa26f/zGWCV755gZPrrsauYx/a5E1LR7B5R7L+Jpf+Ts7TlJ
         2nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Aiduif4RtZ3ykWn249hRR5linftwParx0QJwaKRAtTw=;
        b=nzH1ymaP7Fqu4U/tFhP8eHTOkFrzqEBdONXB55dxrKXjiXk/1gCz5sF5nl1PubHi7B
         GrKAMH68UlZo5+sUxgryM3tNuSnoTOCz2LJiasGZ5nK14pf2TFUCvVVM/gU4e4mBJ1fD
         7KmHlEMiwdWq21z5awPmGqCLKO3DgZQi5R5sRkRlO2DNfI214gZZwBknP/llnezJfaIe
         11CVqzhVZjMTNy2zvnv9q3DfMLBwNhFvE9UgIym0YyEDW2GTlVYdUZxvcFFCF6mraMK5
         7xqepz4d43fY9+EKu0MPalgk0Lm3mObKNLMNBOGAYFNBjdcdgZgX0eu6VQFr7w89mC+F
         Okcw==
X-Gm-Message-State: AGi0Pube8PNP6sMXmM29rMZAaGXZCveXYPC0tModqB3OHFvRW8JefNDM
        RLOmyPuzn1ahMtv0tl+K/bNglXGZJ6qkpA==
X-Google-Smtp-Source: APiQypIJLmoLC2KcW4UqL5rSGfd2QfvE7WZ6FQI3H4I3pUnZoo1x3UO0dED1uKCwfg7FEZWkixw/6w==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr8290516wrh.295.1588756028871;
        Wed, 06 May 2020 02:07:08 -0700 (PDT)
Received: from net.saheed (540018A9.dsl.pool.telekom.hu. [84.0.24.169])
        by smtp.gmail.com with ESMTPSA id 7sm1788578wra.50.2020.05.06.02.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 02:07:08 -0700 (PDT)
Subject: Re: [PATCH RFC] PCI: Set PCIBIOS_* error values to generic error
 number
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
References: <20200505210404.GA379346@bjorn-Precision-5520>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <fe3223b8-fbf4-93d4-808b-9e7b2ba7a6c5@gmail.com>
Date:   Wed, 6 May 2020 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505210404.GA379346@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On 5/5/20 11:04 PM, Bjorn Helgaas wrote:
> On Tue, May 05, 2020 at 07:15:13PM +0200, refactormyself@gmail.com wrote:
>> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>>
>> PCIe capability accessors return 0 on success, otherwise it could return
>> either a negative or positive error value. Positive error values are from
>> PCIBIOS_* error values. This behaviour contradicts that of PCI config.
>> accessors which only returns PCIBIOS_* error values.
>>
>> There is no caller of these accessors that directly utilize the returned
>> positive error values. They either use pcibios_err_to_errno() to convert
>> it to a generic error value or simply pass it on or in some cases discard
>> any positive error value.
> We *do* still need to check all the callers to see that they do the
> right thing.  The intent of a patch like this one is that it causes no
> functional change -- everything should work exactly the same before
> and after the patch.
>
> For example, the case we talked about earlier in this chain:
>
>    local_pci_probe
>      pci_drv->probe(..)
>        init_one                        # hfi1_pci_driver.probe method
>          hfi1_init_dd
>            pcie_speeds
>              pcie_capability_read_dword
>
> Before this patch, pcie_capability_read_dword() could return:
>
>    - 0 (success)
>    - a negative value (e.g., -EINVAL)
>    - a positive value (e.g., PCIBIOS_BAD_REGISTER_NUMBER (0x87))
>
> The positive return value would cause local_pci_probe() to warn that
> "Driver probe function unexpectedly returned %d".
>
> After this patch, pcie_capability_read_dword() will never return a
> positive value because PCIBIOS_BAD_REGISTER_NUMBER is now -EFAULT, and
> local_pci_probe() will no longer warn.
>
> In this case, that's a bug fix, but we don't want bugs to be silently,
> magically fixed by patches that don't seem to be connected to the
> problem.
>
> So we need to account for that somehow.  We could:
>
>    - Add a preparatory patch that calls pcibios_err_to_errno() from
>      pcie_speeds() as I mentioned before.  Of course, we plan to remove
>      that soon anyway.
>
>    - Maybe call pcibios_err_to_errno() inside
>      pcie_capability_read_dword()?
>
> We really need to identify all places that have this problem so we can
> see which way makes more sense.
>
> Can you start posting these to linux-pci so they're visible on the
> mailing list?  Sometimes other folks have great ideas, like Yicong's.
>
I will start working on it.

Thank you.

Saheed

