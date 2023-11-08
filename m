Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AD7E5F97
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjKHVDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 16:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 16:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2152113
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699477355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TP4HWuqc6+S21p7XlOM2ZGKm5NH8oXRqzhuYxPqLszo=;
        b=GBZ1CSTF3kD50/1WzHpgVT6V11lt6PFkS4aD08vjBX5h5eLqpym4shPuohO9cyE6iA/vTo
        bdJ/aawchhgIMXtxnRu3xzKWFOmc0M2TugjCx2G1K5CAOpGUwo/Ycd1T2eNMnrLShukPFf
        Rq5TYGDy/DCdeGuSErbg1XyAqiNCjxU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-KiP_M9_8PRCRg2jdbHRgpw-1; Wed, 08 Nov 2023 16:02:34 -0500
X-MC-Unique: KiP_M9_8PRCRg2jdbHRgpw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce2908d14dso15423a34.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 13:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477353; x=1700082153;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TP4HWuqc6+S21p7XlOM2ZGKm5NH8oXRqzhuYxPqLszo=;
        b=NDuVzQFiAW8bY7NqaaGv6WtqE/a8wI1rOFv7XcS4yheVXOEg3Zfp0WGAGj5UgxRsZ6
         TKJdmOXOh68VRiGHj4VB9G6kYvg/PpvWQsKiMeFzgvUXL18hIKSjneg9Yk6ecJUkW1aC
         2NswCLbpwMZgn9My7EjO/PAv40VgxQVng47AqLWqpboQZp8Mq/3OoYB9z9KLM8/1kED2
         t4jSg00PC3Nys1IGqVWO3Bjlq/scSadKV5hsBI2hBwNxQb5QK0bIGNdy7d4SQ2Mk4CcL
         k4r0G6kiz3StxGVD5eLIuQ2iq0lzO5pHaCboFQKiQ1LOnUoqMp26hTRuD7WmCvf7/gAE
         HyNg==
X-Gm-Message-State: AOJu0YxqPTfSfaUWMS/91Rvwl3oQRo0wIA5gQQLdUwhQVxjytdQbDOI1
        9CA1YEGlW801hAfO1ldZ8t72NDTjCAb9GnJZzLD5pnOH6nWZFX/J8raleIr/StnXQ7SsA2zuRI0
        /U+9AAxvg7exaDuHtPhcDuVBPe/8vxqWLPrt+k/q0IeqhnbO+rndNBevJvvkak9aB6iY0iMoFMx
        9p8b7W
X-Received: by 2002:a05:6808:1784:b0:3b2:ec6d:edcd with SMTP id bg4-20020a056808178400b003b2ec6dedcdmr3320191oib.3.1699477353361;
        Wed, 08 Nov 2023 13:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAL0yQhQ9JQfPSl0eGzmMtITWMMnl/qAqqjK6shV9GeqY4L6d39bDSLxUZw0J7Wy/8e1h6jw==
X-Received: by 2002:a05:6808:1784:b0:3b2:ec6d:edcd with SMTP id bg4-20020a056808178400b003b2ec6dedcdmr3320155oib.3.1699477352900;
        Wed, 08 Nov 2023 13:02:32 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32cc:4f00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id pp25-20020a056214139900b00655e428604esm1450673qvb.137.2023.11.08.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:02:32 -0800 (PST)
Message-ID: <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
Subject: Re: Implementation details of PCI Managed (devres) Functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 08 Nov 2023 22:02:29 +0100
In-Reply-To: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
References: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So, today I stared at the code for a while and come to a somewhat
interesting insight:


On Tue, 2023-11-07 at 20:38 +0100, Philipp Stanner wrote:
> Hi all,
>=20
> I'm currently working on porting more drivers in DRM to managed pci-
> functions. During this process I discovered something that might be
> called an inconsistency in the implementation.

I think I figured out why not all pci_ functions have a pcim_
counterpart.

I was interested in implementing pcim_iomap_range(), since we could use
that for some drivers.

It turns out, that implementing this would be quite complicated (if I'm
not mistaken).

lib/devres.c:

struct pcim_iomap_devres {
	void __iomem *table[PCIM_IOMAP_MAX];
};

void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
{
	struct pcim_iomap_devres *dr, *new_dr;

	dr =3D devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
	if (dr)
		return dr->table;

	new_dr =3D devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERN=
EL,
				   dev_to_node(&pdev->dev));
	if (!new_dr)
		return NULL;
	dr =3D devres_get(&pdev->dev, new_dr, NULL, NULL);
	return dr->table;
}

That struct keeps track of the requested BARs. That's why there can
only be one mapping per BAR, because that table is statically allocated
and is indexed with the bar-number.
pcim_iomap_table() now only ever returns the table with the pointers to
the BARs. Adding tables to that struct that keep track of which
mappings exist in which bars would be a bit tricky and require probably
an API change for everyone who currently uses pcim_iomap_table(), and
that's more than 100 C-files.

So, it seems that a concern back in 2007 was to keep things simple and
skip the more complex data structures necessary for keeping track of
the various mappings within a bar.
In theory, there could be an almost unlimited number of such mappings
of various sizes, almost forcing you to do book-keeping with the help
of heap-allocations.

I guess one way to keep things extensible would have been to name the
function pcim_iomap_bar_table(), so you could later implement one like
pcim_iomap_range_table() or something.
But now it is what it is..

That still doesn't explain why there's no pcim_request_region(),
though...


P.

>=20
> First, there would be the pcim_ functions being scattered across
> several files. Some are implemented in drivers/pci/pci.c, others in
> lib/devres.c, where they are guarded by #ifdef CONFIG_PCI
> =E2=80=93 this originates from an old cleanup, done in
> 5ea8176994003483a18c8fed580901e2125f8a83
>=20
> Additionally, there is lib/pci_iomap.c, which contains the non-
> managed
> pci_iomap() functions.
>=20
> At first and second glance it's not obvious to me why these pci-
> functions are scattered. Hints?
>=20
>=20
> Second, it seems there are two competing philosophies behind managed
> resource reservations. Some pci_ functions have pcim_ counterparts,
> such as pci_iomap() <-> pcim_iomap(). So the API-user might expect
> that
> relevant pci_ functions that do not have a managed counterpart do so
> because no one bothered implementing them so far.
>=20
> However, it turns out that for pci_request_region(), there is no
> counterpart because a different mechanism / semantic was used to make
> the function _sometimes_ managed:
>=20
> =C2=A0=C2=A0 1. If you use pcim_enable_device(), the member is_managed in
> struct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev is set to 1.
> =C2=A0=C2=A0 2. This value is then evaluated in pci_request_region()'s ca=
ll to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find_pci_dr()
>=20
> Effectively, this makes pci_request_region() sometimes managed.
> Why has it been implemented that way and not as a separate function =E2=
=80=93
> like, e.g., pcim_iomap()?
>=20
> That's where an inconsistency lies. For things like iomappings there
> are separate managed functions, for the region-request there's a
> universal function doing managed or unmanaged, respectively.
>=20
> Furthermore, look at pcim_iomap_regions() =E2=80=93 that function uses a =
mix
> between the obviously managed function pcim_iomap() and
> pci_request_region(), which appears unmanaged judging by the name,
> but,
> nevertheless, is (sometimes) managed below the surface.
> Consequently, pcim_iomap_regions() could even be a little buggy: When
> someone uses pci_enable_device() + pcim_iomap_regions(), wouldn't
> that
> leak the resource regions?
>=20
> The change to pci_request_region() hasn't grown historically but was
> implemented that way in one run with the first set of managed
> functions
> in commit 9ac7849e35f70. So this implies it has been implemented that
> way on purpose.
>=20
> What was that purpose?
>=20
> Would be great if someone can give some hints :)
>=20
> Regards,
> P.
>=20

