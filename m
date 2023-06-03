Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B3721107
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFCPwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jun 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCPwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jun 2023 11:52:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2AB3
        for <linux-pci@vger.kernel.org>; Sat,  3 Jun 2023 08:52:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so2383949f8f.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jun 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685807546; x=1688399546;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rAiad/hmwb6WYux+QhU+Qu0aeLsgCRBfVSkMrQS0Wc=;
        b=Zu+c0bmdZeCS7Rn4SdGuX1s5PVoS8syZWup3t1BelnuPinElUAS2/W7t0BYQhXBEDV
         jfMW1GpKioimFHtC+Fk8M9MKlRwz4mrZDd/s6HbnvuNsPtsWvKSI+4AUfu0zT0GBmOLa
         FsEchF5FD4mVfhrFQBe/TcdoRqx4c2+n3sbaQrCVy2W9Nk/0Qpt3DGEeMLWsSF40ktn2
         TM7U+aLCtt1QXjOy4qR+MH68ot5c99guk73IsqcbJ6VxJv49HayKzMROejt4xTGDw02u
         Fx7RcbtEwWSh9cUgYf599T+zglboOQmlRhx+onbTG9hUU6MKtSh3kxKZvCrDUoMVJzPw
         QC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685807546; x=1688399546;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rAiad/hmwb6WYux+QhU+Qu0aeLsgCRBfVSkMrQS0Wc=;
        b=i4sr9XV5MWKuUJFCYr4wma00G1AgraSGX/axjjKzBNloi3fFv8t6dorLaJax0aWDu6
         Ddqtcvs+24SA/Q7RY2pyGsR2kL1ETWoscRg0gC0LUIR6NxShIouFjRqRdE1Qjvg/MMOF
         i/KokCo+BbxfsX3rRi8DJBk9JXtYMQkXRSJh1/+vMhzTrYhM3bHNj6SOl9EUyXaNFyLD
         3kWNwmF68qNeQNxNYZwM79pI/t/7vgVoIgCvBqN0mJQxKsZ6xF2uWiyapDUz6tLH+PMT
         c50hq3srB4sE1X20/reIkcvnRJ6Xup/TEITottTo1lvzSBTws+8YiJ7stizRhYfPYAkL
         wAIA==
X-Gm-Message-State: AC+VfDyX07ppQ8F/FGr0V3M5J8nw52kumxgYr1Ipi0cYVLiyH7csLVQu
        i076vG1zrNv9EsTU4VBhI7Sppg0Ivs0=
X-Google-Smtp-Source: ACHHUZ7uJEwQLUUUAzmpU8BiEgeUhYqguNXviX5MzL7pUySt1jhMnZtzNqBReLOPolz5DNn02soJaQ==
X-Received: by 2002:adf:f30d:0:b0:309:3ae7:e725 with SMTP id i13-20020adff30d000000b003093ae7e725mr2390426wro.12.1685807546395;
        Sat, 03 Jun 2023 08:52:26 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:103:11d0:d554:b5c2:d78:9732])
        by smtp.gmail.com with ESMTPSA id g8-20020adfe408000000b003078a3f3a24sm4816865wrm.114.2023.06.03.08.52.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jun 2023 08:52:25 -0700 (PDT)
From:   Damien Dejean <dam.dejean@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Old Asus doesn't seem to support MSI
Message-Id: <19F46F0C-E9C8-489E-8AA5-2A16E13A6FE9@gmail.com>
Date:   Sat, 3 Jun 2023 17:52:14 +0200
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi linux-pci,

I recently installed Debian with a 5.10 kernel on an old Asus X73SL =
laptop. To be able to boot and use it properly I needed to use =
pci=3Dnomsi, it seems that neither the GeForce9300M or the atheros wifi =
card (both PCI-E) would work with MSI enabled.

I=E2=80=99m suspecting now the chipset does not support MSI at all. =
I=E2=80=99d be happy to contribute the quirks to the kernel if it is the =
case. Could you give me some guidelines to verify this hypothesis ? =
Should I check the ACPI table to see if the information is available ? =
How can I check if MSI is supposed to be supported or not ?

Best regards,
Damien=
