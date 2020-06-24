Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EF207E90
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbgFXVaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403939AbgFXVaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 17:30:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB1C061573
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 14:30:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so1823455pfp.9
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLAueZueQmLo+U3ff1yWRTxI4RTBZr5ie/D1r3LUxVk=;
        b=UTpKVD20ozvTdWMRMhXjRuDa7E6nhyfuuFzbPsLPOJkgDHZzpnipT7xh2/Wno0v2Oq
         jdpABPkcKmrg491zzfi9zOks98eQJaOLDTz406Z4w2MgG351GRHcHMzGWpNAyEJdLecz
         ji/dnLP69LQeXVwamBUI0SmjGSavdPaLzdKRaDqcWl5xT7zXOVfMtWSCERwyPWhmuC8a
         4KDq5FM9YdU0RrraXVR/hGh5TC7cw1r0O3lilGh9m2vHjgmv1WKElLUiabdJW2m76HZC
         7iRUNTtGTKyZS7schzBZuKhvkys5qQmNg4oE6XUh6jUFgmi+eFh4EE769mR4zWRz8YdS
         PQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLAueZueQmLo+U3ff1yWRTxI4RTBZr5ie/D1r3LUxVk=;
        b=JEPSyZALGZdMFOpWfXZj5qXxlcmMwQRXS6PN6AVRuUg/a1MUHun0v7Rhtb5a1Am+py
         cg6KaSUZj5ZjGDxF46bGnMZs5VSC+jgZaTnzesBgwu3hIlhMXf2OWXC+CzNO/eTaX+fY
         6ZqVMlJNXh4vTwCjZHT8x/0bvIx81+Z4jDIH0f4tnkxyyIQszddC+UIhBC+0a76n3mdw
         0qx8CiGTVJD0ZknkR9BcuDSQ7Bsv/i7pd1kO9bMHbe5RjaRMFfiFTZKDWrn8sZvUGc3I
         OLGlzgrrdhdy+4GFx7MQQzqVe96S/GvUfKKHcdf/lNbK4Pqjs+PUGyJmxSLY6iu4OZre
         OxhA==
X-Gm-Message-State: AOAM531L9q18fl6j/5/sNsLJFZJ6BSQr2ME4nerf+x9tpzehdLB0ZzEM
        y+zjVoEwCXQtg6wpOUb/c3dZ4w==
X-Google-Smtp-Source: ABdhPJxhxSeUIX3+whzU3DS6SVAWzNuff6r9HMO0IkuALFVi/g2AiuvayCKmK1FcYKc9xkjwmkX3MQ==
X-Received: by 2002:a65:6393:: with SMTP id h19mr6687231pgv.278.1593034221896;
        Wed, 24 Jun 2020 14:30:21 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id g17sm6052460pju.11.2020.06.24.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:30:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:30:14 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200624213014.GB26253@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624211540.GS4817@hirez.programming.kicks-ass.net>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 11:15:40PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:38PM -0700, Sami Tolvanen wrote:
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> > 
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > 
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> > 
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
> 
> I'm very sad that yet again, memory ordering isn't addressed. LTO vastly
> increases the range of the optimizer to wreck things.

I believe Will has some thoughts about this, and patches, but I'll let
him talk about it.

Sami
