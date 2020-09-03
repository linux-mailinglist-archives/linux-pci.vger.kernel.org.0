Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7028625CDE6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgICWnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgICWnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:43:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11188C061245
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:43:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so3501051pfn.5
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x2xuRKyyLJWi/1UackWdCkMB4cqQZJ4+/7t+T3jGKh8=;
        b=lJIfcDz7WioC0cxPF2mcu4r4CpHJqN+NQMfhDVOZMDBJjVlbujjOIztvgAAg+FLLZl
         OQLArQHvfuAUFWnT+Br9hn0eKYi/T1OqGrNfJkgbHQQkXC6PnVXOP14VrZKCoiAx6sGj
         N08DlYuf2tSmgQZcy/X6jmQw8+vZKntUZzYMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x2xuRKyyLJWi/1UackWdCkMB4cqQZJ4+/7t+T3jGKh8=;
        b=OXJ9vAw/+BCBgvu1oykW4jHBLNc3uc87a3O71YtlJSoLgP/t4YVhv7XFSCA/PV+cBN
         6u1yw8+IHKx3yAZLOrsGlK/n8HkWN9NW48wmXvXCD1wPTbHNPmH7Ecw+T9wI4X5YA9Mx
         p6WblutIeJXUWTYG00CrufAcK9REUChrxiPfHsRLPMIscU0HtIWL5jEAek1b0QApUwmv
         UjN5yUItkLfFOPrsUoGjiii2+5ucqs/E4fT46s6jjYg3/YeJyQ6FnnK/G5bkgENpm4sO
         2As6CemGjlosheVbIVZm0n64mnNK+2JRnLl1m3PpRFy2NcRTwgVmHXf1+oLpJk5fN20P
         FRwQ==
X-Gm-Message-State: AOAM532fANoxNtENoLOtHIX6bZWcbpbo4egh732hFl0+sENgguV6Q8jb
        y4YvpY6TZZOLtHNeTTSTKpz15A==
X-Google-Smtp-Source: ABdhPJxsKeiM9lZAcQ/0JJhv0k/hyo346z/156yZaTdrOqzHtGfq/qkV1ZHNDgZ+unL1v+eZfT0LrA==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr6096909pld.1.1599173018675;
        Thu, 03 Sep 2020 15:43:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16sm4354057pfq.13.2020.09.03.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:43:37 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:43:37 -0700
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
Subject: Re: [PATCH v2 20/28] efi/libstub: disable LTO
Message-ID: <202009031543.47CF616F@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-21-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:45PM -0700, Sami Tolvanen wrote:
> With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
> files. Since LTO is not really needed here and the Makefile assumes we
> produce an object file, disable LTO for libstub.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
