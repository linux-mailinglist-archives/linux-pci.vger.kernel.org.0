Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4D3383DC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCLCqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhCLCpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:45:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86CC061574
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:45:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id x29so14912673pgk.6
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QU0VzfL9/lfvk4BOo6El/Igfm4hUidBDqCnte6ObskA=;
        b=dCt656rf528kGz65pkdCCRwvvb6LHMDAt1mGWptf+qA1H+D1fqonFC8NIlOt/4mplW
         SfLgdS9gaLGlL2B9nrZb48Pz4kn/Ry2TH/6Oafm8iapyD2b38tCNNwVi2kChy9sqiaHI
         yYrFQdLV5XU/tYDIPz05PWQzC2cCC0g7WMHLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QU0VzfL9/lfvk4BOo6El/Igfm4hUidBDqCnte6ObskA=;
        b=gbGSOV4ywad+EU09SpGCn6y/Yso+hiGDxGyYNllCr/nV1fIMDBCAOm+rBo8vzLeROc
         mgjqFE1SjznoPnSyCFlNBnCmvWJ3FE3vwM7uHzaYq9a/TojFHvyMuOv6Rrg029IMgfqr
         kFf9yyEZF+OqrbEgReD5gvcvIOW1xo+ZAVGkFTuRaf8IgKa+0dHboKs9hXH3jsGEtHo+
         yX3JwxJawfmiBoRgHfwfPkN65z3K15xy1Tf9yx+Be344BnVxN/rFusn89Fwve/QaPHWG
         dwDPaYKchg10HmKMH5pq+4K/GPyQBZAbfn2YyRvBiJUfnPKK8gNZFYTDCvX0xnAko5Va
         MNVw==
X-Gm-Message-State: AOAM532fz2is3ikO9vRMSquUfRGi6ZsZMnY5k9BtLB3rkdaG1hxlyg3t
        HIkUupL4799KqpXqZMWgDOVP0g==
X-Google-Smtp-Source: ABdhPJyZjX0dDYfZgQFE6j3eol5QYVolHh+A3d7V2uX9uhucCEXJOChGVC9n8UJhMoVf/kiUBIdI6A==
X-Received: by 2002:a05:6a00:22c6:b029:201:1166:fdad with SMTP id f6-20020a056a0022c6b02902011166fdadmr2389793pfj.58.1615517145009;
        Thu, 11 Mar 2021 18:45:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm2934089pgq.16.2021.03.11.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:43 -0800
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
Subject: Re: [PATCH 10/17] lkdtm: use __va_function
Message-ID: <202103111845.1D52CBC1@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-11-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:12PM -0800, Sami Tolvanen wrote:
> To ensure we take the actual address of a function in kernel text, use
> __va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
> the address with a pointer to the CFI jump table, which is actually in
> the module when compiled with CONFIG_LKDTM=m.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
