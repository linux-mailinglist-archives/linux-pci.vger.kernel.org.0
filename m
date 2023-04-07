Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BF6DAC91
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbjDGMTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjDGMTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 08:19:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33368976F
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 05:19:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y7so10963628ljp.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Apr 2023 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680869939; x=1683461939;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=UVVIJKsnMck+Lq5lIyqGG98FIurrnJx27BQ0nOS+B6b1jaBIVBGCI18v6f4+Zzg8Vm
         QTFmprJZqcHc+32Gv3vBTLX0puKofzvYSiuMr6GAKrOta7ZqAzrXREHGDtxr62qm+Wv8
         x9dKl2sVC8ssHzp4k84WTqvmriyuIfbpFtmrmdiXp8rGu7JtswtG/IghIdn+iw/A3G/0
         EqkEJyJphjXkr2ueW5Sar9Vl/n5c0JRPAd0qKHsP/+CZWiJgULtlz8y8inVsNsOgM93K
         hYrI+DehJapVpO484RIrcOsRz6ypCiQajCyfPDnelLKKzThBnC7TCpiLfmLxD16vWQ/g
         YwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680869939; x=1683461939;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=ydBxEfji62uwMXJnrqgNCkUch0fkQtdl6WA5/nTLsbBxKjHwdtWmO6zv53AFNLYmoz
         0nzAkIVAqbeCp5lgkNwvCn97gnK78ui+D4mR/UA/iiOIvWfs6QAsZfwBYLaB1EI2oP86
         4GTOet9YJRY9h5urW3V6O1dXK2h9jJwOHQECINQzXsLcTWSaF7KxEbVF2oR5zGjBNVos
         aW89Ue28FIzwsYLZLItFh7Yb3CoD4zF7nVch/yRRn+VYkDOCFdr4i7tP4cqdm+ydy+5t
         V7gZpj6HwvDyqSlPt5WgbAgqdmH6rsHUyJoqNQtkkjxIoZmP1R4zvNASrAhSx7ZzbKzG
         x1nA==
X-Gm-Message-State: AAQBX9c5DwfSlFh4vtNH7j+xkQMn49hpZqs5bM/xOBOn+5IxoZAne5GS
        qU9Hi/ibU6b6vBzQ8VctQle3em1+yzPRsCReooo=
X-Google-Smtp-Source: AKy350bENQDL0dixTzwSxe3/RM/z23K2+eE/PMsZSSqsbHfy9WJSit+LZa3mHS1fa9Po1fz2XBkien+gqxEvU7+X5Pw=
X-Received: by 2002:a2e:9195:0:b0:298:b375:ace9 with SMTP id
 f21-20020a2e9195000000b00298b375ace9mr532673ljg.9.1680869939136; Fri, 07 Apr
 2023 05:18:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6257:0:b0:224:2f90:549e with HTTP; Fri, 7 Apr 2023
 05:18:58 -0700 (PDT)
Reply-To: saguadshj564@gmail.com
From:   MS NADAGE LASSOU <pjihin96@gmail.com>
Date:   Fri, 7 Apr 2023 13:18:58 +0100
Message-ID: <CADXuY1e914AYteqYfNE0ndn16vpPqGtcQB5w0fn9ZjA8HVpmKQ@mail.gmail.com>
Subject: PLEASE REPLY BACK URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings.

I am Ms Nadage Lassou,I have something important to discuss with you.
i will send you the details once i hear from you.
Thanks,
Ms Nadage Lassou
