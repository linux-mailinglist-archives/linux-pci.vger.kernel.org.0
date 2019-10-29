Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496C8E8779
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJ2Lu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:50:56 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:45422 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbfJ2Lu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 07:50:56 -0400
Received: by mail-lf1-f54.google.com with SMTP id v8so10269111lfa.12
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2019 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ssi6f/Qfkb56NhEW1iOk+0+bDUsP8ulwyb6JfSgT3YQ=;
        b=i6/QQI9FPJD7MH7kkWe7FTmt7Fdfz9Dm53Iv6zfGHULrDPqRMZPKpGg9TVCMowmSyh
         PH2O+TX4n4E2Iq/DGwkYW3chwB9VnSbz0sxecqbNXCScsbpEVbQIBKT12WYM0MfjVbXP
         uxxz1uQvgVjQw9IxY4kjCSiGobKYmXJRJVjlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ssi6f/Qfkb56NhEW1iOk+0+bDUsP8ulwyb6JfSgT3YQ=;
        b=IfAhqCjRRCjvylBSC3aTBzDfoy14zQzPfCR4xjuo3l0Oy9jZxvZmhO1XkEI6/qNoRR
         Xb4xHswXxZsikuv6/nejlctl1o/SeRJJCO1Rp1GWAQu3cLZmo2WXeBbx9JmlhjK4qYnK
         BjXUxvFehhL0uLoDLpYz3jJVIVrmL8aU/nS/9qSXj4l+ttZoapFgoo2XnJDdR+L7iIZO
         Kt/4TliaCxkt+crpHwh0+VzLRZ0xgUBpqNyFZjbONV2noYXRHT5thj4FpE4k5yc2XMDT
         AxqMg/zC5oB69v4oVqqB6LHJb52Wkd6a/kTLwTkHpiNjqYn29RQgEeEjRU+eCnbrgBUv
         zYcA==
X-Gm-Message-State: APjAAAUb4evjI1Br3p6Rb0M50hgCa8RPzhyYYdEgC7upT1z8S8upmE1i
        W//rscV1buxLTgsmVadPPuBI/goayGaYT9Xge9bEjK3eggJ20SSEzUnAW4K3TKl3IMoKGJENtIZ
        80pj1Z4O4MfR4k9LjyZxjcckPH4t8Ww==
X-Google-Smtp-Source: APXvYqwyVYOYbTmkqxvyHrGGVuVjOk5ytdnpqvDypuse+anjxDu/UUPNIi6rpitRppGfFaEeyt8LslnWnMbsClXrGUc=
X-Received: by 2002:a19:6d19:: with SMTP id i25mr2181919lfc.178.1572349853828;
 Tue, 29 Oct 2019 04:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103156.GC22848@e121166-lin.cambridge.arm.com> <DB8PR04MB67470C5AD54BC91BA5E2294F84610@DB8PR04MB6747.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB67470C5AD54BC91BA5E2294F84610@DB8PR04MB6747.eurprd04.prod.outlook.com>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Tue, 29 Oct 2019 17:20:41 +0530
Message-ID: <CAKnKUHG2bNZoaLp2OBsnzC9O6vNoLEv8b4ThGee9a0FUckLGGw@mail.gmail.com>
Subject: Re: Mobiveil legacy IRQ binding erroneous interrupt-map
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi  Lorenzo, Zhiqiang,
        Thanks, will check and fix.

On Tue, Oct 29, 2019 at 5:08 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> Hi Lorenzo,
>
> The Mobiveil INTx controller is not used on NXP's platform, so I cannot v=
erify this feature.
>
> Karthikeyan, please have a look on this issue.
>
> Thanks,
> Zhiqiang
>
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: 2019=E5=B9=B410=E6=9C=8816=E6=97=A5 18:32
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>; Karthikeyan Mitran
> > <m.karthikeyan@mobiveil.co.in>
> > Cc: linux-pci@vger.kernel.org
> > Subject: Mobiveil legacy IRQ binding erroneous interrupt-map
> >
> > Hi Hou, Karthikeyan,
> >
> > I have just noticed the mobiveil interrupt-map DT bindings example is w=
rong:
> >
> > This:
> >
> > interrupt-map =3D <0 0 0 0 &pci_express 0>,
> >               <0 0 0 1 &pci_express 1>,
> >               <0 0 0 2 &pci_express 2>,
> >               <0 0 0 3 &pci_express 3>;
> >
> > should be:
> >
> > interrupt-map =3D <0 0 0 1 &pci_express 0>,
> >               <0 0 0 2 &pci_express 1>,
> >               <0 0 0 3 &pci_express 2>,
> >               <0 0 0 4 &pci_express 3>;
> >
> > Legacy IRQs Interrupt pins map this way:
> >
> > {{1, INTA}, {2, INTB}, {3,INTC}, {4,INTD}}
> >
> > (as read from Interrupt pin register in the config space header) (ie re=
fer to
> > PCI local bus specification 3.0), please fix it as soon as possible.
> >
> > Lorenzo



--=20
Thanks,
Regards,
Karthikeyan Mitran

--=20
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any=
=20
attachments, is for the sole use of the intended recipient(s) and may=20
contain proprietary confidential or privileged information or otherwise be=
=20
protected by law. Any unauthorized review, use, disclosure or distribution=
=20
is prohibited. If you are not the intended recipient, please notify the=20
sender and destroy all copies and the original message.
