Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3773D2A4
	for <lists+linux-pci@lfdr.de>; Sun, 25 Jun 2023 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFYREB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Jun 2023 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYREA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Jun 2023 13:04:00 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FB91;
        Sun, 25 Jun 2023 10:03:59 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6687096c6ddso988323b3a.0;
        Sun, 25 Jun 2023 10:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687712638; x=1690304638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXGVLD2f6XGphux+ittDv5e3nS4ZwERSKvSP79IqJIY=;
        b=M92E2rnEwc2WVWhwgMD5Y5rC3GbAJ8lXx/yvbAiAIr8YW+YSr4myJQtvR5UIRJh5Lb
         81DQyJXHeo/36ltbRNE2939KOaHiabYX/LZdPEJeI1Hj7BcWwQOfOJD91HRVtv3qQ/bP
         EqJzeO6t2yP1pAXARgJNSxh7YOpA2CRs4xPYFDe/6k1WCeCJD7ZfChhTEpBeB3E8QAf9
         DkbQaOnE+4suf67F9hxHO3770I4rHi551jdJM5XKESO88ZyXRdy20aftpzw2G95iSfCv
         KmDBwzNin0Hm5FwbdOHOg+r7darEOvoCknWA5fWeGiEZ3VcdoJ2E/i7uNVL+/DSxvmoO
         uxLQ==
X-Gm-Message-State: AC+VfDxEtv14kkA6NyYd05z5eTH6EReXX+EjSHlLoNmG1znaZyGA9xKQ
        ajKtbb+eejgW1Kp0G0hcdo4=
X-Google-Smtp-Source: ACHHUZ4kwifZA3dJPCEfknD8sN6NVUq+K2hVaArWAOkolI+4eXXHmQ4uLgSPyQF8fUNwrEz6m1cQcQ==
X-Received: by 2002:a05:6a21:6d86:b0:122:e4f:25c7 with SMTP id wl6-20020a056a216d8600b001220e4f25c7mr16501490pzb.31.1687712638079;
        Sun, 25 Jun 2023 10:03:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b00659b8313d08sm2440664pfh.78.2023.06.25.10.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 10:03:56 -0700 (PDT)
Date:   Mon, 26 Jun 2023 02:03:55 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Xinghui Li <korantwork@gmail.com>
Cc:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/2] PCI: vmd: Fix two issues in VMD reported by Smatch
Message-ID: <20230625170355.GA2459283@rocinante>
References: <20230420094332.1507900-1-korantwork@gmail.com>
 <20230624163314.GD2636347@rocinante>
 <CAEm4hYUhRCBo=N9EKUaSbBWZafKk0WzzwDWYmJ4FykpQoeZe1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEm4hYUhRCBo=N9EKUaSbBWZafKk0WzzwDWYmJ4FykpQoeZe1w@mail.gmail.com>
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

Hello,

> > >   PCI: vmd: Clean up one inconsistent indenting warn reported by Smatch
> >
> > Even though this is a very nice clean-up, I did not take this patch at this
> > time, as there has been a similar patch posted in the past, and Christoph
> > Hellwig suggested, as part of his review, an alternative approach worth
> > considering.
> >
> > Have a look at the following and let me know what you think:
> >
> >   https://patchwork.kernel.org/project/linux-pci/patch/20221115054847.77829-1-jiapeng.chong@linux.alibaba.com/
> 
> I think Christoph Hellwig's suggestion is indeed better.
> So, should I submit a new patch to address this issue?

Please.  A single new patch would suffice.

Make sure to explain as part of the commit log why this specific change
that started as a Smatch complaint about an incorrect indentation.

Thank you!

	Krzysztof
