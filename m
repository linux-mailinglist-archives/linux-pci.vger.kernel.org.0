Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E15F66FF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiJFM4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiJFM4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 08:56:24 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B421828;
        Thu,  6 Oct 2022 05:55:33 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id r17so4322258eja.7;
        Thu, 06 Oct 2022 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pMgQyMBUHz4DAGv7dUKQ5faE2OXLKUuJdGmQsBE60y8=;
        b=AUCe13PGJRYHhE/cTCIPw3OUFheQpUYNOU1YGMsrmfFlzNw2kwLLxVFE7xU4qNWRhj
         9+MqUoB1YKqUZ3grGYiXLXIciHboc0OhiCtxIR1W6M6cavsAtHlj8DlNj+fTVvalDIHy
         74udg159h7+Xf8btJEit/ihZjOhuuIrIzg9xBO3ev96L9E/t8wiG+V9Pk6SPpVBYA/4e
         0cBR56s7R/eWMiRwmY8UgV4MYlvuFtsey9C35FuQE9TFx9hvThpq6mFowVovaFMgQxMq
         1kR8ncqlEbm7AvVMob7N3+9WrsNEH0eadJyccflxQBerghS+1SNTMW5eEMB8BSvJASQK
         bX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pMgQyMBUHz4DAGv7dUKQ5faE2OXLKUuJdGmQsBE60y8=;
        b=JZX3MSiVAIFWTKQp5c+/RkLvEMiehP+yNk6eK8bkAS25L0ACywHhsm3OxdoXDtbrxZ
         GudILje6ImjSGU/LuHTq09zIe5QwN4pMQanac1eHIbsILflVF9Tk9z74nV5MF9JOZBGw
         rVAkDOnWClF0YijLZR3oeCT4/7DQV7UdCoSLcnk4DlQfFWjf2RrLd606rUlArfxSCR+L
         xSSTLDAUItuAP/6We7+/851v2QO6i80pxbdzr4CJIRunGOmYKX9eH6pC4pcUlhciCF+D
         ZezVT5PvitQ0gveRxjYAJAQ0cZU2mzlmATZ/w5NGgKhZ4qrAPbDQf4obWfNZXdCrGa4e
         kJEA==
X-Gm-Message-State: ACrzQf2vvzKQIgXLwxer9+SHmf7In+2MMJ5gMw7vvmfL3Z5mbr8rXWR1
        1MWJOUbsVAXuwICuP4Re9zU=
X-Google-Smtp-Source: AMsMyM5eI7766P4xReWjJJvJIeOwhFNTHRvpw0SnB31J+1Nay85fWQ9zH9PSAx5ICwz59XycOdax6Q==
X-Received: by 2002:a17:907:7ea7:b0:78d:3638:9018 with SMTP id qb39-20020a1709077ea700b0078d36389018mr3934377ejc.236.1665060627958;
        Thu, 06 Oct 2022 05:50:27 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b40-20020a509f2b000000b00456c6b4b777sm5710157edf.69.2022.10.06.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:50:27 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:50:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Update comment about config space
Message-ID: <Yz7PEakeTyvmnxDh@orome>
References: <20220911113216.14892-1-pali@kernel.org>
 <YzRcYwQYlawV10QS@orome>
 <20221005194336.gdnu4vfzkudedjw5@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ERmlPpGZ/YGPk8vW"
Content-Disposition: inline
In-Reply-To: <20221005194336.gdnu4vfzkudedjw5@pali>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ERmlPpGZ/YGPk8vW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 09:43:36PM +0200, Pali Roh=C3=A1r wrote:
> On Wednesday 28 September 2022 16:38:27 Thierry Reding wrote:
> > On Sun, Sep 11, 2022 at 01:32:16PM +0200, Pali Roh=C3=A1r wrote:
> > > Like many other ARM PCIe controllers, it uses old PCI Configuration
> > > Mechanism #1 from PCI Local Bus for accessing PCI config space.
> > > It is not PCIe ECAM in any case.
> > >=20
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-tegra.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > Perhaps this should be rolled into the PCI_CONF1_EXT_ADDRESS patch?
>=20
> Well, I split documentation change and PCI_CONF1_EXT_ADDRESS usage into
> two patches as those are two different / separate things. Documentation
> change is a fix (because documentation is wrong) and PCI_CONF1_EXT_ADDRESS
> is an improvement - code cleanup. And in case if there is a issue with
> "cleanup" patch it can be reverted without need to revert also "fix"
> part. This is just information how I looked at these changes and why I
> decided to split them.
>=20
> > On
> > the other hand there's really no use in keeping this comment around
> > after that other patch because the documentation for the new macro lays
> > out the details already.
> >=20
> > Thierry
>=20
> Ok, whether documentation is needed or not - it is your maintainer
> decision. Maybe really obvious things do not have to be documented.
> Also another look at this problem can be that if somebody wrote wrong
> documentation for it, maybe it is not too obvious? I do not have opinion
> on this, so choose what is better :-)

I wrote that documentation back at the time and I fail to see what
exactly is wrong about it. Granted, it doesn't mention the Intel PCI
Configuration mechanism #1 from the PCI Local Bus Specification, but
that's just because I didn't know about it. Back when I wrote this I
was looking at the PCIe specifications (because, well, this supports
PCIe) and I noticed that it was similar to ECAM. And that's exactly
what the comment says and it points out what the differences are.

So just because the mapping is closer to PCI_CONF1_EXT_ADDRESS than
ECAM, it doesn't automatically make the comment wrong. The mapping also
isn't exactly PCI_CONF1_EXT_ADDRESS, so the new comment can be
considered equally wrong. The mapping is neither ECAM nor PCI_CONF1, so
describing it one way or the other doesn't make a difference.

> In any case, wrong documentation (which is the current state) should be
> fixed (and removal in most case is also proper fix).

Again, I don't see that this fixes anything because there was no bug.
The documentation change makes the most sense when combined with the
change that actually implements this in terms of the new macro.

The existing documentation exists to give further background information
about the mapping. If we remove the comment out of context we loose that
extra information. However, if at the same time we change the code to
use another (documented) macro, then we replace the information without
loosing anything.

Thierry

--ERmlPpGZ/YGPk8vW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM+zw4ACgkQ3SOs138+
s6GdLQ/+K2j1y2qtNmImdTk6z0RFpErz4nwlOCuWT8DAT/EhGoQbinPh2BdjSXNg
YXhfLiuq2EPHg/sE0m5EGifBF6ntxU35M34GZydQ/sSpLpyymYDyUj1iWul7PbGe
/OKq/0sOmL/F9L0lkouwEnnftncz5JDa/xGEQ5g6D3wiyTsz1IVorXUjC8ezilSm
ZNxdgaV1uwV4k5Tt+tLGK1FXA1G1bLi0wEUJm3c/sUPQLGkF+HHCeyxzwkDMyVe1
9j5Go1tULi6ZPMGw4MZvX7g02dZ9kZif9I2xf6P+N9LHyvAeG8vVCMlj8In3IT1B
CUwiYwx70qucJZB9gAnOeHWBWCFPHf9gi97kGvkQ4ysCMQ022j2FrsnyEIJ+IwL2
TdiU6Sf60TAjmLudBew0Gf4ruDPyQWL5DLHOb/bqYWd59PBsd2Svno4S7JwaJUKK
fPLwilYCpMjwD/jy7eBG5Hkoehd0jEeTZbg4wVczJVbCHVV3hKJShVpaHjH5CN1p
iaZcK67rPEFyRjuq6skj8bkFKqUaQFRBe7Ui1nrntDi33e32W9JnwJ7DadVeuGfu
9zWLcIxKEHTAaKdx/tUG6RJL+qCLaB/5GBx/7NzLQk4QQn9gOrBb9wm3EkXsUtRR
/JnJkLSvqaDK4VzuGSMkmt/0tPGI+LFF4pSeqqBu0jvfru78CFY=
=uOBE
-----END PGP SIGNATURE-----

--ERmlPpGZ/YGPk8vW--
