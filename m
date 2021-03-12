Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCED338409
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCLCv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhCLCvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:51:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC95C061761
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:51:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bt4so4445389pjb.5
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jgKB3A92D5gwIxX7ZNPTWJNkyox2kFXe9uVkjxxztms=;
        b=Byp8VJLq4cTqNlyW1jcVtPh0g5LN5iNS4eR11K81JCbvgPvNMAhVXh9Gd+468WpnBc
         lejZk+bqLROi5s87MT9mO+QL80AzVMLefAwEp4YN4MFXFOgzdc//xji3nbCrTC8EviEH
         //3c1oVgTFeQhQtFuqphdUQ4neW/w26ZyRino=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgKB3A92D5gwIxX7ZNPTWJNkyox2kFXe9uVkjxxztms=;
        b=XTWUZ40FwablTnTwcTnUg7x2RnMAQf8xm0ez1daLct/px8yNZgACtyEcRTTSIZlMjL
         rKSAHNE3M+oXaCYJ9hiR5icH9r38hFPZnKmxJHRQA4ogD23h6R700Aks4jOQGEmJOxcs
         hou6s4E5cBrW4uC4I5sM8INVGOtxGL1g1RHz52R/7sKED7XVm0KYN97NVQ8Nr8iZxsv/
         EGcYNAGVBt0kmzGmz7woMVhwna0D+4VxVXTxxCjYx/6FB8O1U7kHH2mZnnELfxXb7KML
         sOnrjqIDT9J/lTf8y6oPdbYgZkip8sm0gw5VCB0EL9WuGFpT9lT5zlAWh3CT6eiIllor
         nW5Q==
X-Gm-Message-State: AOAM530jmwp+n3eMtEb7IL4G55Oy3YTj9haYf273t0v7KTMtj6NKW+aF
        ZneDe5LgBAoBcKop3LCCTz1FVQ==
X-Google-Smtp-Source: ABdhPJwAHxl/NS7FlgAJRz5QaAvQOXkfhkHGZcnAZkR6rCdXdtzDyILaDAk8TTtJWufQKkWHZbPLwA==
X-Received: by 2002:a17:903:4093:b029:e5:b933:fab7 with SMTP id z19-20020a1709034093b02900e5b933fab7mr11028894plc.11.1615517460606;
        Thu, 11 Mar 2021 18:51:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w188sm3656858pfw.177.2021.03.11.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:50:59 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:50:59 -0800
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
Subject: Re: [PATCH 16/17] KVM: arm64: Disable CFI for nVHE
Message-ID: <202103111850.163D807@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:18PM -0800, Sami Tolvanen wrote:
> Disable CFI for the nVHE code to avoid address space confusion.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
