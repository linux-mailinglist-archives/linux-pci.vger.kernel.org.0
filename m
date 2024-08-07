Return-Path: <linux-pci+bounces-11466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E494B3AE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 01:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F765B2308A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA497143751;
	Wed,  7 Aug 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI7d1GE3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A452B9A1;
	Wed,  7 Aug 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073961; cv=none; b=JKO06O0yXPrQF5KPo93MrDgO5AkVHK3RBaECYmRF2LH4f6cC2MqItZxBSpJqCjGIwIiwWO1wvS9Mxep2neBT25wP4s76uhcSNKrMEuBKU/KTyhKeB8NxtBMrMyNqbxedJS9+TmipFHSXB4iBa7FyPnNGOocwigPeWO6vY3+bk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073961; c=relaxed/simple;
	bh=paORnyQpzJ03P5vxAgXOwzUdZgz1DX+OHOfaY9cuOhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTaTySnyuKdIjPmIqFzBBiBMEiZCNAEBjsEYSvfrjUeqWWIBnBEwz8rq0+PExqa0g6cau7+rUXtvxOs+Rt5GNCPH6tFLWRvjcLzP1mgmuXSHwVTNkB5oAYD2/Tgu4IlY1NHJPTVO4K7LJ/Kma4t66tHAizk1aIFvP+E9FKCQytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI7d1GE3; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso144048e0c.3;
        Wed, 07 Aug 2024 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723073959; x=1723678759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCHmliBndJK/MPPvHoPCBgyseherKeenX7Lly3rzXJ4=;
        b=DI7d1GE39vJ+0dq1ANZECutbFln2RdENBxux2kp9yc17Y1EW7G0Zfw185M1BQKhP/Y
         c5T1CejcxYAyb2N36KIEW9i5ehjrHMC23yzWLbrSVPY6WXJSi7ZQBaqlPQ50AevfG1UC
         PQy+6eorPjaa0dXe4Rcj45ALIgGB450OzuWxuKT6aK9vVnRXDshJDgqLTVA6d75yjE14
         iWl+JaUWCDTIgsQSkvJayCmvTx+1dAwx6eYoRhzImaK3Ff1t9rqzzObjBQZjwE7/uAvg
         fI+L+1yOrIolEZAmqmSuWDq2o3a3bG5ud6r+hOyLoqfKK84EB26Rqzv/lm1NT+cgHJzq
         W3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723073959; x=1723678759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCHmliBndJK/MPPvHoPCBgyseherKeenX7Lly3rzXJ4=;
        b=CG7sjTqAqRPY42KU74uWEZbDgxKMgeVoVJKCpVdpURtYfJGIovPjcFp1FEQ5+Jzjeg
         HHXzhlokt4pOzqdnQofPxA2oxF2BFwqBcgEbvNbqIJqOVP9FZiUshgcSEQX/LKkw9Tn8
         MIsYPf5uqSCPLjBSHc3Y58UkpOB9lYkmWO0xAzDHLFkbKYaYKNlDKq57eABix7GsNMWz
         5IOF3TSHX9baTSDB0CkXWRuyIaojdPc3h4N94mbHkL7T60fpkMRDbu5iwsgYMpuJLbwb
         odmWuiLdqzoXR6iEcP9la9Y6JXxOdzTSouMUyq30BiJvezj4KuBMw7C0P1G/UMyMAMmz
         +YPA==
X-Forwarded-Encrypted: i=1; AJvYcCUq9K8yjHhsO3znOTfbC6T2pLKTX/kzyOx3L/N7WcnxhS0wLBh8Am/A0qm9BSPZFXsv+0YIvwDANlJqzxiAATQNLahn9J9Xul8UA3CimwS7nsM/RwK/VW4aDZvh0Y8xMevC3DfhXv6b
X-Gm-Message-State: AOJu0Yxyk07wTZQ+eJUGtskRyP4oF5WDUKMK2biSw3OQI+z044SfDqtX
	tZgMrlKf85WMJhh5ORn2/F3NRCM5dwpftgS7/BhW4iWe9VzDpUSr0HC0ngIuVpTHywQD1uGtstL
	PJAlGpwUEe+irVhz8+FpsDB6ZRag=
X-Google-Smtp-Source: AGHT+IEb7LFhEnW+VTMmmgDZX+tSGRjjI+Y41vEhb5T37N5WymQlm+mb0e0bLODgm9yn2/fBRYvsrtc20qYE8538UH0=
X-Received: by 2002:a05:6122:3b16:b0:4f5:26c6:bf13 with SMTP id
 71dfb90a1353d-4f90298ac3bmr341882e0c.13.1723073958906; Wed, 07 Aug 2024
 16:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230118.1332763-1-alistair.francis@wdc.com>
 <20240806230118.1332763-2-alistair.francis@wdc.com> <cbc54dfb-6699-ae15-f40e-d3b5969fc806@linux.intel.com>
In-Reply-To: <cbc54dfb-6699-ae15-f40e-d3b5969fc806@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 09:38:52 +1000
Message-ID: <CAKmqyKNiT=yDw0ScwAxODpaQ-0fJRM5eEBxGTpbTe22N-UAfNQ@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] PCI/DOE: Rename Discovery Response Data Object
 Contents to type
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, Lukas Wunner <lukas@wunner.de>, alex.williamson@redhat.com, 
	christian.koenig@amd.com, kch@nvidia.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, logang@deltatee.com, 
	LKML <linux-kernel@vger.kernel.org>, chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:03=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 7 Aug 2024, Alistair Francis wrote:
>
> > PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
> > "Data Object Type" and "Next Index" as the fields in the DOE
> > Discovery Response Data Object. The DOE driver currently uses
> > both the terms type and prot for the second element.
> >
> > This patch renames all uses of the DOE Discovery Response Data Object
> > to use type as the second element of the object header, instead of
> > type/prot as it currently is.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
>
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 94c00996e633..795e49304ae4 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1146,9 +1146,12 @@
> >  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX         0x000000ff
> >  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER           0x0000ff00
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID           0x0000ffff
> > -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL              0x00ff000=
0
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE          0x00ff0000
>
> This change (removal of the old define) is inside UAPI header, so it does
> seem something that is not allowed.
>
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX    0xff000000
> >
> > +/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_T=
YPE */
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL              PCI_DOE_D=
ATA_OBJECT_DISC_RSP_3_TYPE

The old define is kept here though

Alistair

