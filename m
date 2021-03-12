Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA53383AE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCLCkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCLCjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:39:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1EC061574
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:39:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e26so852089pfd.9
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bWbXoBSRfLL/FoTdQfLfpXolWUy5m83XPY+H7QO24j0=;
        b=evzkYQgPA8nzFkbfdQKvRQL6ieuUkCwpRnth+avWnhVog6oBX6wwEDiqjRSV5zJc4/
         a0uxnzyPyJry3x4YSS1x4Kmnn2YsoxzEP8f6D0kWamIfwpqHbY5Y0/qY/FWzHxMfwihz
         yUkW/BECzVzHTMH03Su4DS19ldO5mtf+x1ZZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bWbXoBSRfLL/FoTdQfLfpXolWUy5m83XPY+H7QO24j0=;
        b=A9DvJowJ96wh3N6odRNnsEXA4A9j91JC8qT2KsDdvmdSzLVU5QPkg66JA+XG1GX6RG
         aBV/Xht+QgPv3Lrr0X33LvL7G36Ahe64hVnH9L3oBAbl3f9UhNJzPjV2wBdzIYrEXrWj
         WmBuqt0DlZMQnJjUnFwPClEvtZe4rn4RtbR7J+gC7EqzIGciKZEOEz8IDFHmH5TojYqk
         8GQFrqHhyjRT2/hGw+UrElWWLzROHPm1TtsJA7m8gZkrhPWkh/tHd21J+C3hWlOJ8gEl
         7HOd3EuDBDwqc3OclL49RYBzD2iVGbS1dsVvMmmtFQid9JHj0gwp3mX3XyFBJWLs1eRc
         mfog==
X-Gm-Message-State: AOAM533jFo/Wp6Ev+ST03XJblck6eeFQ2motMGiD20+LEQuVYH6AP9I+
        DUHkREQePnlk37FyR+wYd+mOGw==
X-Google-Smtp-Source: ABdhPJwhrU4emOD5WayCUMZ7IN6WHeCVuTJ7ryuE6Iq+KPE0SNSElLD+CiEu3EiXqH08G+7H37jG2g==
X-Received: by 2002:a05:6a00:16c7:b029:1b6:68a6:985a with SMTP id l7-20020a056a0016c7b02901b668a6985amr10384578pfc.44.1615516786330;
        Thu, 11 Mar 2021 18:39:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t22sm393058pjo.45.2021.03.11.18.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:39:45 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:39:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] add support for Clang CFI
Message-ID: <202103111839.4A4375E@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312004919.669614-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:03PM -0800, Sami Tolvanen wrote:
> This change adds support for Clang’s forward-edge Control Flow
> Integrity (CFI) checking. With CONFIG_CFI_CLANG, the compiler
> injects a runtime check before each indirect function call to ensure
> the target is a valid function with the correct static type. This
> restricts possible call targets and makes it more difficult for
> an attacker to exploit bugs that allow the modification of stored
> function pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> Clang requires CONFIG_LTO_CLANG to be enabled with CFI to gain
> visibility to possible call targets. Kernel modules are supported
> with Clang’s cross-DSO CFI mode, which allows checking between
> independently compiled components.
> 
> With CFI enabled, the compiler injects a __cfi_check() function into
> the kernel and each module for validating local call targets. For
> cross-module calls that cannot be validated locally, the compiler
> calls the global __cfi_slowpath_diag() function, which determines
> the target module and calls the correct __cfi_check() function. This
> patch includes a slowpath implementation that uses __module_address()
> to resolve call targets, and with CONFIG_CFI_CLANG_SHADOW enabled, a
> shadow map that speeds up module look-ups by ~3x.
> 
> Clang implements indirect call checking using jump tables and
> offers two methods of generating them. With canonical jump tables,
> the compiler renames each address-taken function to <function>.cfi
> and points the original symbol to a jump table entry, which passes
> __cfi_check() validation. This isn’t compatible with stand-alone
> assembly code, which the compiler doesn’t instrument, and would
> result in indirect calls to assembly code to fail. Therefore, we
> default to using non-canonical jump tables instead, where the compiler
> generates a local jump table entry <function>.cfi_jt for each
> address-taken function, and replaces all references to the function
> with the address of the jump table entry.
> 
> Note that because non-canonical jump table addresses are local
> to each component, they break cross-module function address
> equality. Specifically, the address of a global function will be
> different in each module, as it's replaced with the address of a local
> jump table entry. If this address is passed to a different module,
> it won’t match the address of the same function taken there. This
> may break code that relies on comparing addresses passed from other
> components.
> 
> CFI checking can be disabled in a function with the __nocfi attribute.
> Additionally, CFI can be disabled for an entire compilation unit by
> filtering out CC_FLAGS_CFI.
> 
> By default, CFI failures result in a kernel panic to stop a potential
> exploit. CONFIG_CFI_PERMISSIVE enables a permissive mode, where the
> kernel prints out a rate-limited warning instead, and allows execution
> to continue. This option is helpful for locating type mismatches, but
> should only be enabled during development.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
