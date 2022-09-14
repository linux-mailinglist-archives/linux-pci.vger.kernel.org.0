Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1C5B8878
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiINMox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiINMox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 08:44:53 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74786167C2;
        Wed, 14 Sep 2022 05:44:50 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b75so9559481pfb.7;
        Wed, 14 Sep 2022 05:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ppilu497MeD4MTHY8A0xUP+wtHWmhwuugRsdgpfLbGA=;
        b=I+YOzOgSWWu766CKlCqVcpO4JXuWaQOKg+JOnwz9CQsc0Jvo2Hb9weax980+LvFXvf
         Km5Ez2PTCe3Bc+QxEljvOlyU2yF/0YLJv8/pwNYFqOYU/7c5ALmxKZCIUYZOvss2ycPI
         zMyfdGHy5Yxokop5EAtZnxq0S51daTN9aFZGA6uy1DHrYy65aQPitiZ9bjucJaIIIP0v
         YirGN78Gb3m/Gq+qPeA8d5DEyD3aIPLDOomgIPYhx9tpaIA+xVLoUWMUgWWIRZqHoBIa
         8f/B7mXV6OXVD0lHzF0lPQhMaauDMENpK5pbCThzvf/i+OyToF6l5mW2sw8XtszcW8yV
         JuaA==
X-Gm-Message-State: ACgBeo2e062mF7wprKpS84mkb0zPFYZLSKDkcfxps5snQb3qtq0//PFt
        yvulF5ml7RHMj0uiGTUkKZGIRxp+MlF2iO75QV8=
X-Google-Smtp-Source: AA6agR595jtmRRtVgqCFvWfg/d46mv2gTdEmeyhgdhCf3g6mzk1Jk1n81Gp93vy58b3Rb5F2iyAgqw==
X-Received: by 2002:a63:87c2:0:b0:438:f775:6eb7 with SMTP id i185-20020a6387c2000000b00438f7756eb7mr13361743pge.336.1663159489904;
        Wed, 14 Sep 2022 05:44:49 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a191000b001fb47692333sm9142244pjg.23.2022.09.14.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:44:49 -0700 (PDT)
Date:   Wed, 14 Sep 2022 21:44:44 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, treding@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <YyHMvBhWgbDtv6V2@rocinante>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
 <20220914114306.GG16459@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914114306.GG16459@workstation>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> Anyway, I don't strongly object the change and leave it to the
> maintainers to decide.

Perhaps it makes sense to make this a dev_dbg() over dev_info(), especially
since it appears that this information is of more use to the developer (who
most likely has the suitable log level set anyway), and given that there is
no way to reliably detect a presence in a slot on some platforms, this
might otherwise, add to the other messages that normal users don't pay
attention to usually - if this is not to be treated as an error.

	Krzysztof
