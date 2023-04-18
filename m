Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F86E57E3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 05:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDRDjE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 23:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjDRDi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 23:38:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1264234;
        Mon, 17 Apr 2023 20:38:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-24762b39b0dso332258a91.1;
        Mon, 17 Apr 2023 20:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681789137; x=1684381137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU3Z4GZXNJ9Nxt+fFyhf38mM46YNIXr79s9+LQwYmzY=;
        b=iu2/kgMzWe65xMFI2BNSVsiyepJbUsnBNgWT5f3Xzu3N1Jye7glIBkkJ64n5WVHFlY
         btl7PbiBR5jddkf+o3x6lc9ZcP5+L/kxonWw8oOznFJjVjK6z/uT9GCW9kR/ywLX9Zci
         tsfnfCf086KEv5llGCKQyUO2rurcrt0XmhRbP6A+XuDUMVrCua0JFLJ7/HGAjZivub/I
         fAEFvZGGC9ARyrY/lUsLgpAyMS/UJxXKSrXyb9CzkudSKHpjkqYAri+rHZyR3TsreKNw
         20fqhLInBCx9QFb13DdQ0RMk9P8ODcIdJ67dqpaspihEETy+4JdHkfA163rUdmN/wtgB
         +drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681789137; x=1684381137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU3Z4GZXNJ9Nxt+fFyhf38mM46YNIXr79s9+LQwYmzY=;
        b=U8t3+lqL9iiP5j/qNhXTKF+srXY3l3zg2617KTEX2alETepD1C5CseIM5RL6E69GaZ
         rVTpvWc4LcuwPmJa05hXxZV4dPf3Pl98wANiEIILh2GrRXu3houryo+L/0k9NEt+FRwX
         5fucMAO4JaNISTiFOo0F0FeyxFfRc5w6iE30bSsNf7XhlZAYbUFs2k2b7hpqCpuekW7Z
         Y5OuSjLrtpyBkFJczDA3IPUfd+Cs/J4jgFxpiyEjUinzxinnEqRLEu+6fOUNaxF7M52x
         EnRbb92Gs5YUJu8P3OxJsxFhF7MwJDkr0p8xcuEb8H6eVR5fbzfIKOnfsGGPnu4yYTI4
         XtWQ==
X-Gm-Message-State: AAQBX9cnrZ/Kk4xFYb/Cr7IoJAMLOQujqiDG7Vpc1VcALFTV36tTNxNi
        kI8HIEX83BKe/UrN8r41U6clY/fZJvMt8q3rQuQ=
X-Google-Smtp-Source: AKy350Z4l9kl9s53GEMDfj7Ao65Cv6YwlvdArmRQ3i7LWSgRQAjWT5xdGynYjnCrfhS91g++NQmsthB/wWZFZx1ncJU=
X-Received: by 2002:a17:90b:1e04:b0:247:25d6:b849 with SMTP id
 pg4-20020a17090b1e0400b0024725d6b849mr736053pjb.8.1681789137088; Mon, 17 Apr
 2023 20:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEm4hYU4Z+LzhC8PT3OTePMeYjDa-QZEfXMkZqODnSY5i+_hrQ@mail.gmail.com>
 <20230417214459.GA53460@bhelgaas>
In-Reply-To: <20230417214459.GA53460@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Tue, 18 Apr 2023 11:40:08 +0800
Message-ID: <CAEm4hYUYt0yGB0EGu9ZOX0j1t2qeWCz9WcVEVXkTbh5gjQ2YKQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 5:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Apr 17, 2023 at 05:15:00PM +0800, Xinghui Li wrote:
> > Friendly ping~
>
> We had quite a bit of discussion that I don't see reflected in the
> latest patch, so we're waiting on a v5 patch that addresses the
> comments.
>
Got it.
I will send the next version asap.

Thanks~
