Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503B69FDF1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfH1JKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 05:10:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34369 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1JKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 05:10:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so1705888wrn.1;
        Wed, 28 Aug 2019 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFlqAp2x5XoWNK93bhZ/9/y1+CkqFqA2O+2huwenNm4=;
        b=sdUOzUxi4fKV+zG4ZfoHVEK81bwkcxfpuIhGWI7b6/EBRURefqRs7GEn66RrwT0tmz
         D7DnOGAjuVNXUQL10RlayiJ+JrpvdMCYUmGz4pVZdfX8k1h11qXP5vcesIzPsPGWY/6x
         cVyE+XVt38OddAoub9fkpWExOzqManJglG9EP8oJWgO7eTLWRMwpbUhAd2eKaK+fVITm
         SUZKD4920Z458M7Z7lrTk7tLLQ2kfpR/Ci+dsSNrEwIF06HlczH1CzP+Zr//4KW1SH2H
         LCXMzMIe8t9b6TV9NKiC65RWc+b6o9hANNZXJQv4h51Hy7od7gEUpXttAvfwiKmIgVQR
         q/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFlqAp2x5XoWNK93bhZ/9/y1+CkqFqA2O+2huwenNm4=;
        b=LhrBv/k7ZNUTKJKwKtKHdGOoA60UI/EIK3t5wh2bEr85GJtqFs/+RVsCjtDwO2PnYO
         MPF+bympt9H+txnp4ljQALOCWLlcR2Gn968/bv9nqUI/tY7TwmMxm88J90DuWKL3zaU/
         kjotp9g0OaMthIHabRnbn9oiaT2bpm8bH51Uv5oGM7zXmxieQLy4fUTP6jCHONJqM8LO
         lQR3qnGC5JvQCDhF2aRRe3RiCZDj9D/QF2+hFT0hiKW19h9TZ6FTZkkhSXLJVD6H4a+7
         xrJ9aa2vQ37aVSOdXhlE8vFqULP9exrODZdlRE+4O5y8CptwKlV4Uo51FVR4kvSdW5AP
         F9qw==
X-Gm-Message-State: APjAAAVmJF+wRoqHo9p7gMkmCv3NtY7b+XldX0jxNzy7xlifsYnwnyyD
        GgIygQO8ufHzkphv2EfAijA=
X-Google-Smtp-Source: APXvYqxRnsrd2FzTK9oUAQ5WfWWNaFzn4KLktyjySddPaAxaVyLRqyxBW/Iv7/4BkVhqqQjTR3iKhA==
X-Received: by 2002:adf:d1a4:: with SMTP id w4mr2877531wrc.331.1566983430193;
        Wed, 28 Aug 2019 02:10:30 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id n14sm5971066wra.75.2019.08.28.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:10:29 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:10:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, kishon@ti.com, gustavo.pimentel@synopsys.com,
        digetx@gmail.com, mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 0/6] PCI: tegra: Enable PCIe C5 controller of Tegra194 in
 p2972-0000 platform
Message-ID: <20190828091028.GB2917@ulmo>
References: <20190826073143.4582-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20190826073143.4582-1-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 01:01:37PM +0530, Vidya Sagar wrote:
> This patch series enables Tegra194's C5 controller which owns x16 slot in
> p2972-0000 platform. C5 controller's PERST# and CLKREQ# are not configure=
d as
> output and bi-directional signals by default and hence they need to be
> configured explicitly. Also, x16 slot's 3.3V and 12V supplies are control=
led
> through GPIOs and hence they need to be enabled through regulator framewo=
rk.
> This patch series adds required infrastructural support to address both t=
he
> aforementioned requirements.
> Testing done on p2972-0000 platform
> - Able to enumerate devices connected to x16 slot (owned by C5 controller)
> - Enumerated device's functionality verified
> - Suspend-Resume sequence is verified with device connected to x16 slot
>=20
> Vidya Sagar (6):
>   dt-bindings: PCI: tegra: Add sideband pins configuration entries
>   arm64: tegra: Add configuration for PCIe C5 sideband signals
>   PCI: tegra: Add support to configure sideband pins
>   dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
>   arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
>   PCI: tegra: Add support to enable slot regulators

Hi Vidya,

when you resend with review comments addressed, can you please reorder
the patches slightly? I think it's more natural to order them like this:

    dt-bindings: PCI: tegra: Add sideband pins configuration entries
    PCI: tegra: Add support to configure sideband pins
    dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
    PCI: tegra: Add support to enable slot regulators
    arm64: tegra: Add configuration for PCIe C5 sideband signals
    arm64: tegra: Add PCIe slot supply information in p2972-0000 platform

Or perhaps even like this:

    dt-bindings: PCI: tegra: Add sideband pins configuration entries
    dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
    PCI: tegra: Add support to configure sideband pins
    PCI: tegra: Add support to enable slot regulators
    arm64: tegra: Add configuration for PCIe C5 sideband signals
    arm64: tegra: Add PCIe slot supply information in p2972-0000 platform

That makes it more obvious that patches 1-2 need an Acked-by from Rob
and patches 1-4 need to go through Lorenzo's tree and that I'll pick up
patches 5-6.

Thierry

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1mRQQACgkQ3SOs138+
s6GoKg//c0Y8aNQgON5iL5nm5/UbKfGB8YDwT6hVWpzkOowmnglV2QSXZG73j4mx
hjXJuiSrXTTDgdhKhDYSv+xxG+SB3sUMCtxG6BkPxjMgElw8PuLo/qfjTzHIGN7P
4OzB/u3fInyfoO4lrb1bVqR/DysGqpyuX/eoGHtAD99UKvuaCoPq/YuRMuEJB9uM
P/iNX66JVhfYRag1BTGdkawWxTHhZUujAIXWJRyDvNN43xA30Y401ZZIzrKnvqCg
BLv7/bCXpx1i9jN5WtvTwjp1MbgjrKrTI5eMe0yrHyI/JuFC7mqWEIW+pNuO7GYB
taA7C27Yod+pvaGbiacVpzRFZMXaiDxhE3/DuxjQ3wD4decVzPGMh3adHmAhISCM
LMwHxo0IwTZTZPubNkLRuymqy+r5bGYNd8LkNdy2pVs0awL/JkfkIQTNkMD97/O9
9giB1qsTILOXPeD2nI/xHlQvYu8nmwldvefoh+c815Ym17IaVRrXCZwqzudVBuvu
+xUM2rpbLEXtqrIK6g18q8rWdpO4wHFJcqrcjX8fzdaMOPpSDVxD7TESYLt8rQ70
IwylYJxXWR7yR2YfOAv5x8tLTzbxkju/NU8TXBooVDoqiZGl9wNOFbsjhr2VCxQs
u97ZCPtSZ3x4a2yFlVMHBStYPz4XZUA451oncHfju3K8tviyaTQ=
=Y3Mi
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
