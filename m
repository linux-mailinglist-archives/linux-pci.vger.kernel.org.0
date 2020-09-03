Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30025CDD2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgICWmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgICWmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:42:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742CC061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:42:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so3474957pfg.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlwuOH2EQG6MCnppWuU43l955MakvluKpUTVDERTNO8=;
        b=XY2V+aPzW1+LDnPQgs8LCKdfsW+ukc0CH4hsERu2c197BquhpT6ytbY651mqbWroP5
         NoijPo4tmmhjTbE82fXMmxBiTTfrN9b+BObSgnEn5HC00srbReXMVw7CaVxDZQjvWDNb
         sLqtBJzVmvCGKIRCPcZC9IKz2mLH5Kg/+0yME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlwuOH2EQG6MCnppWuU43l955MakvluKpUTVDERTNO8=;
        b=YQk3GIMCGPV8gW/CfnXvuvH7EwA8BTjvi9qM6gmJpeU/FgkTcjr6SNPkQ4+AI1mZn1
         a+belw3JZGW3cO8pcb80ju1L5pSg1P/OjfeGKN2BrKBMKWVtyv6fDnSged8qZ3mE61v/
         mhZJfYt6e/ZvsV3jGwY4AJ2T+kEK0wtOUy/Cx8ogkp55hgwl+hiluHNEdxVREExWGXIa
         Ud9j70eyVxAwML0NaLRwh5meiBx7juJOouE3SgQxR9UGpbWdlz7VGV6qKDZGaElYb1IP
         WSXTwEuTuGh45zc1kCvSFHF8cDt24QWqQLU8229aQKU0jvX9g2GNiN/u8m1rd9wZgkNk
         13PQ==
X-Gm-Message-State: AOAM533ZcM4AkrQSNfaQnl/Kzk078V9UjZVwZsLBggTRrA2A02bKLsGW
        F2cGvA4avSTkOLdECW5YhyBu4A==
X-Google-Smtp-Source: ABdhPJyqBzmMfYaY/Mz5zx6mhtV8btCsnKX7oA2efoS7o6nY6a3yOyI6Ra3/iG5Srj/uMw3Z86qeLw==
X-Received: by 2002:a63:384b:: with SMTP id h11mr4827548pgn.113.1599172936031;
        Thu, 03 Sep 2020 15:42:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm3760136pgt.70.2020.09.03.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:42:14 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:42:13 -0700
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
Subject: Re: [PATCH v2 17/28] PCI: Fix PREL32 relocations for LTO
Message-ID: <202009031542.F6DA50F6@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-18-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:42PM -0700, Sami Tolvanen wrote:
> With Clang's Link Time Optimization (LTO), the compiler can rename
> static functions to avoid global naming collisions. As PCI fixup
> functions are typically static, renaming can break references
> to them in inline assembly. This change adds a global stub to
> DECLARE_PCI_FIXUP_SECTION to fix the issue when PREL32 relocations
> are used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
