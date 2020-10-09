Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B3289A29
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391213AbgJIVGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391133AbgJIVF5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 17:05:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8376C0613D5
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 14:05:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so7892813pfj.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXQaBaNS7A6eVo/ydORo8r5bdU1C9Le836RTdHwCBbM=;
        b=JoSdKxNwxsMfI2U0CjlTc5BwvhqCy714WkSi+WKKGJVkSxeS4A84NzKevK6CPn9KXt
         luyi7jDs6nQbVyyVPeYM9mQUjAAefT+ScUKjFnKzQLP7hS1caTnxv6LwwjUOs1sG613o
         Z1mfBp8CiisbR4rWjXF/lItpg0T+9m58kSN6ymcBrb9qx1Q5pE6/8rfEwDSOFoHPmLeK
         ZOhU9su8JfRbkCsj5wTlpzUcuguhQKLNKVmqQEdIiT1RZKGFUwDcT20B3P+mB4B8pmtl
         zOKoiM+eB3smbcYTz3v4uqlSVWDNijwAFgnLDRm8ha9grVnXIpZsyUDrdJ34aNugK5Zh
         t79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXQaBaNS7A6eVo/ydORo8r5bdU1C9Le836RTdHwCBbM=;
        b=dUBJXEhu1fsQ173W+vyu3ML/pqhamf2XujQGCjYMAIu0FV9SxsiWrJNG74C1yNYoB4
         D86qu/9T+L/MoSsYnWMCqTnx+wXDGRXUhwhdvx/gVWjDgI7NOaNEvdoVYF1EGwiWIdT3
         HS4DePo/KPb0UuHbDPP4hmaTuSzrf049EUyhZZtEE4NIuq8eC/pnus8aaMfo71+nRL0j
         MANhEmF166RJgs9EqU4GvUsyi9iHjbsYT2DNEKbwh705NXFmaxinSOK2ZmHnNcw76gCR
         hYiGIJdzhLyrDZ5r8BOeuEyE4Kyoh27JdKqfXffHWuOi2zxatzADAa59hCCER9/g1FHm
         DRFA==
X-Gm-Message-State: AOAM532Bk/oBTPZgG8GSJQmehOipll1tV9WwfJmvkl8XjbNpzWKf3W/l
        GAc6azg8alyGOMqCqhM/bLwmPQ==
X-Google-Smtp-Source: ABdhPJxjzJ92vFbxcRcoQJ+j6aZ4ui51r5YFp2dBuqEKUdI8vRCJOM24sn81H3xCAiwt33ZPrcU5Mg==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr5047545pgv.106.1602277555126;
        Fri, 09 Oct 2020 14:05:55 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id t13sm12057753pfc.1.2020.10.09.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:05:54 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:05:48 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
Message-ID: <20201009210548.GB1448445@google.com>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009153512.1546446a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009153512.1546446a@gandalf.local.home>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 03:35:12PM -0400, Steven Rostedt wrote:
> On Fri,  9 Oct 2020 09:13:09 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
> 
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> > 
> > In addition to performance, the primary motivation for LTO is
> > to allow Clang's Control-Flow Integrity (CFI) to be used in the
> > kernel. Google has shipped millions of Pixel devices running three
> > major kernel versions with LTO+CFI since 2018.
> > 
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
> > 
> > Note that this version is based on tip/master to reduce the number
> > of prerequisite patches, and to make it easier to manage changes to
> > objtool. Patch 1 is from Masahiro's kbuild tree, and while it's not
> > directly related to LTO, it makes the module linker script changes
> > cleaner.
> > 
> 
> I went to test this, but it appears that the latest tip/master fails to
> build for me. This error is on tip/master, before I even applied a single
> patch.
> 
> (config attached)

Ah yes, X86_DECODER_SELFTEST seems to be broken in tip/master. If you
prefer, I have these patches on top of mainline here:

  https://github.com/samitolvanen/linux/tree/clang-lto

Testing your config with LTO on this tree, it does build and boot for
me, although I saw a couple of new objtool warnings, and with LLVM=1,
one warning from llvm-objdump.

Sami
