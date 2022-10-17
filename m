Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB0600F6F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJQMqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJQMq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 08:46:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D546E4F181;
        Mon, 17 Oct 2022 05:46:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y14so24593569ejd.9;
        Mon, 17 Oct 2022 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VhTPIytBoNv8+TbDZr5QCn1+oF/ctoi5F9yehDAD1M=;
        b=iRXBmm8wwjYtv2OYRKxE/LrfNj1sYEjNBMuG3M3Setn7W8eHVitAWYMnlB/Ne3Nic2
         1nBT4OQcZ82jXdKEnDB4fjTtns4CL+YQOM1Fb6DZcpIfzafztje0b33+C6jOgSZjC3DA
         Zks4YDrTKv2hAi/YQHCTMvVJXPb4VAHPujq/m7+Xqarz695AbtlYeVGxIDedrQ0H6ymU
         3sOw6BxE3OMIOiNjaSxRCiEJk9SdI3OAn/HEU/qX0WOdlpJAZBTPZFrL5feNhfbTQJc3
         UmwQvzzBK7IyNWdEjksQ2r2Q5lRuk/m73JoNqs5j7sCteidq7mZWtqHE3OcnmFvyDCu7
         ZUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VhTPIytBoNv8+TbDZr5QCn1+oF/ctoi5F9yehDAD1M=;
        b=mMJsn6qV5ib65t5EnltuJAfgHVSp8ZtDsNHf/hXzTLRTe8+Mz/ZnbBtb9heuCU52mi
         b6hE5f3yIIcxSobKhUrL/VC1QVrxl5dQkT7wnA5s+MZ8T3qejZg2txTaQUd2MZKwJt/M
         p6vVXofCO6aX91PPn1FYTDL3ZAJLHP31aAxDbIrPBccSTwptRQq7YJ9ZwChUF1UlYQAV
         ndu6XKw0GWSL8h+VzmYvAAwe0er/ICmWOddTsCa78RmiTmsaXjrSzyGYPci5/NUKdDWp
         OZMDyXlH5lWqy5aGG8EcZx7AtuKX0rcpiZizTwXW/Lff7nNoZgYQoGO6a+sKDeeK/HOI
         prUQ==
X-Gm-Message-State: ACrzQf3q8I7ya2iZBZh4ux1Rns/12IayooWpTrxlngcWbwTi0sjuXNPI
        HzwtwizkeWHbPf/j3U2fR10=
X-Google-Smtp-Source: AMsMyM5mH0ip2bfRVzImwgmQ4VV5CXsNsXUPZ4DywNlP9ZINkwbvP+xWsxxhgS4Xz6zfT70q232dmQ==
X-Received: by 2002:a17:907:1b24:b0:76d:7b9d:2f8b with SMTP id mp36-20020a1709071b2400b0076d7b9d2f8bmr8111071ejc.414.1666010782988;
        Mon, 17 Oct 2022 05:46:22 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h4-20020aa7de04000000b004574f4326b8sm7231820edv.30.2022.10.17.05.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:46:22 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:46:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"
Message-ID: <Y01OnJ1FmS2nwaWN@orome>
References: <20221017084006.11770-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0HsTIXSYqUDN8Ndt"
Content-Disposition: inline
In-Reply-To: <20221017084006.11770-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--0HsTIXSYqUDN8Ndt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 09:40:06AM +0100, Jon Hunter wrote:
> This reverts commit 8bb7ff12a91429eb76e093b517ae810b146448fe.
>=20
> Commit 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
> updated the Tegra PCI driver to use the macro PCI_CONF1_EXT_ADDRESS()
> instead of a local function in the Tegra PCI driver. This is breaking
> PCI for some Tegra platforms because, when calculating the offset value,
> the mask applied to the lower 8-bits changed from 0xff to 0xfc. For now,
> fix this by reverting this commit.
>=20
> Fixes: 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Sorry for missing this during review:

Acked-by: Thierry Reding <treding@nvidia.com>

--0HsTIXSYqUDN8Ndt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNNTpwACgkQ3SOs138+
s6HM/A//dLQ2+KCnadqbBvCw6Na04hXtu8LbrDb/bzY+96/xdbBTD11AcVlPCdX2
gaiTxIdUlChiWt8uR6zF/HVgvsaKMEn8MoWU30hNmCrMM9BsaSzin0hdrPeVqpBN
BkjddfRFNHDXj0A80P5r5BqsEf1/Q6P/Fk1DI8wiClMw42mKRhZpE/y3Cyj2Uk0l
RvDQI1sy+z/VyNKrZCm/B9tso2ZCWSJMoQr5t9ph5mtN4onT2t0qK41BDVF+4En5
5eXrDmCqwq0h63/ZQibYTTRMwwYsDSK8lzCOWD1lsSNHeUrRJHz27LuSnYsLsO1n
IFrWBWrvIsrfRH/RO4g7sI1b4/TwoAWLzRiaYE8Nwr8Unk6TABymd3oJkS+/N79p
uXaLYIjLpFiDniV1lffjUVuQJmX8hAxf1GNnv7JC+En8rJjDac9MVx019kOACK6/
Xr8U9GkhRxxrktnrG9Gr3Hjh5QodfXqnh+Cry2FEdH37lAZhjEbKLa4VBdSJTu0+
G5SSIJgiJqOYAYk0ZVSSZcZbjliSQ4FfuH1yYDUMbhch1FoaR0JJxdCQYyQUoVK4
vY4Tf5StLLruBHVyB/hG25ZKfz8adki5SMVR5s8qJcVY156NBJby0yNHHPYvRSzC
lDTqjoyqdadZZI+Ndy1Rv5Ge2FnltCN2dkB4PStFB7KfTuDmD2s=
=JEGk
-----END PGP SIGNATURE-----

--0HsTIXSYqUDN8Ndt--
