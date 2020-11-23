Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F732C0324
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 11:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKWKVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 05:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgKWKVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2020 05:21:53 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78548C061A4D
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2020 02:21:53 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so22522841ejm.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2020 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KicNkypOIaNLZNofAMT0/dbRVfdiQb0EG7yDuWE5ulA=;
        b=TDVt/xqwo7FGjOiB50CURiRd4zX8Glpc/xzed4IR3D50NS0EqlijbKWHNsEmT9A92f
         opeYzaDlby6Pgpezpy0Z6eYOPQW6ipaIAyEAtip0SZR01YDtd+SICLsxoZ+9krn8s+et
         lULt1gHvEOthv2285g8UdKxZGn8PuitA3T+FAGLQ/qKxFihLT0OrTedRRYXRz8VblfZD
         a1sXohEAJiNhEPF+raDuSX6Ta4nQGnI6siEeVnxshXZXFTiwE+mIarl4EbBFaSYp4ZqT
         zvmMqJJexFfo+5+oFHJeofxyxcmA2hqWZAvCeahk9touSv1o0xYBPyhqFNpgNP0LgZcR
         CU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KicNkypOIaNLZNofAMT0/dbRVfdiQb0EG7yDuWE5ulA=;
        b=N5t7ONbdfHLeapZnWCzIi3OJbeGJi6sDzty4vp/E2VZRNWytbbSXMiC+GdEbcSAnaq
         xCIxwI3sidnDx/sKoKmpxZRCVl3Xn6jLMSWzS5Kxu02RyxIhrKB18T/Wa/GE7wmr6xDA
         1k/XpC/YKSW9h2ogvigSyRTG6DnncO4axcgB4RiME3rkYibNr3EXbtDUY7aU4/twu4Hq
         gu5mxCLRSIsOmWALTVtIstyz4ZAnZIpUHBL38CUk45lC1PrypVz1zxjJkEiG+STBT3No
         xFNSapnTpgd0MxYV0/OWB1MLCuP1/Evx1nKy5fDpe7qOgCyugb+OQ79IudvPC4Ia9Kt+
         sRhg==
X-Gm-Message-State: AOAM533oWvHZuhcN1RUyez17zj/7q0qLNxe7ALhroZ8MfedSMc31kMD3
        SUZyhOrQqJ6QSAy9CPoqHXGwmA==
X-Google-Smtp-Source: ABdhPJxFSYMYi0puK0drxRNruUpOKNZHKEgE3EPEQ608H69x9iUkj+1IRAw3SWeiVlPLVEVUtEhq+A==
X-Received: by 2002:a17:906:8058:: with SMTP id x24mr44772875ejw.272.1606126911958;
        Mon, 23 Nov 2020 02:21:51 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
        by smtp.gmail.com with ESMTPSA id k3sm4725861ejd.36.2020.11.23.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:21:51 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:21:49 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 15/17] KVM: arm64: disable LTO for the nVHE directory
Message-ID: <20201123102149.ogl642tw234qod62@google.com>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118220731.925424-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Sami,

On Wed, Nov 18, 2020 at 02:07:29PM -0800, Sami Tolvanen wrote:
> We use objcopy to manipulate ELF binaries for the nVHE code,
> which fails with LTO as the compiler produces LLVM bitcode
> instead. Disable LTO for this code to allow objcopy to be used.

We now partially link the nVHE code (generating machine code) before objcopy,
so I think you should be able to drop this patch now. Tried building your
branch without it, ran a couple of unit tests and all seems fine.

David
