Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61332470E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhBXWnf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 17:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbhBXWnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 17:43:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16083C061756
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 14:42:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d16so2116492plg.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 14:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4qD0bh+6rEBJ6s6+qgDoBSjSKGiQ2q5y7JANudls5vI=;
        b=I1JHwIT+U9OO58Pc38ZuzAs2QzAh1xLUIAgX6huh6oz167TxF14RSoBid8UxG9B4qr
         OLWIXx0MZfnvjexW2V6qo9YvswdcbLQ3692oJSi14V+eV8cqWF7ZJ9sHpr6MOsiQR/pn
         6y+MrmnuWJSbFvzWiB+gcgOHY4RvFpNasRt18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4qD0bh+6rEBJ6s6+qgDoBSjSKGiQ2q5y7JANudls5vI=;
        b=QSkoMisTL1OHEthz8Rck7nEjZ/Acb+oRsmCLvCf0fTy5FeAk23+hc8GtXwXUcSXcyN
         XIqcv4fs+w3Zz8yfQx0RYLwLn0zS2TBWUeI4LzDgZyghC7FQwLj2nYAeU6+wCuC/eCWH
         GGYRSy/5/OZILgYmp/EwRV54mB0cWpWNyN4ojxfi4WBEFKNrQKzf7m18miPFt+M3OuH2
         4TjagraPRFnIHbhG+yiMhfkYQQn88LV0fH7qFrGYm9Do9+zoLZYeeDbIM9h73ez6pfhb
         sgLDAttekMCnSJ8YVp/C4ZOR/tnT/HAv8lzsgtCYT4AFkkShNbU9JuSFzhbw6ynpnnre
         pN9g==
X-Gm-Message-State: AOAM533k5g2AagsLW2RZDtdF6aArbOo/7ZRXn977HYcnR7y/Q8hVuAOZ
        oAlk4MGfoWK3h78ymvpu9A94Uw==
X-Google-Smtp-Source: ABdhPJy+FDtnD+N/ZjqgPPbWw42HtyErBlOSrKNol4tmTskqrDwuTPUww2A8PcDziLPJAW0AfGil9w==
X-Received: by 2002:a17:902:9f94:b029:e3:287f:9a3a with SMTP id g20-20020a1709029f94b02900e3287f9a3amr296408plq.46.1614206571524;
        Wed, 24 Feb 2021 14:42:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm3739586pfb.197.2021.02.24.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 14:42:50 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:42:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v9 01/16] tracing: move function tracer options to
 Kconfig (causing parisc build failures)
Message-ID: <202102241442.C456318BC0@keescook>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-2-samitolvanen@google.com>
 <20210224201723.GA69309@roeck-us.net>
 <202102241238.93BC4DCF@keescook>
 <20210224222807.GA74404@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224222807.GA74404@roeck-us.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 02:28:07PM -0800, Guenter Roeck wrote:
> On Wed, Feb 24, 2021 at 12:38:54PM -0800, Kees Cook wrote:
> > On Wed, Feb 24, 2021 at 12:17:23PM -0800, Guenter Roeck wrote:
> > > On Fri, Dec 11, 2020 at 10:46:18AM -0800, Sami Tolvanen wrote:
> > > > Move function tracer options to Kconfig to make it easier to add
> > > > new methods for generating __mcount_loc, and to make the options
> > > > available also when building kernel modules.
> > > > 
> > > > Note that FTRACE_MCOUNT_USE_* options are updated on rebuild and
> > > > therefore, work even if the .config was generated in a different
> > > > environment.
> > > > 
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > With this patch in place, parisc:allmodconfig no longer builds.
> > > 
> > > Error log:
> > > Arch parisc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at scripts/recordmcount.pl line 405.
> > > make[2]: *** [scripts/mod/empty.o] Error 2
> > > 
> > > Due to this problem, CONFIG_FTRACE_MCOUNT_RECORD can no longer be
> > > enabled in parisc builds. Since that is auto-selected by DYNAMIC_FTRACE,
> > > DYNAMIC_FTRACE can no longer be enabled, and with it everything that
> > > depends on it.
> > 
> > Ew. Any idea why this didn't show up while it was in linux-next?
> > 
> 
> It did, I just wasn't able to bisect it there.

Ah-ha! Okay, thanks. Sorry it's been broken for so long! I've added
parisc to my local cross builder now.

-- 
Kees Cook
