Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639272C5305
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgKZLdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKZLdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:33:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347CDC0613D4;
        Thu, 26 Nov 2020 03:33:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so1775297wrx.5;
        Thu, 26 Nov 2020 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=egb+rmPWPno8swR13kTmbmsZkyPaEBLCKtdqB1w9UiA=;
        b=iqFQYYdQI8gISvi1C9Dg6mKbqIslZEb09dy/L1ZR40p+F+yg+YAC9CI76uum4BO00C
         g3VCX5DpwR3DHZ6N+fGB8g2s8mUQoKuWmpavbb4Eoh+ECzLgy+e5ZRtehVvTPIsnRY3s
         z2YYdZMhCQgEzK93K0h9y3MGmsGOPw8FvV+DibgkG4mSl1EH4jlrUIuOOLesd+NZJ1Hc
         th3NH7aNF0OKo3vfeWl/k+yKCIVHvB/TapWk9drxNepAzrkIDmcGRRt3xW95Q5afrvRP
         rv+wbnqyU/t2pbrLh8X5ptWOBvkPxW/oGvtUSMT/q1QVX2mkvmLr0F0i73yOlq7psJXy
         ByCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=egb+rmPWPno8swR13kTmbmsZkyPaEBLCKtdqB1w9UiA=;
        b=Kb7UyEg9n2La7f5uQpNZnWWFQvhLIihdQ8lSaIpsOohjfh8aSOhMgyAqNrvlB6i+sZ
         D5rgq1dqodnAKsKGb3XOHziS6BhmFWdfiMmIns9OclxSGh2sWiBFAAr6nH81MzbMqLME
         VFq6yw88HzZ5D0zW6DkzHfYI9vW5mPp+OMNWvRtpavC1EDsuCfYXLNrXtIsmcbptbvHb
         VTqbtIiULHbg8ZgtXckEUlxiwEjP1qmfyHswSlEqhkiNkuSAozM+TKjWUpiwSul6YnZ4
         knFqpK+5XLXilBZP8L/IHKJm37TGROCBnersMlWaWzTizUGROgECWRTZaAmkmj79bw2w
         kuVA==
X-Gm-Message-State: AOAM531Vx6meKvQDeWV8YcGSrWZaMPuvkzRbeTF+gFMewCU9y3G8Yf5m
        4DPYM+YrJdTP3mdbBw+LRWk975lVYSY=
X-Google-Smtp-Source: ABdhPJzaGFQ6IAMq9ZcaiiRL6HBKdlfLRwagX8eN2M41MY6h64YKjws8L9ecaW0HRgZdT8etMq6Dvw==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr3298062wrt.425.1606390389979;
        Thu, 26 Nov 2020 03:33:09 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 64sm7770115wmd.12.2020.11.26.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:33:08 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:33:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 1/6] PCI: tegra: Fix ASPM-L1SS advertisement disable
 code
Message-ID: <X7+Sc5Mtp4OvrO4P@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QUSexSbmiWV2+Jzb"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-2-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--QUSexSbmiWV2+Jzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:32PM +0530, Vidya Sagar wrote:
> If the absence of CLKREQ# signal is indicated by the absence of
> "supports-clkreq" in the device-tree node, current driver is disabling
> the advertisement of ASPM-L1 Sub-States *before* the ASPM-L1 Sub-States
> offset is correctly initialized. Since default value of the ASPM-L1SS
> offset is zero, this is causing the Vendor-ID wrongly programmed to 0x10d2
> instead of Nvidia's 0x10de thereby the quirks applicable for Tegra194 are
> not being applied. This patch fixes this issue by refactoring the
> code that disables the ASPM-L1SS advertisement.
>=20
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
>=20
> V3:
> * None
>=20
> V2:
> * None
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks like this no longer applies cleanly after that other fix that you
sent earlier. But looking more closely, that's because that other fix
already incorporates an equivalent change, so I think this can be
dropped from this series.

Thierry

--QUSexSbmiWV2+Jzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/knMACgkQ3SOs138+
s6HZMw/+Np2N2UUAqaMpg/MvWdVK9xG7mYjMmqccpmf8B2Gan0nXW9a4cWUC8OIa
TfEuy9GaHiBWdQKnYgtawXmPen/ZremoFl3EbIqcgOuMzkV28dpRBqFu4yaOmnun
JaSMo3R21yv4gjH5lHTmimcXeHIKKizQhkw0t8uov+Qdo8coypV/85vuxCh8c1XR
7LBFG/fUyZjip4H2rLygZyF6eKDPSa6ydYhb1PytrNtYz99kjPOzyOtsTA/P7N5A
2sGVxvF/o7UR1rVHmBSiUr4tPKEDW1Wy/37rygvJ04vWIO9hgaITGCCnjTMe7zG2
3OQnV5hS8QwAfVeW5RMuNcnq/wpG/v3sZWwqkU9clhC4eNfXsJ431ORKWrUB2CAG
0HFro8bFVxPcKxJ1MehA0b+yB1k9CwwjBsMn0GnqKQE1EmHcT51mLfjMmtxHhAoJ
Ss2/eXvWFV7p8uTrwir4ExKAiaOzEe4jWPp0SemPlrXftCJqsi3WSor/bTZLRmVA
ORGbqfXdG3wnw2Qj0gV9sL4qu7XU92V+ARAuE/f9cZt9ZbI+ffVy3BQwZsF9/zmp
VsAFPQColm4qbJFWoPuS6MwL2ajnSQyr37/wBv5Ik8eHTAGdKUWFE+1Ie+8aPSWR
rzDfC4KzLCsjZnDhiPc/lwzKoZPpKG4UUnNWdItoaBP+TQKNHHU=
=UII4
-----END PGP SIGNATURE-----

--QUSexSbmiWV2+Jzb--
