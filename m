Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4F33840D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 03:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhCLCv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 21:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhCLCvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 21:51:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F9C061764
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:51:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s7so11226347plg.5
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3EEyNm7eQ8LTzAuPOfFBo4tKw3xvJrFxDmdpJEANQ8=;
        b=Pw0Wytol3V1W1jSYagNaJuoK7dXXVqpzVhqhkG56gvEbW066nxOADg+yZY9AVoynyD
         HDYm5Fde8wmAQx7uPQFDPwi7KHT0dmeOix4wwzMnENWIDI6GBjFZNEqoJTIFx3IBUknr
         HTdlPPCLI0gUJoS0n7BVVl/PH9ri450DvLqhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3EEyNm7eQ8LTzAuPOfFBo4tKw3xvJrFxDmdpJEANQ8=;
        b=oogSNkOAQULFn/bFZXcMY0eDNiuZNRTKMeVYM2To0/zhn0MIwrM1ZRuyRP3p4hYtxd
         0MQaGMlaoZsWqrRD+4VbRxZ46JIhL1pqKR0s0AXt1imkDpJhtv0CNjUlcoiS9bL30okX
         LCPEmGmpVRrbZB0HkoPk+y3yLFXm9mbJLgQPb/ySOLHsTa2O9gFcXBaiJ82mGZ/K3v95
         r3AQOe/lcpJwpuCTnqhtogIY+lEBQlSHu2gjqcIID7d7U55dniyiBrd6BMJ7BJvudhXn
         MbbjC7MxOfFMc91tBFLvEMMXrM4wUXLczNTV3d0iPLxVtIop0AULnG4P3NO6SGeruQgW
         Z/zQ==
X-Gm-Message-State: AOAM5330UplopcWCpRAjmKWesCZa/HVog/pys4c1khGIm2OgQVlezpUI
        RhpFP0c4BqeXKAl7RzkaHa1Q0Q==
X-Google-Smtp-Source: ABdhPJxzPu6mg+lNqyi8pXBzHWDwhwGeEI+Dbicpb8zWXKXZ3bEFdtsbfyio0s4PFHGRZ2yRBsZRHQ==
X-Received: by 2002:a17:902:d114:b029:e4:87c7:39f5 with SMTP id w20-20020a170902d114b02900e487c739f5mr11218690plw.72.1615517505595;
        Thu, 11 Mar 2021 18:51:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm3672672pfg.215.2021.03.11.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:51:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:51:43 -0800
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
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
Message-ID: <202103111851.69AA6E59@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Random thought: the vDSO doesn't need special handling because it
doesn't make any indirect calls, yes?

-- 
Kees Cook
