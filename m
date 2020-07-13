Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E1421DF66
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGMSMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMSMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 14:12:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32444C061755;
        Mon, 13 Jul 2020 11:12:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so18339914ejb.11;
        Mon, 13 Jul 2020 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wX50ijN1MvREDIsGS5xeUvOvHwSnksvK2NAsbuf3LdM=;
        b=ialw/PlEbuLKxjnilT/9gcUOn1JvXuhjogH2KPopW+8zGMTyzC4cccPQ2FhBzMhUA6
         SNwjeU+EIfxwY/PQbyIFoyIJ9DrYSuGnVOG46YUkzjEVGP10RxniYxGtbY7KAyPLh8np
         3ks1NrAHC9p2laTyrUpynDLUQ4C4srYgNq4XxjIbJAa+fCZN4Wv1ABG2lIMOdRae6RxN
         6PynVm1ZogXPdCp2QG3tT+fIpL3Ev/0RATDhAdeszNZ4Qq4Vztyizti8cBNIONgkDW34
         4l7YLA2wE1qvnxOe6QCLxDJ9gfiLdQa8XUjHs3zkY+qiN6g2AZSgKbJt32PMLYH5bhK0
         1mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wX50ijN1MvREDIsGS5xeUvOvHwSnksvK2NAsbuf3LdM=;
        b=NXy4cISQwoOTFwKR8cbHiyobAW6d65vZLLKz1xVyuvt+gCH1kCiETaKku9XfGSDs8G
         FAudzL4GqijXxrGlnKeRbcFleuEyrE4Wf5QLMepaWIHcYWjJwI8eBj2X5a/hgFHVlqA6
         4OhLSXXpiRoBy3O6dLYtRL8fThMsTYQqMFRDu15guyx4Du1lVL81Hj+oed47MkcuQrhC
         Uyx5ZD3oImq6X1OaUfNt32cNL97tWDcYxhB80CCS79F57cVLYByrzR+4fhzOFCXCBsfG
         HAS2wc/khfVNJoFrRH7LdEiyJU+tiDkegrjTlj5szSQyb70EumsJonqbB6SBCSDGFv2v
         iCnw==
X-Gm-Message-State: AOAM532ya+Y46mquRp2C/uorgCX378Qkehun9qibpPtw8fp54RM9fAvU
        Lfou9nyX9cczd1/Shn/3TGuEPE9Ic41KqQ==
X-Google-Smtp-Source: ABdhPJz/75L97OnteHurSRENk3PzKuEuZsidiUh+ImYU1G4fo56ylorIqQZv+42Mr706DdN0J+VEIA==
X-Received: by 2002:a17:906:57c6:: with SMTP id u6mr945004ejr.194.1594663963454;
        Mon, 13 Jul 2020 11:12:43 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id z5sm7364786ejw.114.2020.07.13.11.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 11:12:42 -0700 (PDT)
Subject: Re: [RFC PATCH 02/35] ssb: Change PCIBIOS_SUCCESSFUL to 0
To:     Larry Finger <Larry.Finger@lwfinger.net>, helgaas@kernel.org,
        Michael Buesch <m@bues.ch>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-3-refactormyself@gmail.com>
 <70e57af0-6a8c-a893-67c9-0181af16ae2b@lwfinger.net>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <78b52ad5-015f-4452-0cd0-dbb2c8597672@gmail.com>
Date:   Mon, 13 Jul 2020 21:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <70e57af0-6a8c-a893-67c9-0181af16ae2b@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Larry,

On 7/13/20 7:16 PM, Larry Finger wrote:
> On 7/13/20 7:22 AM, Saheed O. Bolarinwa wrote:
>> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
>> Their scope should be limited within arch/x86.
>>
>> Change all PCIBIOS_SUCCESSFUL to 0
>>
>> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
>
> Could you please tell me what difference this makes? It looks like 
> source churn rather than a substantive change. The symbol is defined 
> in pci.h and is used in many architures. Certainly, PCIBIOS_SUCCESSFUL 
> indicates success even more clearly than 0 does.
>
It is a trivial first step towards a probably significant task. I 
explained in the Cover Letter, I can see it didn't get through but I Cc 
linux-wireless (properly this time). Probably, too many addresses.

I have resent it. It is here 
https://lore.kernel.org/linux-wireless/20200713185559.31967-1-refactormyself@gmail.com/T/#u

> Why is your name inside quotes in your s-o-b?
>
To keep me company before I get to know my way within the kernel.

I saw people with >2 names do it, so I did! Please let me know if it is odd.

Thank you.

- Saheed

