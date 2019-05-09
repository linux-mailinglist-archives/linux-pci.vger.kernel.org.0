Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1018B87
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEIOR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:17:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35355 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEIOR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:17:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3440819wmd.0;
        Thu, 09 May 2019 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IB8c2IxHAzOoI/TggpVaeKg+6XQl0SXGEOFq4gJZkJM=;
        b=EMkvNpueC0vjL1DOxfTBaYKAgM4kjl237nrQiWXCFS/LdfDCl2rF05TmgYGKGPqxU5
         UeD/ah43NnXCkFNxovEyoWRwh5V0DkIQkntGm7kjvIxz1l71fyZlBZw/qUzRFnZHxXIz
         Cj1Kd4KrpC0rGY9VrF9uOSOpCK1SlRGvLNqzrkLpZJPZqanTKho24Gb4QHCUuRco8BZz
         +dOS/gnfmr35PqwCvjS6ctcLTN0fWCK6SheAmQnLl58ewpCh38a7WuQj4fQ4MW6CHcU6
         wsEC42OR9tNLPGfOisnC1qScGQGwXevmfh9MYWKM8Q3DXSLNs25w8B9ECtCgpePG4BmH
         R5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IB8c2IxHAzOoI/TggpVaeKg+6XQl0SXGEOFq4gJZkJM=;
        b=J1UJczH/8+G2lJTTO3K4rcGrsnuP+dtqE7h9SGgU9xbKY2YAT9FK1gm7D6rcU/V0w4
         r9/rA3AqolS63FIymt1Bsz+yBQsSnUKPmwYhAH2jJJTZB9ezteY623P1csngc8amETBM
         9MqSpxSMhAurzFc2rYD31NSkRd3l3ezsRLjoD7hk20vjkeVHRlabC/OUAt8uEzJHqzRC
         GxwumWzy0rj2C9BFoukS2Z8CBapOSB687Bk+h2gZjK79eCAGSj1pr9KZAsakxO3RpSrI
         BDkt52xyF+J3KEOepQtpOnZ1nwsuIq2qIv6jDsTU+tDYyRBXWo30EORPK/RdVnZ5y8Wx
         hong==
X-Gm-Message-State: APjAAAWb2jeLdXgNF68EIh0mxw1GKhyoDmDZ8qSnN7xfxNKrRgS8gJ8t
        Vdu8q6FYpx3eDVsthZXTz8w=
X-Google-Smtp-Source: APXvYqwWTXb841riFLEL1FoB0N6emHqvseBwTqw45u6r0y4OAoG4p+CS2OyOm2YzcsBY7kdgR183Ig==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr3078420wme.126.1557411443942;
        Thu, 09 May 2019 07:17:23 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y7sm7416403wrg.45.2019.05.09.07.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:17:22 -0700 (PDT)
Date:   Thu, 9 May 2019 16:17:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 06/28] PCI: tegra: Add PCIe Gen2 link speed support
Message-ID: <20190509141720.GF8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-7-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-7-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 02:58:03PM +0530, Manikanta Maddireddy wrote:
[...]
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
[...]
> +		while (ktime_before(ktime_get(), deadline)) {
> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
> +				break;
> +
> +			usleep_range(2000, 3000);
> +		}
> +		if (value & PCI_EXP_LNKSTA_LT)
> +			dev_warn(dev, "PCIe port %u link is in recovery\n",
> +				 port->index);

Blank line between "}" and "if (...)" for readability.

> +		while (ktime_before(ktime_get(), deadline)) {
> +			value = readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if ((value & PCI_EXP_LNKSTA_LT) == 0)
> +				break;
> +
> +			usleep_range(2000, 3000);
> +		}
> +		if (value & PCI_EXP_LNKSTA_LT)
> +			dev_err(dev, "failed to retrain link of port %u\n",
> +				port->index);

Same here.

With that:

Acked-by: Thierry Reding <treding@nvidia.com>

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNnAACgkQ3SOs138+
s6HNAA//TZ0zt5Q7wT9uwqxfIJUZaByyIy/zrcbeh/psahyWwxWLZyvAKQSfpYyi
0Q6jvS7g0EfuH1H1HGYQs6DN4UK8rQs+OWiICQBAKpkYjaAEWQ3HIKpbF/8cwjSX
cZ85Q08bihPmmhL9+fd6HnEkoQxRs2zBljM00jmXIs/SmYnT7uuTVxL49LJGdT2L
NlGN+2psY0Zcc8LOtZR7a3zq2S++DIWjtSa1GXTUcDwq1uSd0vD2LTJqWr0gTU4Z
gixIT3jFr0L4kuFVG5DJNyBYY8hW9scSVTfehhoSWf3eDj6NhdLCo6vO00v9ddZ5
9u2/k48CX6eMec6JKJ92YANXlUypir6fwnKTyv1Mch0zTpMJ8LT7ITKeCb5bofUd
Z4EBCgUWFZSLp3cfQOMUpulWBLSgn0l031P1yD3TRJGFy9Ej0vvS4WiBH35s6UkT
xgUH0KLcTJozkMx4nb8TiZXdTaiNfHLX1K8Hii4EV19WxIjBReQoPQI+VjGeX+8l
xc+B7VMt73J6655833TiKQzqZknQhvqldXpyxsQrIkiiauZU7VXbrxkNwzQohDNu
LygF3wmSpxNuY265beBcpwAoWlpUrqgGjUbh8Ic+M/75NAvhw0rlirtO4n+cTpxO
xCA2VC3VpLNYQoZaTz+2xii32VJcP1P0ElVZJDeRaLE/UabBPmI=
=rwdL
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
