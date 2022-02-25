Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02F4C502F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 21:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiBYUzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 15:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiBYUzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 15:55:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CC1E4819
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 12:55:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so2403392wmp.5
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=pYyf/gcMNcPjka309u1PxjANqEWr6UweGBj6NdzSXajcH7FlPZfUn606XZWXsVG1YW
         BLcYWwpE/3Zb9Zz6bMQobspEjRcGlO8s18CaIoE2MmfibShwFGSTZ0l4m0myzX5YS8kR
         zBdK6POneFfRSIFQRQ0Ye2V4rQ76iEI4f87CHBps9I79/zKeDRnHIZKKZjoZDQzsxNbV
         3iXKdDO5fQJPNLi4di59CS3GiCjD66L3OB+5F6+IQr1xcbaJoXflSajMIgkn+3uCnSN2
         eQAASXxst7nCu7xnaGma5pWD4YmX+q8SVjTBk29NLaIsPYNzhjRkmn+FAso0Ey6IZvn6
         P2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=2asjLtAeJoQgTbLfGUUwCkD5ma2VILuhA325/u/EkK18oshQcuLBtRzd1JPIPlgJZp
         o9KZAeKMkr6Ma4iojDxkllzY/zTbU4IsVGFHd8V0OgJBFKqT1f3Ii73vDrCBjx2IzDKx
         KM3y90JXtbIv8ZcInEPA5LBn8U+Gd0nMeW5X+3aErbOGJS87XFCeYWJ8QjbTQKFj39+R
         W5Vvpuumv2R+8dPQwhKOLjkHj3qqiJCIQfNXxZoeUsshNNOjIbkVw3+sYfjwb7vfpAPW
         N0MlkXIvw86wYGcSNMomAKHRgkjhU2EYu4nC8/UiTP2hEaXDk0PqtpExj+6B8/mfavvR
         nxug==
X-Gm-Message-State: AOAM531bYv6T8pmOO1vxJEfuPE9ljYlfYju4zVqKsCtXqayzaejtQAFP
        rZbL0VfM8qCEKBR+sXyYiac=
X-Google-Smtp-Source: ABdhPJy63t2NaOXDAEdd3nq/hMqt3mwNb/NY8AQOyF90Ic+XBVo2tQQkLc63Vm/O2Sq9Rl6xLfuuqw==
X-Received: by 2002:a05:600c:4343:b0:381:3fba:4fcf with SMTP id r3-20020a05600c434300b003813fba4fcfmr2683486wme.122.1645822506002;
        Fri, 25 Feb 2022 12:55:06 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b001e75916a7c2sm3216523wrt.84.2022.02.25.12.55.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 25 Feb 2022 12:55:05 -0800 (PST)
Message-ID: <62194229.1c69fb81.85460.b9d7@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <borealex766@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Sat, 26 Feb 2022 00:54:57 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com
