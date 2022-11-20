Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F316313CD
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 12:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTL5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 06:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTL5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 06:57:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08AA44C;
        Sun, 20 Nov 2022 03:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4087A60C47;
        Sun, 20 Nov 2022 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A86C433C1;
        Sun, 20 Nov 2022 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668945451;
        bh=5ggy0qQWOQikRZXdP6PhBP9SY1KAh6GYvEPfkQOJ5x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoQOfYMy1c33U6h/6Si4Kkdk/nYqh1lkdFXZ7pJNL5n9vK4HQ3DUmgzTQOLTi3J/+
         4L3CB5IjyqYzX7X6zG+dkWGYwvA0hdGuc7N8jgmhdeJrVuTqN/xj+dhNjZlfZ7J+m8
         NQ3W2f0KvfT6p0noOZ/qXVAUIyJBbjFLwkXHWLqq4vnB57jfFy83AYkdplnSgmAaxg
         zCmdzQLQ0WFjr9mXKc4j8OxmQ84ISEza82CabM3W7gyfz8kIdxOd4eSw2xfIjVG+7w
         QNO+he23TglDYzyGgKk5ZjXVMQ7a3tWEdMTEYRmF8wOpAKAo7Hnk/oHDUutDwNLNGQ
         zJucDyu29NEnA==
Date:   Sun, 20 Nov 2022 11:57:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Mack <zonque@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex
 anchors
Message-ID: <Y3oWJQRtgbHbqz0I@sirena.org.uk>
References: <20221118223728.1721589-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q3GCr2oBFfh1LNvT"
Content-Disposition: inline
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Q3GCr2oBFfh1LNvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2022 at 04:37:27PM -0600, Rob Herring wrote:
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.

Acked-by: Mark Brown <broonie@kernel.org>

--Q3GCr2oBFfh1LNvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN6FiQACgkQJNaLcl1U
h9AA2wf/bx63PKQM05br3AtOVY9zdnicSS3gPjXP1RhIZFx5DzHwpwd0ubzHQeEN
Kk6JXxiJGRd6UUsifgfE3wHiKuDzN/eqx3PrQeCPxvUM70Uz2XifdEqmnhRhR/ow
HSxPCKrdL/VnVCE4OGskhnQnuNKdomuoEv5pKw5+0Ue8/O2O24vxh+Ckm/qdedgr
oN+ptQEN4r+FDCGwsc98OKacDLoBwXp0NKSqoflhG0+AzYS3Pv4CWoSJyW7PPzYR
Na7vdI9pcZxlPhOQilQUYKQWmFt0yl7+uUldCPsQXO/0XTBa1KTcI9H2bRK1MsOw
EN4xxqC1SJ9Q0J7wg7TTl77qIj7PPA==
=lgNY
-----END PGP SIGNATURE-----

--Q3GCr2oBFfh1LNvT--
