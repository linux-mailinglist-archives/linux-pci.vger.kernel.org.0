Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C26347D0D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhCXPyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbhCXPyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 11:54:32 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A7C0613E0
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 08:54:31 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id z68so11588151vsb.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvdMNpuLDTAr72CZhKMnuvvxwLSHQueODNwVd/tQkSw=;
        b=fB+V4oDpRcxIY7NRezv/LgYAX+HS0KhU+rJZTEOffFFfAiDhycklq7vjJKyxwAyN6d
         FwVooeLY/l/eF0g2TiN+AEb+pWaU9Yjy4oeAuL2EjKqlXuPDwvNse4NeL0O8VLQsYJrj
         MduPgnhW4BoOEKm+9blk0AOlC9ZFe2MWNVdXg05XsLH8u13/F+l8TvAs/zdYNo204lOb
         UO2ejvr4schD5aphabcQ/rkR6XZAgxxn8+gOR3cZyqZ26gf7fuyTuc2VNfchDyeH/tfJ
         /ihpDMwEMU+3K5BBUlLCDwOe8gCAWXmR5ilixiAwXqQwXtxAH6TLPNups0PP1aS/TPeQ
         E9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvdMNpuLDTAr72CZhKMnuvvxwLSHQueODNwVd/tQkSw=;
        b=m+bjZgEDR+YPsJGr/IUcUXqwRZb9u35WqRPLzpmSdDbiCKXvXknLBm8rWdOGfur2v/
         d8RINrMWoo9yBSh80aiyFm2SjHi+FTa0BkdXd18ybJcrs9pTY7fN53RCsmm/Mq0rZDuL
         wzpFJTtoFvJlIKjWap38gkIXk34HVUo1P9vFaxn6PRfExcFdMzawgaV2rc0GAjnxMPWT
         h8HnhpjipdOGysclhmimDudwmzUHeYJADkUWH3+6D4oCHPVn1/UkfgYqK4Sgm17kR97y
         LMhzmhrwMAJY9sbiC5wy3YT+/0TpwVdRqGJzql2C35Ee0iPeCHB9mtiQtUZHs5Eps6B7
         2m4Q==
X-Gm-Message-State: AOAM533tedE5ShwPdqSwDdALUe61LHOP80GhTbQtfuzUSkD6XNOl6AzQ
        2hxjLHbHXIka9CXe6f9o+DrRCiQgOK3E1i1HN4mVGQ==
X-Google-Smtp-Source: ABdhPJw/Tt5Eglhjkk3DSFJmZtQNB1612Zn3Mq7A5Is3NYScePeRKnpnTe64INtZMtYBNux7wDX2SFzRZ2Nc/eNRj+g=
X-Received: by 2002:a67:b447:: with SMTP id c7mr2227327vsm.54.1616601270219;
 Wed, 24 Mar 2021 08:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com> <20210324071357.GB2639075@infradead.org>
In-Reply-To: <20210324071357.GB2639075@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 08:54:18 -0700
Message-ID: <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function macros
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 12:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses
> > in instrumented C code with jump table addresses. This means that
> > __pa_symbol(function) returns the physical address of the jump table
> > entry instead of the actual function, which may not work as the jump
> > table code will immediately jump to a virtual address that may not be
> > mapped.
> >
> > To avoid this address space confusion, this change adds generic
> > definitions for __va_function and __pa_function, which architectures
> > that support CFI can override. The typical implementation of the
> > __va_function macro would use inline assembly to take the function
> > address, which avoids compiler instrumentation.
>
> I think these helper are sensible, but shouldn't they have somewhat
> less arcane names and proper documentation?

Good point, I'll add comments in the next version. I thought
__pa_function would be a fairly straightforward replacement for
__pa_symbol, but I'm fine with renaming these. Any suggestions for
less arcane names?

Sami
