Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3324CF9
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEUKjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:39:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51703 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUKjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:39:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id c77so2439716wmd.1;
        Tue, 21 May 2019 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MEql/0Ufbo5GktebIV5F/qta5r8Z4maoI6b+hg0Bauk=;
        b=BNr3YNZxoMulifhrzz5nFuhwL12wp7dc7H7BazvQ272Ah/wEFQqyhjCBMHOrlhLY9N
         dElhEcvtp4bsJlARwIrIf11F5saY/7bnmortvcSW/AinCT/ZLmEzBK3hHUQlUSsugopx
         DS4ZwMxJv7YQU0fE05yOLE/3Nr3i+qRSuiTvRXdaEOrrFmRvJ1Snz8/X2H40FjVNK6Ab
         B5A9AhKQVMYu+CCFsnlt8gWjy+DqfQ30/vm6btSpi6OcuL/D+qQ8oy+/ZjJ0SoECfceI
         gV1JFY41oAG4c5NLtFUkq6ZTs2m7niINQNxlztkFj4sFXtONdG6h4Zg+PuFkIoEUJK1L
         /Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEql/0Ufbo5GktebIV5F/qta5r8Z4maoI6b+hg0Bauk=;
        b=AG4JQTgNnmR2qNbZV8FruIg757JJDJ3rY3bPUAORtlc2XCE/OwYWvoryrba9tlynq7
         t19ecNNJfPuziuePDAiyCM9EW6ySRSp/r95+qEA7xkzHbug0bZROOUHlXDMQeqKaxOa6
         wBGlbArsLovMkHFnflBIdR4KTdDoQ6ZCSvhu3AgOMQHLcefQ0F+EGAL8CIPaYuJ4J7bn
         vbcR4Ry+3r+u69pz3WEPFw3z35otQZbKMyh/glrShWZa/Fhqoog/y57ZdP/Lcho9bS+Q
         zeQ8JmnT+kSfu0cjZ/Iic4V4gMy2WkhL9nCh0rJ+Y5RZbbzaSGeOknCjyPAf1o0LWkHb
         vV+g==
X-Gm-Message-State: APjAAAW2FhxrYMXBw+f3wEYqPOZ63HtJ9HXH6cZG/kM2RUUM1shbRXJI
        qbERZA/UVvJsfsyoBQYrLYk=
X-Google-Smtp-Source: APXvYqwxIsX8sYhmkNliyhrBPfzfqACbFigkfjCtV2NknKUdCGFkNkp3lHVaiOvk3ZuonQrdHEpazQ==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186mr2818933wmf.93.1558435169268;
        Tue, 21 May 2019 03:39:29 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id l14sm18782793wrt.57.2019.05.21.03.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:39:28 -0700 (PDT)
Date:   Tue, 21 May 2019 12:39:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 08/15] dt-bindings: Add PCIe supports-clkreq property
Message-ID: <20190521103927.GH29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-9-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:39PM +0530, Vidya Sagar wrote:
> Some host controllers need to know the existence of clkreq signal routing=
 to
> downstream devices to be able to advertise low power features like ASPM L1
> substates. Without clkreq signal routing being present, enabling ASPM L1 =
sub
> states might lead to downstream devices falling off the bus. Hence a new =
device
> tree property 'supports-clkreq' is added to make such host controllers
> aware of clkreq signal routing to downstream devices.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * s/Documentation\/devicetree/dt-bindings/ in the subject
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
>=20
> Changes since [v2]:
> * None
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj1V8ACgkQ3SOs138+
s6GxMA/+NpI6ZwlnTMAsJ8ruKfvjYGpc3OE5nyJWsBE+w/rPCtvydx/UNDb4nMh8
gdNQ08uHKoRG7fx7mW8u8nuExzY8euEy3GPdIDycVfEtIzu68wTOL0Fma9cjAOxe
cc+QaowCdUqRpEgs6ofUrcOUfPAV821c/wJ3O77MjlO99apfproJWw4iupCmUsot
b5M7jiptwqfi5OJklcQG2szxmbu23vBr1x+BuPDq6D+zF/K7LVuA1BSuMDywdvnc
24PpnWha4OV8zo1Ql5mUr0+F3VO+QP/lQO2YWvXx/mHO/zVp3IzKKu8vmymJBUhm
OC5EeWj1+OBVmO6NXG8K3INzzsR6T21AssIkfsdeavGHZh+JE54IHIJnwiAnq1nZ
bWmwR1aD4sQ3f81ObETw2KYoiAbyCFo0pxAiiQKgHa/c5XGCk8XzCdxWWoTNMdZA
lntfi3itDEl1X7BjArF/z5j2WRHu8lG6wBdV9PySN6bUlzkvxk4phTFMDPzgJKBW
mC95CXIvTR6uLPfNchE7HuMd/ylsM/V/EbLUgmf2s3uiU+jMoDVs3o5Nvh5aQLHZ
vLMH4hozBmHGvyENFaXeBSMuExVnx2vwWfDpCxr/8M/VYMQsqkCsKyINzAtLmCQ3
lbzIKQRGlFmaPKwX7V39yTk1CPE5pkWYEM6Z9/cJXzEot37EH3g=
=KEQ8
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
