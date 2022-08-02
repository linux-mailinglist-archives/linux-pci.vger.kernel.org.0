Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A17587BA7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiHBLdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiHBLdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 07:33:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3774D169;
        Tue,  2 Aug 2022 04:33:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso18177209pjr.2;
        Tue, 02 Aug 2022 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OHpxFokX920XOnwkMxfB9CAAUPf2pEttxrq73aPUfwg=;
        b=TR+KZ687xlxeL7Us1osYLQcbJmjHFeFtJW6JasrwzfHc3ZH78P1VlCyldkQl7zgMLy
         ToPFQ3ipHuJ7QQHoahQTHU5cWhPARZ1SsF1xUvMQqzoDkhOPSzrBmgHlnesDR8/akR5p
         +mtah5U9Xpre8ec0h+ojRjlDjLbhB0tCaOtZZM3j2QBf2iyMPLJNredGTX5kD9RsoEug
         aybnNlGQr4oF9yaqmeCPBT4LN/tW6XenM3iGtR/kORoK9OpIASSsnMAXn5Ru0M1xuYcl
         wqSWz2J847sZoaleApLZ1HphiMzCReucbcLw4Fu+Wkfl11cDCO88x4tsAbqWOv3hcfp3
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OHpxFokX920XOnwkMxfB9CAAUPf2pEttxrq73aPUfwg=;
        b=PqYNjVKelFVNzG+aTBVAZipnxp2CuAZ39Id6mLgCSv1xXGq9DZGQCMbsOmBTatGQtA
         qm1N6gddJOtCcbQIw+uLsx44I6dLc8A/wlEaj6odGU8VR66x3n7dK7f+KLIQU2o6oQhm
         h1YZj8+Y1JTkY9RH5mZISnxubPfbntuZa4oxQ9kbqqr4NjQyIhWFBHa1NArlvtcBC+vI
         ocwLCvTD+RWElSpNjOOxPQFpFDMhZOdHlUqIn76NzFbQ1K1ggw5jEq0rBZtWns0zcGz/
         zhe3PL6yliBX9pTKWeQXlxNkeRr0c6M57dsvDXDMcciqfzpaMxFH+2blDUihGP4XAZL5
         ssTw==
X-Gm-Message-State: ACgBeo0UCjTu/kQtJ6Ua58uiv4HayOsn4K8jRQ/qkfd9JcivNT0i0xpp
        0MvTMxrkBgS6vADFRIa94DvJc7E6l/lDyMRvdqY=
X-Google-Smtp-Source: AA6agR62S7sB+RY924boipu5bK5CMwb6VMEmt5c/qUQlI35C+U5LQAoWAwf1rotNC920mX0heJN1DM2OBsKXfdD+aHg=
X-Received: by 2002:a17:90a:d3d8:b0:1f2:2cd:a1ca with SMTP id
 d24-20020a17090ad3d800b001f202cda1camr24947017pjw.135.1659439981626; Tue, 02
 Aug 2022 04:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <YuenvTPwQj022P13@kili> <YueoPDOseM1BGiXD@kili>
 <CAFqt6zaLY3_DKC-=NJSrgzePrDS-q-dfUQxrN9puBf0+qVNfUg@mail.gmail.com>
 <20220802110133.GG3460@kadam> <20220802112011.GH3460@kadam>
In-Reply-To: <20220802112011.GH3460@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 2 Aug 2022 17:02:49 +0530
Message-ID: <CAFqt6zZCwo9XhAUuBdnCqqh-NTZahHQqMFibG0LSV===8uL=dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: EPF: Tidy up some bounds checks
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 2, 2022 at 4:50 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Aug 02, 2022 at 02:01:33PM +0300, Dan Carpenter wrote:
> > It's the same in English, the variable comes first.  "If twelve foot
> > is greater than the height of the tree then blah blah" vs "if the tree
> > is less than twelve foot blah blah".
>
> Hehe...  I had a brief momement of panic where I worried that these
> statements might not be equivalent.  The backwards if is so confusing.

hehe.. Sorry I read the condition wrong with an example value at first.

Acked-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

>
> regards,
> dan carpenter
