Return-Path: <linux-pci+bounces-24051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A09A67745
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EE4189A2B1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537A2E62C;
	Tue, 18 Mar 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDUhq0BG"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935620D50E
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310130; cv=none; b=QfpGkLblbwX2a3rSf2mcRe5OZahOKxd/XJsXlUkoiBDd/S9C9dN2llWDo4+kkEtsh0XbieWYtuXUI7d680uXgGrQwgfpmZTQPvCPpqAaf9ran7rw30+b3IXuKUeL767O7ctaCEqyk54TdIt7fm3MPJK7dt1BpfsHZT5BsnYWJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310130; c=relaxed/simple;
	bh=NeRQV6sfvbTorj7f26S+KJdYMGp4UY/s/qd3Ja4u+tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJB+MQuBuPFKhj1Z+o63MP221Mnt3oQexkbW32bpfMw2whPRCAcCSfphFbeHl+XYKMp5tqrmeEtEFe5BfBDUU4tY1hthKMwekUPaL5NBysoAwfhjlxdbDBj40nm77zP14GUUUOd3yPm4aOpFHdV3dIZpwkBh7rBzctT/cRDlEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDUhq0BG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742310127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4YD2sf+w7TG9LkPdewhHv9XVtamWwqRcBK8ja6UyyY=;
	b=aDUhq0BGNFX/r9G/wJjI5jL03nj7P3+OusVtj88Ls1rdBz6TyPCP4OHCkCfajhkvhB9M1s
	McPE5SGFAVAyvCYSwyjuVWbia7gWhxr+HsEQUircIuN+XhrWDcEZbaCodm/VFScPDR0FLZ
	MjT668ukhwVnqNVpInd2Q8VUhWQOUxM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-xjpRtFcKOSSeMbEgiUlw4Q-1; Tue, 18 Mar 2025 11:02:05 -0400
X-MC-Unique: xjpRtFcKOSSeMbEgiUlw4Q-1
X-Mimecast-MFC-AGG-ID: xjpRtFcKOSSeMbEgiUlw4Q_1742310121
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d44e9f0e69so8705805ab.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 08:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310121; x=1742914921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4YD2sf+w7TG9LkPdewhHv9XVtamWwqRcBK8ja6UyyY=;
        b=eltMwEBtPlQxPFSfPdh1m5UYdwxw/RooaPl+2K0f25Lu7yDM77rw2OEKFxkM/NOYvi
         CnwRDY063iSsjBKkQ5v2XSITxwKQTzkIDO0AmwaRIJAS7m5qYLw/jRVXtzYqRwpRzggr
         IPCgIvNfh9nLuyQuN3mPoM7G2V3cncAgg9HRuAG1uNgVM4e0TlmoMuxyDnqKFBhfa6Ns
         j093Lui2UuVJYDKIUHrEQhq0+VgMsZXCsrT7uDGFW+TVaEfonlUHlgLGtQ1Ig5ChBEGz
         qAQUVXy1RCYSEBZ89B/m4MjyjvqWKGNtNopKN2Fmcm14KEevyGOqmvAb4rCu7OPqG2Hh
         efQg==
X-Forwarded-Encrypted: i=1; AJvYcCUlY238We4XyCMbxnX2GMEK0B/ps/jRlF4fkamJIg8eIkVZVrNswumn9/iFq/FhqEReHNqgjNK2PCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbl/IBjra7nScJGY7jVnjvewU0N5M0J8hMDxgLNp9wTZ0gZ3Z
	Yo5qSR/ciuMMDj3aoAwJ/SAVh8KDNqme0h6vfgst9x/o4wd1YaDvSu2ze0PZN6KhyJVklTdicOP
	eZRvuAthA2Kgf0f5MW8tHxWgVgt1arbl4qo99IgYyScCdUi2NGfWHekz9cw==
X-Gm-Gg: ASbGnctCHG1YCfTRpqro27KLcGKzSKiP8WSwkV/+oPsXuN22A+2E23jAMHAGTMMso/B
	7RvQgCJ0r6ymVnHidvWTglSI4xjoFPDOLi9HtVwCN8j7QI/TkQBNRn5UsVxp3qcuN0dF0FHZC05
	bYyu97bhLdfyzTz0TAuXlVQWZPK7BQ5ElIeb6d/KjPS7KaZozD6oywwYUdUhD+I18FiPD9k6XpR
	FOeGiA4QskqEY26fCOX/ksvwurVthdMZ6/jY+AnaPq69sVcmtjzxNKhGOWUSIVPQ7oyehZUU+6W
	M7sNaMsfPflze2x1AUA=
X-Received: by 2002:a92:cd8f:0:b0:3d2:b3ad:8491 with SMTP id e9e14a558f8ab-3d4839f5b51mr45017915ab.2.1742310121224;
        Tue, 18 Mar 2025 08:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEcLIWZMtQ3F020b/3FknCQq+tiAONkCx2hpltju6JhikxxWuBUauM9d3Fq+6ZXXyItoDnA==
X-Received: by 2002:a92:cd8f:0:b0:3d2:b3ad:8491 with SMTP id e9e14a558f8ab-3d4839f5b51mr45017785ab.2.1742310120858;
        Tue, 18 Mar 2025 08:02:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816ae0sm2795939173.119.2025.03.18.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:01:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:01:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250318090157.525949f9.alex.williamson@redhat.com>
In-Reply-To: <ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
	<20250314085649.4aefc1b5.alex.williamson@redhat.com>
	<kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
	<20250317163859.671a618f.alex.williamson@redhat.com>
	<ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 13:42:57 +0200 (EET)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> + Jakub
> + Alexander
>=20
> On Mon, 17 Mar 2025, Alex Williamson wrote:
> > On Mon, 17 Mar 2025 19:18:03 +0100
> > Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote: =20
> > > On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote: =20
> > > > On Fri,  7 Mar 2025 16:03:49 +0200
> > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > >    =20
> > > > > __resource_resize_store() attempts to release all resources of the
> > > > > device before attempting the resize. The loop, however, only cove=
rs
> > > > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that =
are
> > > > > assigned, pci_reassign_bridge_resources() finds the bridge window=
 still
> > > > > has some assigned child resources and returns -NOENT which makes
> > > > > pci_resize_resource() to detect an error and abort the resize.
> > > > >=20
> > > > > Change the release loop to cover all resources up to VF BARs which
> > > > > allows the resize operation to release the bridge windows and att=
empt
> > > > > to assigned them again with the different size.
> > > > >=20
> > > > > As __resource_resize_store() checks first that no driver is bound=
 to
> > > > > the PCI device before resizing is allowed, SR-IOV cannot be enabl=
ed
> > > > > during resize so it is safe to release also the IOV resources.   =
=20
> > > >=20
> > > > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, whic=
h I
> > > > understand is done intentionally.  Thanks,   =20
>=20
> Thanks for reviewing. I'm sorry I just took Micha=C5=82's word on this fo=
r=20
> granted so I didn't check it myself.
>=20
> I could amend __resource_resize_store() to return -EBUSY if SR-IOV is=20
> there despite no driver being present

I probably never really considered resizing BARs for an SR-IOV capable
device when adding this support originally, but it seems valid to me
that if we extend releasing resources to the SR-IOV BARs that we simply
need to assert that SR-IOV is disabled and fail otherwise.  Thanks,

Alex


