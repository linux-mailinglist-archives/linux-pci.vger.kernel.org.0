Return-Path: <linux-pci+bounces-43078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387ECC06CB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 02:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E188330142D3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1C22B8C5;
	Tue, 16 Dec 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ari1B+D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071C1FE47C
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847666; cv=pass; b=agMb852HxiSmkzhAo9zdeRrcOlHBvBa9MlQrm3tYsyjwh/A/NW/RppGrepmJTHHpojavQj12Lgq1BCWoKzIoe9BsZcBiw1ctuUxLHuw1WX1oRitEXmMtc5PFqNcVvyEN2FKkLH2J0Zo/y1D3ZJdcRa97isAc+jfEfVuNgbstwlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847666; c=relaxed/simple;
	bh=RYQZPJfFMxqkp+1nngNLsMaHBFm6+xCUj4KkP21+dYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l07q42HSYIzSfk79NKnsKEy+Yh4P02bY2hOrR3ZCcN+sE0bqnTNifA3WTuQcOF2ebimLbEFARcj0KqaqRucce5zoAHyBmS8HJSPxqt7AV+KojH2RvWszdVGy5xC4qBqjQkSLTnV42zVQCdD7SUqXcKNCdwNHsUD9s/xrhKMafto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ari1B+D; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed67a143c5so152361cf.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 17:14:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765847663; cv=none;
        d=google.com; s=arc-20240605;
        b=XAPuJrzpY/W2XdxYdenDTECeeFNp7FfvJiC4R+xdkvaAAcHDz2h5GnssBuQKwg6RZT
         H4qKSl0sDR88P2b9Xd+Edam1X7X8LB5/e4V9h3IopYQM3QZeigi6LfHV43oL7cWjQ7/q
         fxFRjkWGMUwVIk9cqUNTAW2nuoABrJQULVfHY6F6S7XZ9443KkBN9HpTQqY8hAint7Uw
         z4LTR0OnyWVk119dYGZi5juAKWtRsdmT2h9XVJBtzLXXr+yo7Wnusry//7wGQ7Ps4B8S
         UuSBZBd8HYjcy9eDyZwR7DT5MAEVjJ89qEs94Fn4WoZGuD4/LgyNtNzsPHGU0nzLf6sW
         nV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        fh=vVSgc7rqrnc0txM6U1pyzDQcRYCaPCf5sSlBrp1L9pE=;
        b=FXS0z/gWGQku0JXzO36MTDQ0pHmYAceC1SgXpUYcq4udFch3BJIx5YqlPUZSZPHCx0
         DSA81+itGcHSCASkOTgpuvVSlyFGVGqubKvkCYoqV21pee7m7EkTmQw3Fs6bFfefjLBM
         AzUIFN+4O+Vn/rtK5mq1oNrFVjpn8CcpNpaiyLzWl6O88vgauqi5hpYGL1WGFxahUrPY
         dS5QE6SBPqDxzCG0z/p4H8v+YgOTa+cx8SmlpG2faQ8bPczNw18211DNFzq3LuMhDBZN
         7nNhkD/+fo6bthNgtQ/+uwVNbizKBCCMnHTjtKnJjU+xa3PF9WnFNJ+TRptnnY/q5dpI
         Delg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765847663; x=1766452463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=3ari1B+DFeL77dgRqQXsmkwyt3RpD5yA/XqttCV8veBhDTk0MUnXiBVw2Ka7+3hlsv
         VCY/3P8wYJlCxLpohyYwMLEQOPeSCAYbDV5tjZmS7qnzRhMkAlDsbSdeE3SuVy1fwIc8
         lA5NHOCM5dN6iBptDP/Np5epV8nrLcRkPk066yRGIc4OhzyHlea71C5x+1oq2Wr9COyG
         x3GNW9+tN8N8H8Ui056BJG3Ma/F/hiP9CP6YYrSqkgzIVtB+3vjiIIIhx90AKBiK3MT6
         7bpDrHk0oYwU2KQ5XzO5+XNO9qeugqgUZPYQ/XQ0I+QVY+GmD9JYYC6zfLTXi4IAeeH2
         Kw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765847663; x=1766452463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=j0/STuz8nCbru8BBrQoU9MlT9tN5ldN7WC/83blrYg1nThjs1ime8yQk5PPlMnG4NU
         O3I2U5/kNqVBg7f2fZwfA7+/DPUsaKEjuAJpENOikBn1lBd25D3TvAisUlTZSCooJlYi
         25HXZKyAE8OiGOcM3NCq/WYJH1wHQ46HZYTucmnUyQiBRbFzF0ue1lH+Q5HpFlVVu2Ae
         qLaJRzYm3ymAoVNUHRE/fHNk8szVrCgIXA0SU1Ehyeum8CmJF2otTq9Un70FylKbu6Rp
         OEPjvaX6u4HhIpmJLGB0Xkf5k/dgIWJBUFCs1l/rMDjvKqpijILetxJ2WGOpQF5i/+Wn
         5/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeuRk0AdH4H/uOmo8czZEDFvh30eI2U+MxQN4/8hHaNN0bWe1hbNbFBxh5Hnz2tb9NY+xxUIYf5Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLvOv6a399QQN8+rBhFglgdEiPVwiRECpaCaj9rQB2nQ15Tbq
	GuUPh2hDYzz4zkr4s1AFe22byQECV1yinWiMVSLHl2Gk2TboW6zYypIHJjs907TLn7avtI8fAcl
	wiWn7zrWbjWw8i64/lFMWJB3yZztMDzwcuCTzxat1
X-Gm-Gg: AY/fxX5pwj3tfp1MB5Y8Zu4G/wKqxHdbe05DVC49oBQKHpVEiEbsWdH98Ytjk5Wc6YI
	Ht24SItF99gezd2DRFkoP+P+7ZScDAtrNRgnSqOwcQnE27ws0CEfByXpflcH5RBYS8L0+N2rvr2
	5e68wmy8OjlAD5xFDn0Tp7RySEfqXiSoO9tjqacqNMM41o45SyfuZcu1CC+4/C8KdwnoVnWg97f
	W+OI28fSF6fIMz3hZ39kyjQegeG5GXOWkyqnm0lPMzHMBbetWazgaEAjbWu3rFndcj70XI9Z3Hl
	dFKqk0Nal1ANJJfeTUGQOnkh3g==
X-Google-Smtp-Source: AGHT+IHDK9Nx0ZJG9GA2+hWOGyWZ73qxIXF4H8RaWSuD2ofLYKrM3Tu07Foy0ZrKHXYTXOo9Ba7m6bZ0z05T+81FVJI=
X-Received: by 2002:a05:622a:8a:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4f347f93f08mr1579311cf.9.1765847662514; Mon, 15 Dec 2025
 17:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765834788.git.nicolinc@nvidia.com> <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
In-Reply-To: <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 15 Dec 2025 17:14:10 -0800
X-Gm-Features: AQt7F2pGryc6oZ72KleXBeas9fEej802hxD59J2edZO4aLe2-OI0GRs2t7Q1jUY
Message-ID: <CAAywjhSzKM_bEm_VbPZFffY9sR3-p==gbVppSL+555D1kPg_3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] iommu: Lock group->mutex in iommu_deferred_attach()
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, afael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, 
	kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, patches@lists.linux.dev, 
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org, 
	etzhao1900@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:42=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> The iommu_deferred_attach() function invokes __iommu_attach_device(), but
> doesn't hold the group->mutex like other __iommu_attach_device() callers.
>
> Though there is no pratical bug being triggered so far, it would be bette=
r
> to apply the same locking to this __iommu_attach_device(), since the IOMM=
U
> drivers nowaday are more aware of the group->mutex -- some of them use th=
e
> iommu_group_mutex_assert() function that could be potentially in the path
> of an attach_dev callback function invoked by the __iommu_attach_device()=
.
>
> Worth mentioning that the iommu_deferred_attach() will soon need to check
> group->resetting_domain that must be locked also.
>
> Thus, grab the mutex to guard __iommu_attach_device() like other callers.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..170e522b5bda 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2185,10 +2185,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>
>  int iommu_deferred_attach(struct device *dev, struct iommu_domain *domai=
n)
>  {
> -       if (dev->iommu && dev->iommu->attach_deferred)
> -               return __iommu_attach_device(domain, dev, NULL);
> +       /*
> +        * This is called on the dma mapping fast path so avoid locking. =
This is
> +        * racy, but we have an expectation that the driver will setup it=
s DMAs
> +        * inside probe while being single threaded to avoid racing.
> +        */
> +       if (!dev->iommu || !dev->iommu->attach_deferred)
> +               return 0;
>
> -       return 0;
> +       guard(mutex)(&dev->iommu_group->mutex);
> +
> +       return __iommu_attach_device(domain, dev, NULL);
>  }
>
>  void iommu_detach_device(struct iommu_domain *domain, struct device *dev=
)
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

