Return-Path: <linux-pci+bounces-39842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EEC21B0F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7500F4F6C0A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D3365D39;
	Thu, 30 Oct 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nmfm7qtR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C3315D4E;
	Thu, 30 Oct 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847381; cv=none; b=NiRpbleb9Pvm2tZEM1FYb/3t+ZS0EQSGIho1qKbJzxRVO1y0sRMFf/wZPgpopAYxIKwZxkNIIaZwnXCs+gWDm1kxkhJ0uGmn58RCrTa1tTFt5ZbGD5uXXdOOhhqaySjp0VSjnVxoJSJ40qSg22X1YkR8WRoMvCAUUDVtyLBz5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847381; c=relaxed/simple;
	bh=vDwlv2wIxuifa4WMIkW8aM4STmw9u47pct+PmwEZY+4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qInwuOr9Cq66g96GkDwwZej5MC4jEjh3gyPsRFAZ84549h4GDhVY948tRhk2DG6Csm0c2otrvN6Bcm8XpvFtu+nV+ZKGjRgLjV/YESrR0pHP6EyV8cinObLWydUOtrWOcu404WCSS/LDrgqzvMrwr4SXnI4g9wv8+MDrFhh2gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nmfm7qtR; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iVJW4ud2NJIGSMWzm7QTw7Epgh70TDeonMG9NVC7r2Y=;
	b=nmfm7qtRgkgqZWSA0nyj2JrIW6MH4mgXSef0YuL7xH+InTFo8F5qFOnOM9rYTyDebXqOspdIg
	t5lhsgFIsuR7azpzwNEUy4uDutjC3BQDhk1w4SBx2akG1GyGKu+Uiu8ZAdaulCoc3hy3q7gSpqm
	RAVZxmP8SFzDA7PTqRVU0yU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cyBlD2WbQz1vnvZ;
	Fri, 31 Oct 2025 02:02:00 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cyBgd1kHkz6M4qd;
	Fri, 31 Oct 2025 01:58:53 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C9E841402F5;
	Fri, 31 Oct 2025 02:02:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 18:02:44 +0000
Date: Thu, 30 Oct 2025 18:02:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 06/12] coco: host: arm64: Add RMM device
 communication helpers
Message-ID: <20251030180243.0000751b@huawei.com>
In-Reply-To: <yq5asef0cwos.fsf@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-7-aneesh.kumar@kernel.org>
	<20251029183306.0000485c@huawei.com>
	<yq5asef0cwos.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 19:34:51 +0530
"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Mon, 27 Oct 2025 15:25:56 +0530
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> >  
> 
> ...
> 
> >> +void pdev_communicate_work(struct work_struct *work)
> >> +{
> >> +	unsigned long state;
> >> +	struct pci_tsm *tsm;
> >> +	struct dev_comm_work *setup_work;
> >> +	struct cca_host_pf0_dsc *pf0_dsc;
> >> +
> >> +	setup_work = container_of(work, struct dev_comm_work, work);
> >> +	tsm = setup_work->tsm;
> >> +	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);  
> > Could combine these 3 with declarations for shorter code without much
> > change to readability.
> >  
> 
> Not sure about this.
> 
>  static void pdev_communicate_work(struct work_struct *work)
>  {
>  	unsigned long state;
> -	struct pci_tsm *tsm;
> -	struct dev_comm_work *setup_work;
> -	struct cca_host_pf0_dsc *pf0_dsc;
> -
> -	setup_work = container_of(work, struct dev_comm_work, work);
> -	tsm = setup_work->tsm;
> -	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> +	struct dev_comm_work *setup_work = container_of(work,
> +							struct dev_comm_work,
> +							work);
> +	struct pci_tsm *tsm = setup_work->tsm;
> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
I'd wrap it a bit differently.  

	struct dev_comm_work *setup_work =
		container_of(work, struct dev_comm_work, work);
	struct pci_tsm *tsm = setup_work->tsm;
	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);

Entirely up to you. Hence the could part of the comment.

Jonathan



