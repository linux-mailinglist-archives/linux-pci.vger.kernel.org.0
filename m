Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC053383C3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCLCnz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCLCna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:43:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B5C061763
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so10048520pjh.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=fS3ImwrxxM2DE3EPiSqkkSbtg7AkezrPZEd01kE1dWcZszmGj9zSpFTelfDiqstTga
         WftPqqERieBGyxCVAYbjYrgDbk6A5YKAfLzSpkArBkvYk41+DSZTjZOqaRsE43dgsGh6
         xNgvTqcdZWxl1z22bhI6cbBrEqddMCMIaR2WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=H71muXtwaPaP3gzO7hxAIGaeuc0TMSFYnsm/WwTe5I07E5bvHkGIa0fnvxwrpysI0j
         LcKXdWIN9j/lF8y22DaG3ZYbGMiUbFcwhXZVKJAGfqtCxk5fOskQyMxGYyLLEreZ0YwF
         R/RXoZBqd3ZSD5X/PRQmkTG/mkmjeFUPnYt9VzModhZ9NRl9MOuzvxsCTI3LZTCpMWQu
         4TBrJ+DBb7WnXBt91z+bDKffPynksy07y0fGtQhSYnU0qUlDUTo8RDMYNyy4bTNii662
         ZW/x3tc4LaPHr/0hC0avaSVHfSOWD4o27YJn01jkzk2xpAsZMquq2vnU80ejd5TA2hXB
         lGew==
X-Gm-Message-State: AOAM530oiqZJfsCt6NNPLxmsVamiAgSMnibW4I13e8V0owtJvoyxaJO4
        TNsls1On7H4reHCoAO1UW8doTQ==
X-Google-Smtp-Source: ABdhPJwJNeCPNAMR2ch3Yz24PwKhscrbLVrh74rWQAy51W9PeIe5O7weL/Cd+eYEYu9YKFOgM7LJSw==
X-Received: by 2002:a17:90b:686:: with SMTP id m6mr11513193pjz.26.1615517009803;
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s19sm3652536pfh.168.2021.03.11.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:43:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with
 modules
Message-ID: <202103111843.9456B460@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __kthread_queue_delayed_work from a module points to a jump table
> entry defined in the module instead of the one used in the core
> kernel, which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
