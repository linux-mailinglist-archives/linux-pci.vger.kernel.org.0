Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD03383F3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCLCsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhCLCry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:47:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1AC061761
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:47:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z5so11233831plg.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pbYYGaj80nmpPvKAoi7nhvjG8dX/laYbfFgJvGfe3c=;
        b=TVvY3uWHgNwAIsZEgnbifL/pc30apYHHTufaQZzVegGdzliIuHgvA8Nbd8Lrll72FY
         KFmxKs8QqhJcSAjCd6mlI3lKltRekuyYpF/AgZJ6+fCknS1tomIK1kPZGVB92pEeZEVp
         3UjOXcbS9ZxbdtV8l7DXBsqnx9hkNEYwPcarI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pbYYGaj80nmpPvKAoi7nhvjG8dX/laYbfFgJvGfe3c=;
        b=J7Fzb5wWUfxORiMa8dzNYUXQ4o4g4xj8Gt/G6/lIm4wvvHmuiZL3U6bnsCKIr360AN
         OjxGc5m6DX6kYuYnAjhNI8E5nlFrWZ6LL8+obXPrejMh0+2w+Nd11RZE/q/dhP0RIY/k
         WckPpqMNaYMjxsCZT4y/ruHVCHgdDXHbGPOWfn6xCeXE3XDFJ7j4awgWJcLfrp4AdsBO
         7tlra/ox5O4ZiBqOD2mtTxnEQgBLW3uKu8/HxPOBj0KBn9a0V3bCTtMXk7ck18YbqPND
         5xTXEmdK03dgwp68ROqj5g1GhmLMvabzUdTH4st5hEYfLDQNWBCEhFLOCVzAGE43y00o
         zcHw==
X-Gm-Message-State: AOAM533rg+B3p4m06JW1Zk+/ZXhzgMG6Sg/IvkP1TxC6Wogh056Bgvg9
        Na4xEZ6THxm9pBOL6L822AQYHw==
X-Google-Smtp-Source: ABdhPJxK8F7zRzFG3Hv59fvgnwRI+OZARJnDoK1+LfDL/LiWLtBVkDEva8AoU4vTLsGb4IOwAup2lw==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr11959110pjb.234.1615517274302;
        Thu, 11 Mar 2021 18:47:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d24sm381554pjw.37.2021.03.11.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:47:53 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:47:52 -0800
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
Subject: Re: [PATCH 14/17] arm64: add __nocfi to functions that jump to a
 physical address
Message-ID: <202103111847.0EC7EDBF@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:16PM -0800, Sami Tolvanen wrote:
> Disable CFI checking for functions that switch to linear mapping and
> make an indirect call to a physical address, since the compiler only
> understands virtual addresses and the CFI check for such indirect calls
> would always fail.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(I wonder if there is some value in a separate macro for "makes a PA
call"? Might other things care about that besides just CFI?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
