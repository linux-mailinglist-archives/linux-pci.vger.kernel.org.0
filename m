Return-Path: <linux-pci+bounces-39921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1449C24EDD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D6B1A67D82
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4C3491E7;
	Fri, 31 Oct 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N6Zj/egf"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39505348470;
	Fri, 31 Oct 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912464; cv=none; b=rj2CpiMNfBzjBKamAZcArAn5RdKqFgAGO64j9afTtws7+JDXJI6cew/kA25cQWNuj9Zxt+rfCeZLZmqXo5Ev4JuRF/JufaRjyCQ31Mwbvwl+Qpqd89/RaF0mKlLdEdZ7yu+tbhj+PdjivQFgQWD9IgVwUUZeVPVC5S60Ogyq5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912464; c=relaxed/simple;
	bh=axhskxiBo2zPW17sTIBm+Goy9FupOra+dPrV5xh2Rh8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+cthVGdoIR9xqKGxyag/lO6ibBneCSYW1NVgMaoOnkyIVUlQCi+BKm43IsryLGpARFmB7UZzYXbLnuFaJxRwotOiiwmMV0bQI2p/jG6ZdBjiIqlhCsmWli7NfoKLF3vwACwRxPyInn/qnbYdU1Y6BNeQNfccdLuXaFjJJoDWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N6Zj/egf; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9TolKU4YCUfsB69h9PmW4OYgivzsAp8onhB9iwqpHl4=;
	b=N6Zj/egfxBgO1FKnSEx/io0wWg+UUnAHCKtrPJVhD/6OGp0sXP5jRPQkmReGL76/jRUaq/GZD
	xDZdkYV817aO4vELHUBJKtikjIHGG6ThsXVno/85oMnEnMRk6Iwsl2G1KWTzYSTjO+zB+I/6Atb
	EKwZ8rfTCG4sqVH96LpOU3I=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cyfpt1qxFz1vnNV;
	Fri, 31 Oct 2025 20:06:46 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cyfph13qYzHnGcf;
	Fri, 31 Oct 2025 12:06:36 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 875C01402E9;
	Fri, 31 Oct 2025 20:07:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 12:07:31 +0000
Date: Fri, 31 Oct 2025 12:07:30 +0000
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
Message-ID: <20251031120730.00003758@huawei.com>
In-Reply-To: <yq5ams57cx9q.fsf@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-7-aneesh.kumar@kernel.org>
	<20251029183306.0000485c@huawei.com>
	<yq5apla4cqex.fsf@kernel.org>
	<20251030181246.00006328@huawei.com>
	<yq5ams57cx9q.fsf@kernel.org>
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

On Fri, 31 Oct 2025 13:34:33 +0530
"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Thu, 30 Oct 2025 21:50:22 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> >  
> >> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> >>   
> >> > On Mon, 27 Oct 2025 15:25:56 +0530
> >> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> >> >    
> >> 
> >> ...
> >>   
> >> >> +static int __do_dev_communicate(enum dev_comm_type type,
> >> >> +				struct pci_tsm *tsm, unsigned long error_state)
> >> >> +{
> >> >> +	int ret;
> >> >> +	int state;
> >> >> +	struct rmi_dev_comm_enter *io_enter;
> >> >> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> >> >> +
> >> >> +	io_enter = &pf0_dsc->comm_data.io_params->enter;
> >> >> +	io_enter->resp_len = 0;
> >> >> +	io_enter->status = RMI_DEV_COMM_NONE;
> >> >> +
> >> >> +	ret = ___do_dev_communicate(type, tsm);    
> >> >
> >> > Think up a more meaningful name.  Counting _ doesn't make for readable code.
> >> >    
> >> 
> >> I am not sure about this. What do you think?
> >> 
> >> modified   drivers/virt/coco/arm-cca-host/rmi-da.c
> >> @@ -188,7 +188,7 @@ static inline gfp_t cache_obj_id_to_gfp_flags(u8 cache_obj_id)
> >>  	return GFP_KERNEL_ACCOUNT;
> >>  }
> >>  
> >> -static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
> >> +static int __do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
> >>  {
> >>  	gfp_t cache_alloc_flags;
> >>  	int ret, nbytes, cp_len;
> >> @@ -319,7 +319,7 @@ static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
> >>  	return 0;
> >>  }
> >>  
> >> -static int __do_dev_communicate(enum dev_comm_type type,
> >> +static int do_dev_communicate(enum dev_comm_type type,
> >>  				struct pci_tsm *tsm, unsigned long error_state)
> >>  {
> >>  	int ret;
> >> @@ -331,7 +331,7 @@ static int __do_dev_communicate(enum dev_comm_type type,
> >>  	io_enter->resp_len = 0;
> >>  	io_enter->status = RMI_DEV_COMM_NONE;
> >>  
> >> -	ret = ___do_dev_communicate(type, tsm);
> >> +	ret = __do_dev_communicate(type, tsm);
> >>  	if (ret) {
> >>  		if (type == PDEV_COMMUNICATE)
> >>  			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
> >> @@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
> >>  	return state;
> >>  }
> >>  
> >> -static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> >> -			      unsigned long target_state,
> >> -			      unsigned long error_state)
> >> +static int move_dev_to_state(enum dev_comm_type type, struct pci_tsm *tsm,  
> >
> > Naming is always tricky.  Not sure why this name is appropriate given it's definitely
> > still related to dev_communicate.
> >
> > Maybe just squash do_dev_communicate and __do_dev_coummnicate.
> > Slightly long lines will be the result but not too bad.
> > I haven't checked what it ends up as after the whole series though
> > so maybe it doesn't work out.
> >
> > static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> > 			      unsigned long target_state,
> > 			      unsigned long error_state)
> > {
> > 	
> >
> > 	do {
> > 		int state, ret;
> > 		struct rmi_dev_comm_enter *io_enter;
> > 		struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> >
> > 		io_enter = &pf0_dsc->comm_data.io_params->enter;
> > 		io_enter->resp_len = 0;
> > 		io_enter->status = RMI_DEV_COMM_NONE;
> >
> > 		ret = ___do_dev_communicate(type, tsm);
> > //renamed
> >
> > 		if (ret) {
> > 			if (type == PDEV_COMMUNICATE)
> > 				rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
> >
> > 			state = error_state;
> > 		} else {
> > 			/*
> > 			 * Some device communication error will transition the
> > 			 * device to error state. Report that.
> > 			 */
> > 			if (type == PDEV_COMMUNICATE)
> > 				ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> > 							 (enum rmi_pdev_state *)&state);
> > 			if (ret)
> > 				state = error_state;
> > 		}
> > 	
> > 		if (state == error_state) {
> > 			pci_err(tsm->pdev, "device communication error\n");
> > 			return state;
> > 		}
> > 		if (state == target_state)
> > 			return state;
> > 	} while (1);
> > }
> > Jonathan
> >  
> 
> I need the existing __do_dev_communicate for a followup patch where the
> device communication won't loop till state transition.

Ah. I'd missed that. Fair enough.


> -static int __do_dev_communicate(enum dev_comm_type type,
> +static int do_dev_communicate(enum dev_comm_type type,
>  				struct pci_tsm *tsm, unsigned long error_state)
>  {
>  	int ret;
> @@ -331,7 +331,7 @@ static int __do_dev_communicate(enum dev_comm_type type,
>  	io_enter->resp_len = 0;
>  	io_enter->status = RMI_DEV_COMM_NONE;
>  
> -	ret = ___do_dev_communicate(type, tsm);
> +	ret = _do_dev_communicate(type, tsm);
>  	if (ret) {
>  		if (type == PDEV_COMMUNICATE)
>  			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
> @@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
>  	return state;
>  }
>  
> -static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> +static int wait_for_dev_state(enum dev_comm_type type, struct pci_tsm *tsm,
This name conveys what the wrapper adds to the inner call but neglects that inner bit.

do_dev_communicate_and_wait_for_xxx or
do_dev_communicate_synchronous()  // maybe - it's approximately a synchronous wrapper of async operation.
Or something along those lines perhaps?


>  			      unsigned long target_state,
>  			      unsigned long error_state)
>  {



