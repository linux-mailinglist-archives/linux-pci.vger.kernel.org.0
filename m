Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660925CD62
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgICWUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgICWUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:20:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1708AC061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:20:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so3441953pfc.12
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dmzINT6p66dX/e1LULkP+IK8q8rhLoHpFzoaZ62doLA=;
        b=R+gBqR6jMnk+6oKx2tqu8pEQMa6B4rvdU39xncVxP9cYGjTvu9Y7E6/eDwL4d91aZg
         2AWd6bD1I8hpzfCMHWXyOEAUYG/ByrfmTjLvqStAtIQAudEBj+5PL2eVmUhWK1C7kkkn
         PbOlpfhNaxLGq78/VBxGKRETiCVBKzIIjWBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmzINT6p66dX/e1LULkP+IK8q8rhLoHpFzoaZ62doLA=;
        b=A3Fp56UYmfpL7R2zgG5bzF8rcojSqCfcMeJSfDZdclSwGY1OmS42nUYJk0GtafaW8X
         vrL0do3PYY0DSLj0kPB+Cb8lzmoDRsIxrChWw6xwAvpDpPcgKM3vXC6JXH0sCTdsT0ch
         i5F/pjB5BI6FZYVJstrBzkaJmtgORGBV8tBvYV9HNYYhrS3uq1smmALwnGh0g31JYFt1
         bleCn8BsMlegIc+s3mvviNZKOUlvKyNDTqEIXJ79I1cRp+610d5vaSradpCNMQsdii9+
         8BYRXx6YD2/1U5bhaz0sjMnHbaMXPtVuFrA8y3PQn1qTr3oIMWF1WKlWH3vhnhl0TA8G
         WKRQ==
X-Gm-Message-State: AOAM531XaQMhS9jynrBkLi8IcdMU/B8euLe3BZwuVAYrZjEDEZkdzUDD
        HD9ctHKDkoV2lShNscmVjjgvrg==
X-Google-Smtp-Source: ABdhPJzvTlWSfXCMJbRcWCpKisPl6QUA4PdiAul/EgxhmyHEf/e8MtwNFLvtPo2Deh4MEaqWvcd6DQ==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr5955717plr.27.1599171616614;
        Thu, 03 Sep 2020 15:20:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm3294870pju.25.2020.09.03.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:20:15 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:20:14 -0700
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
Subject: Re: [PATCH v2 12/28] kbuild: lto: limit inlining
Message-ID: <202009031520.DCF0B90B65@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-13-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:37PM -0700, Sami Tolvanen wrote:
> This change limits function inlining across translation unit boundaries
> in order to reduce the binary size with LTO. The -import-instr-limit
> flag defines a size limit, as the number of LLVM IR instructions, for
> importing functions from other TUs, defaulting to 100.
> 
> Based on testing with arm64 defconfig, we found that a limit of 5 is a
> reasonable compromise between performance and binary size, reducing the
> size of a stripped vmlinux by 11%.
> 
> Suggested-by: George Burgess IV <gbiv@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
