Return-Path: <linux-pci+bounces-42534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEFC9D1BD
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936FC3A1749
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9232DC352;
	Tue,  2 Dec 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Op5VRHid"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290EA55
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711716; cv=none; b=Dxo5fmFHU+eVEsQdkKK1A3cPCaufCQqrfomrLeDViZYRrnUjh7j10MGSxercN+jXUvLO7swxA6cCKJnMiv5Dk8ISb3GCmj98RC0dtdM4p/dLQqz56cQ/Yt6wHHx+0eaaITjpZ5vZGJkhcgEwIWeA6SeqVAQHPEw3qgl8Gi4VeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711716; c=relaxed/simple;
	bh=bK1bgqioLqPqNCUbFDzXCG7JyoMoUTbDQKJcABIxh2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlpL576HEMDNGvT/7dz1lfY+NWbrk5tf4KkRy5QzuTmfzjGYVpOlY8TKqJgophBKrJaJttFwMPyHhBL5HqJ4FtaewtEPNrS6KiBiPzpA0gsF9Y3Gfb1gZqA4WI8vlwxAeDuaD+yhcp4FJFaNNd18jtYXGJqwPyyZJScJDDDGNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Op5VRHid; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so11261655a12.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764711713; x=1765316513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBy8J1XDJHjmvX+Es4TFPSfzkazm1BSKmXhHEtk+CP0=;
        b=Op5VRHid8eH8ab8VEX0QPXgsFu0URtp8bXZp/H8ljdQMHABjoPeqMIU6h/A5GYp09O
         KZ5CJiq1zG2ZcYTiSuZL8G0HA7ePok6V34mVi4UsUQK1mZxHsBufcTh95QTs0z2ihO9K
         tul2bvvQ5hdy8L1+JKgxMlJ+AOV2OxXlnOLcOjQ+85y1ot0k98PVhHPZiiqQMk6K08n6
         WNGL8ukYm6/qJrI6EynDO9OHFaoqeIRrK7YKnrvMut71cFGvIs9qYblyM7l6+yODBLjJ
         f+kzAAZBOXpVBv2JJwnoBkpwjQTpeE7PG0BVbxTnw1VjhZV5e9z3joJfWgH9xun4FFo2
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711713; x=1765316513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBy8J1XDJHjmvX+Es4TFPSfzkazm1BSKmXhHEtk+CP0=;
        b=MUsY7Bxy7UxiueLcvFzE1AHzFqp+BSD29SfmZGKQxU2E9A56ZYShcDobCtO+5L+B8M
         vLfFCgaB890Ch6dYuntbgNdcZEhlgrDbkhDgRJTLGYyZUvG3nTJ5X0xTr7YsdfQ4siNW
         4Zyi0R3w+Prs8c62mfU0/2+AAp0aT9ljDJS4ucIIl+8W+QKTGZ61L4EZv62xxYzhf7kq
         u7dpm7ttuU2KJp4Ki7LdDOFRn+mv4VwFhIfWW2IxOibzrIHPPB2W6ht0beTFsGDIPcaB
         BLH/RS533F6CQBqDGIWyy33Odk6SJpzIufZIJlNt1LwjDWwCRz2tLypisTQwMpN9berp
         7W0A==
X-Forwarded-Encrypted: i=1; AJvYcCXpFdEQtneYZgmaP365Y8RsbsTHGwAgauVwvug71Nri65Wkiyn5vzYd6g/XeGaZ+dTk+t0hsG8CyEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGEdO7dYfRg12PcS45b+FlctuAPUQyLM1X2Igrnim1VUkf9pu
	yBu7QYaV5Tyy+kg/LgoPyK3XvYCLm3Msmg/2TJ9RwB+EMVZQXTtvrPH+Zg+L99/OtSKKymdwjWx
	vF8WrPne0k8aKpa3lztY/ZSj/QVqFZlc4EXAmwBJllQ==
X-Gm-Gg: ASbGncvjYtE2t95iu16IND84XoXQxEJdnZpgWFXiYPrsFfMfUViVKuPgDSqXo3v+Ijy
	L/zWQJ/URgug+USYOu/UvLmnE9adutd/LNlj1vCju++lmsrbd59sBSVxBFoECx5tD0+ZMW2Zzlm
	kGx8jDvExTBXLxZDyQLNltflqsfMs4KRDWAr9dN9IaxWB5SzJQyNghsgFb8XvMzOPLVBKjRXmoe
	D9jwBc4JNJkdq98Wb9y9LZjvWr1lR6vLhBB80I6o8Z4f2LYbJINVV5koDt1w5MhvzKRHY7QaMve
	mcE=
X-Google-Smtp-Source: AGHT+IHWLpn7rUj8mxZXJ9rMfRKD6U7DeusV73jTTRLFZkQI3y5z61JVyECIWb2QWdSzz1X1Lv1zjhKD+XOAMt/wgfo=
X-Received: by 2002:a05:6402:455b:b0:643:129f:9d8e with SMTP id
 4fb4d7f45d1cf-64794f33cc3mr841742a12.8.1764711712986; Tue, 02 Dec 2025
 13:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
 <86bjkhm0tp.fsf@kernel.org> <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
In-Reply-To: <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 2 Dec 2025 16:41:15 -0500
X-Gm-Features: AWmQ_bnrPyeCqV6AbWIFTsaIoktB-kTeS5xKZG_PhpHyIHste-GfTWjRKtK6tnk
Message-ID: <CA+CK2bBWB_+SOf6EgFm0nfovQd0-KPHQCRkqbWWTq4Yx2wAL7A@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> > >> FLB Retrieving
> > >>
> > >>   The first patch of this series includes a fix to prevent an FLB from
> > >>   being retrieved again it is finished. I am wondering if this is the
> > >>   right approach or if subsystems are expected to stop calling
> > >>   liveupdate_flb_get_incoming() after an FLB is finished.
> >
> > IMO once the FLB is finished, LUO should make sure it cannot be
> > retrieved, mainly so subsystem code is simpler and less bug-prone.
>
> +1, and I think Pasha is going to do that in the next version of FLB.

Yes, I will add this change in the next version of FLB; however, I
will send the next version of FLB only once list_private.h [1] is
added to linux-next, so I can replace luo_list_for_each_private() with
list_private_for_each_entry().

Pasha

[1] https://lore.kernel.org/all/20251126185725.4164769-1-pasha.tatashin@soleen.com

