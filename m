Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8E3383D7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhCLCqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhCLCpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:45:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037AC061761
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:45:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so10050432pjh.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kwV+ZEKg/XUTXzjIOI98K3vszan57O9kTgEQIPUcyY=;
        b=jjgy6DIlMrFWse7xf7SeVmNo6/eGcfxozbDUHSMQIaAkUvtKpYHpt1Nwc6YY8mktC0
         QvA45UlbJ3LdLEcjQJRShs+Mi+w+YtXcAlxhMbLCprgTfdm3QxYC9CKRfKXx0lp5VKN/
         0rig3eJkC3MeuhK1bHFBrPGYFC3oy4KEA3qQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kwV+ZEKg/XUTXzjIOI98K3vszan57O9kTgEQIPUcyY=;
        b=fi/EgBpUpy2ugIL5t+dJgcHXq5Eue1HdLBdYyBCwRBs7f1p2Xicb0dNIHQoWduKNWK
         xmqbwTQAeNzr21WBNckK6/QvhHkb8DwLnyeYhihyvBKw3ieWgIa4sHRZA1hp9lsnevua
         PiVdkqiI3PMrbKwaylfY4ZlFEAn/gWfv7M8ecVPINfYxYT8uI3OqWnGOhCvYRr+Y5XNE
         wjF+untGJLEAnp4bQiv+uMw+86Vc1W8sj2339Be7+A+n2Fd5mR0VoL041cZgeLVaBJZ4
         HETejuzWOGgzDrfNtMpRtiFtsJDnDNF5FINfAsLNkJix0BOZtMSSSzY3v8eoRbHC9WKU
         ZeRg==
X-Gm-Message-State: AOAM5317IFfX8gynq1U7n+FYUwKk3gnNg3+mAtEChgKaTbhA08NV0XGp
        1Fvj6MTJEl3bpe9qmHwnLoAr/w==
X-Google-Smtp-Source: ABdhPJwDCBrjoyl24XQocrPBFT0JUae7XRtchBVIiOME05IAIHkeYXy2xsIRiO8vA4pM0qb+BqLZfg==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr12125260pju.54.1615517129325;
        Thu, 11 Mar 2021 18:45:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm3684714pfo.45.2021.03.11.18.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:28 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:27 -0800
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
Subject: Re: [PATCH 09/17] lib/list_sort: fix function type mismatches
Message-ID: <202103111845.A61BBB44A5@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:11PM -0800, Sami Tolvanen wrote:
> Casting the comparison function to a different type trips indirect
> call Control-Flow Integrity (CFI) checking. Remove the additional
> consts from cmp_func, and the now unneeded casts.
> 
> Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
