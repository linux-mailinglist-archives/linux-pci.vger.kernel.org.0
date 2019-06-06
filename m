Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F073780F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfFFPeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 11:34:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51807 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfFFPeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 11:34:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so409737wmb.1;
        Thu, 06 Jun 2019 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YNCZH4cwmzPfukjIuLRGuMkntmVdByW0qbXhUjyBVJI=;
        b=qkTuWFTlw3+q8iegPcKQi5pHRkjycGloiIIztCCnol8eUIPokPCXP4YRVghDXDiwSK
         G9p8cvDaWEVxt0dCZ2CKExTIKqIRnqOCq4ZK8EXYWbTi5aSHF2+AoESLcZWuHMykQ/dq
         gXx+aq/LsdL2uFtqWoT98mHJ6HtH+LbosxYY6Fr4QFD3rim+dI2jxLb0+oQpCav0+/kQ
         z368AmjqFNen6gnMfrduuUo3a6Xf5Tln7SofOb8EEom1KHuTY5vwQiFKOHqAxgELqdtB
         w9/xd0qp+1/wr2nya+0+ra7AX4cW9pMKhrDgGlu+xegVxxWiw/yQL+6CxNgCvBBg9exk
         Ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNCZH4cwmzPfukjIuLRGuMkntmVdByW0qbXhUjyBVJI=;
        b=b30l//SlwmLh30Xk+29HTEFGOvwyBskPVfWmaXPHv4jYFLkxGNE+YEj/MxsYl+R//Z
         ijuCOnvJC6FpxvunSW4v1b3DqmbmtscLrGIxZZbf87BbMMr9bbcwMJb7IMwz+am6fkGx
         FGrn7urZX8alC+hk3FJoSKlVyvgs4TglwLBC73tuxciZ1wbLn700NVd86fYVj9Co4PwG
         0R6lIZzn2RlXHKTbwbX1FY6eR4p+jh/scFpszB6htFMb/0jPFsV7u3gP8dPrB/jOsuQb
         e29ArEx6YvyflL9qox6f9S6+1czHJAyCGhF/OTGQo9aWYcTNGW6eR8SXdu/bwA0WQMDT
         YWaA==
X-Gm-Message-State: APjAAAWnWrU0lr3qN4uL5N5M+88WcVzK7X2ChyvSqnH0oylTRCw9iHcn
        Wy/RYlB3VXVQ0my+xhSkpzs=
X-Google-Smtp-Source: APXvYqwlmKS/iYNpwXsxb3o95trjpJEbEMQt25ZZsFm3shcsDu2hQJZ+WVxjYH8Lt0OMyySB6KY5wQ==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr503162wmb.80.1559835251398;
        Thu, 06 Jun 2019 08:34:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u13sm2173183wrq.62.2019.06.06.08.34.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:34:10 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:34:09 +0200
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
Subject: Re: [PATCH V8 09/15] dt-bindings: PCI: tegra: Add device tree
 support for Tegra194
Message-ID: <20190606153409.GB3338@ulmo>
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-10-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20190526043751.12729-10-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2019 at 10:07:45AM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Thierry Reding <treding@nvidia.com>

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz5MnEACgkQ3SOs138+
s6EZuRAArnRIwdHFGGw7PRPo7CkDJeVM+eTKg/JkJJmI9FfY5NbdVm7wwEXJJg4b
jkzRaxcDKtL/8WkfptcnjrtRiz+GY5oz4+FvkIqaAXVy2pYQChgfecQ5fTgf8R5b
U/cyR75uLNk7VTyOjHsn8s16NsvTEe4eVgxQzt9OF/AiR0OPeT2Fnu/wvUO5MJmA
zeyr/MaJ8vkm6qOmkntugy0cTjx+o0/7kOd7Oi7FEOOvrKUsgbuW3k31pvykYIbE
qzDwL+R7Ay9h3dM+OAbRgrK7K/sHZFJQxGtIRn8jq5iTIJcPs8jIK+B5v8d8ahlC
aSlUS1gouB7Fp0zSJEdD25wGtZh8MV80kM9wSC/R/4CnY1VqX+/o5sDbL0X8ir1v
cd9h+XKLY5ZgSRsz1EHdbilB+uu5LNtDYBdkBWcEY7oLM/ACom2JSI4vtJs0w7nJ
yBWq1Qxw/9Gy8pOc3YfUuNx2yjdlK1c9QwLJd585/aKExzYJfrlOCvljY4nl75DD
1bw4mDI7uWdBWUhgsdMugW2sVz5RgkVPjen2sx+tIgBPCmR8JInAEROvIpALG5hC
9VHz2Yc2GGSM6tHiVUD5lBmNmhdh1PS38nEw4KUEuDFlc26S7S9Vf/tqHlwZ0G4f
JaFf4UTs1U7Z+PtXw13of7OpxYVFfdMlswoI6y1ottPBuBFhLU0=
=M5MQ
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
