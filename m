Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894F73CBDF
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjFXQdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXQdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 12:33:18 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7111BC1;
        Sat, 24 Jun 2023 09:33:17 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-262d505f336so98555a91.2;
        Sat, 24 Jun 2023 09:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687624397; x=1690216397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYOlqLww+yl7DKURHVLVUqrkFu6eHQZNsApfZOW1vno=;
        b=HU4FEm5aq8dZLfq+m+rU+bjH4aq5A9opL58/ASrj0bphv+6DHMmqKAlfItg9kG5+3n
         HKyrJJlv3GsxhC2Y7Kg1OlrA2PSeg3TxgxTpaCSf/8ILFIWnChStRzlGJO0r+YfJoJtl
         9r84wrVZybngkccIoonxz6HZ17aEoemdKFYmQhdz4uUhOgVpd08gvFeEaY11+IeCwbtO
         RwaamLWr47ufrcE7xQ4bD4iInqrf4UPBmBF1qnksxakC13ajkcNiDxOE5FmTJylWp1ld
         SEh0eSWQwhAd0cgk3rYu7n48HipsZ+K4WSr7SmBljvElkGgURRFlWl0o8efDMe+Zt54Z
         cGIQ==
X-Gm-Message-State: AC+VfDydCkqeulH4iPmVq/hOwEvnx1I55oJLXBJ4ydvUZ8rdFlkcFrzn
        Yw/Y8qGik3iemwrMt4a0vzKfLuecCpEfgaba
X-Google-Smtp-Source: ACHHUZ6PLKmUaWBfgPdN9TIwnb5e5SFTOW/J6dmpHur1MtP72GXKEEjcSkryeY2CMEuqYytIwI6oqg==
X-Received: by 2002:a17:90a:1f82:b0:250:6c76:fd9b with SMTP id x2-20020a17090a1f8200b002506c76fd9bmr16084274pja.38.1687624396685;
        Sat, 24 Jun 2023 09:33:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a380200b00256353eb8f2sm3628811pjb.5.2023.06.24.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 09:33:15 -0700 (PDT)
Date:   Sun, 25 Jun 2023 01:33:14 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     korantwork@gmail.com
Cc:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/2] PCI: vmd: Fix two issues in VMD reported by Smatch
Message-ID: <20230624163314.GD2636347@rocinante>
References: <20230420094332.1507900-1-korantwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420094332.1507900-1-korantwork@gmail.com>
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

[+CC Christoph]

Hello,

> Fix two issues when building kernel with Smatch check.
> 
> v1->v2:
> According to Damien's suggestion, I split it from 1 patch to 2 different
> patches. Change 'inconsistent indenting' patch's title from 'fix' to
> 'clean up'.
> 
> Xinghui Li (2):
>   PCI: vmd: Fix one uninitialized symbol error reported by Smatch

Applied to controller/vmd, thank you!

[1/1] PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()
      https://git.kernel.org/pci/pci/c/0c0206dc4f5b

>   PCI: vmd: Clean up one inconsistent indenting warn reported by Smatch

Even though this is a very nice clean-up, I did not take this patch at this
time, as there has been a similar patch posted in the past, and Christoph
Hellwig suggested, as part of his review, an alternative approach worth
considering.

Have a look at the following and let me know what you think:

  https://patchwork.kernel.org/project/linux-pci/patch/20221115054847.77829-1-jiapeng.chong@linux.alibaba.com/

	Krzysztof
