Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627947ACECD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjIYDy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Sep 2023 23:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Sep 2023 23:54:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87682DF;
        Sun, 24 Sep 2023 20:54:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso6574700276.0;
        Sun, 24 Sep 2023 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695614059; x=1696218859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITTBpzczqd4LSWTAD9aZOIvJ8J7Zcd7g95EdndUh4GE=;
        b=Us4f8NXuy1Pc9HAme2OiaRc+1fSl1RMv5SxecL9lK1hnV1RVf5OXaEpnyB9seZUITm
         uOEyn6LWbGnipYnqbzwyvLldTu5fuEdQ5q3/68cL6X8GpGQpN0pwdz1eJslI4zcbtbuk
         yd9BTaCm29nWQ9lCy/+U4aehHN1TKtTIj8EFikKulxxLNC1/2dOM3DfgrzPV0I6L9gMp
         lzBx9IHuL1Otc9m+8I4UcdjtwkAv0rSk8hKedSmbOQoYQgSzvOpb/ds+wslFiX2YHkvg
         jsscELyOJ1H8MIFYO0CpkpvjL0nusMUCMSYuxJZMBV4SFZCtvFOhdLfWDUS2s3AhFni9
         EOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614059; x=1696218859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITTBpzczqd4LSWTAD9aZOIvJ8J7Zcd7g95EdndUh4GE=;
        b=wCkDK0oxSnKs6mei2ej8G1KmmSNGBXmoYEnMFTbc78XYzyBZGzbYManfPA5mv04muO
         xygjfo0kHTAJLO3naOzoHPU7Kdx1wwGvKsgbu7eh9ENlxqvUyLP0lpQ9YbCm1c6812mK
         mQcjuvIfSnI4CXRUhdiVWpJLF5Z9fFhw8FqoK9G1wm64+9DL6D3rCo/aiyxEHpfEQ47e
         HeMAQkWpVa6Vjbe1ly/sV4TbUSfESrw3fXHa19OA2qWganRJVlT2ancs5z6L14/+/Bvk
         yV/8tHcyd1X4ad8G82KTbERGfUZXqn609mFoFF1pCD+sqMt4YoIMd9GJUYZlAQvhpLVb
         YcPg==
X-Gm-Message-State: AOJu0YyF3yDs1CrvkTDUZZNndSiRej1Y6tWvatIjYSnFb1mngoiU715A
        rm0AWf/UgpC4KqLwesWcjq5MRTMJKf01INeycymQwCNR2kI=
X-Google-Smtp-Source: AGHT+IEPOLAmcobHAk1T8K+we8QFLN4PFzlGhEPu6UIp+fRvfWYf2Xav/jX3C/IYkXWacdxhlKDFU1i+P3s28fkvDpw=
X-Received: by 2002:a25:4106:0:b0:d78:be:6f02 with SMTP id o6-20020a254106000000b00d7800be6f02mr5161748yba.11.1695614059628;
 Sun, 24 Sep 2023 20:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <e486db16-d36d-9e14-4f10-dc755c0ef97d@linux.alibaba.com>
 <20230920230257.GA280837@bhelgaas> <625cdd6c55994bf3a50efd8f79680029@AcuMS.aculab.com>
In-Reply-To: <625cdd6c55994bf3a50efd8f79680029@AcuMS.aculab.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 25 Sep 2023 13:54:08 +1000
Message-ID: <CAOSf1CEML1s0pOpi92By9Ms4nnq5onSX-d7wCY4jXXAviXO_qg@mail.gmail.com>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
To:     David Laight <David.Laight@aculab.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 8:23=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> > It would be nice if they worked the same, but I suspect that vendors
> > may rely on the fact that CPER_SEV_FATAL forces a restart/panic as
> > part of their system integrity story.
>
> The file system errors created by a panic (especially an NMI panic)
> could easily be more problematic than a failed PCIe data transfer.
> Evan a read that returned ~0u - which can be checked for.
>
> Panicking a system that is converting TDM telephony to RTP for the
> 911 emergency service because a PCIe cable/riser connecting one of the
> TDM board has become loose doesn't seem ideal.

For kernel native AER the default reaction to errors is
reset-and-reinit which probably isn't much better for your case.
Sounds like you would want a knob to suppress everything except error
reporting so you can handle it in userspace?

> (Or because the TDM board's fpga has decided it isn't going to respond
> to any accesses until the BARs are setup again...)
>
> The system can carry on with some TDM connections disabled - but that
> is ok because they are all duplicated in case a cable gets cuit.

Well that's a relief :)

Oliver
