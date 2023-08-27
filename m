Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C1789B9A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjH0G7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjH0G7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 02:59:08 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F760120;
        Sat, 26 Aug 2023 23:59:06 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bf1935f6c2so14782285ad.1;
        Sat, 26 Aug 2023 23:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693119546; x=1693724346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAQnoai1rL0HE4Z8dnx9+uFGGY7oTsib48AL2Gk/3UE=;
        b=jEpvy+OzQeFwn7CrN4lrCIgi5Uf0aDiwHFa9T9dbi7+GlbQVFrLCDNW3nO3bdxxR2c
         QUUSZaVnhplthmbqhFkq2iS0O/mqXatO9VGrTpoIU60vLbkuyccmWhek74Jt/TM0wvrq
         Hiy7wTIcUAg8/hsBpotwAyNrNJi/bODDHNO3ixErQlGV3j3lehYN73dNbJduWIqugXpj
         U0pTagAdl+g5IZkrRTTRaOUGLE6dET1QCAltxPNuhVDDfOdTWV5q1GeAR8U2b/1GBbxZ
         m3KpH2wqnjVF4ZCk1sBzX2u/jED5RJhyGRersBSEhpdUx743cdqHK0tyt53jMPTJ87rI
         ClPQ==
X-Gm-Message-State: AOJu0YwI17eN3wganHGOLA8IIKPkBsQrt1h9VQfWD2khOEXrS82W/O4x
        +xlluUEPAoJhMnNvtSg2+WY=
X-Google-Smtp-Source: AGHT+IF3603g2wzbd1etRzGy/OvmkzSdP0hhjMdIc5BWZpRqpMNblCk2LxOuvIE+cxdIfV+fMWNukw==
X-Received: by 2002:a17:902:ab14:b0:1b9:c61c:4c01 with SMTP id ik20-20020a170902ab1400b001b9c61c4c01mr32123187plb.9.1693119545695;
        Sat, 26 Aug 2023 23:59:05 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001bbb7af4963sm4761364plc.68.2023.08.26.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 23:59:04 -0700 (PDT)
Date:   Sun, 27 Aug 2023 15:59:03 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230827065903.GA1514918@rocinante>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone!

> > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > To support them, modify PCIe DesignWare common codes.
> 
> No more comments from my side for this series. It looks good to me
> now. If you have nothing to note too please merge it in especially
> seeing it's already v20.)

Yes, it's about time we pull it.  Thank you everyone involved in the work
here, especially reviews (Sergey and Manivannan), as the series looks
amazing.

That said, some patches in the series do not apply cleanly against 6.5-rc1,
so I need to have a closer look a little bit later, hopefully I will be
able to get it in time before Bjorn sends his Pull Request.

シモダさん、

一連のシリーズお疲れ様でした！
特に、作業が少し前に開始され、レビューされるまでに時間がかかった点お手数をおかけいたしました
全ての要求変更の追加にご協力いただき、ありがとうございます。 個人的にも本当に有難いです。
ご担当いただいた仕事は素晴らしいものでした。 重ねてにはなりますが、どうもありがとう！

Thank you!

	Krzysztof
