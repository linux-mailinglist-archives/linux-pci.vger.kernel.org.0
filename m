Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5D7E5FE0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjKHVRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 16:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHVRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 16:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E810A
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699478209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paSntSYp2GG/deBqbHgD4a1lEk8wMlIzwd4247xlESU=;
        b=H+V7fUWc/dhfw/Uw1wiV6E0pk3m7DPhLQbqTjeH68c8s8hDI7puX33VRs82BdLPFpfjYdk
        4iRrFCtgl5yBUiFRn78Hg0/0akA2lCKNxCCCL9dbHz3i51N1kjWsbRRdbYsff/TMX9I5wW
        rS31MSdOJNKpplCjhRbDSCMXbMNsZ4U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-q8iGim5COPSDvVBgT7kmyQ-1; Wed, 08 Nov 2023 16:16:48 -0500
X-MC-Unique: q8iGim5COPSDvVBgT7kmyQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b6aa594943so23184b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 13:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477903; x=1700082703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paSntSYp2GG/deBqbHgD4a1lEk8wMlIzwd4247xlESU=;
        b=CAOLg1L67ayQLLPlF5+Hs11Bcnp24O4falptPCGRrx+u4EkK7CnIkO/voz2FT/h0Kp
         KYLjwU+SPE3szmNgVg/kpFLHyvG/OS1OoCN9fODdCds5bQLl4RLo/OPwK6UIcN0v21i/
         9OMC06vJi40RIysEYogBy19dfUDsLJpOYllaP5wBlTk0ygwVFio5lJkpZovSjmB3pwuH
         bIKoE8WSBN2oWtCoTCWxzlnbvt8SIzJdyT42/cfXFYcCezHa4Gr1Sq+V5A+of1XFXtYl
         88l0mRrqldwHJ5N3dgPdUuotRrq8rcCAFwzxEp48QLOzBnUsD7+EWhdExAJG/UuPC2H5
         wDQw==
X-Gm-Message-State: AOJu0YyTY93sow5bDOAflVogv81Eciv0ziqa8scakCHInXvAyZqE2fp4
        SbU4PYdeD47NPgrrg5ORd9ZYz0IOtJMd5m5dp/1QPNrl7dpX2S3kgrPJFx+eY/UcZ3uOoj3kTk9
        CyJN0RILUai1svArd9nI3u5ybSvUR
X-Received: by 2002:a05:6808:1784:b0:3b2:ec6d:edcd with SMTP id bg4-20020a056808178400b003b2ec6dedcdmr3345792oib.3.1699477903436;
        Wed, 08 Nov 2023 13:11:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQZu713UM61gmDnP03DzvxUIH/sg1UGbMqITbGBapXwx3DDnSFzWLR/IkoOSu1DY503y02zw==
X-Received: by 2002:a05:6808:1784:b0:3b2:ec6d:edcd with SMTP id bg4-20020a056808178400b003b2ec6dedcdmr3345775oib.3.1699477903165;
        Wed, 08 Nov 2023 13:11:43 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32cc:4f00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b00767d4a3f4d9sm1445660qkg.29.2023.11.08.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:11:42 -0800 (PST)
Message-ID: <305e0b056b8a7ecb61c4ff5e3eaf4ae169b43c70.camel@redhat.com>
Subject: Re: Implementation details of PCI Managed (devres) Functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 08 Nov 2023 22:11:40 +0100
In-Reply-To: <20231108173522.GA421244@bhelgaas>
References: <20231108173522.GA421244@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-11-08 at 11:35 -0600, Bjorn Helgaas wrote:
> On Tue, Nov 07, 2023 at 08:38:18PM +0100, Philipp Stanner wrote:
> > Hi all,
> >=20
> > I'm currently working on porting more drivers in DRM to managed
> > pci-
> > functions. During this process I discovered something that might be
> > called an inconsistency in the implementation.
> >=20
> > First, there would be the pcim_ functions being scattered across
> > several files. Some are implemented in drivers/pci/pci.c, others in
> > lib/devres.c, where they are guarded by #ifdef CONFIG_PCI
> > =E2=80=93 this originates from an old cleanup, done in
> > 5ea8176994003483a18c8fed580901e2125f8a83
> >=20
> > Additionally, there is lib/pci_iomap.c, which contains the non-
> > managed
> > pci_iomap() functions.
> >=20
> > At first and second glance it's not obvious to me why these pci-
> > functions are scattered. Hints?
> >=20
> >=20
> > Second, it seems there are two competing philosophies behind
> > managed
> > resource reservations. Some pci_ functions have pcim_ counterparts,
> > such as pci_iomap() <-> pcim_iomap(). So the API-user might expect
> > that
> > relevant pci_ functions that do not have a managed counterpart do
> > so
> > because no one bothered implementing them so far.
> >=20
> > However, it turns out that for pci_request_region(), there is no
> > counterpart because a different mechanism / semantic was used to
> > make
> > the function _sometimes_ managed:
> >=20
> > =C2=A0=C2=A0 1. If you use pcim_enable_device(), the member is_managed =
in
> > struct
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev is set to 1.
> > =C2=A0=C2=A0 2. This value is then evaluated in pci_request_region()'s =
call
> > to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find_pci_dr()
> >=20
> > Effectively, this makes pci_request_region() sometimes managed.
> > Why has it been implemented that way and not as a separate function
> > =E2=80=93
> > like, e.g., pcim_iomap()?
> >=20
> > That's where an inconsistency lies. For things like iomappings
> > there
> > are separate managed functions, for the region-request there's a
> > universal function doing managed or unmanaged, respectively.
> >=20
> > Furthermore, look at pcim_iomap_regions() =E2=80=93 that function uses =
a
> > mix
> > between the obviously managed function pcim_iomap() and
> > pci_request_region(), which appears unmanaged judging by the name,
> > but,
> > nevertheless, is (sometimes) managed below the surface.
> > Consequently, pcim_iomap_regions() could even be a little buggy:
> > When
> > someone uses pci_enable_device() + pcim_iomap_regions(), wouldn't
> > that
> > leak the resource regions?
> >=20
> > The change to pci_request_region() hasn't grown historically but
> > was
> > implemented that way in one run with the first set of managed
> > functions
> > in commit 9ac7849e35f70. So this implies it has been implemented
> > that
> > way on purpose.
> >=20
> > What was that purpose?
> >=20
> > Would be great if someone can give some hints :)
>=20
> Sorry, I don't know or remember all the history behind this, so can't
> give any useful hints.=C2=A0 If the devm functions are mostly wrappers
> without interesting content, it might make sense to collect them
> together.=C2=A0 If they *do* have interesting content, it probably makes
> sense to put them next to their non-devm counterparts.

Most of the magic seems to happen here in lib/devres.c

struct pcim_iomap_devres {
	void __iomem *table[PCIM_IOMAP_MAX];
};

static void pcim_iomap_release(struct device *gendev, void *res)
{
	struct pci_dev *dev =3D to_pci_dev(gendev);
	struct pcim_iomap_devres *this =3D res;
	int i;

	for (i =3D 0; i < PCIM_IOMAP_MAX; i++)
		if (this->table[i])
			pci_iounmap(dev, this->table[i]);
}

/**
 * pcim_iomap_table - access iomap allocation table
 * @pdev: PCI device to access iomap table for
 *
 * Access iomap allocation table for @dev.  If iomap table doesn't
 * exist and @pdev is managed, it will be allocated.  All iomaps
 * recorded in the iomap table are automatically unmapped on driver
 * detach.
 *
 * This function might sleep when the table is first allocated but can
 * be safely called without context and guaranteed to succeed once
 * allocated.
 */
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


In devres_alloc_node() it registers the cleanup-callback and places the
struct that keeps track of the already mapped BARs in the devres-node.

Besides, the managed wrappers usually call directly into the unmanaged
pci_ functions, as you can for example see above in
pcim_iomap_release()

Not sure if that qualifies for "interesting content", but it certainly
might be a bit difficult to extend (see my other answer in this thread)
^^'

>=20
> The pci_request_region() managed/unmanaged thing does seem like it
> could be unexpected and lead to issues as you point out.

Unfortunately it already did. I discovered such a bug today. Still
trying to figure out how to solve it, though. Once that's done I link
it in this thread.

P.

>=20
> Bjorn
>=20

