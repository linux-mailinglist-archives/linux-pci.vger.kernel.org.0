Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCF4ED31
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfFUQgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 12:36:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40443 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFUQgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 12:36:05 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so433794ioc.7
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k0Gv8DfD1efOdqhlugZQYcDCnL+VjkQIY1zETUpyLmE=;
        b=OMHj9VHPqt6HJV5QqUNQBFucnZ816kuNESW2vX7vWTjN2NKZQ0Ssors2vl9q/oyuMH
         L4gD9fWAwVneJlkOZ5wKA4kPos2/DA0u7tENNy0CRpi1DpOTAoeLOYZzZNuUhqa3NYoO
         l+m/HJGVQEyGbWRa42bxOPQn5wxbmn1nC6c8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0Gv8DfD1efOdqhlugZQYcDCnL+VjkQIY1zETUpyLmE=;
        b=igXxbtN24VwqfRf3aEL6s8hym60uAjn2V0Z6Jsi4WlqnzFzBfQArJPAyr4+/SRo64F
         wcUqny44Q1Edrsl7YS7K7FM82ffqhtufgC1MLJFGKYMJ+Tz+D4vi7UHXYbaCNK8/B5d4
         6fVjP0F5lXWTblMQolBRXG/M5AGSWD6wp+/XadRyboRrQb9HjNj3D50ShaVL4W3h7W8v
         YOwFYy2HNoqQFOSGhKAvK0wbgADABSAYhbTHJUxL4IXNInW+DFTkCj/q4B2a8uk90Q4N
         ETD9WiLA6jCDSk1rClPdGNDq+E8OM+ma3C8NwDNb6U1+p5G2CI/7NDRWOk9PWu+7MHVi
         UwWg==
X-Gm-Message-State: APjAAAVkln8Dcn2ydeT32WlBnFTnjAGOYveLKVl3dvNmUzxTjrYmgiaS
        bp4dYLTKUKhksF0R3tgWXZATcVdPrEM=
X-Google-Smtp-Source: APXvYqzGFfCvLzH6zCFRfbW14LQqv78O/rLPC0RhDAbvKNQeJ9kfbYFCwBGc/fq8J4aAggu64E2IhQ==
X-Received: by 2002:a5d:8508:: with SMTP id q8mr14433265ion.31.1561134964449;
        Fri, 21 Jun 2019 09:36:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm4374026ioi.72.2019.06.21.09.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 09:36:04 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] net: fddi: skfp: Use PCI generic definitions
 instead of private duplicates
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, stephen@networkplumber.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
References: <20190621094607.15011-1-puranjay12@gmail.com>
 <20190621162024.53620dd9@alans-desktop>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5f04f52d-8911-4db9-4321-00334d357d54@linuxfoundation.org>
Date:   Fri, 21 Jun 2019 10:36:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621162024.53620dd9@alans-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/21/19 9:20 AM, Alan Cox wrote:
> On Fri, 21 Jun 2019 15:16:04 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
> 
>> This patch series removes the private duplicates of PCI definitions in
>> favour of generic definitions defined in pci_regs.h.
> 
> Why bother ? It's an ancient obsolete card ?
> 
> Do you even have one to test ?
> 
>>
>> This driver only uses some of the generic PCI definitons,
>> which are included from pci_regs.h and thier private versions
>> are removed from skfbi.h with all other private defines.
>>
>> The skfbi.h defines PCI_REV_ID and other private defines with different
>> names, these are renamed to Generic PCI names to make them
>> compatible with defines in pci_regs.h.
>>
>> All unused defines are removed from skfbi.h.
> 
> I sincerely doubt anyone on the planet is using this card any more.
> 
> Alan
> 

Thanks Alan!

Stephen Hemminger is suggesting removal as well. Makes sense to me.

David!

What would you recommend the next steps are? Would like driver removed?

thanks,
-- Shuah
