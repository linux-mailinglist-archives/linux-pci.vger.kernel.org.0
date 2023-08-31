Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8778EF33
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjHaOEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjHaOEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 10:04:31 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CEC3;
        Thu, 31 Aug 2023 07:04:28 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so586164b3a.1;
        Thu, 31 Aug 2023 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490668; x=1694095468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8XXEK9RmQdx4SObXPw7grPK1RuzChzezZcq/KGPIaU=;
        b=iL7NjubHWbW4NNqDJV6AqjlT/s6fwEe1Y2a/khyio81FrDCRpYNx5uXeuOIPHtQjKa
         T4RXG7j4AzOUeT1W09l2SHjc68aL+6wg2mtF7nGDK18RVJUKA9p2Wa6IXJFFT2o9mGNA
         9Tv3PtPPfbiT6oVW3GyocgUSG2f4Jabf4cEf2QNCFfn70CLvhSLH0qVwn/juACkeWhcS
         XbAvwpc3KjNH5YFFTfM7wGpObOkpPVEVsFv7YSDumGldqZfYS/mq7ScEudncnyBehc4E
         YLv7L9CMLDbF6LMBgEcbiPnkywDVqnlneZjBhooNORs9aCyCaAo9gmCZY+wa4KQkDOWo
         cjrg==
X-Gm-Message-State: AOJu0YyjmQ0Byw3Cx1Ud6MUkS2wKWo4f4TP9gzBIRDRX3xZzejtn/qv6
        QoD/nKfcaHuJN5d8uGzOdv/yI5VUbCWSNxXZ
X-Google-Smtp-Source: AGHT+IFrImfvhxUlwlYWoYEXfUl82NOevalyTknYYsbnfWjTdX7MBH8dWwUiibVajT9Jt0Zu2u9UiQ==
X-Received: by 2002:a05:6a00:1a8f:b0:68b:dbbc:dcea with SMTP id e15-20020a056a001a8f00b0068bdbbcdceamr5046916pfv.9.1693490668247;
        Thu, 31 Aug 2023 07:04:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7904c000000b0068a0b5df6b2sm1355474pfo.196.2023.08.31.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:04:27 -0700 (PDT)
Date:   Thu, 31 Aug 2023 23:04:26 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230831140426.GA255922@rocinante>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230827162721.GA2932694@rocinante>
 <TYBPR01MB5341A56DBA3E4335FE8A35F0D8E5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341A56DBA3E4335FE8A35F0D8E5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > Applied to controller/rcar, thank you!
> 
> I should have asked you before, but is it possible to merge this for Linux v6.6?
> Today I realized that "[GIT PULL] PCI changes for v6.6" [1] didn't have the controller/rcar...

Bjorn chosen not to include the series as the scope of the changes also
spans across the DWC code base, not only adding a new driver, and he wanted
for it to remain a little bit longer on the -next, so that if there are
issues, we can catch things...

... like the dt-bindings issues that Geert is asking about.

That said, there will be no need to send an entire series again, if you
have anything to fix there in the dt-bindings or the dts patches, and just
send a new patches for these - I will pull and squash everything later.

We are getting there. :)

	Krzysztof
