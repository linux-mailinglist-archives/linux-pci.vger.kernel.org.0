Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BE25CE6D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgICXiZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgICXiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 19:38:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038AC061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 16:38:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so287907plr.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vpMIvEwuRSqC+Z+zTJmdoPgPG+oL4Eop2jtb25EWWgk=;
        b=gvG6wFPNF0Tcin4Ap2mhko2aiVRBSXzp1p2mlklenZECv4SocSBp+jn3VNJMansFKr
         OiZX2u7WDwqU4iPvPk8YmYriiePKsJQyUZuud8Bhv0KORwFRgLPlXNkRLZ2trFWXd5Y/
         oOBfwOcv/SeeoHkG8Ef4WwrqpQReE8/Tx8zcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpMIvEwuRSqC+Z+zTJmdoPgPG+oL4Eop2jtb25EWWgk=;
        b=FsANEwz8y19PcqjJ+QQjt/JCWWg5BH49ebhXW30vK0Ux8QPeE2vExHfcJm1kyioxSk
         FDPlBXusN83F3EzNv1LJesbKpmzxsvuREXl1l7IKdefB61JwkSdgiQ3sBYYeF12XXp0i
         ppoljsL8JM1HVRIxJFN5PG1LNE/HAxuf5pIob/IjA3hW6bnOo+QjrAbb4gfwE9Baxjil
         gPvtMrci2mye9KdFI8S0nYxDCOv9oY7/tYPQq7EQltktX/R5eP9F837vdkq8+FWzeJL7
         s1WiaO8J5cJB+u9NcqPmrpg+oAKfxLFiWu5n2jG1IxUHOVtZKzrSofXZRne6RzyVKLf/
         wkMQ==
X-Gm-Message-State: AOAM530D5kmxga1chJ2+8PEI06JFaMkXY5lOaaAsPBjn5kB5d9Dv9sxu
        JvHjhhhnhu5kYZgXR2teqzqr5Q==
X-Google-Smtp-Source: ABdhPJyiZpxHVqfKKsHge2peFlT0tOhsV4ucarLlAr1ffPxhOv0TOSI8XtiKBiFflmROB6YHqiVGkg==
X-Received: by 2002:a17:90a:d514:: with SMTP id t20mr5116667pju.134.1599176301506;
        Thu, 03 Sep 2020 16:38:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z66sm4420212pfb.53.2020.09.03.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:38:20 -0700 (PDT)
Date:   Thu, 3 Sep 2020 16:38:19 -0700
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
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
Message-ID: <202009031634.876182D@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:25PM -0700, Sami Tolvanen wrote:
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).
> [...]
> base-commit: e28f0104343d0c132fa37f479870c9e43355fee4

And if you're not a b4 user, this tree can be found at either of these places:

https://github.com/samitolvanen/linux/commits/clang-lto

git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git kspp/sami/lto/v2

-- 
Kees Cook
