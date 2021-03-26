Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C651D34A0A2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 05:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZEfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCZEf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 00:35:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C10C0613E0
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 21:35:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1130325pjh.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 21:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vxhJYqYDEMLCG7mk2hvbmEzicWN7eS/ImmMoA4Wpy9s=;
        b=Y7C2yx9t4jVJNzzq+bJUag8zcjHDw7vTM3dhGvCOhTUSNJ9rVJAGUyw/R1kV1BKF9h
         UBZcJlu9jC+zABe5EH5uKqrAMx5g2Si4eSS06uLrUMls5fsYouIWM1mvmNY3BhP1kCgI
         7z3GGiGVF/ZfEa0cIMn6Cl6WedLtccFzIZQLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxhJYqYDEMLCG7mk2hvbmEzicWN7eS/ImmMoA4Wpy9s=;
        b=pk2mVD0jKDH1RsfVx/2QVjAgMG0m9ZR5T5TyrNEu96lbnlT7U4uD3jKfsyhq3WMklj
         I8ZWvhXbhnK/G43f/w9piDqrChfe/sWIsGIZLPwrDS76/yt5a1D7D3LeaMPvTzA6XFLn
         0Gn2VqBVBqa4ZptF96VsKaN08VodGlpXX+C7615AXSUHiInysKKO3wP6P6mU5rGPngYL
         fZJvfKmeyWg3u018QCdPXVSg2OOmRsM7+Yia5rikpBvpBmFCSCGa2GHRTf828rPBtCNl
         i6hzdtCO2vB7q7Jja8Lw3bbTLocBdjmBheIKM3y7f9Z53r9SV0BeaAheaNN+o1s+9yCj
         uCSQ==
X-Gm-Message-State: AOAM5315MHaKSVNPcHr9LEIqseM2KhWxzKUhVtDEmdZfG+yqhCzmj31r
        GK4HlFiGDp0A0WvtQRCTGJkULA==
X-Google-Smtp-Source: ABdhPJz2QNhFYdHooMpU/mFgIftB2v/X0l9ww3xc4ZF/mkJWRrD/dCONt/yBrv2NakIcxZr0lCtyZQ==
X-Received: by 2002:a17:902:d4cb:b029:e5:f608:6d5e with SMTP id o11-20020a170902d4cbb02900e5f6086d5emr13342060plg.20.1616733325756;
        Thu, 25 Mar 2021 21:35:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u84sm7686856pfc.90.2021.03.25.21.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:35:25 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:35:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/17] treewide: Change list_sort to use const pointers
Message-ID: <202103252135.9B17EFB@keescook>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:38PM -0700, Sami Tolvanen wrote:
> list_sort() internally casts the comparison function passed to it
> to a different type with constant struct list_head pointers, and
> uses this pointer to call the functions, which trips indirect call
> Control-Flow Integrity (CFI) checking.
> 
> Instead of removing the consts, this change defines the
> list_cmp_func_t type and changes the comparison function types of
> all list_sort() callers to use const pointers, thus avoiding type
> mismatches.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
