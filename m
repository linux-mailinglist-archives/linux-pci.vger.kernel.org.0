Return-Path: <linux-pci+bounces-39845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20345C21B4E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DDA3A3AB7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D927A103;
	Thu, 30 Oct 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PBft4wRw"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45C238C2F;
	Thu, 30 Oct 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847985; cv=none; b=CEUjnPpq7s17EeIo1MjLU6u+E9hAokOHu97IWUGSPaN3h0fWHLbzNFZpoWud/S41ljwdCprbbunhDj0wEfVoRrVVKdY7lQ7WwtmpghcALFDx6TVTbh84bbLAqGFokfAFscmOoKMoyUq/TSl7AuMD09hXTW9IEWwI5EnXmSNXCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847985; c=relaxed/simple;
	bh=pIzWpuUD6jTHhXtQ9pix8ZTiK8iGIjhuGEfFdWbZ4A0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX0bv70K8vIhEAeGqbLVXjACFSWqmlC+OS6mxZS8SDXLQOSmAPEFKgeCN9eStP+YvSZeQUvKXHN0kMoKpB0ZxKUV7e8bx9xgzEihfGmZC4IZ1hoWBkZRbciC46/9Gfh/jbhFynZnVjqb8Zyc51AkDd58ewjUfWLyKxazONK9wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PBft4wRw; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KoPfinDgMh/viJR1rwPHmW2T7nZ+bfwoT7P3YyntFzk=;
	b=PBft4wRwLg39bBAgVSj36UOzPPe/O9EoGyhJslgGOi40Y3vNYLCFC9GgokD8mTMA/Ge1XOGV4
	5PnOWvAM4j1feyI1HeQb7oLZiWhOGbgSFBXi84/HE1rqV/h9oeJC1EYWXM9ecjRhEdqdom+sOal
	EM8Kdw6B0ludsjPU4Zl5jbc=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cyBzc0tz2z1P6n1;
	Fri, 31 Oct 2025 02:12:43 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cyBvY0qvDz6L57Q;
	Fri, 31 Oct 2025 02:09:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 37ABF1402F5;
	Fri, 31 Oct 2025 02:12:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 18:12:48 +0000
Date: Thu, 30 Oct 2025 18:12:46 +0000
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
Message-ID: <20251030181246.00006328@huawei.com>
In-Reply-To: <yq5apla4cqex.fsf@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-7-aneesh.kumar@kernel.org>
	<20251029183306.0000485c@huawei.com>
	<yq5apla4cqex.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 21:50:22 +0530
"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Mon, 27 Oct 2025 15:25:56 +0530
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> >  
> 
> ...
> 
> >> +static int __do_dev_communicate(enum dev_comm_type type,
> >> +				struct pci_tsm *tsm, unsigned long error_state)
> >> +{
> >> +	int ret;
> >> +	int state;
> >> +	struct rmi_dev_comm_enter *io_enter;
> >> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> >> +
> >> +	io_enter = &pf0_dsc->comm_data.io_params->enter;
> >> +	io_enter->resp_len = 0;
> >> +	io_enter->status = RMI_DEV_COMM_NONE;
> >> +
> >> +	ret = ___do_dev_communicate(type, tsm);  
> >
> > Think up a more meaningful name.  Counting _ doesn't make for readable code.
> >  
> 
> I am not sure about this. What do you think?
> 
> modified   drivers/virt/coco/arm-cca-host/rmi-da.c
> @@ -188,7 +188,7 @@ static inline gfp_t cache_obj_id_to_gfp_flags(u8 cache_obj_id)
>  	return GFP_KERNEL_ACCOUNT;
>  }
>  
> -static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
> +static int __do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
>  {
>  	gfp_t cache_alloc_flags;
>  	int ret, nbytes, cp_len;
> @@ -319,7 +319,7 @@ static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
>  	return 0;
>  }
>  
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
> +	ret = __do_dev_communicate(type, tsm);
>  	if (ret) {
>  		if (type == PDEV_COMMUNICATE)
>  			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
> @@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
>  	return state;
>  }
>  
> -static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> -			      unsigned long target_state,
> -			      unsigned long error_state)
> +static int move_dev_to_state(enum dev_comm_type type, struct pci_tsm *tsm,

Naming is always tricky.  Not sure why this name is appropriate given it's definitely
still related to dev_communicate.

Maybe just squash do_dev_communicate and __do_dev_coummnicate.
Slightly long lines will be the result but not too bad.
I haven't checked what it ends up as after the whole series though
so maybe it doesn't work out.

static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
			      unsigned long target_state,
			      unsigned long error_state)
{
	

	do {
		int state, ret;
		struct rmi_dev_comm_enter *io_enter;
		struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);

		io_enter = &pf0_dsc->comm_data.io_params->enter;
		io_enter->resp_len = 0;
		io_enter->status = RMI_DEV_COMM_NONE;

		ret = ___do_dev_communicate(type, tsm);
//renamed

		if (ret) {
			if (type == PDEV_COMMUNICATE)
				rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));

			state = error_state;
		} else {
			/*
			 * Some device communication error will transition the
			 * device to error state. Report that.
			 */
			if (type == PDEV_COMMUNICATE)
				ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
							 (enum rmi_pdev_state *)&state);
			if (ret)
				state = error_state;
		}
	
		if (state == error_state) {
			pci_err(tsm->pdev, "device communication error\n");
			return state;
		}
		if (state == target_state)
			return state;
	} while (1);
}
Jonathan

> +			     unsigned long target_state,
> +			     unsigned long error_state)
>  {
>  	int state;
>  
>  	do {
> -		state = __do_dev_communicate(type, tsm, error_state);
> +		state = do_dev_communicate(type, tsm, error_state);
>  
>  		if (state == target_state || state == error_state)
>  			return state;
> @@ -374,7 +374,7 @@ static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
>  
>  static int do_pdev_communicate(struct pci_tsm *tsm, enum rmi_pdev_state target_state)
>  {
> -	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
> +	return move_dev_to_state(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
>  }
>  
>  static int parse_certificate_chain(struct pci_tsm *tsm)
> 
> 
> 
> 
> -aneesh
> 


