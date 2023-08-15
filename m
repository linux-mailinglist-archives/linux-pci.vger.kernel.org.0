Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505177D1F5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjHOShb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 14:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbjHOShA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 14:37:00 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB110F0;
        Tue, 15 Aug 2023 11:36:58 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79a83720538so2021953241.1;
        Tue, 15 Aug 2023 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124618; x=1692729418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7KTxWY/SpNxrGU9dm0btENkLt9iwa5dBzQCh3C6K7M=;
        b=Y7RGwV9zJ1JaNBX/NOdSnsmeMgh+5eVdWfLmz/TWn29jBFIMadKlRYckLzQdSQKjU4
         S0pMUYhl8q0sqhfMNEmjb2mFviBr9WNge9C7V8q720qLvq4ky2u8OQg6QQpTnTJC13AY
         eUaoy9psXBP+VkoKz1ONLN5IAerkldHhtA6zpEQO/N72+9zVvd5lyxjywzVZUfy4ePT3
         NBdalo6uUuZ1+Kn7KqjQD64/xa65wt3t7kwoIfOHKhwVOHld1DGlKSzVH2Ev9ReoPXvZ
         ISa4eN11ncPj5IkOe/IgUYvd8yN7iMX2BDVIyvO7ND1wzkAoHa3A7VCZjgRji+pC+eiW
         RNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124618; x=1692729418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7KTxWY/SpNxrGU9dm0btENkLt9iwa5dBzQCh3C6K7M=;
        b=ERb7WoWlPD605mn85q6NnA/3Ng+nh/GQ6UepLzfJbASw2dsnQMKamS7r2gftDs70d4
         FXEUxCkyhpzLFp8t2WpfDat8rWwKT8y/qgCHI4/HQymYBUNZ+fuw+j5ycokNTUMr6Wvn
         6C2pLA58uvFEcbpK8pNHzphAcxAfZ67mCKC1e9tN8mwHh0lWTWwNyvm4cSwnOBTCdxlN
         du8K/yaRlkHqpNcni2R9pnS0YTmi+FaitExL28mClHY91Pf1i6VD5eEeLxdcYxK7rQ0d
         b2cShj1JCD58JWx/J0OcYCPp2Ibafsk4iKMTWQE9wZgsgafDxcWqjEH6ztf0eJLTVAbq
         6VDg==
X-Gm-Message-State: AOJu0Yy3ivbJYFbTOAjRRPj+HX9DbvlPdbqQ/LYkFisWbqL4udx4+usc
        +ltV/RvpStxldD6xENhPvsHhm6qP69h7aKvbek8=
X-Google-Smtp-Source: AGHT+IGCTtzDLWNmB+lirbqyOIOhoX/tSlmIKuoh/sCXSjtoepI8BH4M0qzglyDORyoEBqezW7OZSma9B/NtkKwraHs=
X-Received: by 2002:a05:6102:2855:b0:444:bf88:c6d5 with SMTP id
 az21-20020a056102285500b00444bf88c6d5mr13641496vsb.1.1692124617724; Tue, 15
 Aug 2023 11:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
 <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org> <20230812082108.GD9469@wunner.de>
In-Reply-To: <20230812082108.GD9469@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 15 Aug 2023 14:36:31 -0400
Message-ID: <CAKmqyKMRxN68N_29HjEDb2UVU+_RyAc7Z7+iouHP_xq3f_UX0g@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 12, 2023 at 4:21=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Fri, Aug 11, 2023 at 10:03:58AM +0900, Damien Le Moal wrote:
> > On 8/11/23 01:33, Alistair Francis wrote:
> > > Each DOE feature is exposed as a single file. The files are empty and
> > > the information is contained in the file name.
> >
> > s/feature/protocol ?
>
> DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> or "Data Object Type".
>
> PCIe r6.1 (which was published July 24) incorporated that change.
>
> So going forward the term "protocol" is deprecated in the DOE context.
>
> We should use the terms used by the (latest) PCIe Base Spec so that
> users can easily make the connection between the language in the spec
> and our code.
>
> Unfortunately this patch uses a mix of "protocol" and "feature".
> It should use the latter term exclusively.

The existing file uses protocols, so I have tried to match the
existing style. I have changed the names to feature though

Alistair

>
> Thanks,
>
> Lukas
