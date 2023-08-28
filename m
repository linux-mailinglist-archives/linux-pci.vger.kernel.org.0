Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1619278B518
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjH1QHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjH1QHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 12:07:18 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB111A;
        Mon, 28 Aug 2023 09:07:16 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68becf931d0so2401162b3a.3;
        Mon, 28 Aug 2023 09:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238836; x=1693843636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XsL/00PF9/8sA2oKagxC6NwbgxKDpHaDCE49iGbgg4=;
        b=aIeQyoRpIxPUa/xvxd9qW32k1P6oQehGW6KDUBwTBh67G6pIoa09wjQsee6FKdLLCF
         NrpilLClRfteEOM0IjthirmRai9wmLE78nVCEkfAiSGwvDg3OLhDH44ICNNvcri59ZAi
         zvL1rqvV5EmUHK5NjOlcA7PfxWFo1dYWqkDmkRml3daT9RhAwAXLaNhO3BvPEEhK58WE
         gHHgpbEZQpuRlJ+TwZYcY9bv54AoPv59bksy8vMwFdTJRn1UYLwtROZIRZqvYar/M9Tn
         Us8ozgPCZkGxugl9CTIGCFn+it4SeERvH1IIk3ALFRvTO8mSIsQQ+LOSS6zmNRqSaADZ
         0biw==
X-Gm-Message-State: AOJu0Yzt3S3WCvMJkzcF901U9BAj00PBJMzW5v2KBVQ4hbkxgLM0pWsG
        7a+D7VImJMlXUr9uKaCuPlJDV891xKrsag==
X-Google-Smtp-Source: AGHT+IE8MtyM/qFrxwb0AQSGr69DTwsrmprLspNhoU1OxjlwtT2yinZQ8NgjAlrL7zwCsS16o6LnZQ==
X-Received: by 2002:a05:6a20:3d20:b0:137:2f8c:fab0 with SMTP id y32-20020a056a203d2000b001372f8cfab0mr26377428pzi.49.1693238835694;
        Mon, 28 Aug 2023 09:07:15 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id k4-20020a633d04000000b0056c3ee09b71sm7514766pga.74.2023.08.28.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:07:14 -0700 (PDT)
Date:   Tue, 29 Aug 2023 01:07:12 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230828160712.GA2127814@rocinante>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
 <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > That said, some patches in the series do not apply cleanly against 6.5-rc1,
> > so I need to have a closer look a little bit later, hopefully I will be
> > able to get it in time before Bjorn sends his Pull Request.
> 
> I'm sorry for bothering you about the conflict because my patch set is based on pci.git / next,
> not 6.5-rc1... But, anyway, thank you for applying to controller/rcar!

No problem!  

That said, it's always a good idea to check the main branch from the
following the repository to see which version to work against if
possible.  PCI development lives at:

    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git 

> > シモダさん、
> > 
> > 一連のシリーズお疲れ様でした！
> > 特に、作業が少し前に開始され、レビューされるまでに時間がかかった点お手数をおかけいたしました
> > 全ての要求変更の追加にご協力いただき、ありがとうございます。 個人的にも本当に有難いです。
> > ご担当いただいた仕事は素晴らしいものでした。 重ねてにはなりますが、どうもありがとう！
> 
> Thank you for your comment in Japanese!
> こちらこそ、ありがとうございました！

Sure thing!  Greetings from Yokohama. :)

	Krzysztof
