Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2B17778C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCCNk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:40:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCNk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:40:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so4431359wrr.0;
        Tue, 03 Mar 2020 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLrc2+FA1ilMNRmgjCWNRM7AU/9wyz5rmTyxSf5L/jk=;
        b=tuAM88xFmr/1HHdgnU+iN9kKxRCACr7qjOAbMKA2T6ct8kOUOPCytXX5yv7PsPOpq3
         KaI5IOFI7uye+KEltFVfEIU28ByZqcjE9dpNPgjNDv28bC9BUyhtvi8TAG10NGL1uSoE
         S4teOUD2khVaxZC6jD2ygMa8bW/10RZfFmMHSJoEzck2ITDCYx+uBC4GpJA6Wt98JVvV
         vNJ1/HzzD9ClQopIlsC1xOFt9E54txaUfmJ9CyDtvxk4bdtb5Ttvtop7cGrGlD1HVwOK
         9AbPrRsbMnIzFcNha+LJ1gMXmPaDhPrJDLpJkiBz3X+xUHNEmpt+i0omU4sLz6ifb/AG
         g+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLrc2+FA1ilMNRmgjCWNRM7AU/9wyz5rmTyxSf5L/jk=;
        b=oi4GLqNXaSFmyF2U13kS/b04SEehGGrxXCpVMWZy2TQGHj0WYuWyO5BCPoCIMffEqS
         4enlyTrjA5Z8A1xN8Fe261fka0bTMF0kWg85qqcSorYoWH/sK6owWtr+6rEGHHOkyQTX
         IChpfRHLdbvv/MqQ7hkdb8kDaSAmakvVyM3mlRjmEfxHQ8ViYdj2KHPs8OWDuyR74OoM
         aHH4rPqfJvCesGoiO813OxrYhCFBnG1McqtGG5k1y7XgMaOjl7THET1vzguUJLdNOLSY
         83LJpZk6HFJF9pzsRS4g4qQJclEp16vTfF6m4EsBvUwx+T7ssClvKwHcGHQkCGAGyS0P
         ws8A==
X-Gm-Message-State: ANhLgQ2CHPoly1/LSipHOT2ZVt/clFdoeJyH9kD8bGjEGsLAOjaMRJr3
        aXv8IHQiothhISmPNxK8dBiFu2XX
X-Google-Smtp-Source: ADFU+vsUi9N0mZqkU864Zt1scSOjkJGbRqy/7SxuooIaUW3uRiZRk5L7SxSRfaKwnjHBqYIWc2rWJQ==
X-Received: by 2002:adf:f641:: with SMTP id x1mr5471264wrp.248.1583242854870;
        Tue, 03 Mar 2020 05:40:54 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id s5sm32044251wru.39.2020.03.03.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:40:53 -0800 (PST)
Date:   Tue, 3 Mar 2020 14:40:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
Message-ID: <20200303134053.GC2854899@ulmo>
References: <20200303105418.2840-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20200303105418.2840-1-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 04:24:13PM +0530, Vidya Sagar wrote:
> Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can oper=
ate
> either in root port mode or in end point mode but only in one mode at a t=
ime.
> Platform P2972-0000 supports enabling endpoint mode for C5 controller. Th=
is
> patch series adds support for PCIe endpoint mode in both the driver as we=
ll as
> in DT.
> This patch series depends on the changes made for Synopsys DesignWare end=
point
> mode subsystem that are recently accepted.
> @ https://patchwork.kernel.org/project/linux-pci/list/?series=3D202211
> which in turn depends on the patch made by Kishon
> @ https://patchwork.kernel.org/patch/10975123/
> which is also under review.
>=20
> V4:
> * Started using threaded irqs instead of kthreads
>=20
> V3:
> * Re-ordered patches in the series to make the driver change as the last =
patch
> * Took care of Thierry's review comments
>=20
> V2:
> * Addressed Thierry & Bjorn's review comments
> * Added EP mode specific binding documentation to already existing bindin=
g documentation file
> * Removed patch that enables GPIO controller nodes explicitly as they are=
 enabled already
>=20
> Vidya Sagar (5):
>   soc/tegra: bpmp: Update ABI header
>   dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
>   arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
>   arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
>     platform
>   PCI: tegra: Add support for PCIe endpoint mode in Tegra194

Hi Lorenzo,

I've acked patches 1, 2 and 5 of the series. I think you're going to
need to apply patch 1 in order to satisfy a build-time dependency from
patch 5. I can apply patches 3 and 4 to the Tegra tree since they're
only adding device tree content that may conflict with some other
patches that I have in the Tegra tree.

Does that sound reasonable?

Thierry

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5eXmUACgkQ3SOs138+
s6FGqQ//SZc5V8LZwgjymzl/i7cT6pra9G4FiC7lOGh3wefGsiUhHtjnSMK0T1fv
oeOyO1/dIIAWsl/qztmbf6Cq6ARu0f4bBo/ZpRAdC3CiyHn6kRmk8dChB9/JN+HY
RshU2ZcppcNhvhSQKWkyFBj8S05T4ceTO1GAoxwTd1OuVcORYXT3gP7Fiht6sfQu
74cIXdMELea+aDoucY2joPWmZRUkr0Rs+P1oQSSoCcETlEmM7I+cyM5QPQk1qLJK
q6b/peT9yJ/JBQuxo/MZ2K4ebUgyEVNQsreHbTOPLzHwidFSGSjev63CDPBEdTsD
4T+7thNE0OlFRoTfSBuaCrxtvPKpvWF+5XXYMYM2z8xyJAKZok9nz7CQPPOTUiNn
t5Qbf/vLBjbUD22sEUaZXBlalAeJgBOK0aW4YnxOh5xfRXKz6f5T4FLOwxKc91Zu
m3pHTaDLvm8YSXmiTbq62IvCp9Hc2fqBw3vUzbH1tvkcJA0DwH465rQx1ADM+To+
IQOOum66ZXNRrU4ctc5eZhEGF9rRclXXirdzIDPLmAbp1fjr23+Vxr46pwSGazcY
9tQb4UtptzcuvaWQ0HhkatEFWGHkjKKTevtRJ1J8w32/NzbaMZpGUBJIGfK8pe8z
OGhxDwZ77g2oQ3ULktj27BDFPzP8TT42JPvi+AHOmEiJTfFKNGo=
=Datu
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
