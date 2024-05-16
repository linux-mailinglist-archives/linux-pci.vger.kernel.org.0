Return-Path: <linux-pci+bounces-7577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4338C77EE
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16F71C21B6A
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1E1474D9;
	Thu, 16 May 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKoTJ3HW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED0145A1D
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867389; cv=none; b=i02TaixaaaXxyY+hbVVtyv3Wud6/jYmW6PYUxPfz7scL0aIJvZYf5ctxLfz2r+bdwnKTAL8e8+zTP/3Wle8WtSllD9ywG8wfbso1eaIxGTnQ0sJ1nrAFjehUtMrbect/Z1Ic5gjpVXOfLkVrfdQdLS4GPg0OXtug1YDXxKsMeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867389; c=relaxed/simple;
	bh=iakNWc7F6HuSiUO8Jqe2EDv5oR4F/2lzF2b1HKw904I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVpMzSBAo2g2ngcVneFMhIAZSS1fIXofgn6UDZAyegm9Ra87vqPL5/u33hgl0hBXXwAC31k2KMYlprDq4JFCUQrS44ba5V+Me+Dc8JMytESmEIisvZ6hLBrT4J+joMfncEMcoA+DGD8BmUc8hHcO50WlvRd8xxs6KQGJX25cVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKoTJ3HW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715867386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7YdvvVfIZDxqqpB6T9vcJmnv88i4uSuhdDa0a9miHE=;
	b=YKoTJ3HWyPg7TzGYpCLzlwra+gst82wG+Zpwrt+dFuXJku/cRfO2lgKJkZ7gT0a1ccFker
	3pTloCImgJ6eqL3DxlUxQdZ0Z054K0rUoVSTv+Hbe42E4FcaoV3/YDP4VsOlASBRPGggPe
	z1yu27I052NbY2EkEpsuiJ5AXYl/Ckk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Gr_e7eTbPXuMgdIfhPV_nw-1; Thu, 16 May 2024 09:49:45 -0400
X-MC-Unique: Gr_e7eTbPXuMgdIfhPV_nw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so726394939f.0
        for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 06:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867383; x=1716472183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7YdvvVfIZDxqqpB6T9vcJmnv88i4uSuhdDa0a9miHE=;
        b=IHOiDYB11mL5qn87R/xUU5FpWxq1VNkCsQ1EX02Wx9aJbnR5k8cnLbcmwMDU9F27aD
         ljbPsCCQmc1c2y4lurx0ig1tv5oIrJUioNSJnOMvIDY5lwhzTPUbXDL+AGRyQQxj3mi7
         NwssrWWIkHe8YMns6S09dQu2CkKrhomQiCG1nd8UjI/wyDO+dcDq+BJ68o6HnqD7aSoe
         7b44vF0CEojHOeYeQO4l8kHEkcdcmYXLun5XxbZC2Hfw5MRWsOt6hZmphi7zdlKD2Sqv
         3VorKEN5g9uwe4XSh+4lbT6kAJ4YgWDDAo2NP2BU7di6fffuCRIKLPbAANevMs4zPio0
         OR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxcSPZky4WNXoSxfoL8WZB8PyF7PVJcCsxi9e3E0mITRCduHHkdNPppzGZwwWrFPmO6lxzcYpX0ke7ClAvDLylSR1J8LQmf/l5
X-Gm-Message-State: AOJu0Yyc0h15iCdoPVhCBlLWVubEso5WuVSn2HNRnU2GUBwkPyjyirJu
	CG+P4aXjLn65QS56M127Yy27hjwK9kh67eeVSXq+YuqfdXInQ5hLb2pPvCFwsXlIZzsxMhCHP+3
	6BKo5K2wMDe2hrfTV/zTYAwoX20jc1ImBiKGYsSxvJ+Zfkb+UqGhWJ1RN1Q==
X-Received: by 2002:a05:6e02:1c2d:b0:36c:50c5:a5fc with SMTP id e9e14a558f8ab-36cc14774f3mr236146885ab.12.1715867383336;
        Thu, 16 May 2024 06:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCuIPSRgAWYmNxzxg9/pix3zmTqWtGDN4umBsTfywrad1rVPzF7N/aJMxAnjyKChJzTWJ/fQ==
X-Received: by 2002:a05:6e02:1c2d:b0:36c:50c5:a5fc with SMTP id e9e14a558f8ab-36cc14774f3mr236146705ab.12.1715867382998;
        Thu, 16 May 2024 06:49:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36dc38759c0sm1314035ab.39.2024.05.16.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:49:42 -0700 (PDT)
Date: Thu, 16 May 2024 07:49:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
Message-ID: <20240516074939.3689ff0d.alex.williamson@redhat.com>
In-Reply-To: <a16aeae5-9507-3a5d-de04-04eb92aefffc@linux.intel.com>
References: <20240507213125.804474-1-alex.williamson@redhat.com>
	<a16aeae5-9507-3a5d-de04-04eb92aefffc@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 16:46:09 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Tue, 7 May 2024, Alex Williamson wrote:
>=20
> > Resizing BARs can be blocked when a device in the bridge hierarchy
> > itself consumes resources from the resized range.  This scenario is
> > common with Intel Arc DG2 GPUs where the following is a typical
> > topology:
> >=20
> >  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel=
 Corporation DG2 [Arc A380]
> >                                              \-04.0-[61]----00.0  Intel=
 Corporation DG2 Audio Controller
> >=20
> > Here the system BIOS has provided a large 64bit, prefetchable window:
> >=20
> > pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff windo=
w]
> >=20
> > But only a small portion is programmed into the root port aperture:
> >=20
> > pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit =
pref]
> >=20
> > The upstream port then provides the following aperture:
> >=20
> > pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit =
pref]
> >=20
> > With the missing range found to be consumed by the switch port itself:
> >=20
> > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> >=20
> > The downstream port above the GPU provides the same aperture as upstrea=
m:
> >=20
> > pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit =
pref]
> >=20
> > Which is entirely consumed by the GPU:
> >=20
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> >=20
> > In summary, iomem reports the following:
> >=20
> > b000000000-bfffffffff : PCI Bus 0000:5d
> >   bfe0000000-bff07fffff : PCI Bus 0000:5e
> >     bfe0000000-bfefffffff : PCI Bus 0000:5f
> >       bfe0000000-bfefffffff : PCI Bus 0000:60
> >         bfe0000000-bfefffffff : 0000:60:00.0
> >     bff0000000-bff07fffff : 0000:5e:00.0
> >=20
> > The GPU at 0000:60:00.0 supports a Resizable BAR:
> >=20
> > 	Capabilities: [420 v1] Physical Resizable BAR
> > 		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
> >=20
> > However when attempting a resize we get -ENOSPC:
> >=20
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: rel=
easing
> > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64b=
it pref]: releasing
> > pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64b=
it pref]: releasing
> > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]:=
 can't assign; no space
> > pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]:=
 failed to assign
> > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]:=
 can't assign; no space
> > pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]:=
 failed to assign
> > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign=
; no space
> > pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to as=
sign
> > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 6=
4bit pref]
> > pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 6=
4bit pref]
> > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 6=
4bit pref]
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: ass=
igned
> >=20
> > In this example we need to resize all the way up to the root port
> > aperture, but we refuse to change the root port aperture while resources
> > are allocated for the upstream port BAR.
> >=20
> > The solution proposed here builds on the idea in commit 91fa127794ac
> > ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
> > be resized while there is no driver attached.  In this case, when there
> > is no driver bound to the upstream switch port we'll release resources
> > of the bridge which match the reallocation.  Therefore we can achieve
> > the below successful resize operation by unbinding 0000:5e:00.0 from the
> > pcieport driver before invoking the resource2_resize interface on the
> > GPU at 0000:60:00.0.
> >=20
> > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: rel=
easing
> > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64b=
it pref]: releasing
> > pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pr=
ef]: releasing
> > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: rel=
easing
> > pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64b=
it pref]: releasing
> > pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64b=
it pref]: assigned
> > pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pr=
ef]: assigned
> > pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: ass=
igned
> > pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64b=
it pref]: assigned
> > pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: ass=
igned
> > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit =
pref]
> > pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 6=
4bit pref]
> > pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> > pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> > pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit =
pref]
> > pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> > pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 6=
4bit pref]
> >=20
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com> =20
>=20
> Yes. Looks another case where an already assigned resource prevents some=
=20
> operation from succeeding.
>=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 909e6a7c3cc3..15fc8e4e84c9 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(stru=
ct pci_dev *bridge)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> > =20
> > +static void pci_release_resource_type(struct pci_dev *pdev, unsigned l=
ong type)
> > +{
> > +	int i;
> > +
> > +	if (!device_trylock(&pdev->dev))
> > +		return;
> > +
> > +	if (pdev->dev.driver) =20
>=20
> Isn't portdrv bound to bridges so how does this ends up working?

The user will need to unbind the bridge from the driver, just like
they'd need to unbind the endpoint from a driver to resize a BAR
through sysfs.  I'm not sure how else to avoid races with drivers
requesting resources other than to assert that there is no driver for
the device.  Do you have an alternative suggestion?  Thanks,

Alex


