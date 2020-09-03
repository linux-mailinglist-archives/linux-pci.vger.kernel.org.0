Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB825CC92
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 23:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgICVp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 17:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgICVp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 17:45:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A786C061244
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 14:45:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so3188360pgm.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88UAUo6RYF27MUEaYZE9R7HTuO6mGUyasahfv8EZhB8=;
        b=EFlB8L3484X2NUQ2w9kQvBk3L+1RDvCzNz+1QFX1Nm3dCNte5YHScmXG1pqmo0J2+E
         C6Clco3P/dWY6iT/m+OtQJLLVltMdhY68a4RYVvEYy7d7wz05uOxuTBRrPhAf9vZulwq
         OT1t8R0KPmtqqUOLIMHdbCPWYgvYCgeGDAsFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88UAUo6RYF27MUEaYZE9R7HTuO6mGUyasahfv8EZhB8=;
        b=NrXLhvLKrEin2J3mFe08GVOkS3QTJSUtKA2OmzM0iutDYqv+hz0ZLUpIhL5ZX18Agi
         CI5blwlh7vEGa1v87P4NkF/ZAXn2jwnRdePivjMoxR8LQVRTYHgdzcwFR4wTK51RwdCJ
         +ImQQ/jQU1Mc8Fl2Di605JbV/0Q3AAnTxzPcf7bTjJ9L8ej+gLxDxKza7Sg6gOR0/PZT
         1+9Fv4VmETfI8QqL0rI1xhUylIY2A3l5RAdAiEliuqeBYiecya3NNfbYDqQArXQXzGpO
         KVKJ8Fudtljq0IRNdbHsLkFz+lrdr77b00ej+AAzcu5s3lOwTdNEjLzTUHz2HdglxABp
         MT+g==
X-Gm-Message-State: AOAM531vUTCJ3rXPrItKxTeetWW71LSk7ZutuMOiXwjq1zxTpFeeftED
        xTlgVrf43aqvrN2PobBeF4c/7w==
X-Google-Smtp-Source: ABdhPJyg0lgZlgBi8/Irq6grlvy58EaMpaSg/pdagWK+0tWzLnV3KOczUO8JKY6Ln9M1KxRZgEWLVw==
X-Received: by 2002:a17:902:7b83:: with SMTP id w3mr6022860pll.28.1599169555661;
        Thu, 03 Sep 2020 14:45:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20sm4165589pgj.27.2020.09.03.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:45:54 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:45:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 02/28] x86/asm: Replace __force_order with memory
 clobber
Message-ID: <202009031445.807B55E@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-3-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:27PM -0700, Sami Tolvanen wrote:
> From: Arvind Sankar <nivedita@alum.mit.edu>
> 
> The CRn accessor functions use __force_order as a dummy operand to
> prevent the compiler from reordering CRn reads/writes with respect to
> each other.
> 
> The fact that the asm is volatile should be enough to prevent this:
> volatile asm statements should be executed in program order. However GCC
> 4.9.x and 5.x have a bug that might result in reordering. This was fixed
> in 8.1, 7.3 and 6.5. Versions prior to these, including 5.x and 4.9.x,
> may reorder volatile asm statements with respect to each other.
> 
> There are some issues with __force_order as implemented:
> - It is used only as an input operand for the write functions, and hence
>   doesn't do anything additional to prevent reordering writes.
> - It allows memory accesses to be cached/reordered across write
>   functions, but CRn writes affect the semantics of memory accesses, so
>   this could be dangerous.
> - __force_order is not actually defined in the kernel proper, but the
>   LLVM toolchain can in some cases require a definition: LLVM (as well
>   as GCC 4.9) requires it for PIE code, which is why the compressed
>   kernel has a definition, but also the clang integrated assembler may
>   consider the address of __force_order to be significant, resulting in
>   a reference that requires a definition.
> 
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

In the primary thread for this patch I sent a Reviewed tag, but for good
measure, here it is again:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
