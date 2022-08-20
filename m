Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7459AB87
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiHTFyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Aug 2022 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiHTFyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Aug 2022 01:54:13 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D3225581;
        Fri, 19 Aug 2022 22:54:11 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso6626324pjh.5;
        Fri, 19 Aug 2022 22:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wegE5f1QqdauRGukEsg7vRb62UqXw1UO2UnVIWYOb+k=;
        b=lTT3ak0Dg4QqO6Obs5eIbZvQe8Nv/QJvB/4S0AnqLFkrMjQdpgVIttpAQJweHTntJL
         jaqy+68ICLaDRDOle23JmUAxb7ByKV4v9+vRMIFnBaoxa2BCQBHf7Obb51RC65PIOjkZ
         8P6hfqGvwZlOoRT7IoOQTQyBr9kLN3yPKA1y1MHWCd5vrYB1htDIizN1ZcnZA0+0D0G7
         Qh1sTuMJbdWlcSCwKpwfi2K+D12g3jnCSKxHWGc1leGpx2lnYH+qZ6P6wWMv7o/7dbkk
         GoNgflLrb9pWgyMpJV8Dl/4PXQI6tClnXk9oCilgcju/JJDkg8bpQ4RQvgsLrcCbNZOK
         eyAg==
X-Gm-Message-State: ACgBeo1bBJvddJmStys6Xik7gWAud3GToPWRQtRsxhSsK9kyax9w6bSQ
        8aQfWHNUZNAa6ZQkCrtk/P8=
X-Google-Smtp-Source: AA6agR5BVsqdCK7sEiiWwvH3yKojF2rUW093KAoShNTho69aQ2OVS1XMg6akH50YqRKDm/EAlqYpCQ==
X-Received: by 2002:a17:903:40cb:b0:16f:196a:2bb4 with SMTP id t11-20020a17090340cb00b0016f196a2bb4mr10686282pld.104.1660974850807;
        Fri, 19 Aug 2022 22:54:10 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id nu18-20020a17090b1b1200b001f216a9d021sm6169320pjb.40.2022.08.19.22.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 22:54:10 -0700 (PDT)
Date:   Sat, 20 Aug 2022 14:54:07 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, lpieralisi@kernel.org, kishon@ti.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as the reviewer for PCI Endpoint
 Subsystem
Message-ID: <YwB2/w5tSKCWqdfS@rocinante>
References: <20220819020817.197844-1-manivannan.sadhasivam@linaro.org>
 <20220819200555.GA2502055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220819200555.GA2502055@bhelgaas>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> > I've been reviewing the patches related to PCI Endpoint Subsystem for
> > some time. So I'd like to add myself as the reviewer to get immediate
> > attention to the patches.

Welcome to the team PCI, the best of sub-systems :-)

> Thanks, applied to for-linus for v6.0.
> 
> Updated subject line to:
> 
>   MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint reviewer
> 
> since "add myself" doesn't mean anything without reading the whole
> commit log.

Thank you Bjorn!

	Krzysztof
