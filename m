Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D346C648B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCWKPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWKPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:15:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5E1A485;
        Thu, 23 Mar 2023 03:15:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so84162056edb.6;
        Thu, 23 Mar 2023 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dA8ydvuA/WaWBfApBoDiSPygU9WQclAtBqZTzXYAyw=;
        b=TjPlwTNo/orl5t5bVDpRZec4X8IxUGIUtVAJOBLVIsNi3J6yrU6l2CVd16qmGliCmV
         4AWEgN/2viyAzUvGQAJKHBvdVqzZtL1+kBGT1K5Xhi59wa6zdCqvc1IGeUxfCQVOpXd/
         FpxYwRMk6QAnFhhDcFKsMk+Olr2gTLRSRJe8craht8vaM06TVBbl5jg5tyWpqqLUxYCO
         TU4gKZ6fGRBWF2jf3KNvOJjliGnhiW/MJRzRamnhhbfyVXpGRZgWuGV8A/H6i6j63hMA
         KNO9lZS5P6iIc7cRigE9dbiMrSDh8jcfGahl+SN0gJwnfH8jgOX1tAlEBd51a4FFj4nD
         F8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dA8ydvuA/WaWBfApBoDiSPygU9WQclAtBqZTzXYAyw=;
        b=CJSJFeizck34qJ4wDSAHs8kztiAFHWLLXxvB6W+eEJQbg9tcnLFJU85Pm1wzkK6x/R
         t39ZrNvJG+hK5wUspx9N2Z/laSJeDYVlsoTCA02xITQkz5ZtnImLO2DhAyKDS0VWgPUj
         X92iUAKso9F8OvO1df0AhkANWid5DQ6pD//BkpAXerZ/8Vgf1J3vPuyqDQMhJS3UVUzD
         3hCr0CEHpNkYeIjAGcOQPpc2tIQ+x6FkXVVDaQIP2M95In/az+0NMoXGrI1iWnj70Gbr
         TB58ToF2Ot4/jfOK+Wf5RYXv07OshZcHFHqf1b06VSMzMCtVJ+GoQqqH8tnKCavMYY0v
         rFiA==
X-Gm-Message-State: AO0yUKVBkkf6leY/xwyEw0CHsFWFBrJc4usxSF4qCvBDPjUTZigma0vq
        bz17XSroaED4VumTszV1qafy6X2OD/A=
X-Google-Smtp-Source: AK7set+K+/unjZLyY3xnuTerkikW2195nmRVJS9iuB+6xAitd4cGPffhlnrZwVnoBlXhdvCcZhG3QA==
X-Received: by 2002:a17:906:18a1:b0:92f:43a2:bf7d with SMTP id c1-20020a17090618a100b0092f43a2bf7dmr10092447ejf.73.1679566499512;
        Thu, 23 Mar 2023 03:14:59 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906850400b0093018c7c07dsm8361948ejx.82.2023.03.23.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:14:59 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:14:57 +0100
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
Subject: Re: [Patch v3 02/11] memory: tegra: add interconnect support for
 DRAM scaling in Tegra234
Message-ID: <ZBwmoZJAEgzc+VEK@orome>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FGn3JdHJT1ZVxORw"
Content-Disposition: inline
In-Reply-To: <20230320182441.11904-3-sumitg@nvidia.com>
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


--FGn3JdHJT1ZVxORw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 11:54:32PM +0530, Sumit Gupta wrote:
[...]
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
[...]
> +static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct tegra_mc *mc = icc_provider_to_tegra_mc(dst->provider);
> +	struct mrq_bwmgr_int_request bwmgr_req = { 0 };
> +	struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
> +	const struct tegra_mc_client *pclient = src->data;
> +	struct tegra_bpmp_message msg;
> +	struct tegra_bpmp *bpmp;
> +	int ret;
> +
> +	/*
> +	 * Same Src and Dst node will happen during boot from icc_node_add().
> +	 * This can be used to pre-initialize and set bandwidth for all clients
> +	 * before their drivers are loaded. We are skipping this case as for us,
> +	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
> +	 */
> +	if (src->id == dst->id)
> +		return 0;
> +
> +	bpmp = of_tegra_bpmp_get();
> +	if (IS_ERR(bpmp)) {
> +		ret = PTR_ERR(bpmp);
> +		return ret;
> +	}

Irrespective of Whether we end up doing the BPMP lookup via
tegra_bpmp_get() or of_tegra_bpmp_get(), I think we should resolve at
probe time and cache the result, since this function can get called
multiple times and the lookup is a rather heavy operation.

Thierry

--FGn3JdHJT1ZVxORw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQcJqEACgkQ3SOs138+
s6E48BAAgKA1povzoTBUTaZIIbXSLlYXE1lnamtot8dMIFOrfAXaRc3i9AcPQ3gM
eSVszZtSL1ARSVMQjvTCEvg3kNuzQioBk6rdspuQ7j/I0P8TjXNadrQe0M0uVwdp
fKnDBTAxYDIjAP0jTezBUE5hA6SaxWumnpNZrNqL9mmoAbQGeBXeqrfcbhb/I54H
1g6dqNjHnOyiESk7pvCcMf8CFaSG8BT3OqVyPhc5Vst4yLtqztPFBdmx9gzXJ6HN
zr1/oeYiu+nzya1gRhga+4SM3L6IvAWIbj0TqoE+5QTzZt2ccFlw+wbwlC4K8pLJ
pU0LE56UbwM42D+yMLA/DsWOi4r8zL+A432JrXk5464P018X+I/dYKnmlg/0nWAR
zqyVv4nQxY46DOwfPH6mUnl/02J4GHJGYJ7E980APnUgkObOX15NNvh6Xat6Go7v
kf3S/byknRohkjE7kbaUm1Ys/79RTvwLTIVU005zAT5wjpVyU6qTXDg0kA5AaF2d
HtvnSratQkv9kDyoEiqC7dwPXeEez1HWdbY+sZ/sKccEonME1o/hmGFdAZaxYnlV
/fhhl9DKUQt9eordK1gEb95qN8t+ksxi8m+LnadsPbFrLIxcA8OwTOm2BPWxFy1P
blYrmZF1mFMk4RS7f7oamceSXxdBut1rQBC4f85ZxzJzcB6Zamg=
=9mRi
-----END PGP SIGNATURE-----

--FGn3JdHJT1ZVxORw--
