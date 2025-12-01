Return-Path: <linux-pci+bounces-42390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB481C98A79
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 19:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40834E1840
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DA337BBB;
	Mon,  1 Dec 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzQLz69l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FD31813F
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612479; cv=none; b=es6zeXmvMgZ4++LxiBDJoG/PihwtSUFb+Qn/9UpCYvP3u8k4ikbYSxtheYL6/B/LfdcGib4+zHINAnwok3maWJnm4lmmwpYVEP7fxRiYL3ECnMqrvmBdLqC073ezPW/5t1RQAIZBU8R2r188bbHUhxc7tpP/gFuMSjGleMVZBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612479; c=relaxed/simple;
	bh=8rsROMn92J41TVNBjy3cP4TH9efYQIu1NyuM3KAZho4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW4YSjwdqnAhFLyP0yRc6wvLi/V5yKzXQ8uFAjNZcmSuo1k4t4fB3P06TgWxfZXUwlwCXS228I4EATEyI9Hv6mkUjmD+XTQzS20L1ZfGo8vdJALv5FxA96DhtK4Ny+DlMRY8cab4qewhoasrz7epCtzXkvHUhNn5MuzzNik7sE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzQLz69l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso33700331fa.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764612476; x=1765217276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHR2b1tdnReLGK2rMPeAJ5tNK3FsFx1mTEmh9YttTBY=;
        b=PzQLz69l264KeGRPYi4nVtOpPUD9jsr4xmYhrLrWSRbV9lp/1tkgftFWRJ56qUlzIB
         Wy8LCIk++bvz4pR7djsRXLfcHu6I+e/h8a06OqdLl8pdBPb+lUYMN/s3CG6kYEEgseCD
         vr3Y87lc7HKoyEoeLWv/mK0m6yI9Skj/p1SDfGEdScwMSycLGUcQtwIM74wmDVno31H4
         Pk7/uKtzI0WlFBvJlQUhco9DKmWPRk29wZ5ecYJfPiOFBxZlJIyhxhdbG8m17LfS6YPV
         KywnXwEtK5iVkxDTpKpqx0rc9Z3wvvaI6d8SiTLAZFwCAQPcGp/ziTSR3iVGclBQjyXf
         nB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764612476; x=1765217276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHR2b1tdnReLGK2rMPeAJ5tNK3FsFx1mTEmh9YttTBY=;
        b=Ogqm7eH3RD2PmwDUrcjA/XPJF7DtN2hmlKCZBdZEaEkTttpdc3Moj0MdU2K/LJKvCe
         X7X4jwcJCH7EQtturPMZp2bwcYHqW7y/c/0EHV+Mdlzsp5Yw6iEzi3i/0Yd4BMZzunLC
         n150pNVySctHhVKMad+VDO3Rxhqe8h2EXAPu8LEYfcsN+ydDyaJ4n8IHR2OofcVeFN+F
         UW0BFa7CiPD27WYzyNzyx9/ZAyadMQ6Q5T/MFHB99W4TU5yWHeYb0bNcrRkQcuvzsrC6
         tQO5P7xOxkjsX6kKpLBrogBNXsMjZuauEqCsYIVEgwmGQSFu6eEZlY/zvv+LiUDqK9im
         KPmg==
X-Forwarded-Encrypted: i=1; AJvYcCXm+H1WbNGEaiq3SW7uM/4pPeCGrKuaVUua1+GeW23XwUNE/tGvEjfJWZcfn4UtXayN8en11M5m0Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEmfkOYcUchdnSMZDW8eagQxjU+Ds4Z+ejHIDHQLpfoUl109W
	7NxQYFzu6exM0/rWYiiY8oT+me3wRNQFSgQXd+ke/t3ZpnCJ77QbMMpv9kH1p8KsDz3CuFkvQN7
	yvQlqkiJ8eMCfxI6fvVGqgokojcn+0HmpPdNI+v6/
X-Gm-Gg: ASbGncuuVsXqcB4q+Io+z8H9kxrcthitbTcaVLN3h64eM5zvGoKwVCXPua30nfOSfSm
	JHxOixdSqbA5Y2PLWo89YsyVDSZsO7wGrdkCGehhPc5Hrqztg6c/L/nTyEGyDVwiTSz2emcuwVZ
	7L/ua4SqHxWkDvr7xNNJuX2o6zFo6dY0bIEBft47nqlsAeTl/823dA7+wIDsLiYuRH6dp8sVM6Y
	7QQ60JePgMivMIm7Bvzv4V1+3f/WMRJa5Fa8JpWYpBJtrLZAK93qZmlVeJ96JodXGFZzN8I
X-Google-Smtp-Source: AGHT+IEN3e+8GrhdE9mAKq6M6O36EXV0rwfuSn04+F/nQOmCWX8I0XUdBirEHvrMIu0J0E0PqjGTqNWM7KtX/bHjIWU=
X-Received: by 2002:a2e:87c9:0:b0:37b:ba96:ce07 with SMTP id
 38308e7fff4ca-37cd91b6896mr84496801fa.15.1764612476135; Mon, 01 Dec 2025
 10:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <CA+CK2bDhr-ymK7mKxYpA-_XJ9t4jEr3dMQH-5c8=jbtwVvNSKQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDhr-ymK7mKxYpA-_XJ9t4jEr3dMQH-5c8=jbtwVvNSKQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 1 Dec 2025 10:07:28 -0800
X-Gm-Features: AWmQ_bkomNF3J9A1FiK-AgqV8WToT7JD_nfz6VIh1V5NsvSQRYZQicK6wnjcmD4
Message-ID: <CALzav=evA12+-4mOjUMLin=E=STKSW9JCpT12poyvW=N8jh8Cg@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:15=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > +{
> > +       struct pci_ser *ser =3D args->obj;
> > +       struct folio *folio =3D virt_to_folio(ser);
> > +
> > +       WARN_ON_ONCE(ser->nr_devices);
> > +       kho_unpreserve_folio(folio);
> > +       folio_put(folio);
>
> Here, and in other places in this series, I would use:
> https://lore.kernel.org/all/20251114190002.3311679-4-pasha.tatashin@solee=
n.com
>
> kho_alloc_preserve(size_t size)
> kho_unpreserve_free(void *mem)
> kho_restore_free(void *mem)

Will do, thanks for the suggestion.

