Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8645BF161
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiITXlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 19:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiITXlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 19:41:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CD79A5A
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 16:38:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c9so5668512ybf.5
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=fXUvxxJHDDhv3FmGidycr8OCKz5uNhwCrWMeT8IPWCs=;
        b=QyrfbE51T/dZRPZaRPdPLGQxbMEzX2jsUiq2k3oHLPYPgzUi0KsbFsNkI0ofJ45giJ
         fYUqflMeVMgd3wsMV2gFlNjC7by/7x1sss0cpOp7BQLfa3KaObzGZSX1jYzErID7mOem
         LY/vQTTcrVjdb4/X58XzZvIZaWSBwS0us+DzzwGz2sEPi+O4NrVmOiByuKf7l5JaBmkp
         cDMlZoWiFk9PA0tx3JSTbGTCHi6CmgtMDjW7cIcaxfpzZ0pPb0hZWOwjjZLqTeerkOzU
         r6nu3J3u+f9CSlQPFXAbz+W+VtssmHWJzfOiBlikjV2VCMdOeUhnX27UxJ9fNU7yUu20
         3l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fXUvxxJHDDhv3FmGidycr8OCKz5uNhwCrWMeT8IPWCs=;
        b=uO7KUIrCQdjXBJ2+Mludx3gR4EA7QxKW6HfMhMkYpDcdbGGmvXO4C98CQy3G/7541r
         e9J8OrRybkiqjr7k0gq7K1YtLQ7NQOgiXJl7nW55zxxwh/s37OmgGGXEGu/3dmzZwV3N
         kspeVkG09oFBXe7odXssMAT4mOE4xHnXF48Hxw1oEDSDxCvLzggceNXPSfUYvgroRwwo
         /cSdJq+xhAN8EeMhnHALRH4qcRQOUrBW3ngc0HxrL3O4MEGkCreK/BQEUvPBO3yrVB+/
         J4jhzWwVaLLpbUw3Iwl9/kJlfeynr/gCiqP1lTZCyMUAI2xsAOCqApxHxwxezrKWU10Z
         KwEw==
X-Gm-Message-State: ACrzQf349a8c4FS2Ffg4naSwK2UQKwIt/qh1nTjFGGD1UqeYCWsCpK0G
        Cgw6sDzTjhenoYMW9yDycx9kadzXtgWZFx9HY+E=
X-Google-Smtp-Source: AMsMyM7pNrnmWUxTFOx7UoJh6+OkCFM110lhFKevR1+vbfm1cZijGANLiuvE+lcVAyT22j8w9rxzoTiFp4+qAy3HFuo=
X-Received: by 2002:a25:c005:0:b0:6af:c67e:9032 with SMTP id
 c5-20020a25c005000000b006afc67e9032mr22577108ybf.557.1663717110725; Tue, 20
 Sep 2022 16:38:30 -0700 (PDT)
MIME-Version: 1.0
Sender: azeyidouaboubakar@gmail.com
Received: by 2002:a05:7000:3dcf:b0:3b7:b4cd:e8dd with HTTP; Tue, 20 Sep 2022
 16:38:30 -0700 (PDT)
From:   "Capt. Katie" <katiehiggins302@gmail.com>
Date:   Tue, 20 Sep 2022 23:38:30 +0000
X-Google-Sender-Auth: vODUt_nu86-MItUpeMZOKsGV4vY
Message-ID: <CAC=5C6ALBnkec=6C-Wqjzq+fxSSpzJrw9Tu8i3Pkxrz_FTvRvw@mail.gmail.com>
Subject: RE:HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hallo,

Mottok du min forrige melding? Jeg kontaktet deg f=C3=B8r, men meldingen
mislyktes, s=C3=A5 jeg bestemte meg for =C3=A5 skrive igjen. Vennligst bekr=
eft
om du mottar dette slik at jeg kan fortsette,

Venter p=C3=A5 din respons.

Hilsen
Kaptein Katie
