Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB56C6472
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWKIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCWKIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:08:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7809811A;
        Thu, 23 Mar 2023 03:08:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so84023463ede.8;
        Thu, 23 Mar 2023 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566129;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGAuq1vj2Az8BeSIwxE6OVDA/Cv51CPyVJAXOIa5Vuw=;
        b=OOX/X+HlYB7eQPs76GFdPpZy1ayHbuh8C2ASVmqG7AI4UVM4ZTwmWm/S55CF3OCkvs
         RIzx03EpXXuTutIIuOsEvndGkpQwdMpwPPzZ1uVYQ+ZTfKiqtq80YSgy/l7GsurwZd/A
         RaD9+Yd/rCAZaYRghLOWakcm8P7f2iYeibVKrIDeIQ7yx4G9T4w/eQ6pYaJU+J26FeH2
         NSM38Q945dqvmnc4Miz1Jh728wV4bXBjo4QQ5E3YN67VO5aXjBYmTmKzrCT0cmQvyPfk
         NAGG2dxu9BOzwvMSIDRskr3voLcB635tcSPzMbTukJAsbLBvGJ60yN/CQtQZG3XDi8b7
         O7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566129;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGAuq1vj2Az8BeSIwxE6OVDA/Cv51CPyVJAXOIa5Vuw=;
        b=ZENZBkaJZ/6urB/NbnWUQBUxer3cPsJ+XM2XLmZ0Sda1wL2OpK6ewf93T7vgeRPrY4
         +2/3DoEwRk3MxssWx0ohYLO0XPXvH5/4aGGO/e0s8vz4dTEIk62GS6fsRiopvLoq+Uf0
         cNtueL0zF/RLfAz8CKGlsg/rYj7ECRCaBby+gpHna6izCMzaFdbr1wy4+M+1BlP8xrvK
         PzUUIAv22uYDFVxxaSVPTwqrqek3mHfeyKBrJoQWDIe1VK7y+ujrSrsXG1h5isX8IJaj
         C5sIKoo8JxNShXtpceo7vNkOMh4R6D9dLIos+/3Dj8hr/PkutLkSgB+Kw0Q9ZK4bokcb
         avhg==
X-Gm-Message-State: AO0yUKXvdwMm1g8QCZQwm7eoAiXi7EYwrI8XxGmCz/iZrSksAb5bdXU9
        X34i1eHfQmTqK6NiTcgCZD2a1VcyMW4=
X-Google-Smtp-Source: AK7set/e+lCIB7EqMESTFCG6SmJknH91+J8loFEApNYlA1GuhCbTcoqYH/DrnRCYxVie/7foo0EACw==
X-Received: by 2002:aa7:d84d:0:b0:4ef:9bf0:7177 with SMTP id f13-20020aa7d84d000000b004ef9bf07177mr9364747eds.9.1679566128974;
        Thu, 23 Mar 2023 03:08:48 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm9041451edi.36.2023.03.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:08:48 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:08:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v3 01/11] firmware: tegra: add function to get BPMP data
Message-ID: <ZBwlLmPlBgC5tYTD@orome>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6ApTD5EBx3VpHtc"
Content-Disposition: inline
In-Reply-To: <20230320182441.11904-2-sumitg@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--r6ApTD5EBx3VpHtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 11:54:31PM +0530, Sumit Gupta wrote:
> Add new function 'of_tegra_bpmp_get()' which can be
> used by other drivers like MC to get BPMP data without
> adding any property in respective drivers DT node.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp.c | 38 +++++++++++++++++++++++++++++++++++
>  include/soc/tegra/bpmp.h      |  5 +++++
>  2 files changed, 43 insertions(+)

Sorry for not noticing this earlier, but can we not resolve the BPMP
using the existing tegra_bpmp_get()? That requires the presence of the
nvidia,bpmp property, but since we're adding new functionality here
that's not a problem.

Thierry

--r6ApTD5EBx3VpHtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQcJS4ACgkQ3SOs138+
s6EvWA//eWb9KTOc3+VL6SIY2YLcp+/47Jg/5r8MVpHI0BwBmah2YohmvE3oUOsj
A7zy1BJWxGrK8aw+8xXc7+osx29toqEpgI3gqEwMFvylowKPVDWL1x9+bNdYIIf6
J8lRBpn/nG5dcL0GAx7qNIRrWZMWJbMTGUOY8TgaGLpodEaGQ5EMDuUmZBeWkPft
asHwDuTP/fFK+dlvjCg5eabRwjfl85LoPzbq4yj0iUfY38BPZ69/ZKTHY1XIUtyS
VfciS8Es5jDIc5gWFO67NuyPWIxygE8ceH01OJay1Oa9gE8mF+62w6yXfysiYMo9
DV9UbxdaoKG7+Pp8+VM81Gcei+KReL5bLwiNZWhEMLdg2UOwRq6OX8SSVB8JVI/K
INZlS+S/q6vvMhbLOy2KGQ6VgFzyDDrngpe9cXXjs6t1w/oyLouNt01MXL5//qw8
Nl/eQCB0JLUY5JWJ4U2RbhWfFOfBDGQwCzRjv38PeAjsHNdmaLdD7amq/FZQ2cjI
AP4tHe0q3YL2eaNJapKd7Juvz4A8guLmbxf3N/IE3Wr+4pn22OTdZm56C4z/aiEq
zErjvkhiSJmvherwpqIDEuwGbFO7R10iR5E78icEE3il7Dxi40OYp3VmZ88wW+MT
PnKWtpdtP14tGzvsmOpKDdZwlPJ9HFlFXKZbF9W1kLNyrb62/nY=
=Y8ba
-----END PGP SIGNATURE-----

--r6ApTD5EBx3VpHtc--
