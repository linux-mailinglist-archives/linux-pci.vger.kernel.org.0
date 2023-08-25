Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A27891DD
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjHYWo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 18:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHYWok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 18:44:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A203269F;
        Fri, 25 Aug 2023 15:44:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdbbede5d4so11971175ad.2;
        Fri, 25 Aug 2023 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693003477; x=1693608277;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EfHZKV5Rs50FUqRYXClC9vzZD5WlxrYeYbs3IamXT4=;
        b=YxGLOPcaOZR604IVjJRcGcoKnB33IZ0CTfYuHyWKXt+0pInUOQSMoNyJ0dS6B1KmgY
         cxaBOMvor3UlQ6MZnz8hco99YltIQ+TVGTfUiOj3M6EtIom4aLy5Ogu10qSlU6URXk+W
         RnRGmXEhLIg0POh+PDKptxk33OVTKsM2/52zz5494dr8R8CSNGpoqbrRI3gpmS9Q+cTN
         hJYUsHOFyiz+AcMtmJLq8rt6PHOWgX+jhYTNJt4ghkMZ1YZYHd+UADqGIVtKxfSRzrdW
         eHx1TWLsT9QLE3Re7SH9KzLMTXlxKvezJrH+R76CylIu77symnMHbROv+J2zJ4UP/BTK
         7yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003477; x=1693608277;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EfHZKV5Rs50FUqRYXClC9vzZD5WlxrYeYbs3IamXT4=;
        b=cp1KRCgcYkUTSF2D8a/65bm9gqUzQihVnP8c6wC6//KEb6d0JIiky/UAp7xRjHFcih
         8s1FHO+UQbhcKHIGH6ZyjVwvqRLBbhsB1N1lNaZ9FL0owO1HKhy/Fwso4Cvtq+DxE50o
         vA7XJSYq98tq7HF5W5D9gEn1VMwaEF0hgGVUNno9jMKLX7vah3BgtHwPV9vdnNbsncU0
         TFZg16oEAiXNzdM5iLR35aiSR8KTJ8GuInan1PFH3GSggW5Y8J+wCiQEH3fo8NVkPoAi
         od40573Ua718hlQrOtxancrF5a/ztQX6HBg4R5oi+P8L7kdh3pR2ZE6vtGyfLme3mm8e
         BgfA==
X-Gm-Message-State: AOJu0Yx8RZpbLX9s4Wh8CoyI+NHVzTMAIgKR8W9FocKvYDSC9GX2MXs6
        LP3g7lpzxzcizs6KrVtcVCocaJKsEpB/tg==
X-Google-Smtp-Source: AGHT+IHfISCtSa05UGz9PT6tDA2qtVyoG70cJPjb2fBEQ6/U+mzxDHROeZB/hJ4FR5D+DwWhbVxiGA==
X-Received: by 2002:a17:903:25d4:b0:1bd:bbc3:c87b with SMTP id jc20-20020a17090325d400b001bdbbc3c87bmr18047490plb.41.1693003477133;
        Fri, 25 Aug 2023 15:44:37 -0700 (PDT)
Received: from Schmitz-MacBook-Pro.local (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.googlemail.com with ESMTPSA id b1-20020a170902d50100b001adf6b21c77sm2280761plg.107.2023.08.25.15.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 15:44:36 -0700 (PDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230810141947.1236730-1-arnd@kernel.org>
 <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
 <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Message-ID: <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
Date:   Sat, 26 Aug 2023 10:44:13 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Am 25.08.23 um 19:39 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Fri, Aug 25, 2023 at 3:31=E2=80=AFAM Michael Schmitz <schmitzmic@gma=
il.com> wrote:
>> On 25/08/23 13:12, Martin K. Petersen wrote:
>>> [11/17] scsi: gvp11: remove unused gvp11_setup() function
>>>          https://git.kernel.org/mkp/scsi/c/bfaa4a0ce1bb
>> I somehow missed that one ...
>>
>> The gvp11_setup() function was probably a relic from the times before
>> module parameters.
>>
>> Since gvp11_xfer_mask appears to be required for some Amiga systems to=

>> set the DMA mask, I'd best send a patch to add such a module parameter=
 ...
>>
>> Do you know any details around the use of DMA masks for Amiga WD33C93
>> drivers, Geert?
> Doh, it's been a while, and I never had an affected system.
> Probably it's needed on A2000 with an accelerator card and GVP II SCSI,=

> to prevent DMA to RAM banks that do not support fast DMA cycles.

Thanks, that's good enough for me.

Linux 2.0 had this comment:

|/* * DMA transfer mask for GVP Series II SCSI controller. * Some
versions can only DMA into the 24 bit address space * (0->16M). Others
can DMA into the full 32 bit address * space. The default is to only
allow DMA into the 24 bit * address space. The "gvp11=3D0xFFFFFFFE" setup=

parameter can * be supplied to force an alternate (32 bit) mask. */ |

|We now handle that (since 2.6.35) through masks defined in
gvp11_zorro_tbl[] (though I note these don't account for unaligned
addresses such as implied by the example in the comment. Are unaligned
DMA buffers still possible today?). Would that cover the 'A2000 with
accelerator' case?
|

||

I'm happy to send a patch if an override to the device default DMA mask
is still necessary.

(Incidentally - did you ever publish the m68k full history tree anywhere
in git?)

Cheers,

=C2=A0=C2=A0=C2=A0 Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>

