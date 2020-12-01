Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A12CA9BD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404132AbgLARbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbgLARbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 12:31:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A29DC0617A6
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 09:31:03 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so1508887pls.10
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIhrXegmFXx4Y1S8YgnbVoZcP9r/eMN50vMQw7Htjj0=;
        b=COBsdbubf4U1NB4bryhE6zpFJFlxC6tnZcSZU41etUauCccqXZsiquU+7Pg3YtVZk6
         FaJj4o1AIWN+/OM9H6u8TAIFxZgoJVNQ/2jTBB5a/m2hHYR3qjgThVUzKnMTBTgmN/d+
         qjZ/Lpe9hl7c2js/gywR+ayaeczGzpkDoU8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIhrXegmFXx4Y1S8YgnbVoZcP9r/eMN50vMQw7Htjj0=;
        b=WRKS39ZvYmf0nD4Aj22MgPz71T9zE1EBUP7ftRqeyOExJ30z67wkvO8Lts+bcWor2N
         Tt+PpRrHLCKi/pWQGrz9fOEE37aMNHYKO/u7jek6ysiSeeBHCstP3pcVWIfe2JjKpeSH
         s9AjnHr0wcbh+XoF6FXEc/YZgYCPqmtweGyA3sTmmwgprn2LEt0lKdb9xxMb25+sOUsk
         BaexjwQcSPSWu/BTzOv5CdSNIZSvCrVPPkChTHHsmJbIB12QZ1IJ5fgqNFSs4U7VfRAO
         Q2awQiEma9ux8i2eH7oFnNXZcZk1Z8z0wPH7hwnUpzFoGQ8PT32EoPSNi04MRaHdaHXt
         QTkg==
X-Gm-Message-State: AOAM532ZQINl4o8X53h3sQG3n1qgA4Zz2Mb08M1lIROC84oz+Ws7Nwsi
        YNxFxC2nqFJsIPkiN1YAan518w==
X-Google-Smtp-Source: ABdhPJxNXrz8lyJzMPvVj7dGfW+IUsSemW9FmHsAZMwUW4pvNI4+h4MvkJF21vQXTZU3MgV3CsB+ag==
X-Received: by 2002:a17:90b:224a:: with SMTP id hk10mr3671202pjb.81.1606843863156;
        Tue, 01 Dec 2020 09:31:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j143sm400818pfd.20.2020.12.01.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:31:01 -0800 (PST)
Date:   Tue, 1 Dec 2020 09:31:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
Message-ID: <202012010929.3788AF5@keescook>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130120130.GF24563@willie-the-truck>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> Hi Sami,
> 
> On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > This patch series adds support for building the kernel with Clang's
> > Link Time Optimization (LTO). In addition to performance, the primary
> > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > be used in the kernel. Google has shipped millions of Pixel devices
> > running three major kernel versions with LTO+CFI since 2018.
> > 
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> > 
> > Note that v7 brings back arm64 support as Will has now staged the
> > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > on fixing the remaining objtool warnings [2].
> 
> Sounds like you're going to post a v8, but that's the plan for merging
> that? The arm64 parts look pretty good to me now.

I haven't seen Masahiro comment on this in a while, so given the review
history and its use (for years now) in Android, I will carry v8 (assuming
all is fine with it) it in -next unless there are objections.

-- 
Kees Cook
