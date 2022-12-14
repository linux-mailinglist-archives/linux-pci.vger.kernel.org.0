Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC46564CF0D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiLNSBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 13:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiLNSBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 13:01:36 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F77AE44
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2022 10:01:35 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g4so659032ybg.7
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2022 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=in0+4T7zsT1szAcuDpgB7UD6oKEoJr8ruNZ5Dg7YtpA=;
        b=NX5Fj1ezfKxiLPTzV0af2fewGQYUkwGctpfcN9Pi2mGgyBt01CD1BBSVTY/sivXdF3
         7kyzkC1cFP0Z0AI21bt1bJXSFE+tFvY1zBuKuOifzVtQSZSGmeKciSjqqtlI7i1tlFBp
         4a4HJafAE3yvStOb6KSBezQvMUaRzDoFMs7/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in0+4T7zsT1szAcuDpgB7UD6oKEoJr8ruNZ5Dg7YtpA=;
        b=V8wYSmcSUTM+wEvZSk1N6bIlD23rxiB2GJMP+1+NZlATWie5OiwdbggEQmfI+2E3Bz
         fEb5sPG0Z2gesDIZVWzfA/GyGS1gaT+VZU6GaUK1onzdCBlidRhGur0Fv65loTpU58is
         i7eH9XIuAZyp2bgbJPG+c1mlYLIgJORzVib3TS9WzV09NN7T5l3W+Hb6QwsHmBkItsrI
         CNOCsLlZHWXFDCEs2hbKBP4eqdzldgYvIy912Gjfhp5fmvz/CCVYsjWkctpwmWDAMfnK
         +EKeDtc6bMpbldeVXwUyZHBqJAaxFKj9lnwR7ufeLrmesF2HpHTe8dfW+hUjEgX0S/Cf
         Shlw==
X-Gm-Message-State: ANoB5plmafQSOwdgGd9uatpAKATS+tfcxD5aKgA4XkoL9wt3AHlKcIMy
        4K7/nqYyFJiVkqd/rQNe16GQCb7AMSA5X9JF
X-Google-Smtp-Source: AA0mqf44FyayuEP/BXiMs0dD7PklnEXNMHVUAoRLyWKrjgIbeLDDHJYQ8Ki2EO9le/NClGmbKGG89w==
X-Received: by 2002:a25:b2a5:0:b0:6f1:4b27:9c7f with SMTP id k37-20020a25b2a5000000b006f14b279c7fmr19672291ybj.10.1671040894681;
        Wed, 14 Dec 2022 10:01:34 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id l24-20020a37f918000000b006fc5a1d9cd4sm10449749qkj.34.2022.12.14.10.01.32
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:01:33 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id k3so1588075qki.13
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2022 10:01:32 -0800 (PST)
X-Received: by 2002:a05:620a:8420:b0:6ff:812e:a82f with SMTP id
 pc32-20020a05620a842000b006ff812ea82fmr638686qkn.336.1671040892215; Wed, 14
 Dec 2022 10:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20221213233050.GA218218@bhelgaas>
In-Reply-To: <20221213233050.GA218218@bhelgaas>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Dec 2022 10:01:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
Message-ID: <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v6.2
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2022 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> You will see a merge conflict in
> Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml between these:
>
>   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
>   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
>
> 5c3741492d2e is already in your tree via arm-soc, and 4cc13eedb892 is in
> this pull request.  The resolution I suggest is to use 4cc13eedb892, which
> means we'll lose the addition of "ecam" from 5c3741492d2e.

Heh. I only read this part once I had already resolved that thing differently.

I dunno, I used my own - possibly bad - judgment to add a case for
that 'ecam' thing under the vendor-specific list.

That was very much a "monkey see, monkey do" resolution, so some DT
person should check it out and possibly make fun of me and my dubious
ancestry. Rob? Thierry?

                  Linus
