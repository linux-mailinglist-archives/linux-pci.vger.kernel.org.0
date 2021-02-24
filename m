Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE465324562
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 21:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhBXUjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbhBXUjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 15:39:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD1C06178A
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 12:38:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d11so1916794plo.8
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GZwVz+by9nHRK/VgqqFp4hya3sLU12ve4q94Q8a1TOw=;
        b=PkCcl/k7NfbtPwMQr8z5WhePJ8T22XJy9sfGUI5eow2vQmOTwG1B3B6CsQhjz6CARN
         hfN1R2ddWbMTYj9tE1Lwh+a/L635lr64afHtTZRdXvbYHBmR84iGmARmfeZH96r9Q2bl
         rylrULoicn3EwqmyKEvuCNlKTjG3ImD8g1etA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GZwVz+by9nHRK/VgqqFp4hya3sLU12ve4q94Q8a1TOw=;
        b=to/ICYPaT5/Uqb6lKUtx9ZzOXPyj4+1eVkblMauBeP3DNq6CjOdLC2VRAlHJPIWnUM
         4f9RB6ZnMfd0EtuG57MjRa0HktB4iPCKVuwon6+SKDtCOvWlSa/DheM4an5e5SX9AhAk
         iEsd3nmEO0SwZgRJBWQkHKMtwcy9jLLvDrYBeiFopSs+Pg/M2z/67rhX7QmxG69hAt9J
         P+nkUp+itPFWSpgZ1R6i+RUuL88fs0zr3Y5jmS/0nzROnULMQYCs27c+Dh6+1c3Bq+Wg
         iXbDvrQB6OLQiG8eQHgTcYZyci/qtKElh3NJZwxUHRxCqXqYEdy0zXTn7n3v1o4Pm/d4
         QWuw==
X-Gm-Message-State: AOAM5303EJ0LRo8dYOYzA6HpG+89qVT9amza34nDlctHfmfnlE9fbXQs
        Yg2yEO9ZbRPvpcoz9GWnyI98dQ==
X-Google-Smtp-Source: ABdhPJxYx1U060YI3/ocToHHmhrh3XN5Wc9YJIVgqhXdsuC8TDQUbe866zMWKSPIdD0ty9NbhhGm4g==
X-Received: by 2002:a17:902:8d82:b029:e2:e8f7:ac44 with SMTP id v2-20020a1709028d82b02900e2e8f7ac44mr34308993plo.60.1614199135689;
        Wed, 24 Feb 2021 12:38:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm4268137pfi.99.2021.02.24.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:38:55 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:38:54 -0800
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
Message-ID: <202102241238.93BC4DCF@keescook>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-2-samitolvanen@google.com>
 <20210224201723.GA69309@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224201723.GA69309@roeck-us.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 12:17:23PM -0800, Guenter Roeck wrote:
> On Fri, Dec 11, 2020 at 10:46:18AM -0800, Sami Tolvanen wrote:
> > Move function tracer options to Kconfig to make it easier to add
> > new methods for generating __mcount_loc, and to make the options
> > available also when building kernel modules.
> > 
> > Note that FTRACE_MCOUNT_USE_* options are updated on rebuild and
> > therefore, work even if the .config was generated in a different
> > environment.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> With this patch in place, parisc:allmodconfig no longer builds.
> 
> Error log:
> Arch parisc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at scripts/recordmcount.pl line 405.
> make[2]: *** [scripts/mod/empty.o] Error 2
> 
> Due to this problem, CONFIG_FTRACE_MCOUNT_RECORD can no longer be
> enabled in parisc builds. Since that is auto-selected by DYNAMIC_FTRACE,
> DYNAMIC_FTRACE can no longer be enabled, and with it everything that
> depends on it.

Ew. Any idea why this didn't show up while it was in linux-next?

-- 
Kees Cook
