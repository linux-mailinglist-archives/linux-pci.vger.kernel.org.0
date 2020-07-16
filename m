Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BC222677
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGPPGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPPGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 11:06:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3EFC061755;
        Thu, 16 Jul 2020 08:06:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so5016537edy.1;
        Thu, 16 Jul 2020 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09ZWDemsuMN9Men6pOx5y/Q1sTJiJnBfoPahLjSSTbc=;
        b=mMozZmtjGV2zt9cWQ0Cv+oHvS134AMHfdggOH7FS5yGS2kEIwCS/sxKq7BnI/dL1sU
         FFKg/FfUnkvupefRsHJJl3TpVW/Qgv+/gStrrW+digos2R1VE1PUBZCCc6pfarLhOTJM
         47Sq474voQa/eVEMNr2zjsd16n8d3ymHdItWz7nLpJ91/LbrKJoA11oKIWHQ/JlZdmWG
         aE/owsn4sls71jmmAdjN197RHqGNJoeXsauWT11gDPJ/28+VnfnZLDTuM6jZrRYTrZTe
         jHcaIPxJsUciuOgo2A5NiFtTwlE5GlwIqm5Vg28behgMWHrdjOgTUniPWTgnoXvJVd/G
         /2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09ZWDemsuMN9Men6pOx5y/Q1sTJiJnBfoPahLjSSTbc=;
        b=o7au5e/JDzp9Kw8CPX8SVbloa3fuWFntxewPR5WenJdu/KeWIIgIFaxN1dxfbVhJax
         nBQH+x+b4rSZy0givqBjb6EEiMizGdW8VlS4yZxiyGgwX2KGXzYjAFzcEIKLfBKtq10E
         /0kNCDt9LwipgedJCjC5pmSfXO9YHyw827SQMI5Rkn00YJKAW3msOWm8IX8oTUdhnCEL
         XNrbcuDCEai6z+FVZx8N7kjDBg3GXapFir5H8cft2nmLATmudXMOB/tebHqkpoSiKmbL
         D1innyjQZH2jLNqktdZtUlwrvja5ZKu+8JSFLEk7ea3CMSchdpqh/lCLJcdZ2YFU6Fy/
         xvaA==
X-Gm-Message-State: AOAM531BIGOPcQKiNeyoHNV/Dd3m2QOFBhnMEGOp3XqPDeD/80PSZ6OB
        XuGawUMdi3f44JZq0rjuTPc=
X-Google-Smtp-Source: ABdhPJwRbLZwX422ccc+L61/PnXseTMjKRW+FZ+LZ+sKZRAWNfPY2oJaxHNBD4+fB0YGuXlweED4cw==
X-Received: by 2002:aa7:cfc8:: with SMTP id r8mr5018528edy.125.1594912011380;
        Thu, 16 Jul 2020 08:06:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c15sm5868267edm.47.2020.07.16.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:06:47 -0700 (PDT)
Date:   Thu, 16 Jul 2020 17:06:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
Message-ID: <20200716150646.GA545089@ulmo>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
 <20200623145528.1658337-2-thierry.reding@gmail.com>
 <20200716130034.GE535268@ulmo>
 <20200716140704.GA20249@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200716140704.GA20249@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 03:07:13PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jul 16, 2020 at 03:00:34PM +0200, Thierry Reding wrote:
> > On Tue, Jun 23, 2020 at 04:55:28PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > The Tegra PCI controller driver doesn't need to control the PLL power
> > > supplies directly, but rather uses the pads provided by the XUSB pad
> > > controller, which in turn is responsible for supplying power to the
> > > PLLs.
> > >=20
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/pci/controller/pci-tegra.c | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> >=20
> > Hi Lorenzo,
> >=20
> > do you have any comments on this? Can we get this into v5.9?
>=20
> Yes we can if Rob is happy with patch (1).

I think this is mostly orthogonal to the bindings. We're already
controlling these supplies from the UPHY driver and controlling them
=66rom the PCI driver is completely broken.

So I think technically these two patches could be applied separately,
but it's fine if you want to wait for Rob's feedback.

Thierry

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QbQMACgkQ3SOs138+
s6Gcvg//cOAT8pJ9LKNRJ3twRZzbatCBhch3tZEvcliE7vnaM2Rj5L8Y1fi5dz/6
ShACh/Lviksy5uqzxd57lAwABYm/ZrQ9MnjIVETcdPjQRYnPsFYUFqyqeyfu5PtI
50Uh1+7q4S+KuE8lzxFOwLTcxn2soJGCAgj15W38Dr/+BKSr++5QhJscSm3l17xY
j2MXGi9D8gkXfiEIV2puoJLIkNZBn2NkcuW6H3vYlEYeTy36jzIwgaZt8wnCes+G
X/qfEBj0YMkvW1utifn4KPyG6+Ib4oqkkVgMFmA6spoUuSgSRDPlM62Bq/5HKth4
hNSbpzKr48Zq+3/teiRmgyfDrz/M1IraVNq7LZYiMpByZnbBkd8xx6TymbHyv/FF
ry7jBOVjSgO6/G/h+45R3SM8U8LEdjPC65iC+W/Lgr5ZJjqV0gZlhi5oXkFeJ62O
1iWjg1SH0mGyU7eGaEUOwNEyB5BrPplOZZU12jlRtPd9UfZNd2aynwdWH05fBkTW
4ZRuQx3ek/UKDy2bm6vEh3xQM84ZWpO9UrWA/0TcsU+IUNbeFmLqVmHH1qxsaV+H
Cm16hWzX1/ZBm6pxteGFc0kJc/Bwl1uMr/EROPxadBCCpn7fmaSV1l5P9Hpo9mnH
llvFGYQeskTZx8DW62uJY3CU0fjC2gGYvDQxgRPnFUREPm/+enM=
=AVWD
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
