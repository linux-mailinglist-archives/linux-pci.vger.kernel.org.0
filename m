Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D426D9EB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIQLNq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIQLNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 07:13:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B8CC06174A;
        Thu, 17 Sep 2020 04:01:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so1583152wmj.5;
        Thu, 17 Sep 2020 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jeNfa2CRuCdb8X5Pe7Eg1ccR29yjytumjsEyM+xV94c=;
        b=rFjDfbraL+EBXaSPL/Hhq4pI5Zd0umHGrhhTXlOCDCQk9sygiMtPHkA1ZIZPo9g0ya
         7K+A4VXhL/miov/RFmVe/0WUV49QnVTnrFuWhz0NPskR+OZeiOFvvpZgm2S1nZarai9Z
         RtnRBB7Em9bST5X4sjhQ6o9DdxkPjoo5AbZRQeMiCag0BGni0Bhx2KvOOIpaoXGcBkFx
         pjS9sSUtlNpwn9ncljZWCeOkGKX05vAKZZ+iBcT62nlV0aHlZaA13F9s8YQK7nba1VpO
         jqwdYZRTvNd9B6GWENbq79RfbIa/QbbC5zg9kj0xyxI+PXWE13qLW4Kc7dxoiMuxOroE
         iFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jeNfa2CRuCdb8X5Pe7Eg1ccR29yjytumjsEyM+xV94c=;
        b=aVwMh6XoNoNTKQS+bkK0ETOMP0gEUZz1Yb1wrD3s/1aPVlHBngz/Uqn2kdV4s1ym5K
         WyjP5eOW0WLTCALR+E7LC+KC6JExHdpTkdJntBhgs7IYdxee3EkfZireaGlgYj49JjAG
         +Vaz6COfkzxJbjIZDSd+fC7aJy1wsqrrbPXVkh8BA60XLB05kmtVM41jVO2DLtA39MSa
         6z48k9gTlpGnscioasrbhIjAms2MMawEyJaQW/o6I2nXPMHZJgqB+4TeIJTIHps3dFuS
         7JHXdTmJrhjmXYjeyQJRtomaSUHbZA9zuHCYFl5a22HHHvxUK2+C/jn7nJIMOC1tQ45J
         hgWw==
X-Gm-Message-State: AOAM532RTu/MtuovOvc3vhxbgXuA7pqMH/eQjELHYYjTDH9V+1b6okQw
        H5y5bpg6djiX5CRsFTWNgk8=
X-Google-Smtp-Source: ABdhPJzdy5QQOve/od/xUbXopRPkI1LDLcnC1a1s4M0Phyv5Kjo7WgwPVT4DqQlPkZzXSbKPUXstKw==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr9461172wmm.20.1600340486138;
        Thu, 17 Sep 2020 04:01:26 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id i3sm37467241wrs.4.2020.09.17.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:01:25 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:01:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200917110123.GL3515672@ulmo>
References: <20200916025025.3992783-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <20200916025025.3992783-1-liushixin2@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:50:25AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9jQgMACgkQ3SOs138+
s6GWLA//Q4sFN/jT40K7QRBJDLxaXgXCqu1aubENyJ+jyFk+WDrwGHyoNc6oSwKv
ukht/b7ZgucJNV4oeHuGEbbunSr/upLM9wPZ4MPV83hJELLmWukfM3yY+hVCp7ZR
X3MDQEG9H3FoP1GK2Ij/ZyW9hU1kTSaCzNrHtmgSgx+4Asc4GH6JYtCsZ8VfWdOz
c4P+9XnH6JB4Ubx2vvD3AFX+cq364pZ2iYC671Cqwx+uFJiy/5sBdCQYZxe5deC/
2fP/cSYs05ltWwde9+WleYlMhMIRd9mCUnftzGIzxTJLMM0RGPUyF9gaVNU7F1Gi
KQfMjZmSi4zT3JjekzR0FKa3eRug3ESFMp3DdEjkBoAq+DtSsCzg27LP8Zm1CwIv
KSs2rk6t7DhlGQWqQjsinojDVurk2TjM1ckRJo3sc4wOB8BJehj/W2xJWc1wK2Zq
MfAoxXRTqX32gwEEHvhFIqubILl4J1d3ZBKL3scSDwPoeNMjR3QDSd/yFw/HPoNk
87VFu5V8hG89P6yq1Moa9PC454Gd8J1dDpwVIFvJ8lX6Wt08YrMgcjkvT1beQkDG
iW1ZFIEXBjT4JX+4oymZ4xGUIoAU0oy91cvfva6AChRSCj3qySWt8oij6VueCoOs
NC8Y7qTd2XFq44DxTubj6bbVUFZiJ2U8WOkgjZnrithtG0EHbXI=
=qwi8
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--
