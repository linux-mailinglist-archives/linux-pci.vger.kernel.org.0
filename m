Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1424D181B38
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 15:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgCKObB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 10:31:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39693 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgCKObB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 10:31:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r15so2906223wrx.6;
        Wed, 11 Mar 2020 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VjzeEKChSA5U1RVRAuBtpoNW2CBTxFFw13vMlkz5Qxk=;
        b=EHqlZFnV23fFnJW6akKlxvTs10LaICmJ/QCOlISSxIB0cw/p6s1ifiyS3OZVNq7Cra
         /3936DKt8/JFJz9DaopJG5InbBeZvZQeuOQZ6Aed3ghopyfvrWaRZCF1LE/x6R5kBpJn
         0/A1PFt0H4dOR0eMsY0VrYnR0krQmusq1cJRptn09df4Qfb6qmziQ+zua6UH2O+eMec2
         Bw8N02JXEbs4uNpXpKNEvAUIqsava8YurAY6JtdU3NoMUaC9nfqn1m24q5apukcQLlnC
         b1m2mUIIDODwT1Dp8udTeIrQeUioqm9GfvpINHA4RYsiD3ooKoLqmsKQjaZJENIv0tX0
         dBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjzeEKChSA5U1RVRAuBtpoNW2CBTxFFw13vMlkz5Qxk=;
        b=DzRst48KUcc5LxTJIMV84RcHd5Zq9i5tTZEs5gVRaQs+VNV+VEFCOeaNDmaVmg90uf
         uaDyXF6E7KnF5SOSQjLZAq9GH2wJ2JRFDv3iF/XBG3ya8qXO819JHRDtDTVW+eaMIhxh
         2yqb6Ld9lBAjxCAWH4ShfM5LTXwOvbb/02fgccV1/bN5RdzB1EBs1duAexRQeZVECQhF
         T1OSBqaXSb4ZxX248UN56K82DJ5qwwu5M5g6+S9hTMk0pVVKNn9/iXwAOOSYketdqNXF
         pIMhNthn+oMUFMfZMi25rfMPPFr+sepu3JP4Lm5p4E8pf7+e1ETjTGdgueRc44EGW2LL
         lZlw==
X-Gm-Message-State: ANhLgQ3/7b/RwVt7OfnVXNpbROxeoa+blDIczej8jd+bTiRrLFXidvRS
        lSN+sJ1iGevVqig3tTHcvCc=
X-Google-Smtp-Source: ADFU+vuCLwEwQ5JWv5ljZuN0njk0gngoUTdcQ0yYvpJ5vzAu66rQL6Q1YmXNCUN1Wmmj/p+P6gqpCA==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr4872952wrt.191.1583937058668;
        Wed, 11 Mar 2020 07:30:58 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id 138sm3297085wmb.21.2020.03.11.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:30:57 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:30:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, jonathanh@nvidia.com, andrew.murray@arm.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 0/5] Add support for PCIe endpoint mode in Tegra194
Message-ID: <20200311143053.GB494173@ulmo>
References: <20200303181052.16134-1-vidyas@nvidia.com>
 <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 10:52:00AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 03, 2020 at 11:40:47PM +0530, Vidya Sagar wrote:
> > Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can op=
erate
> > either in root port mode or in end point mode but only in one mode at a=
 time.
> > Platform P2972-0000 supports enabling endpoint mode for C5 controller. =
This
> > patch series adds support for PCIe endpoint mode in both the driver as =
well as
> > in DT.
> > This patch series depends on the changes made for Synopsys DesignWare e=
ndpoint
> > mode subsystem that are recently accepted.
> > @ https://patchwork.kernel.org/project/linux-pci/list/?series=3D202211
> > which in turn depends on the patch made by Kishon
> > @ https://patchwork.kernel.org/patch/10975123/
> > which is also under review.
> >=20
> > V5:
> > * Rebased patch-2 on top of Lorenzo's pci/endpoint branch
> > * Removed unwanted header files inclusion in patch-5
>=20
> Applied patches 1,2,5 to pci/endpoint for v5.7, please let me know
> if something is missing.

Great, thanks! I've picked up patches 3 and 4 into the Tegra tree for
v5.7.

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5o9hkACgkQ3SOs138+
s6EhXg//cjYE1EBraQovAb9Meb89XpZgwlbTBz4wVpX5gGBnmOdMVLAJdqSbXdVQ
AxZT3EVQOzy24ZqGwb118iN3a28CNYU9FLUdZM/UoPnA4NHC0Dk62cIeWUly7FU7
geukEaBFNJSl/6EPuAo0Qobgow0Yn5anvPjKgpZ+0BKK/e/+aUYZNzFs0vpde9xq
9PPsB1rGj0KrrDSnAFS1hxrL85yL8B5Hz2X//Zm/WFgC3C7X2lSSCL9z4RWyeT1F
pNc41o45blCOmcA2wZi7WbaMCYkyBvQyjEmBPBTnF/6P3R+J3XWtyWcTJOSwgjby
MHLshrbG0T4HNxFtbZ38G14Q//mCu5kYuGWLW/P3187nejD2XF1wNGYSqmwE9Eny
zcOH7tqEofowLvCjLa3BZtHiSiAxRdwuLY4Q6nh1tEydpQqo5bKp3A52B6vjdqoo
7GBhLvJ6tIal+dZUxI7nMz7wPdb53TrMws6rhQ4/bcb1oprZwXQzL8DGoNij6aBl
kYU0OvWb1Wh9t+EbLa3BKdupY/OuBVK1zu6/mH1+MYTD/FZviyj+EXH8rPLbzki5
THwdnIDEs0dvf3nEfIjXnyVfr+QrVOsrsKOpyfjHq3N0yGeOXavt1Su/XHZ8mBDX
r2nBg9NWA2vPlngiW49ndo080lFoiG3mGmRwgk21+1HJIDdPcys=
=QA1n
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
