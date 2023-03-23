Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0086C6435
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 10:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCWJ4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWJ4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 05:56:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EE3599;
        Thu, 23 Mar 2023 02:55:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so83972730edc.3;
        Thu, 23 Mar 2023 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679565335;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PphF8K//KH/mvExR3XG/4qnql3FAdb+LvjCZLcvDGrk=;
        b=WoaYs4cDl5W7Hl8gUWH/zV0hpbhNl+TFJDeRfKB/UPoKFF9wbFppTVopELseT2E3fB
         p1+O+3B6Tzx1LI5j68FBLGijBifYwCrpHKMkc2blkdVRn+1hbZNcXDaX3he/8XuMfPZm
         sPugHLGPdCilxoP2IMaEhstYiGKnjNnBEBHCmFerC+GdxsXkWciFXUaVC5mtf/Nh9NEv
         J3aCs1lokSWZWrhfMeWjFAyVfYjMK9xMhlJcQ4T4tpcQgqAjUoiISWH//+1jLjpISiMN
         nNRrlcS3bqqgWn4XUgpohK9Nv2C5FgTPrrmoZ38ELLt5y5ND3+Hp2LmGj2hp/3dvRmrr
         S51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679565335;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PphF8K//KH/mvExR3XG/4qnql3FAdb+LvjCZLcvDGrk=;
        b=FNdKor28MYuT7I22xxq/nHFpCRnDlJJDesznnqGxVTcKRsdnlS2WbS5VyUphA0GtOZ
         /sOTyqHahqD+M1cYF2IjjOa3Rakz/3BORkFjSp34I5Nnyfn8wDYF4w7UWRKJOlJdrhhN
         HOnOUOz/vnzgt27hfw6jtHaKn48B8tJwZd02UV2SGaBSNLyQN/LGr22+U3L//PKD9ogW
         ljY+5KZ+zku46LsTGAzlrfjSOTTcmzdFCcgleW0hnRe3xagkePx/TVi8qhzYOreMTpj6
         kvsz0jNmFWoZN5v5BAg0V/KwFrnyKU2psjEPLQyiRWEZuaqeTJrU7VKv5pZoiTizzQ26
         DvMQ==
X-Gm-Message-State: AO0yUKV+cA8d4cZKGDQsgqOx6UA4THTtcuSG5kCkNYGOVueCi1nhZVNK
        7/alXd3YNmyMtx7qlEbWe07oX1OZuek=
X-Google-Smtp-Source: AK7set+SpQe/mPt/Uj8So7EKDhP/In9EL/bDpdZ8DnDAGNDOeKa9HsOCSo/mn+VjWloSWdcvds20LQ==
X-Received: by 2002:a17:906:7f93:b0:932:290d:12e4 with SMTP id f19-20020a1709067f9300b00932290d12e4mr8906716ejr.25.1679565334896;
        Thu, 23 Mar 2023 02:55:34 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00933356c681esm6898578eji.150.2023.03.23.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:55:34 -0700 (PDT)
Date:   Thu, 23 Mar 2023 10:55:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in
 BPMP
Message-ID: <ZBwiFEJ1bTMy6yTf@orome>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-11-sumitg@nvidia.com>
 <dd6257a9-1a12-23f9-e770-0809aaa7ed0e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jHN3+CG4rKdPqrN7"
Content-Disposition: inline
In-Reply-To: <dd6257a9-1a12-23f9-e770-0809aaa7ed0e@linaro.org>
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


--jHN3+CG4rKdPqrN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 06:50:23PM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2023 19:24, Sumit Gupta wrote:
> > If BPMP-FW doesn't support 'MRQ_BWMGR_INT', then the MC Client driver
> > probe fails with 'EPROBE_DEFER' which it receives on calling the func
> > 'devm_of_icc_get()'. Fix this by initializing the ICC even if the MRQ
> > is missing and return 'EINVAL' from 'icc_set_bw()' instead of passing
> > the request to BPMP-FW later when the BW request is made by client.
> >=20
> > Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Te=
gra234")
>=20
> That's not correct tag.
>=20
> Anyway, send fixes separately.

I think this was a bit confusing. This fixes an issue that was
introduced in a patch earlier in this series, so it's probably better to
squash it into that patch rather than have a separate fix patch in the
same series.

Thierry

--jHN3+CG4rKdPqrN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQcIhQACgkQ3SOs138+
s6GPPA//bkgG/9emg8XAzAiCCk14SYzw8PzesQOWogN/oL/DK9MK6TrmtLLHpZvm
I8A3FSzAy0bHgtNmlvogMEog/QqVODAumS7zIUxFfuQxfU/ZFYBiphVULHvcyWNu
/7/84LwUTURyUKPbZGlVzV+bMst1ShUnVjX/YLIMo2gt8knj/C3X12AZETLtW+i+
raTIkwrync5K8TqbYSfQrtlRTQH7VwS2eKBt1U5zZOO9kKlhsQPexVZ2ovxrtoZG
98nrddvhggkn6EGE8FNXxdzt2a5HgMqpbA8sGt+WfpevT6abCHOA7b2JMYYyvt5S
8uSKGq7LFx2JA95RTwa7GaWeLiqvWPeoFeeEgFbBe8nLBxOowwYXjJA9ocjVlThI
eIGDk47LHlesyXS2cyYsnEAa8/JuXNx6RV1QT6l139rtwIQlnq1q5xcHW5B9Xa6F
Pn+5H6Ztr5/xU8OHlNdKUMTC0k5CpuvlapIkQ+ztdPZ0AArhjVSFXaL+rKAZsnj3
S2CSN7r4guMWGUJ+eyoCzPujlMnF6+ZbAMNHGUYBDNYWX4Cy39r/3EUIfZP5kD8G
/kQWWTbgf8LZD2V65bk+rcz7oCNbisO0Xv2WjYm7H6+sUK/dmEcM/qEAfqukElDP
/s4n+oICxCOEu3Q4Ei38PDvUk9ayMpzFV5dlKutGDCJc8MH8G7o=
=+/zC
-----END PGP SIGNATURE-----

--jHN3+CG4rKdPqrN7--
