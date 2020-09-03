Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5836325CE0F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgICWqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgICWqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:46:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DCC061246
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:46:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so3252719pgy.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5TqmD5EyVPuB9TiyITqacSmLzI3cDbmlqWUeyi+ujCg=;
        b=oZ5KzCEi7wKIrEEj86amUMkUmItIM2KtyMb6kJV1Bx2j+6SLbFuob0rHAOq9f5nYH0
         BvcS2/vu4CZRFtoI7y0Mt062eAYVzZTqZzFG2Iu7rRRlhQSIXmNmKgue9t4cr4gsNbj6
         cT+JilU0DZpxA7uH2zokAyWWmg9TpkmIfF0Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TqmD5EyVPuB9TiyITqacSmLzI3cDbmlqWUeyi+ujCg=;
        b=UuRg+z2ynLEHCy7vC2JR+7cV2B80zQhF/Lv+S2v7mY+JKLoyRUL6Ev72yJyopbQrSZ
         MlwvXsbZ2/l+vbpG57t3LiozraqAc/2RJxltSHhYT0L3VGgaqkE7CsccJW13RJx+0Xf9
         cWayJFbqOOLpG8Zn6RWljQDxsu8Nc0pT5MYGT2xKEW1oZ9TLVh/tUsehGa5dUp1fccX8
         MeH5XjYPwzXKFF/2Xqxh35zILaqnWVrsWBDicy3+yqgrz8PMvO783LdQkrLM/E4569u9
         dCshxWQ/KiTOjs5LQQVd/6ZVPqDJK23bs+r1WwLLyt9BJqyX5tyYCKeEoMBC27Gf3r14
         a3gw==
X-Gm-Message-State: AOAM530R/u3LFMo89DtTo3LEQN5omBusomKOxBiWwGw3i7uyOcW3QB8B
        9yM2mXm6zDHdonY/8uJsx3PFSg==
X-Google-Smtp-Source: ABdhPJz0Cu4W/SGUiAG+2DPCBbmeCYnLc7352WExRrDx24NF8XVfzJeuLOmeQkS8ntOwly5Q8T3lkw==
X-Received: by 2002:a63:ca12:: with SMTP id n18mr4721941pgi.371.1599173171199;
        Thu, 03 Sep 2020 15:46:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm3633660pgk.36.2020.09.03.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:10 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:46:09 -0700
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
Subject: Re: [PATCH v2 26/28] x86, vdso: disable LTO only for vDSO
Message-ID: <202009031546.98CA2EF4@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-27-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-27-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:51PM -0700, Sami Tolvanen wrote:
> Remove the undefined DISABLE_LTO flag from the vDSO, and filter out
> CC_FLAGS_LTO flags instead where needed. Note that while we could use
> Clang's LTO for the 64-bit vDSO, it won't add noticeable benefit for
> the small amount of C code.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Moar DISABLE_LTO...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
