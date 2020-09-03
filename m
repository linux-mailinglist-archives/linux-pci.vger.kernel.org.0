Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FB25CE08
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgICWpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbgICWpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:45:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A098C061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:45:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so3516071pfc.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JXlymsrIbyM7AjGm/2rfdOYB0H1CVU1h4Svm00pvuI0=;
        b=DWsncKoXfy4PxyNvBSrYQCxtYjY8jyteneTwkz6mlHPPEZFF7gp7715SOKmC4/qkxD
         q+SYZYmla2S9Ys6tFjcp4ODWzXwDrV++MfFs8CcN+DqLmMxXFZakptYE6CAUTvkVC5UV
         20qyxQyoX4j38sYtCuXlnZbJ2RYy/taCcoWgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXlymsrIbyM7AjGm/2rfdOYB0H1CVU1h4Svm00pvuI0=;
        b=aPS+Mga734E6IkFFSxKiSDg45wYd6YqSHk7T/98Xz6H8dq2PYCwa3NZYx0wBKp1BoM
         vQYEeaYMV3qCeZWWLgBlGQu8kZFmLZ1hxICTKACk2c9vbuK2+1+Y6DX1RwJaqUxX3H6S
         uABssR3c307gKjLlwHLjt8cxVf2hS25QHMJvgV3im2NgQLncfbWYXZYbsnWKaMfj/YyQ
         zH2GFgO9VJS3UfukdWiaRoLyBQ/N/eGGgVJuCWzj017rippnlzEiyDT4PTEqU1ptK0Iy
         /RHTfSylR8m/VKjZ1oR+JhXMvgh2Rmt8NH2gwXJ5H3oC0AMxap/E+x3j3ufALIiI8DUa
         N86g==
X-Gm-Message-State: AOAM530UhZmK17CxQaY+3S8UX5bJ7TelwjwpPbe9Y/tyJQQSe9Altefn
        U5jdvQNMaIICruzo66PRvbqzSg==
X-Google-Smtp-Source: ABdhPJyzQQa+rbWQTOULGEXaVav+gnGRAy9CUx4utciFuxZtqNR92PboxBy66CUG56xUgxKlxz08hw==
X-Received: by 2002:a17:902:7609:: with SMTP id k9mr6059271pll.227.1599173146049;
        Thu, 03 Sep 2020 15:45:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm3619987pgj.0.2020.09.03.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:45:45 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:45:44 -0700
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
Subject: Re: [PATCH v2 25/28] arm64: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <202009031545.559F27FAE@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-26-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-26-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:50PM -0700, Sami Tolvanen wrote:
> Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
