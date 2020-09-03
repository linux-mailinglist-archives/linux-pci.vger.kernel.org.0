Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9480925CD6B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgICWXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgICWXl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:23:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F99C061246
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:23:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so3447582pfc.12
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H9pa3N3N+X5kZ3hnxzvQ5nbf/nL9Hg2di+HfYCma81c=;
        b=MDW/84QFAbUZu6t/g0TK/VAn9O+TVo4DzXtdS9Mhsj4QS/PE4e+Rn1k5NJYTcEw24e
         tNZS2BxVn/MJcmyK/CDSaMc4ViToYo9qGsGIvo5Wk1nGGaIuLIS6ugX3FalJIhONa1De
         fN3g8m6b4O4IAz78V2dpe1p5CqrvjqKDQ1UOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9pa3N3N+X5kZ3hnxzvQ5nbf/nL9Hg2di+HfYCma81c=;
        b=UIk5hLJhyUVKN5B08b0Fe2r33xGvTrlnn+0qWFL5EGwY7sXiBiWCl0gcO0NaPSecsE
         qpdSjvq0wZQK5IQi0RVXtDP/grRykL/czD3s4ddz0GXDeylwpE0ODsPAq8D84ET4aU6x
         Ah41Ixafc5j/2ilyMknjKnCiVX8uFahuWtCIegkgNxUTmojKxNFd2B2dav19bd63JPYi
         ckrxxUYVECmCUGdA0t6Na2IYk54HrcsRcdwp0GSLGnO4Ys6xAgzsDEo9zUEXFEfvzwLL
         HlcAr4A6WfgB9inicLQt+vZi6/V5KzlYz0H1AOA//1Zg6z/EjY47QLHsBv3ZUAN4YJKW
         gyTA==
X-Gm-Message-State: AOAM533jFcJL2reEzOW097CzvFQfHVXE3dlRyO28RVA+b40G278Mj06Q
        DrOTsVa15PtMG9YmJbioQiPwmA==
X-Google-Smtp-Source: ABdhPJxcY2j2KcoBxTS2ZsNzK0y4z5+F+CWnnaOAlqa994vL2EIo7Uflbx8UD2XsOoy0qHrpZNJapg==
X-Received: by 2002:aa7:9286:0:b029:13c:1611:66c1 with SMTP id j6-20020aa792860000b029013c161166c1mr4124056pfa.12.1599171819570;
        Thu, 03 Sep 2020 15:23:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm4361846pfb.201.2020.09.03.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:23:38 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:23:37 -0700
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
        x86@kernel.org
Subject: Re: [PATCH v2 13/28] kbuild: lto: merge module sections
Message-ID: <202009031522.2BA9A035@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-14-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:38PM -0700, Sami Tolvanen wrote:
> LLD always splits sections with LTO, which increases module sizes. This
> change adds a linker script that merges the split sections in the final
> module.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

We'll likely need to come back around to this for FGKASLR (to keep the
.text.* sections separated), but that's no different than the existing
concerns for FGKASLR on the main kernel.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
