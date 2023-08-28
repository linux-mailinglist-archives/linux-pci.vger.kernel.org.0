Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B346978A73D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjH1IJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 04:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjH1IIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 04:08:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391921BB;
        Mon, 28 Aug 2023 01:08:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf1935f6c2so19085105ad.1;
        Mon, 28 Aug 2023 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693210077; x=1693814877;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnrE6dyfVAprK/xFUC60jFewyVljQRt3NNtTMulp0V0=;
        b=LVg55P2ejT0BJXH9H1+hgJHcBL2A+IF5g+KpwZsnJ2WoqXmcrL9ZfEfa3T6fNEdxE+
         ga2nqaZ+gZjmffBcNuVnaXDtmvodkJeUEflTba5i6j/rIlhBduWdBgZRPVnHwy+erFMo
         Q2sF5ZgAuDt+03EKZEd8qEogPdBU5cTg8EccDlTx6cSnC2QLYfomUfDCZyZGJl19L0Ry
         zfDO9BgqWN0KlkikpK3fWA7KZvQWChySAj+L6JXiUhVTo7xH2gRnW3f4Al2lAGJTZzAW
         5ZruNkogVGDYB3ptB7Tk7PeewBGyh+fZdTDyBJ7/jPzoGq3RnYeGV17VCUydj0j+5OXO
         MJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210077; x=1693814877;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnrE6dyfVAprK/xFUC60jFewyVljQRt3NNtTMulp0V0=;
        b=kx2AbQTuZzgjqeFlKchv8jO7AJiM7c3VlC8NfaV+q52q9T+J75VLbGGUz5p1FsAl6M
         /1UmeHL7uXBzA4bhtcaDeQ5M2p/QC2/RjV8f3Ggekio2VHKQrQ/fMVVdVob1tp/nPETL
         aaV3cMvyHQ9X3cxTrAvdEUIi2Mwh4dHPjNQdAWloEG87p0SAw9gwcJhOE9t8TbSEHqAQ
         /MjskPjAjLoKi64Vc2l/+8ISC0SUk5acxV0xnIXImrtLWQYon8khxhuWz3lx0t1GoaDM
         1gKRsR04XkdyvcqBlD3sIQSj8s3DReR/TCbdQLODL4RCOKBX61FDo4x0nMIu3/ij/ynI
         KPVQ==
X-Gm-Message-State: AOJu0YxXEuACwavoq7XtdyCkfFO+zXU8Ht0PMWp6kK2NrFqIyFDMqx0o
        80v+MhYvCUFcG6ybUpGrgxBDzLvYkMTO1A==
X-Google-Smtp-Source: AGHT+IHEN6rjlzubXIy3DuU1iYHuYGfJmUDj7MCrRMJIjxExjNAtfO/xrf/2cugqJ3sCcKtAmuhffg==
X-Received: by 2002:a17:903:41d1:b0:1bf:193a:70b6 with SMTP id u17-20020a17090341d100b001bf193a70b6mr38374653ple.5.1693210077452;
        Mon, 28 Aug 2023 01:07:57 -0700 (PDT)
Received: from [10.1.1.24] (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b001bc445e2497sm6610519plb.79.2023.08.28.01.07.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:07:57 -0700 (PDT)
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
 <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
 <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
 <CAMuHMdUkZmkBSksvaGcDCKz2tsgkwyWgDa+WwCJm2UxFMCj1jw@mail.gmail.com>
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
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <dbed3311-6b8e-a396-7e9e-2747902c5d6a@gmail.com>
Date:   Mon, 28 Aug 2023 20:07:27 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUkZmkBSksvaGcDCKz2tsgkwyWgDa+WwCJm2UxFMCj1jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Am 28.08.2023 um 18:42 schrieb Geert Uytterhoeven:
> On Sat, Aug 26, 2023 at 12:44 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> (Incidentally - did you ever publish the m68k full history tree anywhere
>> in git?)
>
> You mean the gitified version of the Linux/m68k CVS tree Ralf created
> for me because my machine wasn't powerful enough?

The very same ...

> No, and I should look into doing that...

No pressure!

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
