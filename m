Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1828C3B3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgJLVCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgJLVCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 17:02:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B6C0613D1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 14:02:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j7so4833463pgk.5
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnB7E0mI9F7Ie4RlS2cFfqKwCDcopSImUj3IgUSKIxI=;
        b=aKY2mjZqZCjoAe1tt9s9T2FsyHGWEg2r94yXrTIjifMKj+9G5PGXHdmHun7LMLnVVf
         Iyx0hqwAI4RdNjsS7WRjj36UFpYvhE5Z30RnvNh8wxzPTZqIDq/V6FSJyRhQlm3vqAgv
         czJMjy/QiJI5hFODJh0hCucbVTQNfJmHuR7Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnB7E0mI9F7Ie4RlS2cFfqKwCDcopSImUj3IgUSKIxI=;
        b=CUnBII/ExwSAjOhjzUvtKaf0qBQyaMcqYrEfwmq/q5ZW2U88TfKFIPj3KSRYcd8rkt
         7T4T5xPfFqo3xfMPmFFf5npafO5qlB6a5Wq82liCoFe7o69aWFaO15Ul7zshLxWOGLQk
         cfbRqpomKELEx8dAtEypKusl30FDv/WjD3vTSXXdExZYacyu2Tptw8IbmCBWxvF1dw98
         mK+aGu4ID3p8X+TCto0o4OZUSEFG+uPCGutD5uR9Qj/37E1hOzP7v23f0ZS96RgO5LDq
         j4v95kON3zW5xG5IS5C63HX+tlyFSDLELB7J37u0B+RilU4ImkDKhDrktHBTfHw1Fneb
         oRPA==
X-Gm-Message-State: AOAM531OviQs1dNm/hmT1mgA8tQrHUKeMUcm992F1zxuHCmJCvyns+wM
        GMrTGTAxMT2eQCLIRdBnYXI++g==
X-Google-Smtp-Source: ABdhPJzJnGcA0q8XKKQGw3kIUgQPIXUnpTwBiY6N5ghL0OHEl3zmbEFuNMnAsinW9yZvnNW49rm+aQ==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr14040343pgb.287.1602536557163;
        Mon, 12 Oct 2020 14:02:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm24744149pjl.27.2020.10.12.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 14:02:36 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:02:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 25/29] arm64: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <202010121402.1EB5242@keescook>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009161338.657380-26-samitolvanen@google.com>
 <20201012083116.GA785@willie-the-truck>
 <202010121344.53780D8CD2@keescook>
 <20201012205108.GA1620@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012205108.GA1620@willie-the-truck>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 09:51:09PM +0100, Will Deacon wrote:
> On Mon, Oct 12, 2020 at 01:44:56PM -0700, Kees Cook wrote:
> > On Mon, Oct 12, 2020 at 09:31:16AM +0100, Will Deacon wrote:
> > > On Fri, Oct 09, 2020 at 09:13:34AM -0700, Sami Tolvanen wrote:
> > > > Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> > > > 
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/arm64/Kconfig | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index ad522b021f35..7016d193864f 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -72,6 +72,8 @@ config ARM64
> > > >  	select ARCH_USE_SYM_ANNOTATIONS
> > > >  	select ARCH_SUPPORTS_MEMORY_FAILURE
> > > >  	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> > > > +	select ARCH_SUPPORTS_LTO_CLANG
> > > > +	select ARCH_SUPPORTS_THINLTO
> > > 
> > > Please don't enable this for arm64 until we have the dependency stuff sorted
> > > out. I posted patches [1] for this before, but I think they should be part
> > > of this series as they don't make sense on their own.
> > 
> > Oh, hm. We've been trying to trim down this series, since it's already
> > quite large. Why can't [1] land first? It would make this easier to deal
> > with, IMO.
> 
> I'm happy to handle [1] along with the LTO Kconfig change when the time
> comes, if that helps. I just don't want to merge dead code!

Okay, understood. Thanks!

> 
> Will
> 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=rwonce/read-barrier-depends

-- 
Kees Cook
