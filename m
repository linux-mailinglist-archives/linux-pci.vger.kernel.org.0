Return-Path: <linux-pci+bounces-6507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1758AC56D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FE91F2302A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60F4D108;
	Mon, 22 Apr 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeJHuQR6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4F4AEDA
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770589; cv=none; b=ZdpAbv7G8VgJdcn35ZG6wqwnr6rll+gerKXCkrYdE3YSXdXFX8L/YUIkuMdkcvOSDppBU4YICX3u2ZhGlNREcSWqLe5EtMojWznF5NQQbyIHWXzHoEBwSTLzat4qXfo+U84OnBs8CiJ1fdc3gT4Eyy57Qaexm/BeC0Dwnk4Q6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770589; c=relaxed/simple;
	bh=OIcMJG+fGAzEz/NTv46bIkb26Nco9QPi8mc1USWHzpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3fEiw6uFKOqyIaBYLNUnTdAObc/yyE9H7vQa1dUcs+ZKu9pa1TP0KqGDKdZEa1TqwNkTQ1IMpsrHpW24CqMPUI2JpL6rZJtrD9hAaNaIJ8WwbYNAVfzfyTL5cU7CTWgSJQu6XRG0c9fysosQWn/WZaxSOjirP0Bbe1sKrI4V+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeJHuQR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713770587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIcMJG+fGAzEz/NTv46bIkb26Nco9QPi8mc1USWHzpU=;
	b=SeJHuQR6am/9hP444de/G2daLMRWouVKzWKYujNTHoPbiIY/QTHkt5ba/RkFDh8RdqiZy8
	lQ7gVNWAMXOEdf89p530Atsvb2jAdmY/DLqYfBDuCDlsTrI7loj9tqGZpf5nYpvch3vb6K
	2rIp7Kbh/shuC0zK5tn2N9yo8/u9Bbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UC8I2yOdMrCNH5OSesLB4Q-1; Mon, 22 Apr 2024 03:23:05 -0400
X-MC-Unique: UC8I2yOdMrCNH5OSesLB4Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-349a31b3232so543590f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 00:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770585; x=1714375385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIcMJG+fGAzEz/NTv46bIkb26Nco9QPi8mc1USWHzpU=;
        b=d0r0eb+K4hM/Gi+CaJ/Z47xImTRaUSSByWCng2L9F/hmZ3uyjaoAP/jhOb5dgtTr9L
         cryRJZVWWPI/5SczsS5Fu5g/LsF1OXXLgUyWKPDYalQlq0KxrDuFGZYyepxWSIILJohc
         MWuEOjT4hEOUwGTWUTz3zKSCuuYMmM0xB8wjCLI/KMDiZh5IbWmPGSNbq65J/TUalnsM
         sEDirFPsEsl0jk2sjGMYJEkHi3qwXBPxBX/YswQwGSKu1Y8tqMVr9jSb1Z37/12x5EAG
         J/I7s6zL+tXZeydUXa5TFtSV1XVeV7flwTCqu0eR+NthImbWVb99uTFUVp39yiulCj5P
         Nj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSkmBUqQaMLVmkDUSnZ04hAqHvAzE8PEOmDMpJ/ZTC44BLKkv1OIUFJyG9tlKQdXh0yhdl+bkXcG8v+fPzwhy2jbVk2i954AUd
X-Gm-Message-State: AOJu0YzQ3s5izfYkzZsIqo3CekrvXdXcKeBg7CRwWyzNjJk5JOEbCEG0
	08a4+C61pK6a0Hf/vS03RiM6pKDS0r05B4GZoVCHLgp2dSH2iJmGzHN80szZL6d+ojLkIqIjEDc
	JygLVy1bemG1HgRaIXUUc4huTrwvShzJJgcYm3BvO7yLhlWaZ34QVbFItgw==
X-Received: by 2002:a5d:6511:0:b0:34a:f759:271d with SMTP id x17-20020a5d6511000000b0034af759271dmr1699021wru.6.1713770584789;
        Mon, 22 Apr 2024 00:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENlaXme2bZIvMK2y5/VlaEUR/I0OvQzcGMAQUuht+3420rTQbT8vstQpX7xul4QgqcRpsBcQ==
X-Received: by 2002:a5d:6511:0:b0:34a:f759:271d with SMTP id x17-20020a5d6511000000b0034af759271dmr1699006wru.6.1713770584420;
        Mon, 22 Apr 2024 00:23:04 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d6b45000000b003472489d26fsm11267653wrw.19.2024.04.22.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:23:04 -0700 (PDT)
Message-ID: <7b8ffa914dfefcdb19bca9d80024fb8754b73459.camel@redhat.com>
Subject: Re: [PATCH v6 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Mon, 22 Apr 2024 09:23:03 +0200
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Yo,

we know reached -rc5.

Is this fine for v6.10?

Regards,
P.


On Mon, 2024-04-08 at 10:44 +0200, Philipp Stanner wrote:
> Changes in v6:
> =C2=A0 - Restructure the cleanup in pcim_iomap_regions_request_all() so
> that
> =C2=A0=C2=A0=C2=A0 it doesn't trigger a (false positive) test robot warni=
ng. No
> =C2=A0=C2=A0=C2=A0 behavior change intended. (Dan Carpenter)
>=20
> Changes in v5:
> =C2=A0 - Add Hans's Reviewed-by to vboxvideo patch (Hans de Goede)
> =C2=A0 - Remove stable-kernel from CC in vboxvideo patch (Hans de Goede)
>=20
> Changes in v4:
> =C2=A0 - Rebase against linux-next
>=20
> Changes in v3:
> =C2=A0 - Use the term "PCI devres API" at some forgotten places.
> =C2=A0 - Fix more grammar errors in patch #3.
> =C2=A0 - Remove the comment advising to call (the outdated) pcim_intx() i=
n
> pci.c
> =C2=A0 - Rename __pcim_request_region_range() flags-field "exclusive" to
> =C2=A0=C2=A0=C2=A0 "req_flags", since this is what the int actually repre=
sents.
> =C2=A0 - Remove the call to pcim_region_request() from patch #10. (Hans)
>=20
> Changes in v2:
> =C2=A0 - Make commit head lines congruent with PCI's style (Bjorn)
> =C2=A0 - Add missing error checks for devm_add_action(). (Andy)
> =C2=A0 - Repair the "Returns: " marks for docu generation (Andy)
> =C2=A0 - Initialize the addr_devres struct with memset(). (Andy)
> =C2=A0 - Make pcim_intx() a PCI-internal function so that new drivers
> won't
> =C2=A0=C2=A0=C2=A0 be encouraged to use the outdated pci_intx() mechanism=
.
> =C2=A0=C2=A0=C2=A0 (Andy / Philipp)
> =C2=A0 - Fix grammar and spelling (Bjorn)
> =C2=A0 - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
> =C2=A0 - Provide the actual structs' and functions' names in the commit
> =C2=A0=C2=A0=C2=A0 messages (Bjorn)
> =C2=A0 - Remove redundant variable initializers (Andy)
> =C2=A0 - Regroup PM bitfield members in struct pci_dev (Andy)
> =C2=A0 - Make pcim_intx() visible only for the PCI subsystem so that
> new=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 drivers won't use this outdated API (Andy, Myself)
> =C2=A0 - Add a NOTE to pcim_iomap() to warn about this function being
> the=C2=A0=C2=A0=C2=A0 onee
> =C2=A0=C2=A0=C2=A0 xception that does just return NULL.
> =C2=A0 - Consistently use the term "PCI devres API"; also in Patch #10
> (Bjorn)
>=20
>=20
> =C2=A1Hola!
>=20
> PCI's devres API suffers several weaknesses:
>=20
> 1. There are functions prefixed with pcim_. Those are always managed
> =C2=A0=C2=A0 counterparts to never-managed functions prefixed with pci_ =
=E2=80=93 or so
> one
> =C2=A0=C2=A0 would like to think. There are some apparently unmanaged fun=
ctions
> =C2=A0=C2=A0 (all region-request / release functions, and pci_intx()) whi=
ch
> =C2=A0=C2=A0 suddenly become managed once the user has initialized the de=
vice
> with
> =C2=A0=C2=A0 pcim_enable_device() instead of pci_enable_device(). This
> "sometimes
> =C2=A0=C2=A0 yes, sometimes no" nature of those functions is confusing an=
d
> =C2=A0=C2=A0 therefore bug-provoking. In fact, it has already caused a bu=
g in
> DRM.
> =C2=A0=C2=A0 The last patch in this series fixes that bug.
> 2. iomappings: Instead of giving each mapping its own callback, the
> =C2=A0=C2=A0 existing API uses a statically allocated struct tracking one
> mapping
> =C2=A0=C2=A0 per bar. This is not extensible. Especially, you can't creat=
e
> =C2=A0=C2=A0 _ranged_ managed mappings that way, which many drivers want.
> 3. Managed request functions only exist as "plural versions" with a
> =C2=A0=C2=A0 bit-mask as a parameter. That's quite over-engineered consid=
ering
> =C2=A0=C2=A0 that each user only ever mapps one, maybe two bars.
>=20
> This series:
> - add a set of new "singular" devres functions that use devres the
> way
> =C2=A0 its intended, with one callback per resource.
> - deprecates the existing iomap-table mechanism.
> - deprecates the hybrid nature of pci_ functions.
> - preserves backwards compatibility so that drivers using the
> existing
> =C2=A0 API won't notice any changes.
> - adds documentation, especially some warning users about the
> =C2=A0 complicated nature of PCI's devres.
>=20
>=20
> Note that this series is based on my "unify pci_iounmap"-series from
> a
> few weeks ago. [1]
>=20
> I tested this on a x86 VM with a simple pci test-device with two
> regions. Operates and reserves resources as intended on my system.
> Kasan and kmemleak didn't find any problems.
>=20
> I believe this series cleans the API up as much as possible without
> having to port all existing drivers to the new API. Especially, I
> think
> that this implementation is easy to extend if the need for new
> managed
> functions arises :)
>=20
> Greetings,
> P.
>=20
> Philipp Stanner (10):
> =C2=A0 PCI: Add new set of devres functions
> =C2=A0 PCI: Deprecate iomap-table functions
> =C2=A0 PCI: Warn users about complicated devres nature
> =C2=A0 PCI: Make devres region requests consistent
> =C2=A0 PCI: Move dev-enabled status bit to struct pci_dev
> =C2=A0 PCI: Move pinned status bit to struct pci_dev
> =C2=A0 PCI: Give pcim_set_mwi() its own devres callback
> =C2=A0 PCI: Give pci(m)_intx its own devres callback
> =C2=A0 PCI: Remove legacy pcim_release()
> =C2=A0 drm/vboxvideo: fix mapping leaks
>=20
> =C2=A0drivers/gpu/drm/vboxvideo/vbox_main.c |=C2=A0=C2=A0 20 +-
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1011 ++++++++++=
+++++++++++--
> --
> =C2=A0drivers/pci/iomap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 123 ++-
> =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 21 +-
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
18 +-
> =C2=A06 files changed, 999 insertions(+), 212 deletions(-)
>=20


