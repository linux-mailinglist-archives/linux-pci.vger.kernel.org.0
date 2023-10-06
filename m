Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5687BB71E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjJFMBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjJFMBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 08:01:09 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6ECA
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 05:01:04 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1e141f543b2so1625462fac.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Oct 2023 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696593664; x=1697198464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4dHLe022tfg6JAJt/ugwVPdl75c59qlrzkRNqgnv8E=;
        b=JHRox7Y8JoZxD/ReN+Rj6I0gNWJ+vwJv+tH7uVYqDevGExDqNXjPGB135WjzNyabE8
         33eOstDv4TyIt+Q3J5KIwThcaGLniahk18cTRTvj/LWZ9f++9ypjeO75ut2ElQPaOlVL
         jsbN8OZq1COxDk61jDYaxqnloWp0u8boALBoLRF6lGG94LwCwFfzH518HodUv/9WT0gk
         sAUbPlYMxs0eMYC8lida5ci7RtYNHi6eWQpGNqtWadHwQ1XzvnPIMexd6cYsK24MCku+
         4WmbbBUvufDHxEf7vjeqD8g3UU55CU8K/JeEtfKIuGf9aO1rPNfbXwOrmQ00flvfRDN+
         DP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593664; x=1697198464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4dHLe022tfg6JAJt/ugwVPdl75c59qlrzkRNqgnv8E=;
        b=C+Ee+RPYndDU5khYYDJL3ePa9PvZl/aCCaPaq7W4gAnM8U2bEYtGOFIFE7EjkzVLKa
         5ld2yqv+3tnM2TzwFFpCqpEcYRiII8U9r7K0j1c41DnTYBkEcY01lrLQERN4GjxCd3Gd
         nFZ198K4JV9PWE71WXUFLUjcF0hVR7FOp807u5snXiXCvqVqP0P8VZvwCE1MUXdrCPkv
         e4kDqtUzDK8ZfTJobtsJi8zh31sB7TjlOh4R0wTuDfz7ylRZUHSwyzMnwpERP4qCl4Rl
         lLN7idsc4i/B2W4MfHeS/hYCnrv+V2Fn0T8AV8dzDLZYcc/f7+qzx6DuCuSWJx3H6eMB
         cSpQ==
X-Gm-Message-State: AOJu0YwJt4wbn0i3uslVKc+Aly4W2aawUy89WK9eD1ldbTEjRFXdoygc
        gNeGMT00kbjmYmg9jzUT0GSJo/+DXlkhq4FqQ+kxOg==
X-Google-Smtp-Source: AGHT+IHtR0I2S6gwdB3Du4+URFD8ib3OjGxKppuEG08esn3Jzi/IpuBRLxCeeR6aXGWBXeA+lBOhwhRbkeyse6Zpz+w=
X-Received: by 2002:a05:6870:c192:b0:1d6:ce75:d472 with SMTP id
 h18-20020a056870c19200b001d6ce75d472mr2307177oad.6.1696593663716; Fri, 06 Oct
 2023 05:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
 <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com> <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
In-Reply-To: <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
From:   Mattias Nissler <mnissler@rivosinc.com>
Date:   Fri, 6 Oct 2023 14:00:52 +0200
Message-ID: <CAGNS4TbhB19XZN-eXe4uT=ShjLUfmzC9qAkR4abzC1EUg4=r6A@mail.gmail.com>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     cz172638@gmail.com, bhelgaas@google.com,
        Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org,
        kvijayab@amd.com, kw@linux.com, levon@movementarian.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        robh@kernel.org, thanos.makatos@nutanix.com, vaishnav.a@ti.com,
        william.henderson@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 6, 2023 at 1:51=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote:
>
>
> On 2023/10/05 16:02, Mattias Nissler wrote:
> > On Thu, Oct 5, 2023 at 3:31=E2=80=AFAM Shunsuke Mie <mie@igel.co.jp> wr=
ote:
> >> Hi Jiri, Mattias and all.
> >>
> >> 2023=E5=B9=B410=E6=9C=884=E6=97=A5(=E6=B0=B4) 16:36 Mattias Nissler <m=
nissler@rivosinc.com>:
> >>>> hi shunsuke, all,
> >>>> what about vfio-user + qemu?
> >> Thank you for the suggestion.
> >>
> >>> FWIW, I have had some good success using VFIO-user to bridge software=
 components to hardware designs. For the most part, I have been hooking up =
software endpoint models to hardware design components speaking the PCIe tr=
ansaction layer protocol. The central piece you need is a way to translate =
between the VFIO-user protocol and PCIe transaction layer messages, basical=
ly converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts bet=
ween the two worlds. I have some code which implements the basics of that. =
It's certainly far from complete (TLP is a massive protocol), but it works =
well enough for me. I believe we should be able to open-source this if ther=
e's interest, let me know.
> >> It is what I want to do, but I'm not familiar with the vfio and vfio-u=
ser, and I have a question. QEMU has a PCI TLP communication implementation=
 for Multi-process QEMU[1]. It is similar to your success.
> > I'm no qemu expert, but my understanding is that the plan is for the
> > existing multi-process QEMU implementation to eventually be
> > superseded/replaced by the VFIO-user based one (qemu folks, please
> > correct me if I'm wrong). From a functional perspective they are more
> > or less equivalent AFAICT.
> >
> The project is promising.
>
> I found a session about the vfio adapts to Multi-process QEMU[1] in KVM
> Forun 2021, butI couldn't found some posted patches.
> If anyone knows status of this project, could you please let me know?

Again, I'm just an interested bystander, so take my words with a grain
of salt. That said, my understanding is that there is an intention to
get the vfio-user client code into qemu in the foreseeable future. The
most recent version of the code that I'm aware of is here:
https://github.com/oracle/qemu/tree/vfio-user-p3.1

>
> [1] https://www.youtube.com/watch?v=3DNBT8rImx3VE
> >> The multi-process qemu also communicates TLP over UDS. Could you let m=
e know your opinion about it?
> > Note that neither multi-process qemu nor VFIO-user actually pass
> > around TLPs, but rather have their own command language to encode
> > ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
> > possible and works well enough in my experience.
> I agree.
> >>> One thing to note is that there are currently some limits to bridging=
 VFIO-user / TLP that I haven't figured out and/or will need further work: =
Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalent=
s on the VFIO-user side that would have to be filled in. The folk behind li=
bvfio-user[2] have been very approachable and open to improvements in my ex=
perience though.
> >>>
> >>> If I understand correctly, the specific goal here is testing PCIe end=
point designs against a Linux host. What you'd need for that is a PCI host =
controller for the Linux side to talk to and then hooking up endpoints on t=
he transaction layer. QEMU can simulate host controllers that work with exi=
sting Linux drivers just fine. Then you can put a vfio-user-pci stub device=
 (I don't think this has landed in qemu yet, but you can find the code at [=
1]) on the simulated PCI bus which will expose any software interactions wi=
th the endpoint as VFIO-user protocol messages over unix domain socket. The=
 piece you need to bring is a VFIO-user server that handles these messages.=
 Its task is basically translating between VFIO-user and TLP and then injec=
ting TLP into your hardware design.
> >> Yes, If the pci host controller you said can be implemented, I can ach=
ieve my goal.
> > I meant to say that the existing PCIe host controller implementations
> > in qemu can be used as is.
> Sorry, I misunderstood.
> >> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
> >>
> >> [1] https://www.qemu.org/docs/master/system/multi-process.html
> >>
> >> Best,
> >> Shunsuke
> >>>
> >>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe th=
at's the latest version, Jagannathan Raman will know best
> >>> [2] https://github.com/nutanix/libvfio-user
> >>>
