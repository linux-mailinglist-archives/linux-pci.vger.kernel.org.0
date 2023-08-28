Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EA78B264
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 15:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjH1N6u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjH1N6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 09:58:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9863CE;
        Mon, 28 Aug 2023 06:58:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50087d47d4dso5211282e87.1;
        Mon, 28 Aug 2023 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693231113; x=1693835913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GYpzXjipcZ7mlfXoIcyv72cGzFGbTNtJeS4RCiq4Lmo=;
        b=IGwOIrtM8i/OzAypW6B+GIoblnZgJ5HarQsZZTiycPANxuRYq0W+ntkNc+CgnJlon7
         oMQsnFGOLjAosZUbl5RI7/nkTItko+VGxVyHyll3mjaZsazCjlu2yVMTy9SewhC2WYFn
         KY+mPNmJdu3h3TQ0X6K2se50lBlcZHBKsn/sWxJc9qSGuN392za3MwuiPwWwfItKblRZ
         dxeZTKQL2SbbspiXdqaUvv473mxrMrv1eLbcRlXTJxV2Ot4KmiXI2ixIvlLGmF/13SVI
         kQ7eccRbMy2PuCYr6lqK8FHje42nZ+EaPCj6+BT2IHEhKglfjX9o/djySDTHxchwQeCT
         ZFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231113; x=1693835913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYpzXjipcZ7mlfXoIcyv72cGzFGbTNtJeS4RCiq4Lmo=;
        b=Y0pjQg0tmeFTjqXdc3g2tiUWXC7q1V1CeJxtplRdj2jXeWVS5btI2fKEH0CHXGdVOL
         ZmcU0omtBfDBnT32Zif662zyXBi3rsvZzmw1VD+63YnJrwr4jbjct/wL8oiI+tSVNsdW
         dS8A5I3zGDVC11O4BI1qUbLUAlUbSe9+lTS+PwF7vTmM6xP6Dovs7bfScuontYLUK6k4
         z2ClPeXlxWh4yYZBVexcwBKp5z1OPCx1SWPuUuIHYgoZ2cQB/I7cM7tVa2rHqq1i1qth
         3WECDWjl9iddIms5rUhcFd5YEAwKWSH9PDIQ3QMyU1ZkZOcQMXG5jFPxevROY+JnD0+w
         m/KA==
X-Gm-Message-State: AOJu0YyNZbaKbMDCSn9rPaN6Q3Y4vVbvhbe7vIgJKC4ZHjaYDESsvsle
        s+OQztgTx0Rh2DdrnvJ4VGg=
X-Google-Smtp-Source: AGHT+IE6Qy2WpwfL7LMNBTSeBEprQEKxH+poK6zJlg6OraN8vzmq8T6+kReXZPQdh+/YQRCwGHDeQg==
X-Received: by 2002:ac2:4982:0:b0:500:7fc7:8521 with SMTP id f2-20020ac24982000000b005007fc78521mr14243010lfl.64.1693231112773;
        Mon, 28 Aug 2023 06:58:32 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24203000000b004fb326d4ff0sm1559027lfh.77.2023.08.28.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:58:32 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:58:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Message-ID: <y5veq46prsa5rwy42zhods6v6lst2rbf3tqzuznblkyz4tbcf5@wdhju7x3o3oc>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
 <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro,

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

It was my pleasure to be reviewing your patchset. Thanks you very much
for the patience and strong eagerness to complete the turned out to be
such a long-time procedure. I'm sorry if sometimes I acted too
meticulous.) It was always done from out of reaching greater good.

Regards
-Serge(y)

> 
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
