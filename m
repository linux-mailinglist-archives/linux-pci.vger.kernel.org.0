Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17918B99
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEIOVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:21:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45475 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIOVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:21:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so3286138wra.12;
        Thu, 09 May 2019 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rljv+mrzrY35vD5CyjYaboWQ/Qhn4O7mguM7MNHSFdE=;
        b=dMIhw5M+af6CtNzWEXatWxFMXi/vk4dluBcTl4Win7/MGBYWDoI1/ZqEMsNWOwYu2N
         KugdpmlcEGOVMwpSS1iTG8iiuak1gmiU+KDopJrAeGHLqXwHHTU81mI4ZHEzRuFn+HCK
         N4SUvnbyhLB6xDpNVbty4ELZgZlVusrTomS/91dygJ3iMvyWTAzeNiPff12jGWyuco7Y
         kjEZYH8HnulLATg5DmnpPEmKN9oQ9nVAGFGKkk68Rw2S74KZfzuMLlCDzyqry1K9nvr7
         3gmLuWq/1il63i5QIPjmZFCCrTwKNxL3FFQ+JaUMzZlwZL6laHplZPxzOh4+E9PBwveL
         44uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rljv+mrzrY35vD5CyjYaboWQ/Qhn4O7mguM7MNHSFdE=;
        b=lYj1BvDHN4GiQjwMT09vFh5eqbdqJ8ZpJFkVFMQfKB7a/KVBIKyEaHXKXTIPArG8+x
         qdrPRn0dHBbSAdgHGkPtqYcDie74BIZk1NWjIv68coJfZoEb3DgvLghtToB7wB7Fj8qL
         kGAy+ApSjIfwOgR6QDWVBAxNxBUy/veR64JcYW0oeilBsMlYRBBgyaXsT6G4MbYbcrVA
         2oSbOJplWzsJRZJXYIp9zTleaA1Kg8mx/O7tWS417+ut4sibMhwVrWwg2R1IA6+4IaC/
         jO3HhatFOU8huMiuFH40k/VRV5KoDpBdGNMQRdcR5LPyoglQFlHdVxKb2YIcipVBFI+M
         jMVw==
X-Gm-Message-State: APjAAAVxtPoPzh4jAynbBtQgfaDikBex4lFdmM2JX1i/BLUY2vV245+V
        M1rqx5o9hkK+Q4fcw5TSdS4=
X-Google-Smtp-Source: APXvYqxKdH8ulP8s05ljj1OouZMHdwwQTqSqIQ9zTmYGlmMv9wE3NdJuNeOcl5Ky6ECjgArllfwHrg==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr3524362wrm.188.1557411712918;
        Thu, 09 May 2019 07:21:52 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c139sm4197754wmd.26.2019.05.09.07.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:21:50 -0700 (PDT)
Date:   Thu, 9 May 2019 16:21:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 14/28] PCI: tegra: Add SW fixup for RAW violations
Message-ID: <20190509142149.GK8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-15-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-15-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:11PM +0530, Manikanta Maddireddy wrote:
> The logic which blocks read requests till AFI gets ACK for all outstanding
> writes from memory controller does not behave correctly when number of
> outstanding writes become more than 32 in Tegra124 and Tegra132.
>=20
> SW fixup is to prevent writes from accumulating more than 32 by,
>  - limiting outstanding posted writes to 14
>  - modifying Gen1 and Gen2 UpdateFC timer frequency
>=20
> UpdateFC timer frequency is equal to twice the value of register content
> in nsec. These settings are recommended after stress testing with differe=
nt
> values.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Changed update_fc_val to update_fc_threshold
>=20
>  drivers/pci/controller/pci-tegra.c | 34 ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUN30ACgkQ3SOs138+
s6HFQw/+PTC7RN71AKKN6opIjXVg0LiEMaoj3Q48f4ybfsn53m38RUQj8EhdxpMX
LXr8NflHDE0i1nJA/B1NXqAtVWASiM+4fPZOQHtHznUQip/910twhFMabhcxJ6sM
8vBcNe4pBDgnlpPltf/G/F4ztf8lYbffAdGM8X6swv955SVB3UL2g7LCpiwoawSZ
mpvKNTSdiwd+8okBeFvRcqu1WSnt9Gqd3JH99t1NM83IwU1kMCmJNG9BiwYmUMck
OD3grHpwffxRJde+MDZ0OPDOPhYxSJh1qQ2j9a682Vk4QYMtFzFnNXmFLweQqwV8
Ajp++bGjdSRbasjXXdaCyLa/o/z7sMZLTb793yy19PjF1mJR6SuSqLgmcMLaX/GB
pu4qhZGyfHVVGwvB9eo/JQ74/7Q0dJnW8oPnQULjf3wB/iSP3VC53bYQ+d0RcuoO
QSzBwCypk/91xA32xWxoG6xxV7xM4drsp4jplgFwGwldgEdxMIclBdZGxi5jdSLG
aJ1f/WhveIB6f3DVsMM55vwkNDW13fSMI9oD2hCUhYa3bOqbcw//FQz8ZZUhj82f
vuTJG/7XBLObZWea9AyAn5tpg/EFmWAHHGcwHsxTZUuL35b/fgPu0NGeZmtEQyNS
b90w0j9e6RV4xeGqaSas4ORQIybgJN6NTcTzehZrDfCMlHxPehQ=
=cly3
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
