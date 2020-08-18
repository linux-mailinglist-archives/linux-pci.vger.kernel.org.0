Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED94F2486B9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHROJ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROJ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 10:09:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F7C061389;
        Tue, 18 Aug 2020 07:09:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so18406503wrc.7;
        Tue, 18 Aug 2020 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1H2yOHeG6qsldeZpoyc2sz7sMJshfjbS1b8gZKRx98Y=;
        b=jiEOFlujIONfp3NsuPDQRxhggX67lZRgtm1FlIVKeSOqATb5V31ZYHVr3DR37JNiwl
         Anqx/RkRSGwmNHjOcjr4dLGi4XANj5Ezf5JBhYwObSiJKvAg033ZQ/gaxzc9hHjN195I
         lClOJqR70hNEt0beS5Y8JILTPR49xNoWIZjG2RBC6uUT0y4L41R1wZJyXQRi0PE9DYwz
         l1GGIx58h4ul20GqBWe+bREP0afY0y522dCXM0ars4vTFUT9pGiXuqLkIZE58z11PJBG
         oUH6f9JQ68R1sSXkgwo+2lNSCAI8lVt807P+6e6DupMlPtiefVULfci/WybApzDkrI2Z
         7Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1H2yOHeG6qsldeZpoyc2sz7sMJshfjbS1b8gZKRx98Y=;
        b=sEtiJGX5FRm+0pYkIBq7BrZj7C5K4zaDpmrRFDUy+TQJzN3ynhXIx9FdXrniMtCdom
         Qvy3/MW5RtpvOBVXzQIyx6nxxLPWt3/rzGxomfXVCD7Cmoh1gII9nNKlLBSb8emHqEkt
         rbLgOK/e0M9arzkXhm7/WaF11fHF/OOZk/AgIoOb+FXWQJyW4HNvP2YrobQZr9WStr4m
         BHBa2asdu+XO2HO3wCyi9TQyvkW7Wjl9vhb1lxIoJHOO4nLcbi8Br9TK+RGD1cS82eRk
         SZ1Ca8CueY5mCr++9KbRnXuLvy43DOO8gZ2jSh2WWmcyrJXJEJtnT7RtaiV7ldV9wWO+
         SHfA==
X-Gm-Message-State: AOAM5303UPl3pdHZfBbeGU91Im+k/UO9LTKdBp9Trl94WIExNwhjggtU
        MaCj/2vYlfE+coS/2wG9uTc=
X-Google-Smtp-Source: ABdhPJzuOGcRH65pQQhWEPOum5p4OObacHriBq62kw/b4exT9sD7ZnV8iohBJO6BMKN2IE56kRzmdw==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr20170776wro.24.1597759764468;
        Tue, 18 Aug 2020 07:09:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b7sm31979036wrs.67.2020.08.18.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:09:23 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:09:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: no need to check return value of
 debugfs_create functions
Message-ID: <20200818140921.GA814860@ulmo>
References: <20200818133739.463193-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20200818133739.463193-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>=20
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 20 +++++------------
>  drivers/pci/controller/pci-tegra.c         | 25 +++++-----------------
>  2 files changed, 10 insertions(+), 35 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl874Q8ACgkQ3SOs138+
s6EPYhAAiOKXbVExfZ5GF1JdSWf/MtDFL//RZskjZAr4Qt2mz45OBpoOSLNz5ZxT
kY8TAAiQXmIB8SvO1CeMYbJhX9yZKZHdTq9PsPwH7D9ReJ/G6wr18HFQCsmZru+v
MvoUUz77VPh21olmyPr5k53OOwNb/8HSf3JAWuide4a6dZB+DfxE1LXZFjtMLRYl
oqsQV3tiCRqcw9O+nsAkTrEbw5Kj2n1PN2E8QxgSX/YsVRW695obVMBVJkmpX67W
ly1/a7rVhvNfvZD3nkYPtcG8/deJ87w9/ztckn4gsGyg77PH/qlWQLmXcwMPCG+Q
wt5+tdeN9HKwrVQcL7NKUOW0unFCeSYFliwTc4//LqCLg/3ZdHnuuqeaQmXCtxnG
biOlDzgn3GoaUBBKaQ1x3wgb09fgfsnJP2Rboe6Jm2pYeVT7w6F0IHoZH2gqLPHr
MRj71MZGyrQrivsI7cLk5nhWlyOl4HTguD762djx9p+gi+Gf8MXKUIrWiM0A+hj5
WJYfZ0IUpFaLpBZRK+WrpVUU+qe+ZkwKQWDPq9t3YZcxvBhsjEEtrA/heEDLX5xq
/A41Qj97BirCtqLj/RDYhCaGqAFl5Xk7bHESRiHakB8UFVwi+uk+d2QyH8vhQUwL
9wERatxDfRdHK0fMSg2AtpLTYljlVlBcEqTY2aCf9qbSAeB+51Q=
=cp7x
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
