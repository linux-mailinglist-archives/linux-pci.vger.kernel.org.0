Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0926FDBE4
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjEJKtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbjEJKtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 06:49:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DB3C3F;
        Wed, 10 May 2023 03:49:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so6659280f8f.2;
        Wed, 10 May 2023 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683715788; x=1686307788;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkS+JtL/4x2F2nhP046jklHsvY5QYHCKk9mJ3UxHXR4=;
        b=KDLlmdqCNLFvEUJVcsjXC40vvrMwRIfh1bKgaRqK8L6r+8TNiuAECFdNkAUFAjKWA/
         4AkPbPyIcFMFRIFanm9dm+PXJbpbeUowPqSxqQVEGuUKogn9mUzHvHyaOPU/GMXDhsPD
         +gfpIpqIsFtFy62LZFlThJw4k2VrMBUJqBvdWxF5UVwmZjH2zqGbRyNjjxMlB9x+QcwM
         kq7B4B4Vk6Ssh1BZmU99g3neiTAeVM3ED0PylGU6hJaamGcKcIhQaJ5XkUEUda7HuokW
         F4y+a8qjv+OXiYpvpdJVm3XEqUYGTV15IqEUTjA/6xLjiMeUTdYJ1dyGT6krZaFp9dUC
         yQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683715788; x=1686307788;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rkS+JtL/4x2F2nhP046jklHsvY5QYHCKk9mJ3UxHXR4=;
        b=bgMZq44K4yBMUchIiXXCEU3LQgEDnpWyEZDECFwNPaTW5T+W9OlAWvd9uZZ0O1QY87
         xUqENA5L1wcPe5PhsSLWWSr5Ly2CfBej6wcab08e2Hmji7Mo1GfWb/sYPdoltMgXrAug
         dS5LRRseHHPx0WgMpLVHuXZDgcu/h1fYD9MnP6vYHhEqfxf8qvaWw0PW+9iMKOudueC/
         EDA1PJrTXI8CebYJ2Xwm9iZonVjb9nUI6mTYgFE8DP+52cyrNZQFawaAr13xj3TuCyTO
         4wP2+ZqZkyyScNoA8tUaWgYWVOrnNUN99lN5LAOamwdF31efLCKkGcFKoILMZ6Ofsi0r
         HsVA==
X-Gm-Message-State: AC+VfDwTI+hdTbxpFLEPFMYPDIGpVNKs66xDIvG+TEy1RbsqVS41gyB3
        iON+MHBMC/kVRJuzS7TQwu0=
X-Google-Smtp-Source: ACHHUZ4JGmvsYsJs9otSXwm3s6rqmGtYaWe+Fx7RUYPcU7zchmQo743avEngeWoWjBLKUoQtZXMAWw==
X-Received: by 2002:a05:6000:1191:b0:306:462a:b78d with SMTP id g17-20020a056000119100b00306462ab78dmr10354606wrx.53.1683715787842;
        Wed, 10 May 2023 03:49:47 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id o5-20020adfeac5000000b003065f2a8a63sm16871648wrn.27.2023.05.10.03.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:49:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 May 2023 12:49:45 +0200
Message-Id: <CSIJFLM445UI.1W405TTWNZYYU@vincent-arch>
To:     "Greg KH" <greg@kroah.com>
Cc:     <linux-pci@vger.kernel.org>, <robh@kernel.org>, <heiko@sntech.de>,
        <kw@linux.com>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.15.1
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
 <2023051014-foe-multiply-ffff@gregkh>
In-Reply-To: <2023051014-foe-multiply-ffff@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -38,6 +38,10 @@
> >  #include "../pci.h"
> >  #include "pcie-rockchip.h"
> >
> > +/* bus_scan_delay - module parameter to override the
> > + * device tree value, which is 0 by default. */
> > +static int bus_scan_delay =3D -1;
>
> Please do not add new module parameters, this is not the 1990's anymore.
> We have per-device settings everywhere, this makes that impossible.
> Just use a DT value, if it is wrong, then fix the DT value!  No need to
> have the kernel override it, that's not what DT files are for.

Thanks!

Cheers!

Vincent.
