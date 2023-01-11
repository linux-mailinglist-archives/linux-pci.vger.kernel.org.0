Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F36654B6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjAKGiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 01:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjAKGiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 01:38:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E7F5A6
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 22:38:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gh17so34436111ejb.6
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 22:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3V1mNU0HXgYcpMiR+7Lr+08A9+hToUVstRfs4sCWUwY=;
        b=GAy3o7Lg9JUadIeU2R96pDPX+FBLrwP+TISKDYJ5cwNrqtPSRYd1oEfe3H3rCKUxfW
         reuQcIf1yqStlv9ro02x4bvYNoTpFmQKoqe6DFY3SuKDZOSBW91z7BvNo+6h/bokrFau
         Nz74gEIhNbffo/BDqlzIw1VXQ28iZkjEEXuTLqBO6eRRoyGVj1bG0VTo9b+RrsOOYssr
         Jm+Ld5U+Zj6vU2OxIzePeyjdqM2D0gpSAcYfOlKowswFG2fbIApCMVjt03EMR18gP5au
         SUM3Je7Qmg0J/yeC4lNf4p6JouYLgL5PBHtZ+nZ+idkfv8h+TwFjg0lvMUlnCMpzmfcV
         uLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V1mNU0HXgYcpMiR+7Lr+08A9+hToUVstRfs4sCWUwY=;
        b=bxGOS1XLK0iPGaUflushRUT+UUhgLMUhYW7aTM9ap+AumrImTtHe2g27WpGjDv2sso
         rOg/4sR+h1oS83EuLncUUOKvFdMGI3Uf/4/foRuqYItouRlYFPMaDFkITbBCHZ7YKfAM
         DvWfMqLoS7fiCXjki2xMe2m+XDcXdyi1Y29RJGA4jg/6apVzKfJYbEz8RTPtxLpb4hze
         Y1ng00uKbNxm3OrHxib5aP/Htl5Q3nn+QU8A0uviQ4HNjpNHwiTkab7UfFGdesqwoInC
         L8RyUS820/1QfPZj6Ac3KNvjL3/UxwkWe3vCw/YXubwNyye0q4Afep8r2WSv64hj8JXT
         t4kQ==
X-Gm-Message-State: AFqh2kqxxP1PFedoZAFrVNcO3Q0O1SFWlW6aBDBzd9xy61zfXq8ROivc
        QGIkuZfga82FBkGIJwDLl5KQzVoXYnSAfWEQSpE=
X-Google-Smtp-Source: AMrXdXv5fkGhIZIyJSTFu1Niz7RaQS2YqA25BqzpwjT2YP2xBaN+KrxIOV9n2hwjHvIS/sJTjaUB83xOF19Dnn/AI+s=
X-Received: by 2002:a17:906:1153:b0:7ff:796b:93ee with SMTP id
 i19-20020a170906115300b007ff796b93eemr8610389eja.582.1673419079707; Tue, 10
 Jan 2023 22:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109125148.16813-1-adrianhuang0701@gmail.com> <20230109214613.GA1445262@bhelgaas>
In-Reply-To: <20230109214613.GA1445262@bhelgaas>
From:   Huang Adrian <adrianhuang0701@gmail.com>
Date:   Wed, 11 Jan 2023 14:37:48 +0800
Message-ID: <CAHKZfL3GgsGgSZycB6QwwBQrYA4kbnyFWMdPgZjjGZKCgktK8g@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: vmd: Fix boot failure when trying to clean up
 domain before enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 5:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Can we make the subject line any more specific about what this patch
> does?  Apparently this is really about avoiding accidental enablement
> of the window because the base & limit can't be updated atomically?

Sure, I will rephrase the subject.

>   #define PCI_IO_BASE             0x1c
>   #define PCI_PREF_LIMIT_UPPER32  0x2c
>   #define PCI_ROM_ADDRESS1        0x38
>
>   memset_io(base + PCI_IO_BASE, 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>
> The memset does clear PCI_PREF_LIMIT_UPPER32 already, but I think
> you're saying that PCI_PREF_MEMORY_BASE, PCI_PREF_MEMORY_LIMIT, and
> PCI_PREF_BASE_UPPER32 are cleared first, so there is a time when the
> prefetchable base is zero and the limit is non-zero, so the window is
> enabled.

Yes, your understanding is correct.

> I would expect that to be a transient thing that you wouldn't be
> likely to trip over, but you seem to see it consistently.
>
> > This behavior causes that the content of PCI configuration space of VMD
> > root ports is 0xff after invoking memset_io() in vmd_domain_reset():
>
> Well, it doesn't actually change the content of config space, does it?
> I assume these config accesses get routed the wrong place because the
> window is enabled, and some PCI error like Unsupported Request is
> getting turned into ~0?

Yes, I think so.
I'll rephrase the commit message accordingly.

-- Adrian
