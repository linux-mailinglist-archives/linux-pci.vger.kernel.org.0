Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C118B9C
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEIOWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:22:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54934 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfEIOWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:22:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203so3503617wmb.4;
        Thu, 09 May 2019 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EilVSoGW+JMj9cMXRlvk85583Mm2QzNg7/nmF0A0h8k=;
        b=Sfr9upl6rOKs68+jPqGmfuJ5pWwPsmwZ8/IC1/uL2qhYK+8TODW/9M8PiheSzM1sJP
         +jrVbrYyC+pneKcHajyaZANOAAoyPuFUEh4FZLP9sv5hz7NrPozExnz9TFrAH3GsbeA1
         cJYevTKLU/GfPvtHMgX12Q/D2j2qCS0NLpb5QAhZv0n0OTMNZ2DmN3xlKdVmvKtwxExi
         Z1W4FGdvb1na09JJ26XvHlSU96Nf9E94CsqigaSmAB1S6ce+UdTvxvwGSoCK2gIh8r6m
         cDuQSqrGhWulLsvCnUKWs1PQ2M8Db+kJhrK8WlZmf9dAnbLiYeFe92AqRRHYfXnh8gZp
         U/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EilVSoGW+JMj9cMXRlvk85583Mm2QzNg7/nmF0A0h8k=;
        b=hX0lJsLFLcLicp/1QwSsag8T6hUII331jYL+kDwUiC+ZwMEUbYBy2IejbYlmVl07Vh
         o71EySbtPlq4s3MmjVuIb93D3kh6jvGP0JYi+gZZ2vxmGPhLJs9EJHSlAk6t2rhvF5WB
         tJvt0wdwLtr5lcjAdi197TqrQdeEpPZzP6qolvoNhEV8JyFgPFPYcwxGTir/uot1pWyq
         dTcbl5xOpfMtrK3p658dHyjskflfA6GZnZ2kJy0k1wlON7fGyEaoYzFKgieB7xM6MHQd
         TqUwe/e0bdF+6BEGwOZkPPkPJytlUtciSbxYx3wgMjdg9fxUMGMKpQeIC0Xp+EAHJ/4h
         /O+A==
X-Gm-Message-State: APjAAAWtATM+5nR/IbimiIq5LaWkVwHNdfq9rGHZFLmso0Yma9bxjV8u
        Ax38q/gJ6wJvdQ7KfSXxHAw=
X-Google-Smtp-Source: APXvYqylrBjzXf8lMyNANiV8MFN9xwRQrcZfR8LI+pdQ4D7BV/M5EMJzmYOJ6wql124LxcrUhXOs7Q==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr3215451wmf.16.1557411761151;
        Thu, 09 May 2019 07:22:41 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n1sm2569668wmc.19.2019.05.09.07.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:22:40 -0700 (PDT)
Date:   Thu, 9 May 2019 16:22:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 15/28] PCI: tegra: Update flow control timer frequency
 in Tegra210
Message-ID: <20190509142239.GL8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-16-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-16-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:12PM +0530, Manikanta Maddireddy wrote:
> Recommended UpdateFC threshold in Tegra210 is 0x60 for best performance
> of x1 link. Setting this to 0x60 provides the best balance between number
> of UpdateFC packets and read data sent over the link.
>=20
> UpdateFC timer frequency is equal to twice the value of register content
> in nsec, i.e (2 * 0x60) =3D 192 nsec.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Changed update_fc_val to update_fc_threshold
>=20
>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUN68ACgkQ3SOs138+
s6EUIQ//fPLO3+kOgp+cWleSpS5tQI/b3oSJYHWpm4WDf+3W00jaAOngR/nppT+R
xZrL/NENwycIe9ShA3Fh1lOPKnYtTWEfjHj1lsWFMVvKqOykPQCpuQV74G2/BCF3
rSv67tehrwMAgndniHosmKcmu1Pw0gYMITujiodA4J7R9OIkgYsaCb00gNujYfHl
noT6w9b/s38NcSv1E8k4EvTd44YFfyWt1xrOW9QSuAFrqsKD79fFgwQmPr11e6P0
IYLM9ylf0S6Pm5q9WML1CELnThLbuFUwr0UfjlSoLu6siDfD/JC0rTj7m+EIgEYT
nh2Nb1QL8EsDIOLzxSq9h7ZdzQxnyGmGKpm4o1jGkacyjR4np90h8wJSeOZnBx31
+Yo54EFeEUvfwZxbVCz8C8+IP/AbBLqEhKAp+0ES6vH0RDO42KepGQUcalv22Akr
0ret0Bw5TCYw4kTPEsuDy5f0lziu4zqMICz+sATbzn9ptLqaP2KPLII2jEWUglPb
ws5w3+OOvsAGAU160egM4X6cpToY0x0wulj1gguXysASERKwMQ5Q+xZpUWXWVr32
1MiEUEvDPB41hQeqyHmvnMSVu8PfgzyjudOtHR4hzsH5zqXvD82mKVh12bIDBiob
lqtVwu2VdMRm8BBw8tSB+xH25dlRD7xKJD8YVksWMyPElMWFnh4=
=8+ux
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--
