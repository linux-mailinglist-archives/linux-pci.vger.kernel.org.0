Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091CD28EB09
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJOCTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgJOCTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 22:19:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013DDC05BD23
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b26so712317pff.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXE7zd358OihnnXdqbHtVXM+0rFJH6HtXX7mG7HS7rs=;
        b=P+m7XeYyZ2d5m2JBT4Wg90TEWdILqbaLccqKq7i1SamEiRkb82fahXnlpg2f1W1wbg
         hYpm7jOYPcOHuFgqqHnuX4V3PF9C/c9wSPHpPybZudVDCal6bW+V4V423MNW5wH9Pi3v
         EAtrVXrDgHaNrDFivAYIB/ro+72Y46zcpNM1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXE7zd358OihnnXdqbHtVXM+0rFJH6HtXX7mG7HS7rs=;
        b=paPEUB5F0pnc6TYxaNrq96z3GpGdPIfkYgp3ixxqlSAEE+UKyyzRQI/W2D+oWu4YVQ
         955asdu0KoUNEVP8pJ2C2Y8LJxqj7yfwEi1g4YTP1092nYA7tbXLXcLBb69npmlcDVd3
         L9jvYK4b6SN/Rx/P5dEn/irnH4BLc86kLjgXcP8X9W9UOI5UchzeT0rBCNEURrSVsVsA
         mG/qMQ+9JMssIft4gGLg9bQ0PFSGzvQolNlxPTRBbZJMhDydrFlbQeI0aiVOkTXUgSsR
         Wu45h2nyGZXrwxq4/sHpbxOhHsZ2n9Mm9yHWNzW7ODhi/VZA0L4E9t1+GQYLPQk+ibPV
         v76A==
X-Gm-Message-State: AOAM532X9WkJYBnrfTGK+Qn4GFLJrp8duG8qJgGxopLmaNurkrEYhCDa
        Vv8bo2QFeuS1ACc74R4FsSIyMg==
X-Google-Smtp-Source: ABdhPJwfaPNC+AVzyD2mbtxihYKliPRj3PBojQshk4IbHIXu4wlCtL4Vs5DVZZ2Xhz60ywvob16sAw==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr881793pgc.303.1602715405507;
        Wed, 14 Oct 2020 15:43:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14sm630167pfc.170.2020.10.14.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:43:24 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:43:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 07/25] treewide: remove DISABLE_LTO
Message-ID: <202010141541.E689442E@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:45PM -0700, Sami Tolvanen wrote:
> This change removes all instances of DISABLE_LTO from
> Makefiles, as they are currently unused, and the preferred
> method of disabling LTO is to filter out the flags instead.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi Masahiro,

Since this is independent of anything else and could be seen as a
general cleanup, can this patch be taken into your tree, just to
separate it from the list of dependencies for this series?

-Kees

-- 
Kees Cook
