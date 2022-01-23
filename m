Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD394972CB
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 17:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiAWQGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiAWQGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 11:06:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00819C06173B;
        Sun, 23 Jan 2022 08:06:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n10so36438437edv.2;
        Sun, 23 Jan 2022 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A+UmaYERh4ChTu3TUCQPUglKoveOWBsGh8yOqReo2gE=;
        b=HreA47bF2jNtruBFxYPB17MuxUeL6iSA5dhVQRFMCglzOhKywlQrrBMzalK/8huCd3
         xTLslcyIVvADEy71wDd7z0dM6XB8661U5PzAMzi2U5y/6bP5V7WJtuchQLzbSVvU4a/r
         O9j/gTyGinkLMBQ+204oF+2PF3uB9z3+hSZ9cx7x5vNFMDEhQPDwIOWMfD4NhK22UkYt
         Gk1ig5m0rdaYKOuUB+4VGjhFDOoCoPqkKKScktTNDz/PuK8TFxQvQZNG8TH5ep3HPQhp
         RGzTyDWKkJmkvTfhh1HPcDSN1XuCaum2mOfvBufnRl0P3aVqpctu3aOOpIn5k71nUvXr
         EWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A+UmaYERh4ChTu3TUCQPUglKoveOWBsGh8yOqReo2gE=;
        b=nKKIlc0HEgFtZ368oaYPvbi9lArjlubeG/PaZKw1I+ltY1ip3D2WRz2kwSJr4ZCKvM
         0WL7zgsZfugJzyBklfYMK0oItv0AQEDMpB3jvAgzwOs8Ns9wOTX0rvp/UbbI9a1S0O1z
         8y9Q5c90/cLCzpG9+z7M+qh0q9XhygRR/Qs2AmUMWfYlbEw//N+scoMCNG0QsoXkay2b
         JIK6Hq5Edze0PqvHJrPLP4H/fjUB/BqZls/XQ3Z0tpVdi7aFuNzes+YZ7yOhEWEC15LG
         eOPIm5hdfA6Y6QGDSGmfVuP40+36RrHD1eP0EWmR01Jg7Wvpm2TN4F/QRYahw9PQ4mzI
         qnXQ==
X-Gm-Message-State: AOAM530ysfKw4tr93G/488iJWtSyZnUzWbCnJIBvE/6nWV/3+8A1bjO8
        A6hBFEz4UZvQfzW58pvruQA=
X-Google-Smtp-Source: ABdhPJw7H19xKHk4xWD3idrDpf6tkl7esz9jhdnFeZmkevRtWAItdTVkF4UEECX+vNwzcF1JOy7hyw==
X-Received: by 2002:a05:6402:4253:: with SMTP id g19mr3667484edb.152.1642954001434;
        Sun, 23 Jan 2022 08:06:41 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id f18sm3924230ejh.97.2022.01.23.08.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 08:06:40 -0800 (PST)
Message-ID: <dbf8286b-902b-7ab5-6249-31504d0c364f@gmail.com>
Date:   Sun, 23 Jan 2022 17:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <CAK8P3a1vw3n_QbT-aqSzWFavKMmYtBqQptvMxeZmDF+-bO0dGA@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <CAK8P3a1vw3n_QbT-aqSzWFavKMmYtBqQptvMxeZmDF+-bO0dGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/22 15:12, Arnd Bergmann wrote:

[...]

>> +#ifdef CONFIG_ARM
>> +#define __rcar_pci_rw_reg_workaround(instr)                            \
>> +               "1:     " instr " %1, [%2]\n"                           \
>> +               "2:     isb\n"                                          \
>> +               "3:     .pushsection .text.fixup,\"ax\"\n"              \
>> +               "       .align  2\n"                                    \
>> +               "4:     mov     %0, #" __stringify(PCIBIOS_SET_FAILED) "\n" \
>> +               "       b       3b\n"                                   \
>> +               "       .popsection\n"                                  \
>> +               "       .pushsection __ex_table,\"a\"\n"                \
>> +               "       .align  3\n"                                    \
>> +               "       .long   1b, 4b\n"                               \
>> +               "       .long   1b, 4b\n"                               \
>> +               "       .popsection\n"
>> +#endif
> 
> You list the fixup for the ldr/str instruction here twice, (.long 1b,4b), but
> no fixup for the isb instruction (.long 2b, 4b). Your description says that
> the fault happens on the isb, not the ldr, so I don't understand what is
> going on here.

Copy-paste error when deduplicating the patch content, should be

.long   1b, 4b
.long   2b, 4b

to cover both ldr/str and isb.

I can imagine on CA7, the abort would trigger on the ldr/str already.
