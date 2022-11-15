Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB2628F8B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKOBuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 20:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiKOBut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 20:50:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D4FADF;
        Mon, 14 Nov 2022 17:50:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z14so21574335wrn.7;
        Mon, 14 Nov 2022 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq+GIxiklIVtKUEbK8ucEWoZBn9yKo/47esIkXSbciE=;
        b=k6ih+eBWz7VpcB3X6ZiO2pFU3Npz+47xJTh+eTEHLt+wNZBuisnW69DY5KGluoS4bg
         6BnmD3a6wJb5yiT/WG+kVwg8pbHw9fp3hx9FLCPI/dOlSCMiZX8U2aUcT5B556pP5hY/
         nB5kfbzIQWzG4B9tO55xwOHKTC0dKAy4d4qQyq8i7Al34QANCJLG1RUUCt5znhkBXfCi
         c9iYNID3ZQ5HnaVVRAQWc4ivIMSYvUufjPAgs3n2xpMhH8WQvMwmh0ChHPW6tqX7GZq5
         bo28z/b6SnirBjZumcXjeI1mfI3eESNRFjmlk/aIdMD17IdHiOMIK+ZjHW/FM1SoAlIf
         xyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq+GIxiklIVtKUEbK8ucEWoZBn9yKo/47esIkXSbciE=;
        b=BnWrAWCz88Ri4PZD+1CS8u9r05KLTgxImRQ7nzdaKC77SkAOCQ14D6E7gR4gA7994C
         /dD7oPtWbkHoRiQgBYIN25+kTnEexbgdcJk+8SdrISfArqoumv30B9Ucx/3sdfu1H/2k
         wAON2E8f1/bOk+hBmno+EJW90SiulywbTpMELtTTbvcYTKanNpJxgd2UpXCkTIuSoGRJ
         JXIBOT4JNMdLVRI58x0M8JxxoFitLWrABPM9n85zBA6dawZP3Vxa3qegvSukKpUds43G
         kEpnn/9wX2iJZ9GzamECLgoIBrISDqPuyJY0rNF8sCdfJzMVKJAX7KbRIpHGYLVlvCp3
         pv2g==
X-Gm-Message-State: ANoB5pngwkfqAFQ5jUWlqiP7qqmkAlBr1YCuvmCNQ+u3o++qldkF7Uko
        GmimXyE+/sNuwA8HKM/VhQetuvPgZuFaWpd9ow0=
X-Google-Smtp-Source: AA0mqf7aq43bPMm7FbEqVbjX5qxAn2T0zciW2V19Bv1VonAMKypjCRrFvINg8lB+GIdvtZGnpgMI9nl1pEVUa4m0CAk=
X-Received: by 2002:adf:dc09:0:b0:236:7180:6ccc with SMTP id
 t9-20020adfdc09000000b0023671806cccmr9406986wri.573.1668477046120; Mon, 14
 Nov 2022 17:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20221111142722.1172-1-longpeng2@huawei.com> <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com> <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com> <Y3I+Fs0/dXH/hnpL@unreal>
 <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com> <Y3JOvTfBwpaldtZJ@unreal>
In-Reply-To: <Y3JOvTfBwpaldtZJ@unreal>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 15 Nov 2022 12:50:34 +1100
Message-ID: <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com>
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjay.zhou@huawei.com, zhuangshengen@huawei.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, xiehong@huawei.com
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

On Tue, Nov 15, 2022 at 1:27 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> *snip*
>
> Anyway, I'm aware of big cloud providers who are pretty happy with live
> migration in production.

I could see someone sufficiently cloudbrained deciding that rebooting
the hypervisor is fine provided the downtime doesn't violate any
customer uptime SLAs. Personally I'd only be brave enough to do that
for a HV hosting internal services which I know are behind a load
balancer, but apparently there are people at Huawei far braver than I.

> *snip*
>
> > Adding 2K+ VFs to the sysfs need too much time.
> >
> > Look at the bottomhalf of the hypervisor live update:
> > kexec --> add 2K VFs --> restore VMs
> >
> > The downtime can be reduced if the sequence is:
> > kexec --> add 100 VFs=EF=BC=88the VMs used=EF=BC=89 --> resotre VMs -->=
 add 1.9K VFs
>
> Addition of VFs is serial operation, you can fire your VMs once you
> counted 100 VFs in sysfs directory.

I don't know if making that kind of assumption about the behaviour of
sysfs is better or worse than just adding another knob. If at some
point in the future the initialisation of VF pci_devs was moved to a
workqueue or something we'd be violating that assumption without
breaking any of the documented ABI. I guess you could argue that VFs
being added sequentially is "ABI", but userspace has always been told
not to make assumptions about when sysfs attributes (or nodes, I
guess) appear since doing so is prone to races.
