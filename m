Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0786D3875
	for <lists+linux-pci@lfdr.de>; Sun,  2 Apr 2023 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDBOeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Apr 2023 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDBOea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2023 10:34:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56337DA;
        Sun,  2 Apr 2023 07:34:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z10so16010646pgr.8;
        Sun, 02 Apr 2023 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680446052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoKAUsS1+OPv2yaj0HT7KaFR2MH6Yyn+hzIBLI7xgeI=;
        b=ILEvwS91rgkWPiWhD7zih4rFjl7XNbDo2TWQbTQmLiSCIRjv76s9QPGoQlsN043vzN
         yBk6Y2LTK6XhR/DZbwerQlmxtwoJMHabnz0iK2D/M5mc+CrRIQu5bw4kif3w/29NBgFB
         pQo4K/fce8HBMfRPVNUOJ8p0MOYg+DuF2eam+iD9PbmBYo/qe0xqHdzKh8SbvXKXSIf3
         g3YRkSHCV9F65Cyb3psaAYUq98SzfwGMlSbYu8O2YfHFBKJXzRCGbefzIfMm9pgNBnip
         vE6MX1JqDKSopsTjGPu3sWDthzudvdLVTgr1w3M517g7uoeEM8mu1AUAhIUnOVdGwmh6
         2c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680446052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoKAUsS1+OPv2yaj0HT7KaFR2MH6Yyn+hzIBLI7xgeI=;
        b=jzW5sIvm2vNB3A9Rd/vaEp6coN+wIhTc93GamwME3zNz/lggV3nzP8T8ZMLdwxkeAe
         4clsfraoEWG2smsnhvUfxLx8exL5mm+GrvrX6xOqyK1QfudTQpSq0pNekIws59A9zT1/
         cs4d8MDn5lkDrPheJ/p7iiT5winbvmSUE7eFrpjr7y7b6S47ABuGrEM7kIrm7JWD98kK
         4FDeRKjH4WBjl8QJZlLgcwJt5Q9Mlphg1WRv4UYeK+tWwL1CiH4+Pc/FyutbYiPy0bgr
         DLN0zoATGcyTemwrz7rNqZ8oXe5jgKKFnjh53kku9/YjmHEJyPXY7Of2PYWiQVJlCyrG
         33Xw==
X-Gm-Message-State: AAQBX9cJ8bvIAWKYjHnQJVbDfIsy4U1oiCvbnzegZRqCJgB3ob5Gdq8y
        7qPkiqsFjHYJ2jLR167oY5zO/i28UtCb9Qsx1zw=
X-Google-Smtp-Source: AKy350YhREvdHCLaIM3E+GIkX8AqtxKuIacMDNv7RPZaGmpahRKm1+Oas+9LD694s7AeGD6aep3xqXszgN6JcVG8At4=
X-Received: by 2002:a63:40c1:0:b0:4fd:5105:eb93 with SMTP id
 n184-20020a6340c1000000b004fd5105eb93mr8830444pga.3.1680446051785; Sun, 02
 Apr 2023 07:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230329163107.GA3061927@bhelgaas> <0603c75d-82d3-01d5-ffe7-b648c1f02f0e@linux.intel.com>
In-Reply-To: <0603c75d-82d3-01d5-ffe7-b648c1f02f0e@linux.intel.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Sun, 2 Apr 2023 22:34:00 +0800
Message-ID: <CAEm4hYXwGuuZiKb9psXPyau+zKq-w=VboJEuYbS0FbY-iT-EmA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 2:49=E2=80=AFPM Patel, Nirmal
<nirmal.patel@linux.intel.com> wrote:
>
> How about adding a boolean flag by comparing user input for module
> parameter msi_remap? and add the flag at
>
>     - if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || msi_flag
>         || offset[0] || offset[1])
>
> Correct if I am wrong, but in this way we can cover all the cases.
> If user adds msi_remap=3Don, msi_flag=3Dtrue and enables remapping.
> If user adds msi_remap=3Doff, msi_flag=3Dfalse and disables remapping.
> If user doesn't add anything, msi_flag=3Dfalse and decision will be
> made same as current implementation. This will cover guest OS case
> as well.
>
Sorry, I don't quite get your point. How is msi_flag assigned?
Do you mean when msi_remap=3Dno, the msi_flag is assigned as true?
And msi_remap=3Doff, the msi_flag is assigned as false?

Thanks~
