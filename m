Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F121DFC4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGMSfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGMSfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 14:35:45 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50679C061755;
        Mon, 13 Jul 2020 11:35:45 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e4so11835306oib.1;
        Mon, 13 Jul 2020 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pfifxRNrRUR2T4uYGwKiE9RMe487XzOwMSNlNFzce1k=;
        b=HVHCGlJRjYfmXT7uQQTMqziIBypODRZa7gCfW4kTMKTzzuv3te+ebl9nfo5ikRkY3g
         ZZBk3lmPazFumhe2INJfkq16MDSGwl3YCJbANDNbzBuY440EXwvbyuBmTTeWi27pcykR
         m9FfjxokzGaBlJ4wGVcVYTMGaZ2uin1SB7zCs+pU/gAj8SGFpjX4B0mf3i5NSVriEFty
         713nUE12sid3xqDCL4x2RfdeME6g9f674IZLzWyNgUGKfpplb0VOozAdowMbcfVrLu4/
         M91CXZTtp1kK1zfoa5Bh0AM+tWHWWrIev+fp8655BD3GtZtFknvVp93t1EYQ0apE+d23
         kKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pfifxRNrRUR2T4uYGwKiE9RMe487XzOwMSNlNFzce1k=;
        b=IlfE3o/MAlf2nSFY5uJZjnNzlUXdoPqereaz6dRBBdkoDyqgMHsoN8qaO1OQUqe3Uk
         9qd/DMhUkF7L28DeAD1YgGe4d2PlLxw1KDU9Lzqp6FkegFUFonvQ8N85beXkPim2ohM6
         jfz+YCk1Ujc/AXEdkrUMZ7rbBk3JZUwqpILOksex0ppL/Oy4FEjU3DcvQXO67B9ryCAS
         I8naNuADhf2sb384Mk8aJS4jQeULwpasxhL1z9GS/DyoVIHj3MKXLTmZ0P8yakfS/Csm
         9gHiMxrWaB+wTz9ekPp/ZdEUC/AfMUvHTaH5bqvJO6I0s4tkbHtpEAhDsZCCNwCwoSNU
         HK3w==
X-Gm-Message-State: AOAM531l62gD34w9kLLFqPOFofaBrnyF2FXmIc2ZKAxK9dl43meOg5ox
        kyEWtAyW3KgRMFWtTYUeAs+xCjl4
X-Google-Smtp-Source: ABdhPJz3GQ+85yUO/+PkLfsc+YTRMOpRwB45jn1PhyabY7CvTaSczcOYsYChj491oYeq1eXtgklM+g==
X-Received: by 2002:aca:4e16:: with SMTP id c22mr648602oib.53.1594665344656;
        Mon, 13 Jul 2020 11:35:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n84sm2957528oih.9.2020.07.13.11.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 11:35:44 -0700 (PDT)
Subject: Re: [RFC PATCH 02/35] ssb: Change PCIBIOS_SUCCESSFUL to 0
To:     Saheed Bolarinwa <refactormyself@gmail.com>, helgaas@kernel.org,
        Michael Buesch <m@bues.ch>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-3-refactormyself@gmail.com>
 <70e57af0-6a8c-a893-67c9-0181af16ae2b@lwfinger.net>
 <78b52ad5-015f-4452-0cd0-dbb2c8597672@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <886881ac-37c6-596e-5f68-07242ed1d2e0@lwfinger.net>
Date:   Mon, 13 Jul 2020 13:35:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78b52ad5-015f-4452-0cd0-dbb2c8597672@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/20 2:13 PM, Saheed Bolarinwa wrote:
> Hello Larry,
> 
> On 7/13/20 7:16 PM, Larry Finger wrote:
>> On 7/13/20 7:22 AM, Saheed O. Bolarinwa wrote:
>>> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
>>> Their scope should be limited within arch/x86.
>>>
>>> Change all PCIBIOS_SUCCESSFUL to 0
>>>
>>> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
>>
>> Could you please tell me what difference this makes? It looks like source 
>> churn rather than a substantive change. The symbol is defined in pci.h and is 
>> used in many architures. Certainly, PCIBIOS_SUCCESSFUL indicates success even 
>> more clearly than 0 does.
>>
> It is a trivial first step towards a probably significant task. I explained in 
> the Cover Letter, I can see it didn't get through but I Cc linux-wireless 
> (properly this time). Probably, too many addresses.
> 
> I have resent it. It is here 
> https://lore.kernel.org/linux-wireless/20200713185559.31967-1-refactormyself@gmail.com/T/#u 
> 
> 
>> Why is your name inside quotes in your s-o-b?
>>
> To keep me company before I get to know my way within the kernel.
> 
> I saw people with >2 names do it, so I did! Please let me know if it is odd.
> 

Thank you for the explanations. The cover letter did help.

For both SSB and BMCA changes,

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

