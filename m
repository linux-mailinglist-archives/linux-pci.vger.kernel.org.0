Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96A918B8B
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIORp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:17:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEIORp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:17:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so3444989wma.2;
        Thu, 09 May 2019 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qM7HsdAOu5h3QjIrqdUxRQS4rLCccAJsr2GTYxCGpyA=;
        b=Muwk9Jg1Yg/7SaMe3ozVBHsyKvQy2EGRiDxY1s4CJpj2SFLIxn2iwsNPxBG04rwIKs
         6LXQnmYw7h+jEFsJd+EizRF7cdsFqMeVTFnwchluXsjvimE2/SEwyjZDs3/HQ0E+wxFg
         kKVO/m/1PmCoYdZMDm0xeLswXdkYP6Y5W1k5YXamHJKOaet7nRzGye5DmPqe6tl/eDK+
         Al1aJ6Apd0Oitr+62zDxsA/xKjESx6tXBsoDOFqGMIRWyK1NHDJ994BdMaiSHKPn1PPu
         /pPc9dmpQNqYaedGRoY6EFi2BbQNXD1j06+78wLNrzYq14tzQV/sDmv8KgRxXX81MKp1
         R2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qM7HsdAOu5h3QjIrqdUxRQS4rLCccAJsr2GTYxCGpyA=;
        b=PKphGJoXPGn3TKWclvpiTgs0K0oZet8OqW4aLAaHq0c4Jp4TtSaoOcDTfH5uV4qmyp
         KuNP3XQc7wWR6BhphpV0UTeOy3Db/A0OG0DxJOynxZDnh64p2haEKK0Ux0iKO1fff1UO
         /jXGKmUKmsdIviibxiJzV5wcrH+zjIIlHfZbdM3uVKcJHESbsEc08oP6Z4mwHKN4FgIw
         LRPpVjxWn61bet9CJoklI6wxm55q0PIjQznJOGn4TC5UgSgrjJnbyQieBfVZQcB6SX3c
         tZ8ji6PqyIMksTfyYuV51xdMoER8QVxJHtT9BdQQIT/QbG/MxVEz9pXKNKgOWa1JsgG7
         8zOw==
X-Gm-Message-State: APjAAAWr07yizwS7ZyPBzMkHXvza2T5k1IuvFu9MimNkAZMN8pesVYi9
        BG+1+1SLvIDbkLNC3gnDLYM=
X-Google-Smtp-Source: APXvYqwElySdB0laCzktAGpusAs7nAvBlTrEFEK1qP1tLvxPUlMVTrTtuYoFnye5bVsBfrho+tWyJg==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr3098232wmf.71.1557411462949;
        Thu, 09 May 2019 07:17:42 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x5sm1339079wrt.72.2019.05.09.07.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:17:42 -0700 (PDT)
Date:   Thu, 9 May 2019 16:17:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 07/28] PCI: tegra: Advertise PCIe Advanced Error
 Reporting (AER) capability
Message-ID: <20190509141741.GG8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-8-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-8-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:04PM +0530, Manikanta Maddireddy wrote:
> Default root port setting hides AER capability. This patch enables the
> advertisement of AER capability by root port.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: No change
>=20
>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNoQACgkQ3SOs138+
s6FbsQ//YavA3usgKFIoR6+YrHrTJrgo7tDpFnGll8ELzOqKV5vKdaCSdPeCKkpM
qqErThvDrgMzb9M6S30IymhkoO2LNGNMqGtOdVqHNX/murNGOkcs7CABE+va75LA
EpyQnOHbpNKfxV4SXlAyf+N7eR4v4fHjE6qAGurni4/+JDRiTyAOpnr1MKaCaXN2
NJpfX2zwBncj4BaKZ6GSUu2nWs/1jqNMl8XroKXNc129qF6PV3OUegE3vvrUiLIf
E6om1GJLAD+ep/hV3qMwJGzgqpkdI2HyKCWlsRYkyz1UyqrdSKQ5enu033xh1FKS
QtdeNX+l7VHnrUDBZ6DEvGatqspf/Q3Aj7+zfFXGL+NLG6t+1TnlGOpTFlVkU8fi
7We6eG8wMjcI1xV1+YMTf467P2ZClTJhrwrrGRXQa5KTqffqU4XCtT40AeaDfUCK
vEd3d1RMdmlP6WZNOe7gqYsGyZHSX5ofN0VzGlQ5/UkpnDi2qg0e4lbHu+uPsz2s
PAWlkyY0Vv391xwFXQv1PP1E9sl0rLWwjQsWbwV88Dm5aWEgpI5eoyJu3tINQtUB
jRu5SrGyObAuWMEtXE6gIBT3ULGuUmCVksgHaGtpYTl2oubr7+bUzIA2tyEeXhh2
pQblXHZtOCzfVDn5ZbWPCaA9OygGj9/hI7Eb8CA7SyiX1nQeoW4=
=3/Hz
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
