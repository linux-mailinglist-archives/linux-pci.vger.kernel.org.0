Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B96A168F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2KsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:48:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38217 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH2KsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:48:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so2929581wro.5
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M66YH6jCR+YlmOwPqnaTJ3g24q1z7oOst5TzfeavMpo=;
        b=W+oXIRD+pxPdw48MGgVwrFDqL+6+39s2r5KXpPaIg3qEy0c2bZEwaxibj7SRxigSS1
         7ZCcavZlOa8mIfx933WtMVRtFP//sH+/cYYYzZTAYqRj2YslgUvaDX68XzZtNznzzNkW
         UB7hQF/qffvqqtJemlbizMoGAFvj8Q7OGCHaebvRjDlH4GOu9wq/bHXpxnN09NBh8Qrm
         WeWUqewY6C8gjfRWzYwh53287Fc5LUq40L13egmXJ0eYciHdQib/sqt3FX3swnBAYd/d
         xT2P1JOP2XnB13veyYR4O/5EdlwQHoz2Wnxjiv5HMp73ZIUe5GuILTzgv+kSvFt3iLm+
         WO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M66YH6jCR+YlmOwPqnaTJ3g24q1z7oOst5TzfeavMpo=;
        b=uWoa6ovNNCnvjqOFGfqgzT3SBUqLglyNTOf0BlV4BW0CfZ878bYmr1CVnkkxVPDHEb
         /MmOspVYL00E+HTGfzRxyVXsNTTqLNHMFOxMKCFCZHwKoP70KXg7yLqCugdEi7XkGs53
         +6nYk7Upqr4XG7DNugcb+Y890cVUfvh0fdef0hZxUCPKwkqkfS9/Gz5oGJmZcmv8bqmI
         4SWPFjYDucSvhdbgaR7v1kKYhw7ovyVTXSvM+XKDQxaAcXDKZ95ibHfEqErkGRMMrEav
         fSaHrcndQdrcvpKrxHyC3lxPYorRBfS0tpeAusmrHR+vBsrYHwbTmYt52M3RjkEQDAnQ
         KrCw==
X-Gm-Message-State: APjAAAW65nIWiHX83upxuSzdrqEvfNnPtMLsUnCS4VF/+wLHfODktqAF
        iUl2mxdbwRAp7w4FumMDCWs=
X-Google-Smtp-Source: APXvYqye+ZzxdMEedgcDXY37HQNlQw/Lk26u1bmLdv8umJ8Y3qmg44/5TP7cwaswIHbKc+B6e5VPhw==
X-Received: by 2002:adf:94e5:: with SMTP id 92mr10708818wrr.212.1567075692369;
        Thu, 29 Aug 2019 03:48:12 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id o3sm2287354wrv.90.2019.08.29.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:48:11 -0700 (PDT)
Date:   Thu, 29 Aug 2019 12:48:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829104806.GA13187@ulmo>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 11:09:34AM +0100, Andrew Murray wrote:
> On Wed, Aug 28, 2019 at 10:49:01PM +0100, Mark Brown wrote:
> > On Wed, Aug 28, 2019 at 10:26:55PM +0100, Andrew Murray wrote:
> >=20
> > > I initially thought that you forgot to check for -ENODEV - though I c=
an see
> > > that the implementation of devm_phy_optional_get very helpfully does =
this for
> > > us and returns NULL instead of an error.
> >=20
> > > What is also confusing is that devm_regulator_get_optional, despite i=
ts
> > > _optional suffix doesn't do this and returns an error. I wonder if
> > > devm_phy_optional_get should be changed to return NULL instead of an =
error
> > > instead of -ENODEV. I've copied Liam/Mark for feedback.
> >=20
> > The regulator API has an assumption that people will write bad DTs and
> > not describe all the regulators in the system, this is especially likely
> > in cases where consumer drivers initially don't have regulator support
> > and then get it added since people often only describe supplies actively
> > used by drivers.  In order to handle this gracefully the API will
> > substitute in a dummy regulator if it sees that the regulator just isn't
> > drescribed in the system but a consumer requests it, this will ensure
> > that for most simple uses the consumer will function fine even if the DT
> > is not fully described.  Since most devices won't physically work if
> > some of their supplies are missing this is a good default assumption. =
=20
>=20
> Right, if I understand correctly this is the behaviour when regulator_get
> is called (e.g. NORMAL_GET) - you get a dummy instead of an error.
>=20
> >=20
> > If a consumer could genuinely have some missing supplies (some devices
> > do support this for various reasons) then this support would mean that
> > the consumer would have to have some extra property to say that the
> > regulator is intentionally missing which would be bad.  Instead what we
> > do is let the consumer say that real systems could actually be missing
> > the regulator and that the dummy shouldn't be used so that the consumer
> > can handle this.
>=20
> And if I understand correctly this is the behaviour when
> regulator_get_optional is called (e.g. OPTIONAL_GET) - you get -ENODEV
> instead of a dummy.
>=20
> But why do we return -ENODEV and not NULL for OPTIONAL_GET?
>=20
> Looking at some of the consumer drivers I can see that lots of them don't
> correctly handle the return value of regulator_get_optional:
>=20
>  - some fail their probes and return upon IS_ERR(ret) - for example even
>    if -ENODEV is returned.
>=20
>  - some don't fail their probes and assume the regulator isn't present up=
on
>    IS_ERR(ret) - yet this may not be correct as the regulator may be pres=
ent
>    but -ENOMEM was returned.
>=20
> Given that a common pattern is to set a consumer regulator pointer to NULL
> upon -ENODEV - if regulator_get_optional did this for them, then it would
> be more difficult for consumer drivers to get the error handling wrong and
> would remove some consumer boiler plate code.
>=20
> (Of course some consumers won't set a regulator pointer to NULL and inste=
ad
> test it against IS_ERR instead of NULL everywhere (IS_ERR(NULL) is false)=
 -
> but such a change may be a reason to not use IS_ERR everywhere).
>=20
> As I understand, if a consumer wants to fail upon an absent regulator
> it seems the only way they can do this is call regulator_get_optional (wh=
ich
> seems odd) and test for -ENODEV. I'm not sure if there is actually a use-=
case
> for this.
>=20
> I guess I'm looking here for something that can simplify consumer error
> handling - it's easy to get wrong and it seems that many drivers may be w=
rong.

Agreed. However, this requires a thorough audit of all callers of
regulator_get_optional() to make sure they behave in a sane way. To
further complicate things, unless we want to convert all ~100 callers
in a single patch we need to convert all of them to set the regulator
pointer to NULL on -ENODEV. After that we can make the change to
regulator_get_optional() and only then can we remove the now obsolete
boilerplate from those ~100 callers. Not impossible, but pretty time-
consuming.

While at it, we could also add optional variants to some of the
*phy*_get() functions to convert those as well. Currently there's only
optional variants for phy_get() and devm_phy_get(), but a bunch of
drivers use of_phy_get() or of_phy_get_by_index(). Though especially the
latter isn't very common with optional PHYs, I think.

I also noticed a slightly similar pattern for GPIOs. Perhaps this would
be a good task for someone with good semantic patch skills. Or perhaps
something to add to the janitors' TODO list? Not sure if that's still a
thing, though.

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1nrWIACgkQ3SOs138+
s6E0GxAApzHNid5OEYGQlo97Fea57E7eDcI81YdZRcsqH+gwEqDdRe/OM2kUGkec
w6cP5Qc+pXKKHljlei39eH6hD0qMsoFthcd+NK9ZB0UR5lSA3wFRz3upN/0k2rHc
XQJgD743k1fDaCI/k2SeSuHaUHuHdSKvbMKVLDi8EMPwIVfP+2cE+S4Uo8NVLoY/
/dS+bnY1UxhNcTm+mi3LLPVg2356L9/pvnKEHMeFFIJPpV5r/D7z+uAFKQvo8+tj
2jEdlHxszgEvNL/EBI2Hihmt9xHslntxtqw4wV0OhDd0rGM475PS9jgZzmh5vqSL
ciAFKfv0iufycSuV7du/4lxinjKMwPhnuS9U/ssLVywTL7fZpB7oYXHfRTYntabB
tj4Q/1fKukCPAh64kNC3P0JFGjOn+THTggKKdCCu4jSrM88DoHXq0lC/1X4OBBC1
iXwz+9/kNHo3nWPsd6BSENoLGhr5hLVMRmO5hnCayfPNb6ueQPvoMkn/h8bXuKR8
LPC6V2dMysMl8ti18+2q6l8YAviAFbxMjJ0/rokm3lqlFSbc1awrXnAuKC037iAS
wmgmKq1tgnQVjQ02RoaA+IhypBqKOKed+gLcV+6Ih/sHJJiE2oElNOBojVTKGqAQ
gIAIMCmpCiJHLZBsIWYWjVVWZf2VIP3FnGHCe/UQX8sZ1T27YBM=
=b2cs
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
