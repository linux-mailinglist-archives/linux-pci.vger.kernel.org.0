Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED325CE1C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgICWsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgICWsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:48:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03814C061245
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:48:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so3256911pgy.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N0kZAZSHXumzFlr+P3KSPa/xm/RvLBA66H9sz+ks+Hk=;
        b=Oywi+Oecms9EF3LovMy4YD4zvKOmcmZdnBLP+RpPo6vJNZvq4Wn2exUrN/cYyBRvkj
         QpHAOCzGUNXF3wIsqPQqbSCg3YTtavUaX+FrsM9NvoAyqfJuCJ9m05znPNWTjs0F38rh
         A9mlrLTr/MJ+vIHnNL9G8CGzKKp8or3nRT3jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N0kZAZSHXumzFlr+P3KSPa/xm/RvLBA66H9sz+ks+Hk=;
        b=aj3eFZ3hT9SRn1g6Ksw3i6tgyXMCcMSVLILdPV6vIxhv4uH4li0n0JxbIsztkOpAmt
         OAvT5RRptNcRMJXlrMa6Of1+/x3mrR528zKNWxzZudevf/x5gctNAqKKENnTMYtnyafY
         elZiIR+bSewKuDELM1xEXPZMFYZwosK9hW3/rAZCEtFOFRKFvdYwVjyy3CuEsJfu2rNc
         vMeA2MlUCdZvRseG+aA5NTHgLlF8XpGOg0Dv9ORFR+moAuy4t0s44RwgTxmZa4jMzBdP
         LuMGWTK6Nyp6ctOuH/xFVG6Rdtuyxu5T6X+bM2VrHryM+zKev7WnFDumXmWv+bpi80fC
         fg2w==
X-Gm-Message-State: AOAM532PxncSZPWIF7N84nUo+hKieGJ2YXmnsqIlHZqjvn619Aorrs0d
        tCU/RYyaMe7hx1uDuaXHDvXUeA==
X-Google-Smtp-Source: ABdhPJzhSDd0wUjK+CLAjJOCS+RRpwDZiMWAA9QXCsfZew5vqJTkaYMpTKaYMs063H+/576UYhDU1A==
X-Received: by 2002:a63:f546:: with SMTP id e6mr4666553pgk.7.1599173318626;
        Thu, 03 Sep 2020 15:48:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q71sm3612032pja.9.2020.09.03.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:48:37 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:48:36 -0700
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
Subject: Re: [PATCH v2 28/28] x86, build: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <202009031548.84902F3F@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-29-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-29-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:53PM -0700, Sami Tolvanen wrote:
> Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I think it might be worth detailing why these arguments aren't handled
in the normal fashion under Clang's LTO. Regardless, it's needed to make
it work, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
