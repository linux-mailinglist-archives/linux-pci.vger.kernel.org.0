Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0625CE16
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgICWrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbgICWrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:47:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F1C061245
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:47:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gl3so1102728pjb.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eFrstCXBN3HfrZebeISGA36KawHO68DuV5H+8+oCMrk=;
        b=UyJevSS3jZbv6N7QB5+swtwOzbQH8Mebfc6NiguMHEEa3zpvf2Fa8BOPsjRPafItrX
         94+boIdY0eIFAYNargKYhKvUD4q+qsol+8WhYmSNTTfQeUzQx66molHRZp0VKRR4pNjd
         TeTJKO1SkL6fNUa/+nF94zP8Ps5d09zjKGzZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFrstCXBN3HfrZebeISGA36KawHO68DuV5H+8+oCMrk=;
        b=SogrmcG/2O4Jg3cRSL928xiLJliqkBNsdnVxK6hxQbiMC692/eXRf+vk0GuO33WHcQ
         Xl5KdvS29CUPUP71Ky9LAHh9Xq07i8rJq33vrRuH7LPzOkdF2RdyFRXCkXkz2Ap7N/vR
         no2N7e7o2GKn9uMexYZ8XfEiz4BmNPTlZZuPqkjR+yLZ8xLkdAzkLU+XiaZUdOCsMKM/
         83bXoJ4bvgBlzRzXbAxVGFUOXqanQlsGPOxLwjbZtGDGsGDCaagQxmMk5SBVSTfztdeP
         yUtdptPR7N3YauwlrnDWUN2k2OTG295R0NfQ2p8DaVzP4j0k8ET2ruGYEno3fDMwq3fO
         gxbQ==
X-Gm-Message-State: AOAM5317TKXSdsc969nTfDPbnL9wz5+SFT5OqwUg4WlCanFvVAqRLQNC
        OeJqrihYiaPiEmrjNlek4bQ9Zg==
X-Google-Smtp-Source: ABdhPJxBUddtcfqLuFrofAmKe3Wkr2dCSnES8MsReM+zYAT8LfVgd6BWIelLMAoy/r1/rEVW2WoePA==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr5382384pjb.101.1599173254469;
        Thu, 03 Sep 2020 15:47:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s198sm3700589pgc.4.2020.09.03.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:47:33 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:47:32 -0700
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
Subject: Re: [PATCH v2 27/28] x86, relocs: Ignore L4_PAGE_OFFSET relocations
Message-ID: <202009031546.4854633F7@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-28-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-28-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:52PM -0700, Sami Tolvanen wrote:
> L4_PAGE_OFFSET is a constant value, so don't warn about absolute
> relocations.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Any other details on this? I assume this is an ld.lld-ism. Any idea why
this is only a problem under LTO? (Or is this an LLVM integrated
assembler-ism?) Regardless, yes, let's nail it down:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
