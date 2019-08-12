Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8382689B6A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHLKZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 06:25:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfHLKZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 06:25:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so104086669wru.13;
        Mon, 12 Aug 2019 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIAupDPuXjY8vH3r8F2CpCcWnZ4atzq5h0b+kQLhH+s=;
        b=OCwdg+fJef/L9XVuxGY6Alc24Gm4QyZwIk/wWZcJYtfVz0llGuYy8hWIL6dE+CA3Dw
         foGBga0+uFwLxB9DqB/HFPOP0dD/j5Re/mq7r0FkzKjWRgMOBaatS6DAYsW64Q0IoCgT
         v3frKbqCMimQUei0PcaZs3yRncEgP3eVPiVmT2TwOXUAMZDNRzujsM57IKh+zZ1A5DAI
         kOrbhdFdgonKD+eFZttxFiDHiUk2waWwVBdVjv0BsA0OHm9PhEsvKBor4AACD2p938D9
         rKHREm9//MXZEIgDLZ3TArowHQJ0UaDHyG7/ITkQrpNG3ELS+qdc27o00i8tiI5jd3ZL
         ZbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIAupDPuXjY8vH3r8F2CpCcWnZ4atzq5h0b+kQLhH+s=;
        b=EVZF18kU9L9nvCTMdSqvX2BGdT4TIHNWIIdR4D50n9QaSuLDt1z6BNOiLgl57OFWmJ
         FdeMoGiETctJwqasy+ceHYAuRCjrNChINbx8MXMnIrUGevTNsT4xCiE17NCYhyn8yMeO
         7QcW633fbSk/FROLnRsYNXJYe3Iz/LMQDMKDpLkM1pdBZvwo1sKq6XwgpURcKpP+0DDM
         mLxCP0vMAaCmx+BkkkyOa8JnHvjor0BX1C06RbPsn7zm6scRezBELJEk76Sy2FQVFDMo
         TyHKfGQ4b6A0e6FRUztc+hqoghRkJr79mhhVD9L6d9KJRYlOcqCOnAMzbDP9Y34a/Re3
         tAgg==
X-Gm-Message-State: APjAAAUEGDb/qkT8P6uLmBDDjUOb2r60SMWhbypTDTd8YHQ+D089TTqL
        2QdoJnz/bSeq9dm4yWiH0Rk=
X-Google-Smtp-Source: APXvYqzOg/oqt5FDmrHHGm4UwI9Lwb2F5Q0/VdEDMZCcUfcUWnykIVeThG56IyoyM5PHpJ5vVFM8hA==
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr20581202wra.251.1565605522275;
        Mon, 12 Aug 2019 03:25:22 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id a84sm16437631wmf.29.2019.08.12.03.25.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:25:20 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:25:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V15 00/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190812102519.GN8903@ulmo>
References: <20190809044609.20401-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Content-Disposition: inline
In-Reply-To: <20190809044609.20401-1-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 10:15:56AM +0530, Vidya Sagar wrote:
> Tegra194 has six PCIe controllers based on Synopsys DesignWare core.
> There are two Universal PHY (UPHY) blocks with each supporting 12(HSIO:
> Hisg Speed IO) and 8(NVHS: NVIDIA High Speed) lanes respectively.
> Controllers:0~4 use UPHY lanes from HSIO brick whereas Controller:5 uses
> UPHY lanes from NVHS brick. Lane mapping in HSIO UPHY brick to each PCIe
> controller (0~4) is controlled in XBAR module by BPMP-FW. Since PCIe
> core has PIPE interface, a glue module called PIPE-to-UPHY (P2U) is used
> to connect each UPHY lane (applicable to both HSIO and NVHS UPHY bricks)
> to PCIe controller
> This patch series
> - Adds support for P2U PHY driver
> - Adds support for PCIe host controller
> - Adds device tree nodes each PCIe controllers
> - Enables nodes applicable to p2972-0000 platform
> - Adds helper APIs in Designware core driver to get capability regs offset
> - Adds defines for new feature registers of PCIe spec revision 4
> - Makes changes in DesignWare core driver to get Tegra194 PCIe working
>=20
> Testing done on P2972-0000 platform
> - Able to get PCIe link up with on-board Marvel eSATA controller
> - Able to get PCIe link up with NVMe cards connected to M.2 Key-M slot
> - Able to do data transfers with both SATA drives and NVMe cards
> - Able to perform suspend-resume sequence

Do you happen to have a patch for P2972-0000 PCI support? I don't see it
in this series.

Thierry

--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RPo8ACgkQ3SOs138+
s6H7Pg//dh1al8/AaKqfOXUV7vJCuuAAP7eFAzEZssLuFIavDHghC4X+d5w0OsdZ
eOnaJyrojkIFvpialETEQ3G+MLw2HyFoBt+f1G827JsyxMvVe+LDkGa2skg79F1y
wa3gCp2zTkMM1mzS7cfm4wxGSdN1nUuuu63kMvBHpBOALTYnWeGv6hov5/rO+Yqg
B9Wjbwu2rzNjNKirRW98/nUL5A9Ilxd4rVBu7o7JLz0VSoCdZ/5+DpursUTzZZz/
9EbUFzy7pngftxrHxOL4DabxegjdehBj5JKQ7vR1ORmSo/9iukVrXh8dptqayijU
8KUUWoYpnXmCCjBIAoc7mBwrwGfqZm9hF9rGedCILnpWxlVLgrXCxClsvBUn84TL
db/VKF34Qo20wUfEPwUl0k5QjFwUc369XjfBEhBibkIXQb8+/4pA0EvolU7kedv7
VrcLkUkEEPgGpTieaEKN11N3gARx8sEDde0muyKMG/bnRQmnvbq65nT0iiNI+lbj
anvrkE3goyCno6raR0u7JLiWxCOgLVXA94aY+95h+16XpG6+jSQzgJfYWV0Xhi2L
yPAuIH5zKzz2uzzbyqa4eF39lW0P4oBxghVt8jEvUfuqzcTXnR4VenQaciTjUb2A
4S5Rtd/jNgp48OFTOpJTxcSPIBRZLzPKZnGGRhFGrpWZWUGikmY=
=BYfL
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--
