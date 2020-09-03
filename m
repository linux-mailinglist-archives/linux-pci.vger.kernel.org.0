Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EE25CDFB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgICWpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgICWpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:45:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9FC061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:45:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m5so3268084pgj.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eNUX/+cTGqvgJ3/bHzJkiLjPir7L2OtlnI7Fkl+Xb2A=;
        b=EnTAgexJsxXcgEbYIyXAxzgDAfpWUMxvmgoddQQgsTw/gu1PMimkQi0sFP+vzoRcoR
         R5cz17bX6mXjaaXhIIENszOU7GVzd7UtV6ivYdntcxzorGKNslOUw1wAcWUJDwdLZcXs
         t89r3dF6Bm22f/kj6qlw0hvfFybNvnGy7LAoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNUX/+cTGqvgJ3/bHzJkiLjPir7L2OtlnI7Fkl+Xb2A=;
        b=UHCtxbviz6Vmpiok/64Pf2GGkLExS27yLV5yxmfpcJHB1jsQdgkshwwZ1rMmZi8oiK
         rsseOxRNxLI9ihABJ01XHFofLBz6kamz/k9qxzv44Of77wqIm4BiuDPKNB/givny0h56
         r5PMTWsva/+SDlQUyvcZTvP1MQ5i020FMxy5Kvcjx25nP4BaTQv5BU0Vl4kJzoy1Kd8Z
         tZmkreO8+qof0NfHrJgeLEUA4uQRNLvL+t0mirCV0lXwlfuh8va+/OXD5T8qZTyNS/sJ
         nmrRYurjK7ERbdvbsNHiROShRUk1OHmIkjV7TogfEo2gmBIKPid4zC2tiPYb+4Y46NkI
         kzUA==
X-Gm-Message-State: AOAM533szV8KTYYzENEL2LJztqrdzZQZJrGmlVjMETOSmot35EoGdV6P
        oNllhBRUD48xOXSd+R7G4EVC6A==
X-Google-Smtp-Source: ABdhPJyNZusftJcT3VvVFgkaB8aDPyaKtOWJ1b5YXcXD0oRJUTHNPVuoSuBrwlfSbjV/D5xOI4z0Ow==
X-Received: by 2002:a17:902:7045:: with SMTP id h5mr6014077plt.4.1599173106022;
        Thu, 03 Sep 2020 15:45:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv7sm1885610pjb.55.2020.09.03.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:45:05 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:45:04 -0700
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
Subject: Re: [PATCH v2 23/28] arm64: vdso: disable LTO
Message-ID: <202009031544.61133BF@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-24-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-24-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:48PM -0700, Sami Tolvanen wrote:
> Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
> point in using link-time optimization for the small about of C code.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Yup. (And another replacement of the non-functional DISABLE_LTO...)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
