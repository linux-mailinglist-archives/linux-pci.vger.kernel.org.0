Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9A6C6458
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWKCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCWKCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:02:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B31025D;
        Thu, 23 Mar 2023 03:02:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so83934706edb.10;
        Thu, 23 Mar 2023 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679565762;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QLDCkiGfjxuB12NSD16ak9V/6TuGJM06eY8YUnZjuc=;
        b=A/8U8irwMTu1zrqW7p8BT2Y42CZhN5BaFc3Tc/NvL2J9GtmOyNcPzkavntRO4AQygq
         OcLQAAjPFpV3rgHZIHnkJHwjibdAsfh951Umib5UNzj3ketfOSOBGsBaaSDTRc+M0K6y
         U4WkosAsUHOSV7vYl6moj56Qvi1zURYrJpkhI+IXiwwYD83u2BHdWMk2DemZU3AZi08J
         HV0GaRMfQA8Zfg/bqyVQ02nWgT1onzDQg2O0BuKB/o0FiTJzj6cKl21yvspUzqATuowf
         U6DZjAaFIe1hnlNDkcC4ysWyumTpCT7cgR2uKE0mH3bPj9bHQha2WvYBmaeXS+fKIXvs
         NIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679565762;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QLDCkiGfjxuB12NSD16ak9V/6TuGJM06eY8YUnZjuc=;
        b=aiaKbfQdbgron0CHxsbVJt6KaXPw9KBFPU3LYRvlOmTsSzCrsAAwwPS1enllaWNUuL
         yyK51XE9RcKOyFYOsfdoP+EvzWBZCL0BdJKbJYeyu3F2KXdytcYRYxUl1O2dsg3OBh0o
         PNkqsQy9ZsJSgaYV7b6bXLAE9CifxNJCTK/xGOzHGUconZdYvkF8mFBc6bCC29iWuzQK
         0bMjJTN6ndFDrRe0PxvO1l+cA2G1ADjD/QZYPBlc0tILM0+wFlFY26a+tblwQOAK5u/l
         RnpdT1bkA8gee3Vy/gR+C+FRmZgH/T5KvMUIn+Q/xV+17M6BzEkW4j+VZBilqV0cGaj9
         OdmQ==
X-Gm-Message-State: AO0yUKWqdN7coenikMPUCcDLW4PU9LWHBTNZ4/7JKfar4/a32rNcS2wM
        xY4xSaIic0NuQDdXSVdACeo=
X-Google-Smtp-Source: AK7set+96Vu2kio4Ss0ozHPi6bWoPEmQwPjpdtwPgocU6FJGD8S68fYR+nVcNzY2DjAHSoDXaEkRHQ==
X-Received: by 2002:a17:906:698d:b0:930:28d6:4581 with SMTP id i13-20020a170906698d00b0093028d64581mr9818790ejr.59.1679565762054;
        Thu, 23 Mar 2023 03:02:42 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm8415618ejl.188.2023.03.23.03.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:02:41 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:02:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in
 BPMP
Message-ID: <ZBwjvy9KXWE02I1X@orome>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-11-sumitg@nvidia.com>
 <dd6257a9-1a12-23f9-e770-0809aaa7ed0e@linaro.org>
 <ZBwiFEJ1bTMy6yTf@orome>
 <65352fe3-6fb8-cb84-37b8-c9f59e26d3f9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7412yGgzZ0zqK6O1"
Content-Disposition: inline
In-Reply-To: <65352fe3-6fb8-cb84-37b8-c9f59e26d3f9@linaro.org>
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


--7412yGgzZ0zqK6O1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 10:58:18AM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2023 10:55, Thierry Reding wrote:
> > On Wed, Mar 22, 2023 at 06:50:23PM +0100, Krzysztof Kozlowski wrote:
> >> On 20/03/2023 19:24, Sumit Gupta wrote:
> >>> If BPMP-FW doesn't support 'MRQ_BWMGR_INT', then the MC Client driver
> >>> probe fails with 'EPROBE_DEFER' which it receives on calling the func
> >>> 'devm_of_icc_get()'. Fix this by initializing the ICC even if the MRQ
> >>> is missing and return 'EINVAL' from 'icc_set_bw()' instead of passing
> >>> the request to BPMP-FW later when the BW request is made by client.
> >>>
> >>> Fixes: ("memory: tegra: add interconnect support for DRAM scaling in =
Tegra234")
> >>
> >> That's not correct tag.
> >>
> >> Anyway, send fixes separately.
> >=20
> > I think this was a bit confusing. This fixes an issue that was
> > introduced in a patch earlier in this series, so it's probably better to
> > squash it into that patch rather than have a separate fix patch in the
> > same series.
> >=20
>=20
> Yeah, it is quite confusing to send buggy code and immediately fix it...
> Introducing known bugs is actually non-bisectable and harming.

I don't think this was done purposefully but rather as a way of more
clearly showing what was changed. This is also an issue that can only
happen on certain boards, so it's easy to miss.

But yeah, this is bad for bisectibility.

Sumit, please merge this into the patch that you reference in the Fixes:
tag along with the fix in patch 11.

Thierry

--7412yGgzZ0zqK6O1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQcI78ACgkQ3SOs138+
s6EhDw//Us6AoMbGIV7k4mocQuIduHsO0hohbLa+4kSJMGsVH1VulnkHvOdYQrjb
ff7+L2m0wY84SYjhkBsi88EnF+0x/YQMMVh+ksLKwZJw+4tnh0SvjIXK/CgB2Z2R
quNGyzrBKomz+jLkJA/q2bVJqoj3w6ReyBKPFt/P4QgDy/OG2yQcTN8OEkLIknab
keMYf41x31W0ZkDMtPNqiII8wMGcdyqVjGX8GxXCpi6NW/LjOGDIQKIiHsT2Ybg0
Ly3RKo34+ITUAU8wQL8h+C65dZKsLN30Lk8CCy2dZulxdcGfRzq6G2pwM4RMjjby
1GeayKAHEvuZu/bh6EW5yQjB/Dbs3qi8Lfee2qqz5C4it6DDxXng44CQvNnOzgAA
NdYl8pVPgBHij4+V16VzB1VcbY0QMYutfB0Z+8+U9x+ZyRxBzShcqf/aH0auy4SZ
VeC6AyoWmii9FqVwAYcArtT8SchRQwVbTELAb/i65sfJKRbtx+EJejIc9MbR/WtD
pqE3VkfJH8Os176+nR4KAIn7S8OLUMpIU1CMWL8ueVenUNUi5l7mtzE6228cXYOr
u0nyxEw4EWYUNIWSiUaQnVO1/KMLaF8JOmZclk0G6Q8i0tSXPjCBJbtJr//GFUOJ
5vbVYneAJpLcvIxHhzIJGZ+1q8M1rh/QPEkVGfJbQHICeSyahXY=
=+sI2
-----END PGP SIGNATURE-----

--7412yGgzZ0zqK6O1--
