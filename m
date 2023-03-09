Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3F6B242E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCIMay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 07:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIMax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 07:30:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA32EBD95;
        Thu,  9 Mar 2023 04:30:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id n5so1347055pfv.11;
        Thu, 09 Mar 2023 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678365052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/YKLwIekasb3iNzenKRi5ToiMiYuj1/8XmWnpw4kA4=;
        b=oYtbh53Nws0V62q58a8/HBv3amztQeFSxuzfW4KVgxU+3Cf8bo3uEKN8XIBZaS7Nyr
         b7WVl3PsuRNXGC/kReZAjfAZ0+YoQJgNTBmD2DG7FLiEc6MYscAcjA+c++ReodwcTv/V
         uHlvZSPv9CTuPl/Q6BNnVGz7sjDspVzDl4LUYVpNUggHsDwLcIJ2uYeQrWN//ULgFIod
         dSLoNekl2sgfzK7nm8ZCEsN/rqNm3/wiZmUpHfznelYKztyjAUpx1U1ISeWwrCh4lIu5
         VD2uQVN8Txvjm0kwjsJqFsPbP5MJ2IDOqf/6rzU/I9NO+SgT6lO/pS0L5VtPlZTLlEXv
         lhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678365052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/YKLwIekasb3iNzenKRi5ToiMiYuj1/8XmWnpw4kA4=;
        b=1CMwpxO1Te2TajUFCvJzmJLSAd6otmgrytzpO//oGFp2wm7utNZVpkdVYaBIjSkwES
         yxSlS6rTnx003LcqkBrRsO1Y6iu39om0yITMqT9+IoVHbmRfi+mtcRjkq/wIlN8O1W97
         YeFXolfV3WBqLXcp+1TbKOQNv3PCaCyajv5n/80gnbsmuvLRp1lP9Bx0Nl5xvHNeqZ/4
         NNmLGBv9nmedDkOEXtN8YFTgl3FDVNamtSvDYCmIefoygcH0aNVfLFquUOj2ctkb5JBQ
         tzTf3yy6R9FZ/fwu5r71AFpZmQLLueg6dCk7TL0zhJiyInTlkG2zgAxz/L6Cw16HZxxG
         XMPQ==
X-Gm-Message-State: AO0yUKUHm6auSVyZFeQ0acLkcKO+MILzotugV1UzwOyWwBgK5EcrE02E
        5RHZwmuyult9zFgtXwm6FOcVOuH//a/wCPNSZog=
X-Google-Smtp-Source: AK7set+bF+2WjydfqS8damR0uvGIFYmRkD232bgysbuRPfNdJQHy+OaISq+L4QxLrt2G5FgSz0o7LR1V6CImsFcqjFo=
X-Received: by 2002:a62:f807:0:b0:5a9:d579:6902 with SMTP id
 d7-20020a62f807000000b005a9d5796902mr8993099pfh.0.1678365052477; Thu, 09 Mar
 2023 04:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20230307083559.2379758-1-korantwork@gmail.com> <20230308225718.GA1054189@bhelgaas>
In-Reply-To: <20230308225718.GA1054189@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Thu, 9 Mar 2023 20:31:55 +0800
Message-ID: <CAEm4hYXeNR5by3ZX9V1y=ebOFcQ+JD1AgHGmFiJ3UE3xBJvRCw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI:vmd: add the module param to adjust msi mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B 06:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Please adjust the subject line to match previous history, e.g.,
>
>   PCI: vmd: Add ... MSI ...
>
OK. I will fix it. Sorry for ignoring the subject format.

> > In the legacy, the vmd msi-mode can only be adjusted by configing
> > vmd_ids table.This patch adds another way to adjust msi mode by
> > adjusting module param, which allow users easier to adjust the vmd
> > according to the I/O scenario without rebuilding driver.There are two
> > params could be recognized: on, off. The default param is "NULL",
> > the goal is not to affect the existing settings of the device.
>
> Please add a space after the period that ends each sentence.
> Capitalize "MSI" to match usage in spec.
>
Sorry for the format issue. I neglected them. My bad~

> > Signed-off-by: Xinghui Li <korantli@tencent.com>
> > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>
> I didn't see a response from Nirmal on the mailing list with the
> Reviewed-by.  I think it's better if Nirmal responds to the patch
> directly on the mailing list with the Reviewed-by, and whoever applies
> the patch can incorporate it.  Otherwise we have no visibility into
> any interaction between you and Nirmal.
>
I pinged Nirmal to reply to this patch, It seems he forgot to cc the
mail list in the previous version's discussion.

> > +/*
> > + * The VMD msi_remap module parameter provides the alternative way
> > + * to adjust msi mode when loading vmd.ko other than vmd_ids table.
> > + * There are two params could be recognized:
> > + *
> > + * 1-off
> > + * 2-on
>
> It looks like your code matches either "on" or "off", not "1" or "2".
>
I will change the comment. It does mislead the reader. I mean the No.1
param is "on" and the No.2 param is "off"

> > + * The default param is "NULL", the goal is not to affect the existing
> > + * settings of the device.
> > + */
> > +char *msi_remap =3D "NULL";
>
> Looks like this should be static?  And using "NULL" (as opposed to
> something like the empty string "") suggests some intrinsic meaning of
> "NULL", but I think there is no intrinsic meaning and the only point
> is that "NULL" doesn't match either "on" or "off".
>
The "static" one is better, I will add it.
Initial parameters with "NULL" just aim to mismatch "on" or "off". Do
you prefer to init it without the default string?
