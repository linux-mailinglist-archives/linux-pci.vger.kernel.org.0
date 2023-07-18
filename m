Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD64757798
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjGRJQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGRJQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 05:16:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DD171B
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 02:16:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8937798e87.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689671768; x=1692263768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ArVM8hO5JmqawYj0bAdi35rTjPsLnVXsndSgTl9bpA=;
        b=bDAOBbnEsu8XzXY6Qr9rFqFeguyvLdnAWlkhI+TFQkNYOP1B8tboggUAHVKCsgrd+F
         ze+iedigN4Xr41ABn6jlbAmHMKX8Zv4IP5jMvYtEVWmN7Bd9e7FimswjLlSdv7eRpZvZ
         bes7cZxSg7ZsSjXLHZ4A5ETGHk1pvus4yhJtq1c2mTVwGQ1uHt9XKFmQT9IPlQRFvr6x
         9glNHyyB494PBA6b1VGcfU7qAZdV+2VF84TeVtaOjmQx6+ycDYdiBeleklFrdFZtu4WI
         g+YRdES/EgAmJaLFH2W7X43k9VZEsnrnIJl3m2zEStsOHACWueEegpu0J2D3Ybgfcv25
         /lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671768; x=1692263768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ArVM8hO5JmqawYj0bAdi35rTjPsLnVXsndSgTl9bpA=;
        b=iY9B+uStYjFpEH321jJXF2tfGb84DFX9rVfQ9LWmCI/WNQ10RUUkCSx54bhT/HDGyP
         sm4gKDRotbRU6nGhTNAKJa/alUltv0QjJ9nUV5Rgyks9HoFfOS7zLx+/4MnycijTqazZ
         Q3a7+ZHS7eae7Sty9gqIWkFP3cBh1pe/lBeIWxLliZkHBrnz2ia3PLLA/3zt14vImxb+
         zJr5phUK3BDfFznOu4NaibV1/57q7Y5RiEGufVrzGibViGBuvbd+oNyl/sg+FhpJEIiR
         rKq+rbpZP5zCnS1hyIzmhIRtyS0I5jsUYsr+ozXuQx/zStWB1APFLNmudRfK47jsu0oB
         RMJg==
X-Gm-Message-State: ABy/qLZ4RteNplxhaP3vGMcg/kU0QTo6T5/X3X+QiFIAYc8JKfXrbmX1
        v3kCJzz14TRzVIPyDtrDQLgt5QudbF4=
X-Google-Smtp-Source: APBJJlFWdyunRCXhL+SaA4OC9Q8/h0ko7xnGI/QFkqoV3ssjSMQvQ+1kijJLAn03S0LYMrH9pOSDbw==
X-Received: by 2002:ac2:4e0d:0:b0:4f8:58ae:8ea8 with SMTP id e13-20020ac24e0d000000b004f858ae8ea8mr1256472lfr.58.1689671767520;
        Tue, 18 Jul 2023 02:16:07 -0700 (PDT)
Received: from mobilestation ([85.249.21.35])
        by smtp.gmail.com with ESMTPSA id g18-20020ac25392000000b004fa52552c7csm341980lfh.151.2023.07.18.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:16:07 -0700 (PDT)
Date:   Tue, 18 Jul 2023 12:16:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: Future of pci-mvebu
Message-ID: <l3rqo422yn2mbf7qtkqk4ay2fz6jteygmahepvmleiyrxjoaw2@ptqtsl5s6mj6>
References: <20230717220317.q7hgtpppvruxiapx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717220317.q7hgtpppvruxiapx@pali>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To += Mani

* He is now supposed to watch for the DW PCIe drivers.

On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> Hello, I have just one question. What do you want to do with pci-mvebu
> driver? It is already marked as broken for 3 kernel releases and I do
> not see any progress from anybody (and you rejected my fixes). How long
> do you want it to have marked as broken?


