Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA078A5D7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjH1Gi1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjH1GiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 02:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE612D;
        Sun, 27 Aug 2023 23:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AA96617B9;
        Mon, 28 Aug 2023 06:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03580C433C8;
        Mon, 28 Aug 2023 06:38:05 +0000 (UTC)
Date:   Mon, 28 Aug 2023 12:07:55 +0530
From:   "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Message-ID: <20230828063755.GA5148@thinkpad>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
 <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 28, 2023 at 01:19:17AM +0000, Yoshihiro Shimoda wrote:
> Hello Krzysztof, Serge, Manivannan,
> 
> > From: Krzysztof Wilczyński, Sent: Sunday, August 27, 2023 3:59 PM
> > 
> > Hello everyone!
> > 
> > > > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > > > To support them, modify PCIe DesignWare common codes.
> > >
> > > No more comments from my side for this series. It looks good to me
> > > now. If you have nothing to note too please merge it in especially
> > > seeing it's already v20.)
> > 
> > Yes, it's about time we pull it.  Thank you everyone involved in the work
> > here, especially reviews (Sergey and Manivannan), as the series looks
> > amazing.
> 
> Thank you very much for your support!
> 

Thanks for your patience and perseverance! And thanks a lot Sergey for helping
with the review.

- Mani

> > That said, some patches in the series do not apply cleanly against 6.5-rc1,
> > so I need to have a closer look a little bit later, hopefully I will be
> > able to get it in time before Bjorn sends his Pull Request.
> 
> I'm sorry for bothering you about the conflict because my patch set is based on pci.git / next,
> not 6.5-rc1... But, anyway, thank you for applying to controller/rcar!
> 
> > シモダさん、
> > 
> > 一連のシリーズお疲れ様でした！
> > 特に、作業が少し前に開始され、レビューされるまでに時間がかかった点お手数をおかけいたしました
> > 全ての要求変更の追加にご協力いただき、ありがとうございます。 個人的にも本当に有難いです。
> > ご担当いただいた仕事は素晴らしいものでした。 重ねてにはなりますが、どうもありがとう！
> 
> Thank you for your comment in Japanese!
> こちらこそ、ありがとうございました！
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > Thank you!
> > 
> > 	Krzysztof

-- 
மணிவண்ணன் சதாசிவம்
