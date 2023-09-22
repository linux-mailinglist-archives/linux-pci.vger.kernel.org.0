Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1803C7AB979
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjIVSnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjIVSnS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 14:43:18 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3CAB;
        Fri, 22 Sep 2023 11:43:13 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c43b4b02c1so21255675ad.3;
        Fri, 22 Sep 2023 11:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408193; x=1696012993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G45tsaRVnQarxNiDw5nhtDFW/SFrpMwDHk6k5h9JLNI=;
        b=EZeedL58mUMbl5vXMyD+3AKUX2U8AadZ3FpK1hUiy/1fH9+RLHHv19kfso260CmehG
         zOxvU4lvigcgdR4wvdBjfRulnQ4mqGrys6ffVsW9o5wqteGEewvQWpFjqWLS7zkAYLJY
         GcZO7qChHg/CGKtdlGXVFT+CGnbO4ya/B+PUlajaxJe6jsNKYhJ04gkm/BT88ANwpKq/
         WLo/xK/50bXnke+NkCpk9oT2iwNIZt+j1y/tUftn154MUbyCzS/f9AofHuVf1NWv5Wfj
         mZFOjwjKSlumKWR9PE/YWJENSiw+fGLf4BFsyvof/SHTG21l6XZ0/nXzBPLITP1UeaYy
         cX9A==
X-Gm-Message-State: AOJu0YzjHrP5nI1cs1sDnz5X7Z7WXYyTdCwEFUkN/3PnD3W7nS6X/BUJ
        jZcQX8GaKaOMSO1AeJJF5vS+uGJ6UuM=
X-Google-Smtp-Source: AGHT+IHR0oww9NARymoguRZjRSZ1K8ZJLMCiQdWgkelQ549GZG1OOOSByrXeBlT/DbnRC/QW1exoXw==
X-Received: by 2002:a17:902:8604:b0:1c5:ad14:908f with SMTP id f4-20020a170902860400b001c5ad14908fmr221082plo.39.1695408192626;
        Fri, 22 Sep 2023 11:43:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902a50400b001b567bbe82dsm3809002plq.150.2023.09.22.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:43:12 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:42:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Annotate struct hv_dr_state with __counted_by
Message-ID: <ZQ3gFXgoccQ7BE6/@liuwe-devbox-debian-v2>
References: <20230922175257.work.900-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922175257.work.900-kees@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 10:52:57AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hv_dr_state.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Wei Liu <wei.liu@kernel.org>
