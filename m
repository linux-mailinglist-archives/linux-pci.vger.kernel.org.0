Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE757D1EE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiGUQte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiGUQtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 12:49:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995F88F3F
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 09:49:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k25-20020a056830169900b0061c6f68f451so1535406otr.9
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bWmfbqGwjvBFnzfbCf+Z/ISVQu187ftF30a3EQDlMtM=;
        b=p1JfBfy3gZH/p8TTDPmk4eCDp33z9Df7FYoGrW8x7j0X1+MA4qIqiXnEwrz0nufek5
         FJ2W3dB81EFXpJiXAx7u5XnKwOKNGMO9ft96dD2TdvJZsdWBPlw0Megc+BX2nZvYAqcz
         B4bZSI3IbzosIsMz3c2cJcj6FZwzhPH+sBqcgyAIKOX4VvAjV8Ce3Q6tNoEZQlMKWYa5
         b0XI6vaoiseYdjnNLfwPTnAz4JF5CB5f/Eab5MrxBmBidg2KnXqnLTwQoLbSssRtOhVi
         +2sILDlLPFB9eLGxVA3+6tciKC+xDLrtEZTe5cMF5K2xSuIq7sdkwRii9DU3eUHVv8yr
         xrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=bWmfbqGwjvBFnzfbCf+Z/ISVQu187ftF30a3EQDlMtM=;
        b=V8HWpVt8YChOHkO6J1P7QhrSUBM2kZqV4rgQmUXIiG2x3b/ppGOHbAqGk+5BH3ZGyu
         FHOto8Ydq/P1yZ1fVRUT+gIT/9CKRngff/F5z2AkUd3ydKrcysKfPuDGT8DPjj+qoRti
         JUoXAEan4hY9gu7uvCDQAQ+95itQ9X3VF+gBAoYoJmlMU0exeh888kh0NEAnF7n/aclF
         wpGZaER2S2Pae8DwuwUqUbF+/T2NBXmcC/mBLNrAEvw7O6307eHiAPHpk0CJNCgkmW9U
         WXR6T0FsnLSOEYll0qA1H84pB+Si1Dvpoj5LQfVNLJsfUzaMpCJLxU4AGY0sZMHx8wZo
         JC7w==
X-Gm-Message-State: AJIora9bVcsL30OTyTu/IJQ5Mf57N+g8nZ2ahmD3O/dUwRsWwvbdnq25
        X8spzlmMzvT5KyARjySEjLugmCPbi6P/ofi4awE=
X-Google-Smtp-Source: AGRyM1sZJAgkoZ36ubKrW4r/akDg+MV9SI4XfibLS2yKMvlX4YWXIMKW6fKVH6d+uU6Gj08PfV7Fq+IxwsQrFb9GyJk=
X-Received: by 2002:a9d:4707:0:b0:61c:c25b:eb92 with SMTP id
 a7-20020a9d4707000000b0061cc25beb92mr2807238otf.173.1658422170858; Thu, 21
 Jul 2022 09:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:408e:0:0:0:0 with HTTP; Thu, 21 Jul 2022 09:49:30
 -0700 (PDT)
Reply-To: olsonfinancial.de@gmail.com
From:   OLSON FINANCIAL GROUP <ai9432929@gmail.com>
Date:   Thu, 21 Jul 2022 09:49:30 -0700
Message-ID: <CAGGiv6dsSX1_OUwro3XpjvNB5WWKhV3Q4P4xFEL5PMGfKoag7Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=20
Guten Tag,
Ben=C3=B6tigen Sie dringend einen Kredit, um ein Haus zu kaufen? oder
brauchen Sie ein Gesch=C3=A4fts- oder Privatdarlehen investieren? ein neues
Gesch=C3=A4ft gr=C3=BCnden, Rechnungen bezahlen? Zahlen Sie uns Installatio=
nen
zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen. Wir bieten
Privatpersonen und Unternehmen Kredite an. Wir bieten zuverl=C3=A4ssige
Kredite zu einem sehr niedrigen Zinssatz von 2 %. F=C3=BCr mehr
Informationen
mailen Sie uns an: olsonfinancial.de@gmail.com......
