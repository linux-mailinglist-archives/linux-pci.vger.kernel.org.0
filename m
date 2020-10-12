Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBD28C2E7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgJLUpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgJLUpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 16:45:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8CC0613D5
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 13:45:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so9312313pll.11
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/je9IGonHzFsuF/SNifo0ZcXgtv4yeAu6zOR0qhli4g=;
        b=iBvAVUobGLxYChgzQDFIjdgKitAhC2jHTTevcSYvj7umuQsfw68FrsiS588nddPL9n
         rvr2pXp07ZQWqM/LOhZO8EaapVG+BSzu0jORrfEH3ohPyD3qyDxXqnlKu5B0F1SooZd2
         mIgofFGRcvthuFUyb4XxZSLu96zkfV5bLY9hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/je9IGonHzFsuF/SNifo0ZcXgtv4yeAu6zOR0qhli4g=;
        b=A3FgYnwxVjL05oNhQwnlTMPR4p+5eed/EBCDA14ftq/X+lXHgZCd01xk5a9CP+oLIG
         OXgVwnuXByv3tlShMKPs97O8k0bflVjb0XgipVXaFYej12nYII/Ktx7CLzG0vZg864wc
         DFdYChRYJjVr4BLnEWBZONOnRPsxE9O3zDci6GYZFHLoGzdSDbTde6VQQm2sLUTYJrxd
         gLYYA65syh/b7AyCUCyvRNLCD5JJW5CiPXdg9XkWJ8UkGjSylQoShGeFN+Mg/3IbCaQY
         PQ7EarMelzTgojcHe/Gx6YYLsIlvq+xpXxWfYy23fTK1wSeMQp/zBOMTfoaK5qQg6tUG
         BGMA==
X-Gm-Message-State: AOAM533fC+TOwszsCj/uaJApFeH9wmt5TqdL9q6qpsKNxgU6d71BEghb
        YYDVCzmnVhTdx/xlC1peDxigpQ==
X-Google-Smtp-Source: ABdhPJxf12qi2TvIPdMo3b44hzG/IVxwKW/VadUKNptF9UK+YkxRipHLl4jP/u0pgN9HY2DkPgijnw==
X-Received: by 2002:a17:902:cd07:b029:d3:9be0:2679 with SMTP id g7-20020a170902cd07b02900d39be02679mr25530237ply.68.1602535499967;
        Mon, 12 Oct 2020 13:44:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v20sm16032300pjh.5.2020.10.12.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:44:58 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:44:56 -0700
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
Message-ID: <202010121344.53780D8CD2@keescook>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009161338.657380-26-samitolvanen@google.com>
 <20201012083116.GA785@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012083116.GA785@willie-the-truck>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 09:31:16AM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2020 at 09:13:34AM -0700, Sami Tolvanen wrote:
> > Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ad522b021f35..7016d193864f 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -72,6 +72,8 @@ config ARM64
> >  	select ARCH_USE_SYM_ANNOTATIONS
> >  	select ARCH_SUPPORTS_MEMORY_FAILURE
> >  	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> > +	select ARCH_SUPPORTS_LTO_CLANG
> > +	select ARCH_SUPPORTS_THINLTO
> 
> Please don't enable this for arm64 until we have the dependency stuff sorted
> out. I posted patches [1] for this before, but I think they should be part
> of this series as they don't make sense on their own.

Oh, hm. We've been trying to trim down this series, since it's already
quite large. Why can't [1] land first? It would make this easier to deal
with, IMO.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=rwonce/read-barrier-depends

-- 
Kees Cook
