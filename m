Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9393383C0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCLCnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhCLCnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:43:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51EAC061574
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:43:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z5so11229270plg.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNPsz0QLD3vM6+qNFMQ0OL0lFNeTebIONp/Q9dpVBmA=;
        b=QFHHVkV6BruBDLSqpSS5ZgpkzbKbFL9XcSmhEzK11y2mzkKvPQY9xpKatfo/Os2Tcd
         vIbekihgbpvMJcPrRh8gScKUhr1OSYBQOHteZqL4n+5ye8SOoMq6eXo3GEVPYy8bBb5Y
         7GtOMqPoVrJccKwnjRy9eXNFAdum8kSTxSXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNPsz0QLD3vM6+qNFMQ0OL0lFNeTebIONp/Q9dpVBmA=;
        b=clo86HutMusOt/vLlYMVy4a2GTCmXoNkcDCB4bX4ptGyA/TZDnFOTTOYNJKx5AMC6r
         4sxfM1P7oGqcCQDD5IliiHsXXwioLNdQypwDFLeywzp9SHBC4LjwbsmM9hOY5FtGhCyH
         2uuOMFxnYqkPBpA2BWKvcs9SBcrxSpjPCvJ6Bek5az84nnW/trt0IWV8yyH38d7BLNO8
         GiV8dWAFtBB6D7TMHJ4KHJ0ywfRzNLW29osyd84eKG+/ODtFHoB7OtDbzDO2hoVuS7mX
         Oqfyb//+TogPEDszurKhK07x6dt0cYNLqgc9OEV4KgqTDuVocCWBIWDe857kXXUo+YG7
         JFjw==
X-Gm-Message-State: AOAM533Oj/T9UsN0V5rkHVcwSUOTOR2Ek5h5l0BxPVXp1H0uSEgIXTqk
        NmUqmSzlqBWh/7xHcSdmvcAcpw==
X-Google-Smtp-Source: ABdhPJwFKoCF8whxDXdLUhHjkHxm4/5ycmKLMkKhBI3hwmAY7tNoQI3rQR7e3wSMLF56vcYEDo4ITg==
X-Received: by 2002:a17:902:9a45:b029:e6:1444:5287 with SMTP id x5-20020a1709029a45b02900e614445287mr11337807plv.54.1615517000236;
        Thu, 11 Mar 2021 18:43:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm382256pjx.42.2021.03.11.18.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:43:19 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:43:18 -0800
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
Subject: Re: [PATCH 05/17] workqueue: cfi: disable callback pointer check
 with modules
Message-ID: <202103111840.58C5D95F@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:07PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __queue_delayed_work from a module points to a jump table entry
> defined in the module instead of the one used in the core kernel,
> which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
