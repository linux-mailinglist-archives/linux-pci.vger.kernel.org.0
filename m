Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7802CECBE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgLDLIi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDLIi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 06:08:38 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C153BC0613D1;
        Fri,  4 Dec 2020 03:07:57 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id r5so5361505eda.12;
        Fri, 04 Dec 2020 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tGE58xJJnMBWfPFbl6SXcf2i1QFJErPj8dMFW1kpc7g=;
        b=pLG4jjV4omrX89Dzk4D2haEHZI15MUrHzUd+D7rbkLA0Ahrnp20aY43no1bMHCBjn5
         RuP+6FkinwBzMrz+XWRlgJExQElz0Me6GRfvJ/mLSIPa8L1W+BlN2dh3htb0EGVn/fwI
         pWzHo8i65aVpCURzYOXV+w8gGjSilbxpo1VMM1TUYU9nS4hGMMSVAtel8xpNv6hcD95/
         B/sKbpwLSDD3joo4w9m7aoOBu1+4RI2Zc+wGUaI6Z5XN0NMDi9YatM+Dewjkhk+2bDf4
         j9lXbwiV+WBj9ZghkFKrukj6TFADLu4yjrJPH3//I/wlIl/wJSPCuurTlfGlVn7JIMj/
         D/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGE58xJJnMBWfPFbl6SXcf2i1QFJErPj8dMFW1kpc7g=;
        b=uHWmvU8IfAfARcTXe+ua85pMI2uWWKPkdTRtG+qQLJ5RbhuXJYkYm33WgVwPZvT0KY
         pdyezM3dOctVJgqXcwyf8koMlSCnrEF3wjWcEp+Bco1rt6mlmd3YD0fNnn26YCFKcuV6
         79QnjObB6sZCsst2UMCPzyOEfLh72/Dg7KuBxpGtPdypU/GigFzh/q0XZXf/fTK7wDN0
         icCNTLYTW9d45SUulTP49P1kUJfoJtVKU6jEIBJqPg1LuHCkWyLQx3vhicqzqpz/1zaL
         B823L4YMFXJ92Za7q7k/zDXAH00JosS1wRQak3881cpXJ1dvkrtSJ9mkza0TzJ4Z88j1
         5Nxw==
X-Gm-Message-State: AOAM533eTtFicNozNG5GBsPAmcExMxh/lMD4U8uqOjsZKSyME9F089Mq
        rUeDBSyKFZWR29rE8INanho=
X-Google-Smtp-Source: ABdhPJx1oiI9JzRc5nGhj8DLD+ECSmIsxEd+1RgkYGhkEeI78uJtSMbQFzZRhBKO1kKzRPZuiHpqoQ==
X-Received: by 2002:aa7:c58a:: with SMTP id g10mr6854629edq.315.1607080076583;
        Fri, 04 Dec 2020 03:07:56 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id bn21sm594197ejb.47.2020.12.04.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:07:55 -0800 (PST)
Date:   Fri, 4 Dec 2020 12:07:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Set device flag indicating only 32-bit
 MSI support
Message-ID: <X8oYigOObo6jdPz+@ulmo>
References: <20201203185110.1583077-1-helgaas@kernel.org>
 <20201203185110.1583077-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dEsie2Ei6RHjqtCU"
Content-Disposition: inline
In-Reply-To: <20201203185110.1583077-4-helgaas@kernel.org>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dEsie2Ei6RHjqtCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 12:51:10PM -0600, Bjorn Helgaas wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
>=20
> The MSI-X Capability requires devices to support 64-bit Message Addresses,
> but the MSI Capability can support either 32- or 64-bit addresses.
>=20
> Previously, we set dev->no_64bit_msi for a few broken devices that
> advertise 64-bit MSI support but don't correctly support it.
>=20
> In addition, check the MSI "64-bit Address Capable" bit for all devices a=
nd
> set dev->no_64bit_msi for devices that don't advertise 64-bit support.
> This allows msi_verify_entries() to catch arch code defects that assign
> 64-bit addresses when they're not supported.
>=20
> [bhelgaas: set no_64bit_msi in pci_msi_init(), commit log]
> Link: https://lore.kernel.org/r/20201124105035.24573-1-vidyas@nvidia.com
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/msi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--dEsie2Ei6RHjqtCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KGIkACgkQ3SOs138+
s6Fe3Q/+OQTuq82Ox94uHxstM6hyYBsILlvWtl42oiIOh8h3yccko1425i5Ujvcp
Qa93K36CxS/hMPwpLzVVhOoKc3+HZ6DinqTO9Q3qbp6A1rqGjDBCwF88rTEhxqqq
YB6hyLjRdjyY/a67KA/IVSnl4bbmxYRv9S8uD58PTm3fs7FXuBcFW3xQ8G6Sy+MF
2txn0iDKHYx+9mKDudMNqlRtJDKeTFYNyCJOByYAsOQCFqLOrdnnmntmid9Z2Wby
QrRqJ0VjscE+0e9sZ7Jf4jhVFQCG2WkHL8KtFEREnOWGubF90bfbvWaD3X9ZtL/N
mA5HS/RHH1QxoSMhbS2vYnkc9/1kgZSxA3RM/UISI4dRQZFAyhnBaXCyVrO7/7Ci
5XJqOkOCnc3L6P8Gkw8YOk0M0CqOltUeC2eNy+8UIm+RDBtKxuMkO3z3X8lNAd0h
lqwA2Qu+DTnJ5SkE+R0Xw4HMAzS+wySMMjPUkQ85Pqi9hmNHP1V1FV2gTTqXJ5fr
+zZ4JNAVtfB4dNGTaEGpLHnP3XixKi0SjFF/pTPECGEIWfCSN2GUa0oEVstOl3gh
kbCJEL+vDFhtbZU0qFL4TKwAb98L/cvoWqif2R/6rZlew/tMUstYD5J1l9jDrPp8
JcRLgREg8aYMV1c7yd9iYBrzvfzPpH8ajgS9xNgofQnIa8OTcnA=
=KaLO
-----END PGP SIGNATURE-----

--dEsie2Ei6RHjqtCU--
