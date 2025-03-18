Return-Path: <linux-pci+bounces-24052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741FA677AA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272423AA6D6
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1B20E6EE;
	Tue, 18 Mar 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx31GU47"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AF20F09D
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311448; cv=none; b=C5qHjyptAsQhiZZ/vWY8SL/eaNyXH1aPFczfzZ+l9HyZupJd6hNEIolJ5ryllGLYPrlAWhZ6urJsz2V6D24R1A5G6HUgYYFF/UDfKp3u6qtxUTJFHjVVmLDwn+wEH0eLKNqL01fYwMFDsNLEoD1PSuyf32uTilYGReh1eWlWYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311448; c=relaxed/simple;
	bh=Cf1OUc2bx4y6zBMNWnUJYqW8Aw9LIHUNqo7NCdWdpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyG9rTOF5/AfSJseJ4/Ll18AYiJZdp6QcDXsLFDvDBa+IgsmOf42Sr+ZhqcxTw6s8ENvrxZvdfos3dtOErnkiYviDpVlfYMgUOsKZdnzqySX9Rbx/y253PUgnJaLr7Va+qpUIkN2iSNDMKdNEIeNXF5wqzoeauLRhA7ffhk+MHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tx31GU47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742311442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wbk8EGXD4NayOlZfLLYd39YdsPD/QxzEO894bNthxCE=;
	b=Tx31GU478b9g7BCZn0H8T/b6A4lWibGiU5BZm66xImHQHsSYhegf7/USsREFmAaUgnAOQT
	nvDPLqOgQSHy2YAcnxYNawUAraegNwKOv8SIXxurbAdX7484JuiZ/8/5E7z1YRYBbDi965
	fkbSlICwXnOQ3jATbBRLCGNQjKQFT0I=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-HMhD9TjPO763_hbqvrTCwA-1; Tue, 18 Mar 2025 11:23:55 -0400
X-MC-Unique: HMhD9TjPO763_hbqvrTCwA-1
X-Mimecast-MFC-AGG-ID: HMhD9TjPO763_hbqvrTCwA_1742311435
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d43405d1baso6664175ab.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311435; x=1742916235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbk8EGXD4NayOlZfLLYd39YdsPD/QxzEO894bNthxCE=;
        b=hsRh4/jKkJ7QIH13sJTsyPgt1WuZebHarUAQ5OlHtXbSiUy42yMzXOZdldmFlwuNYe
         vu04YDhgvKpzp/xuWL2UJ84mr+Z54spu7uoi5NXp1wPNBnGcj1pCAlu+3kfmsRC1VRed
         kAbHbEy40woioD1I39xBN0jARW0qWGEffJ4+jj/Xh9CV55EQcL6ARy3Ozq/jJppqvGre
         7oQ8kZIn3OeupU6Y7C9T6g5HeLZO3/U5YbjHgTEOfbEuJFfok8pUIRrywJs5VuoqDe5a
         HqGSspPRuJSUvbkU+srrkn0HyQg5cQcGxTUJHROKe+IQqWLjH7jcXD+pyUPAgOWGXja+
         e0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWQNT/t8KFMaxBROYxgBIxD21XyPAXaZ2DURpcOTicBDQJmaXZS5b+5alTMPPERvo7iO3/6aIWrFp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3gMKV81ZVyed1IPIRCLnpA90mgxnuIINQccrbD1lCCjOZWyo
	/oTPWkCPWnysafSOtpWx9t1Z+2fLh8s1SI1yopoGJRWUaJcadXnENS1mzj5nPNYWtmqnqvn9C5I
	9tWWuyNAxco6PORjUaYdy3kUMoWcfq1lgyR71Da9XKKe2TIiI3RwGj6QZIg==
X-Gm-Gg: ASbGncvyATHvY9vw6uLGVHUVAwAli0gUIiuWfyFc6K7UZZNx7ZED/83TnRGaLjjOXDD
	PM15smp33TXyi/W0CVsFBZCizT1m3gITSRf/Dt0Yi2djs2PAJxK2PF7GElc2pFqktrQXCkU+0li
	VLmeHzf69MDvsXr7TC0A0vG3xzk8NAkwH0Ttk1F/TylVwmDI7EB+1S+ZSu2PTvk0LOGltS86lcw
	pO1QvE+jTE4nPAjOPfF8Ip9zIHpzRg0gyr78fX0zvSvz93U8oQGro2PG88ZaIstqMFYBfx7U3KI
	J15/xBxQ0KV2B2c0xLU=
X-Received: by 2002:a05:6e02:1d1a:b0:3d3:dba6:794b with SMTP id e9e14a558f8ab-3d48397f815mr49346545ab.0.1742311435152;
        Tue, 18 Mar 2025 08:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsqooDZPEJptdKOp2GMmqlQWXXfWQoj6QYiJvFz7JFaLA5sT8U5NHTJbX8x5gNGdFuZRsaOg==
X-Received: by 2002:a05:6e02:1d1a:b0:3d3:dba6:794b with SMTP id e9e14a558f8ab-3d48397f815mr49346465ab.0.1742311434790;
        Tue, 18 Mar 2025 08:23:54 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637193edsm2809223173.31.2025.03.18.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:23:53 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:23:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250318092352.1bf43af4.alex.williamson@redhat.com>
In-Reply-To: <20250318090157.525949f9.alex.williamson@redhat.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
	<20250314085649.4aefc1b5.alex.williamson@redhat.com>
	<kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
	<20250317163859.671a618f.alex.williamson@redhat.com>
	<ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
	<20250318090157.525949f9.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 09:01:57 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 18 Mar 2025 13:42:57 +0200 (EET)
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > + Jakub
> > + Alexander
> >=20
> > On Mon, 17 Mar 2025, Alex Williamson wrote: =20
> > > On Mon, 17 Mar 2025 19:18:03 +0100
> > > Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote:   =20
> > > > On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote:   =
=20
> > > > > On Fri,  7 Mar 2025 16:03:49 +0200
> > > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >      =20
> > > > > > __resource_resize_store() attempts to release all resources of =
the
> > > > > > device before attempting the resize. The loop, however, only co=
vers
> > > > > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs tha=
t are
> > > > > > assigned, pci_reassign_bridge_resources() finds the bridge wind=
ow still
> > > > > > has some assigned child resources and returns -NOENT which makes
> > > > > > pci_resize_resource() to detect an error and abort the resize.
> > > > > >=20
> > > > > > Change the release loop to cover all resources up to VF BARs wh=
ich
> > > > > > allows the resize operation to release the bridge windows and a=
ttempt
> > > > > > to assigned them again with the different size.
> > > > > >=20
> > > > > > As __resource_resize_store() checks first that no driver is bou=
nd to
> > > > > > the PCI device before resizing is allowed, SR-IOV cannot be ena=
bled
> > > > > > during resize so it is safe to release also the IOV resources. =
    =20
> > > > >=20
> > > > > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, wh=
ich I
> > > > > understand is done intentionally.  Thanks,     =20
> >=20
> > Thanks for reviewing. I'm sorry I just took Micha=C5=82's word on this =
for=20
> > granted so I didn't check it myself.
> >=20
> > I could amend __resource_resize_store() to return -EBUSY if SR-IOV is=20
> > there despite no driver being present =20
>=20
> I probably never really considered resizing BARs for an SR-IOV capable
> device when adding this support originally, but it seems valid to me
> that if we extend releasing resources to the SR-IOV BARs that we simply
> need to assert that SR-IOV is disabled and fail otherwise.  Thanks,

Also, I've never seen it, but I'm under the impression that it's
possible for pre-boot to hand-off a device with SR-IOV already enabled.
Therefore I think this would be a worthwhile addition, regardless of the
behavior of any given in-kernel driver.  Thanks,

Alex


