Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4E25CDDC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgICWnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgICWnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:43:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E1DC061244
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:43:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so3476656pfg.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JQ91+76gyHMY3xv40LcJfL22rVwnSHEWIrs+JY61Lfw=;
        b=Gv/ffUiV4cHAcDklljNvHcMHuBcglanuZNKtn6NOLTMdAobfJFLi4S3XUK/VF0cMoa
         YCSlZMjLzO+hSp1mb2H+OVfbR2yXR8wtEPXnlt5uMI360+iCnjR0H3cIuzPcnksebXGK
         d93lpCoPbskfIrQ+gg8nraNFnKZGq6Pjaz6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQ91+76gyHMY3xv40LcJfL22rVwnSHEWIrs+JY61Lfw=;
        b=rgaWaDbE6zQpXBQiFroJgeMT1ATWnSO9wFsj98pHzbhZpt2n6YU9CiphPjfKeMAT2M
         qiYgqB1d93I9HsFMKSYHjBVWWn/xpLtE3JtwGplMslVZmD0hqACDOgJ0sJFgiOGUjTgA
         TeWQkoO/XTZp/vxXQJxZaHxVZXwYHPItECP9jDqEJNDPtbRsIaiBvluWWiNeP9GMM7cx
         DeUeHy99UKOK75c0QR1gBbyhSTyl7bMwDo8xuzNEv6SpqS1xgx93HwRilPKh2enq0GR1
         yIRdNstKMX6ZrK+I5L+FPoZOWFjbY8oq+Yp9td6J6Ecbeabuhl3M53Bi0oDs/lc4AVqw
         cydg==
X-Gm-Message-State: AOAM5302UaQfQPH5BDOrE8yWvoVDzOkWPII2Lh/vlSe5TgsHM4ODnTEd
        MaiXDAVQmaKCb7c82yzhozIGuQ==
X-Google-Smtp-Source: ABdhPJzsDxL6JJKJu36vJnlttgHabnBSHn20nTl7ZGP5hdybfETsgZLi8FgY6Utuj7Ord6vXDPO70Q==
X-Received: by 2002:a62:4e49:: with SMTP id c70mr5965062pfb.100.1599172999617;
        Thu, 03 Sep 2020 15:43:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 141sm4425163pfb.50.2020.09.03.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:43:18 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:43:18 -0700
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
Subject: Re: [PATCH v2 19/28] scripts/mod: disable LTO for empty.c
Message-ID: <202009031543.A239909B@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-20-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-20-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:44PM -0700, Sami Tolvanen wrote:
> With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
> files. As empty.o is used for probing target properties, disable LTO
> for it to produce an object file instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
