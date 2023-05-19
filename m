Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A8709E41
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjESReE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjESRd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 13:33:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806DE5A
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 10:33:34 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 03yTqTToaqmw803yUqQMYM; Fri, 19 May 2023 19:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684517588;
        bh=axl0zhsvpOM6Fxxob2rDzGKPa3FDR+vU6oCHaOjC7nk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LhUmCPjqjFRrzSgpetc6BLMo5HV9JGPDZKReX7utFpQcGXqk9CrF05Xmi4ocCv7Rm
         A03Pj1M9tXhjMr3lYU0EUSLBffJtkkkEHZ+lk2jKYI+pINbTdgMRtatuopHZwOux0B
         asNIJX1rZuitNY1XTKyZODeFlf2qfc9R4wgB7dkQV8G5SRDbJEuBHK3GaM0ckGw0Lf
         tbQce+LrhfA1iiIDbEUivumHleLZS1iejFP73gBWiQOv6M4371SjgDKJtk93JKAmFe
         BmBMszFt7s3gDU8ymOMLm7GSv/OrfJG47u0XC9sWW+NQobJ6b6UVKBt6Yg6lKYCloo
         Iuq3oFKRwOyBQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 19 May 2023 19:33:08 +0200
X-ME-IP: 86.243.2.178
Message-ID: <193a5d30-dd0c-fadb-3358-2fd46fa47e60@wanadoo.fr>
Date:   Fri, 19 May 2023 19:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/PCI: Fix a sanity check in
 pirq_convert_irt_table()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
References: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
 <alpine.DEB.2.21.2305190345331.50034@angie.orcam.me.uk>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <alpine.DEB.2.21.2305190345331.50034@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 19/05/2023 à 13:21, Maciej W. Rozycki a écrit :
> On Sat, 6 May 2023, Christophe JAILLET wrote:
> 
>> We compare the size in bytes of a struct (and its ending flexible array)
>> with the number of elements in a flexible array.
> 
>   Incorrect, see the inline documentation for the struct.

Ouch.

As you explained in your reply for the 2nd patch:
     irT_routing_table != irQ_routing_table

Sorry for the noise.

CJ

> 
>> This is wrong and "ir->size < ir->used" is likely to be always false.
> 
>   Hopefully, but we've seen all kinds of rubbish in PC BIOS data, and this
> data structure seems available for OEMs to program with a tool called BCP.
> Better safe than sorry.  Therefore, NAK.
> 
>    Maciej
> 

