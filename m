Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526DF207E95
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404015AbgFXVbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404012AbgFXVbh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 17:31:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BAFC061795
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 14:31:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ft14so728284pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/O3ShsYHI31KeAbcJImqBKhK7RmR1YrkXinaLdbS2cc=;
        b=km0rbdasUCx++8x0lRTpl9dRVPlkvvgXmXH5VDqn1z/oWbZzfjocNBIe3ZynP1hSKb
         KVFJqPSTAVKH6Bv/v1uTTgpFU33rli2X3C/m74frA2+rWkygENBnngQ6aWJvCvtTwisK
         ZbNyudsS3PRLC9fuaxb8wpD7eLdi56OzlUX+Ro85RkehRMCJuUd9kGrUaJVjx1Rm6zjq
         OX9MIPdaaEsCkipcX4Eh8R80M8kBtbcIH8WUg2cLSf9HDDLe4n46v5madSBqNDFMNyys
         VlZ3/ZtSFkzDrwh90gPCorp7EeMVtZmCvszFtKxrIAgZiR2lx7HkBAL7Cd84LfmKQ6Hq
         Sr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/O3ShsYHI31KeAbcJImqBKhK7RmR1YrkXinaLdbS2cc=;
        b=t/oK262Xhk9BxGcb5UV2UCOP9ORPegWwuV7uNlKp6B03Pp/dcaRUeeDoMJzGhcKKWh
         CuKIdeK4AHS1ptwxXhr/HIDG2BDRd3kAURC55+VH7FapXu+R8TpOzDc4M9AN9iOlNznl
         NRwub61pUK7Sn1e2xvoj65stbEH8FghL73huS1xeqnWSycQPB2wwQO/Gh9Jtefytm1lc
         7SZ+2wvMR+vnMLh/RUSbKoyn7SRkLIVwAsloUHWlm/BIVH27kDMTRvqe98tvSEBQzdmE
         3AiercjgxH72nq4iutSKECnBq5dwBxTBXULTC1e7GvWR57EmyR2MoT1mEqEFzXZVosfc
         yGpQ==
X-Gm-Message-State: AOAM533yb/hsyGL93FvIicAoB+rqA9WiamhqQP3+v+Ae/crnweWJqzIA
        PXyEufAotPvC0mc+YdTLR2K/oQ==
X-Google-Smtp-Source: ABdhPJzL1k5l4bBaYzFfIDW/jK3TA6LlmzQ3rQievoHb7W2HsUj9qo9LTDOdsz8oDhdojeg/j6HFOw==
X-Received: by 2002:a17:90a:4ecb:: with SMTP id v11mr29922206pjl.75.1593034294906;
        Wed, 24 Jun 2020 14:31:34 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id a12sm21064814pfr.44.2020.06.24.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:31:34 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:31:29 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 07/22] kbuild: lto: merge module sections
Message-ID: <20200624213129.GC26253@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-8-samitolvanen@google.com>
 <CAKwvOdkY2M9+BgA5FELK+7bjv1sZYMuTmVOztCYijas_OHfVDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkY2M9+BgA5FELK+7bjv1sZYMuTmVOztCYijas_OHfVDQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 02:01:59PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > LLD always splits sections with LTO, which increases module sizes. This
> > change adds a linker script that merges the split sections in the final
> > module and discards the .eh_frame section that LLD may generate.
> 
> For discarding .eh_frame, Kees is currently fighting with a series
> that I would really like to see land that enables warnings on orphan
> section placement.  I don't see any new flags to inhibit .eh_frame
> generation, or discard it in the linker script, so I'd expect it to be
> treated as an orphan section and kept.  Was that missed, or should
> that be removed from the commit message?

It should be removed from the commit message, thanks for pointing it
out.

Sami
