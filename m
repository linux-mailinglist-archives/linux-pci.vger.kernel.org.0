Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD476DF07A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDLJeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDLJeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 05:34:00 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECD90
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:33:59 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54c0c86a436so327645497b3.6
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681292038; x=1683884038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwL/3VMepjx9Z6q8O/t/WMg5rFUEyIyuski0j0+TDZk=;
        b=UIUdMhlb6l1DdqbK6rwBKhK4k4SyDW8DStl4fJIlRpmFsWXZ7jKBjrJpUBswp34c7W
         4LhI8hP9gEwxbP2FRyDdkO4eZCDoc9h8/QumxU1wWIdbanKTgNNvyMmd/+fxdS1NloJ3
         k10b3YvwYrxbIkAVKzY4Fbx0Bzt4CgIDjjv7nd+/9St++CUnfFd0dVst9efwPQial6c5
         X1TD8BAawnalWWEGyGyZYTz3jq5ee4ZnlFangsbUtxTlPMrBDgvuOZay84/M7A94DfpM
         ZkC89+YAs/9jhC5yYKWx2b82yheWHWwgFxl8t5Evcjp08vJO4qE0kzBEDoMAQ1s5XicG
         5l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292038; x=1683884038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwL/3VMepjx9Z6q8O/t/WMg5rFUEyIyuski0j0+TDZk=;
        b=ZoXP4fumdHNynEBdU25v6QwelY6PSNhgrDzOCi6qPSfXkL2lWmUPzxPsVL3zzxmbi3
         B33xQrlAZY1u6bTcsZMkNC+n2Q0V6yXbD8QqTXjQJxMVoRbeJT+yGmasq+BbYYZGmLoZ
         eU/mapvodgZGAjE4OtjlbZoytenvs5q3m2pVoTzQ2KOssBZLUPvHJv0kUPUhLgr5kmdM
         tRlPa9XzNnMWCoxQRnuK+00U9Nx7Sq5uve8mRPp2zQ7tDwnPHFEvhECwFEtxdE2PAsqD
         iercpWqJU2+aeNXQzeTG7bzug+889MVf2gpFFbJM119w7ojby7WA0XPJQ6B0SYg6HKVQ
         SyLA==
X-Gm-Message-State: AAQBX9dCaMUShsKFR4YkRvNkyW7dy3s3+U+Vq8oSVjwU5mL+EvYUghD6
        mApHems6nH9nwrWvitlVVb7OtDWJOZLa2j0TG7LqBQ==
X-Google-Smtp-Source: AKy350b4lXnxJMahbQP29fnZ/K5p/FQvT9/NlNdKGjbcnVD8m4440VDP3F56HTDLXt/hlQHt8oHyRg4ToVodBs0eJDE=
X-Received: by 2002:a81:c608:0:b0:54f:93c0:4ba8 with SMTP id
 l8-20020a81c608000000b0054f93c04ba8mr803020ywi.2.1681292038149; Wed, 12 Apr
 2023 02:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230412093301.3656266-1-ajayagarwal@google.com>
In-Reply-To: <20230412093301.3656266-1-ajayagarwal@google.com>
From:   Ajay Agarwal <ajayagarwal@google.com>
Date:   Wed, 12 Apr 2023 15:03:47 +0530
Message-ID: <CAHMEbQ8MFRNvKk8h9BFSLK=w_03Q2Z70sVxsxvNL6d_cQ+v-zA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASPM: aspm_disable/default/support state handling fixes
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please ignore this email. It was sent by mistake.

On Wed, Apr 12, 2023 at 3:03=E2=80=AFPM Ajay Agarwal <ajayagarwal@google.co=
m> wrote:
>
> On going through the aspm driver, I found some potential bugs in
> the way the aspm_disable, aspm_default and aspm_support states
> are being handled by the driver.
>
> I intend to fix these bugs.
>
> Ajay Agarwal (3):
>   PCI/ASPM: Disable ASPM_STATE_L1 only when class driver disables L1
>     ASPM
>   PCI/ASPM: Set ASPM_STATE_L1 when class driver enables L1ss
>   PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
>
>  drivers/pci/pcie/aspm.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> --
> 2.40.0.577.gac1e443424-goog
>
