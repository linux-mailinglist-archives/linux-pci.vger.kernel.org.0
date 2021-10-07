Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F3425A95
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbhJGSWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbhJGSWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 14:22:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B6C061570;
        Thu,  7 Oct 2021 11:20:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so21819431wra.12;
        Thu, 07 Oct 2021 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZhRc3IAVIWWRvmpAKxKFqnsUK7qkqPNFf3jkMFv7izQ=;
        b=oWyAHrMEEqN2TjisKfEm57exXvKbVMsqnuwNDDiWf2JffyM2M+XfBFnHyNY/QGT4Om
         ykNe++M5OkdwDDlDtlAYXjoooraddakglmcmTFOGi9e50Kpu27tQNpjMTIgh/Yz5s1LP
         llIgQQiOk/Usm9SZCKRqmOJ20/9ioV1LC8O4CqQjBNAfbaYKFvnBlQcUpAtUwXCX/Uin
         2+NMNrpSFPB67gBYILJOmb8KBTZKbf0uTmT/GlzibfBHGLfo4eOOv2rs1P1O+k2vHLJl
         3gGx3fUvJ4IZ9hzk/BQWdHKb1Ai0oAtCaL5IBIK2CaPz/fbIWWDWLUpSIGBpe6UT8NXt
         T0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZhRc3IAVIWWRvmpAKxKFqnsUK7qkqPNFf3jkMFv7izQ=;
        b=OLsSky9vC0JsTFbftNdTEQhvhVVNhN8VKEeSHDykulEEWpcPiv+00q99HmjAQDR//r
         iamIxyC5W/X9iPMjpJiudAJYV45LH7cpxgOQoJyaMhof2Z51tHagfv/3B0C/ZHad+wyi
         P8LNeBBoI8qI8v8MYLDrDItE/zyusXTQXh6ItS3wJ+1wa5Pcg/2oIpEFhIhf25Y8e4iC
         UKZb1KLwuXK68bnnEs+BhCwkMY3iSN2ARyAJGibWGkImE4H0saNpP1j2Yosbp3BYb/i8
         xbP4v6HIAC/xpxfNMKg8vDPMVN8m5kdM7jjzXtntkBrjipmlB27beiw8M0PbFE2t3kKH
         3kiA==
X-Gm-Message-State: AOAM5310BVnWh7KNxGRk7xdDQSNQiRQGzqzC2tAo8bw9HY5da1ADUy4p
        yUXgPoM+p5DieA4wB98Xdbc=
X-Google-Smtp-Source: ABdhPJyOIH5TcuNb1sU5BtAlgXgXJLi+DF3EpG2bg6oQlOPaGpJdfehv2C4luHYj4RhgFQzk3PuRQg==
X-Received: by 2002:a5d:6e07:: with SMTP id h7mr7238580wrz.316.1633630836216;
        Thu, 07 Oct 2021 11:20:36 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 1sm9776516wmb.24.2021.10.07.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:20:35 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:20:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] thermal: tegra-bpmp: Handle errors in BPMP response
Message-ID: <YV86cX/omlQa3kpq@orome.fritz.box>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mNygngPfE2c7dPK/"
Content-Disposition: inline
In-Reply-To: <20210915085517.1669675-1-mperttunen@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--mNygngPfE2c7dPK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 11:55:13AM +0300, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/thermal/tegra/tegra-bpmp-thermal.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Perhaps this should be moved into tegra_bpmp_transfer() or some new
helper to make sure we can keep this consistent across all callers.

For instance, I'm not sure -EINVAL is the right (or best) error code in
all the cases. Either way, seems fine in this case and this is certainly
an improvement, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--mNygngPfE2c7dPK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfOnEACgkQ3SOs138+
s6GF5hAAvcqbHotJ7/HfxHZw0Q5tzuEr3kbxIRtzPmUYW1+JvufApgP2RwP4uJMv
Hkv33HYDbxvw1VLelxVMXcXqwdRUx27s19NJmwpFYkK0UfYQduCSQi0lhZtkKfz9
u09wKBbO3C3NLl10+7Ea+JSMPHWRkfW/4oUcehDMx9Gpevh8BYFU5B9+Roj7evPr
eKTQGTvmVcH7FuJN65bduYNRRwLJMAJzgkTQiLKrC2cnxDT9HCHdBtBTCz85cNRH
fr4+JTLkcusQ9mecjW4v9PGCya6sJbKDmIFs1HmsAZw/FdPzRunhgMZQPDqzKH+M
55v+v8NKYHWaNv7CprHrIVLEie7BwfJmSJBiFMXcKIxFhUJAXGWXWrBThu1vRr5z
gd18EWn5AjL/UVpszrMlw+lE6R9BMdm7sR4F4YqWIWwtxE24E2GRYagZ9dJ/7IMN
Bs/BKI/7ga+53lzvXmInNQZButAs2/k8M0DYdJN/hR7JgJzDgc5ndOd0VD3exNpJ
p6Id25UedjtHDw+rjwyTrKuwfiarfXBJtG49hCBt8FFx3vo3ghBCUazvws5Yy01t
wIv3Ecep90hwKWbHxAex+kS51zfiZO6b4zweqrd1jk7k7+KYC8hif/kLwmpzu5Yv
6WWuGanxaJXDtGoBv2HyCnAskeW6TMvDE6Ui0eMI4M9++e/JqYY=
=6Gov
-----END PGP SIGNATURE-----

--mNygngPfE2c7dPK/--
