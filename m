Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBA7B063B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjI0OJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjI0OJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 10:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF07F3
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695823715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqU7xI+fwjYR7R9bTxX4DQNExmk2VQ9fRBeVw7xLj5c=;
        b=EULdCzUgKcifByp8MyHSd+C1Cd6XbHIk6BJs2Jo0EQeIzVUsKpmXvgOp8G1Vq+BNGee5tB
        CbOyCHm/KYSLp7TCRlkQOompfnO3o1yhzLcZB2P2ZbUZm3Qyin8W8iUfdtpDHBI4mYuVWW
        sZ5EDceCGRpCJQvdWuZoLpi4JPmjpj8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-TuaK-wZfN5SjJ43ig10aOg-1; Wed, 27 Sep 2023 10:08:33 -0400
X-MC-Unique: TuaK-wZfN5SjJ43ig10aOg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-277616d8a01so8763666a91.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823713; x=1696428513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqU7xI+fwjYR7R9bTxX4DQNExmk2VQ9fRBeVw7xLj5c=;
        b=AciNqxGg6QzGvCjBFfaXdSd8nxkHNGdxWHsCMcvqbe/aU1eGICGMeBgn4zYuBzqY4b
         WZ2UHbK5l5MBPWYLFLaCJLFoz2tz1ow715EKBaoPTK1ptOmsBHLLj90S7DsdggBTTRll
         Lp1igiq5J/Rust4yowQ2Ex2VIR2wVvJlM++VOhq09JxVdcENOa6KjTLcJUn9ZsdBkoC6
         O75XkksPvE6wwPjd6P90jw/R7w09wXocQ+EZQegeQgRupjEYgB2YadJhv3If9a2FCfx1
         CPL5KEx12+cqug9sNtwdBWJtK9SFZnNDMcbY7d6zwxSFooNQapPmNgd7V9j3KlBfV/27
         ICCQ==
X-Gm-Message-State: AOJu0Yyzs+mxQ/GJrKz59rpNAKFhCB06qPeMthYS+jxntPiPjcWc1l+/
        pHQX9dUy1pF0A0DxqgKWVT3DoqKpNjRepPYbZPWA0X47ukd376Bu5wBS44/dA8iC16FGI8ytgZO
        OvGLTFldy8JrsJwetDS0iov+KjEIgIDGMGJ4=
X-Received: by 2002:a17:90b:4d11:b0:277:3afc:f27 with SMTP id mw17-20020a17090b4d1100b002773afc0f27mr9038737pjb.1.1695823712754;
        Wed, 27 Sep 2023 07:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfw5SUw/3UdkbV9cISB9GzmZq3XofG+jbzyDxnU4BxXbNz/4MgkWotyyEYQZGL6d8+tk9q38w2/FJ3n9HkyDs=
X-Received: by 2002:a17:90b:4d11:b0:277:3afc:f27 with SMTP id
 mw17-20020a17090b4d1100b002773afc0f27mr9038712pjb.1.1695823712427; Wed, 27
 Sep 2023 07:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230925141930.GA21033@wunner.de> <20230926175530.GA418550@bhelgaas>
 <20230927051602.GX3208943@black.fi.intel.com> <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
In-Reply-To: <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Wed, 27 Sep 2023 16:08:05 +0200
Message-ID: <CA+cBOTcd=SwQQQXvLpf+cgwC=mkUu_wy5=6ZUtqJiiVtL+N08g@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Resending my previous mail again, because I haven't sent it as
text/plain and it was rejected by the kernel mailing list. See below.

On Wed, Sep 27, 2023 at 3:43=E2=80=AFPM Kamil Paral <kparal@redhat.com> wro=
te:
>
> On Wed, Sep 27, 2023 at 7:16=E2=80=AFAM Mika Westerberg <mika.westerberg@=
linux.intel.com> wrote:
>>
>> I would also try to change all the BIOS settings back to defaults, see
>> that it works (it is probably in "user" security level then), then
>> switch back to "secure" (only change this one option) and try if it now
>> works. It could be that some setting just did not get commited properly.
>
>
> Hello, I have some interesting findings.
>
> I reset the BIOS ("load BIOS defaults"), however that doesn't reset the T=
B security level option - whatever is set is kept. So I can't really find o=
ut what the default value is and whether I changed it. However, to my surpr=
ise, the resume was suddenly fast even with the Secure Connect security lev=
el. So I went through options one by one and finally discovered that the "W=
ake by Thunderbolt 3" option makes the difference. It has the following des=
cription:
> "Enable/Disable Wake Feature with Thunderbolt 3 ports. If Enabled, the ba=
ttery life during low power state may become shorter."
>
> It is enabled by default, I had it disabled before. When I enable it, I h=
ave a 5 sec resume even with Secure Connect TB security level. The dmesg fo=
r such a resume is here:
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1990815
>
> I'm sorry I haven't spotted and tested such an obviously named option ear=
lier. My understanding was that this option either wakes up my laptop when =
I connect the cable (tested now, it doesn't appear to do so), or that it wa=
kes it up when I move/click my dock-connected mouse (tested, doesn't appear=
 to do so). So originally I wanted this disabled (and I had no kernel issue=
s with it disabled, prior to e8b908146d44), but it seems I misunderstood wh=
at it does. And I'm still unsure what exactly it's supposed to do and why i=
t should kill my battery life in the process, according to its description.
>
> Hopefully this helps to bring more light into this?
>
> However, I also discovered that even though Wake by TB3 + Secure Connect =
gives me a fast resume in a normal case, I still see a 60+ sec resume delay=
 when I disconnect and then reconnect the TB cable while the laptop is susp=
ended (which is a frequent use case for me). That doesn't happen with the U=
ser Authorization level (regardless of Wake by TB value). So I'm staying wi=
th User Authorization for the moment.
>
> Cheers,
> Kamil P=C3=A1ral

