Return-Path: <linux-pci+bounces-39898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D1C23A71
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45363A8C93
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EF2D2499;
	Fri, 31 Oct 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhqHqbmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434F285C8C;
	Fri, 31 Oct 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897881; cv=none; b=hOZpawTYE83P/R4JCvvrK9KMiX6uYtxqqiTSlo9JJO63c37MNeNrvqk/a/Q9OO/nu59Wi3OvbrFtBHUaQUeXb/6x62GvAk15fy915TiS68tMGBvaB/39czDCWNAk/qTq2JlJ1mxiN0omNhqs9pDtcgTec++kFLTcJRXocKQitNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897881; c=relaxed/simple;
	bh=546etZjxB2dCRx5TRDsxExeuWWF+d4Iy+TeI2nSmrmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XJ+oRnOpRUM1ohh2uNZvg2qHnpyEVyoqiI4MMxnXEeRGMpdV3ZWgU/f0++gH3HYf6hqUPEmA4xY7PzCmDhwEn/WocIiR8nyhWB8oValmQqJ4OKheb8DJAtNpPMMY4kL3p3yas5Jv8yl0lqTPyv7C4rkCyP8JMCp0yDw5/GJ32xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhqHqbmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A395C4CEE7;
	Fri, 31 Oct 2025 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761897881;
	bh=546etZjxB2dCRx5TRDsxExeuWWF+d4Iy+TeI2nSmrmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uhqHqbmYcivsUxPX+RYdkwTde0PdlS+BT4GwY03ZtYB6riJazTikkvm5aX4pSarBU
	 wAuqdHWnKvawwrxzZdETZGZae4jI0OH/pYfKuXov5flO+BDrT5TJ/fIgnOGG+DjNb+
	 Q3tRH03HTvOlKVMWq1zoJ+SW/zey19MHlYVrjJAGOeGhVBaBNjvk54IRE9ZzqUMIEF
	 ygLoKs3nIDMxoUyMOsv1RCuUmc4ZSUTCrzrj4ojO03VWLHXARlwyYRHKYPI0o3fphN
	 sbYbDbg6h811Kq7TnCU/W/D6QXc0yqwFAcT2pS41eyPC59CSWoqbnyIxVeTXBth6dT
	 i7tLeQoucVpyw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 06/12] coco: host: arm64: Add RMM device
 communication helpers
In-Reply-To: <20251030181246.00006328@huawei.com>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-7-aneesh.kumar@kernel.org>
 <20251029183306.0000485c@huawei.com> <yq5apla4cqex.fsf@kernel.org>
 <20251030181246.00006328@huawei.com>
Date: Fri, 31 Oct 2025 13:34:33 +0530
Message-ID: <yq5ams57cx9q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Thu, 30 Oct 2025 21:50:22 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
>
>> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
>> 
>> > On Mon, 27 Oct 2025 15:25:56 +0530
>> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>> >  
>> 
>> ...
>> 
>> >> +static int __do_dev_communicate(enum dev_comm_type type,
>> >> +				struct pci_tsm *tsm, unsigned long error_state)
>> >> +{
>> >> +	int ret;
>> >> +	int state;
>> >> +	struct rmi_dev_comm_enter *io_enter;
>> >> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
>> >> +
>> >> +	io_enter = &pf0_dsc->comm_data.io_params->enter;
>> >> +	io_enter->resp_len = 0;
>> >> +	io_enter->status = RMI_DEV_COMM_NONE;
>> >> +
>> >> +	ret = ___do_dev_communicate(type, tsm);  
>> >
>> > Think up a more meaningful name.  Counting _ doesn't make for readable code.
>> >  
>> 
>> I am not sure about this. What do you think?
>> 
>> modified   drivers/virt/coco/arm-cca-host/rmi-da.c
>> @@ -188,7 +188,7 @@ static inline gfp_t cache_obj_id_to_gfp_flags(u8 cache_obj_id)
>>  	return GFP_KERNEL_ACCOUNT;
>>  }
>>  
>> -static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
>> +static int __do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
>>  {
>>  	gfp_t cache_alloc_flags;
>>  	int ret, nbytes, cp_len;
>> @@ -319,7 +319,7 @@ static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
>>  	return 0;
>>  }
>>  
>> -static int __do_dev_communicate(enum dev_comm_type type,
>> +static int do_dev_communicate(enum dev_comm_type type,
>>  				struct pci_tsm *tsm, unsigned long error_state)
>>  {
>>  	int ret;
>> @@ -331,7 +331,7 @@ static int __do_dev_communicate(enum dev_comm_type type,
>>  	io_enter->resp_len = 0;
>>  	io_enter->status = RMI_DEV_COMM_NONE;
>>  
>> -	ret = ___do_dev_communicate(type, tsm);
>> +	ret = __do_dev_communicate(type, tsm);
>>  	if (ret) {
>>  		if (type == PDEV_COMMUNICATE)
>>  			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
>> @@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
>>  	return state;
>>  }
>>  
>> -static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
>> -			      unsigned long target_state,
>> -			      unsigned long error_state)
>> +static int move_dev_to_state(enum dev_comm_type type, struct pci_tsm *tsm,
>
> Naming is always tricky.  Not sure why this name is appropriate given it's definitely
> still related to dev_communicate.
>
> Maybe just squash do_dev_communicate and __do_dev_coummnicate.
> Slightly long lines will be the result but not too bad.
> I haven't checked what it ends up as after the whole series though
> so maybe it doesn't work out.
>
> static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> 			      unsigned long target_state,
> 			      unsigned long error_state)
> {
> 	
>
> 	do {
> 		int state, ret;
> 		struct rmi_dev_comm_enter *io_enter;
> 		struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
>
> 		io_enter = &pf0_dsc->comm_data.io_params->enter;
> 		io_enter->resp_len = 0;
> 		io_enter->status = RMI_DEV_COMM_NONE;
>
> 		ret = ___do_dev_communicate(type, tsm);
> //renamed
>
> 		if (ret) {
> 			if (type == PDEV_COMMUNICATE)
> 				rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
>
> 			state = error_state;
> 		} else {
> 			/*
> 			 * Some device communication error will transition the
> 			 * device to error state. Report that.
> 			 */
> 			if (type == PDEV_COMMUNICATE)
> 				ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> 							 (enum rmi_pdev_state *)&state);
> 			if (ret)
> 				state = error_state;
> 		}
> 	
> 		if (state == error_state) {
> 			pci_err(tsm->pdev, "device communication error\n");
> 			return state;
> 		}
> 		if (state == target_state)
> 			return state;
> 	} while (1);
> }
> Jonathan
>

I need the existing __do_dev_communicate for a followup patch where the
device communication won't loop till state transition.

Something like 

void vdev_fetch_object_work(struct work_struct *work)
{
	int state;
	struct pci_tsm *tsm;
	struct cca_host_pf0_dsc *pf0_dsc;
	struct dev_comm_work *setup_work;
	struct rmi_dev_comm_enter *io_enter;

	setup_work = container_of(work, struct dev_comm_work, work);
	tsm = setup_work->tsm;
	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);

	io_enter = &pf0_dsc->comm_data.io_params->enter;
	io_enter->resp_len = 0;
	io_enter->status = RMI_DEV_COMM_NONE;

	guard(mutex)(&pf0_dsc->object_lock);

	*setup_work->cache_offset = 0;
	memset(setup_work->cache_buf, 0, setup_work->cache_size);
	state = __do_dev_communicate(VDEV_COMMUNICATE, tsm, RMI_VDEV_ERROR);
	/* return status through dev_comm_work.cache_cache */
	if (state == RMI_VDEV_ERROR)
		setup_work->cache_size = 0;

	complete(&setup_work->complete);
}

Considering current usage is loop till we reach a specific target state,
how abou the below?

modified   drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -188,7 +188,7 @@ static inline gfp_t cache_obj_id_to_gfp_flags(u8 cache_obj_id)
 	return GFP_KERNEL_ACCOUNT;
 }
 
-static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
+static int _do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
 {
 	gfp_t cache_alloc_flags;
 	int ret, nbytes, cp_len;
@@ -319,7 +319,7 @@ static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
 	return 0;
 }
 
-static int __do_dev_communicate(enum dev_comm_type type,
+static int do_dev_communicate(enum dev_comm_type type,
 				struct pci_tsm *tsm, unsigned long error_state)
 {
 	int ret;
@@ -331,7 +331,7 @@ static int __do_dev_communicate(enum dev_comm_type type,
 	io_enter->resp_len = 0;
 	io_enter->status = RMI_DEV_COMM_NONE;
 
-	ret = ___do_dev_communicate(type, tsm);
+	ret = _do_dev_communicate(type, tsm);
 	if (ret) {
 		if (type == PDEV_COMMUNICATE)
 			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
@@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
 	return state;
 }
 
-static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
+static int wait_for_dev_state(enum dev_comm_type type, struct pci_tsm *tsm,
 			      unsigned long target_state,
 			      unsigned long error_state)
 {
 	int state;
 
 	do {
-		state = __do_dev_communicate(type, tsm, error_state);
+		state = do_dev_communicate(type, tsm, error_state);
 
 		if (state == target_state || state == error_state)
 			return state;
@@ -372,9 +372,9 @@ static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
 	return error_state;
 }
 
-static int do_pdev_communicate(struct pci_tsm *tsm, enum rmi_pdev_state target_state)
+static int wait_for_pdev_state(struct pci_tsm *tsm, enum rmi_pdev_state target_state)
 {
-	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
+	return wait_for_dev_state(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
 }
 
 static int parse_certificate_chain(struct pci_tsm *tsm)
@@ -497,7 +497,7 @@ static int pdev_set_public_key(struct pci_tsm *tsm)
 				   virt_to_phys(key_params));
 }
 
-static void pdev_communicate_work(struct work_struct *work)
+static void pdev_state_transition_workfn(struct work_struct *work)
 {
 	unsigned long state;
 	struct pci_tsm *tsm;
@@ -509,13 +509,13 @@ static void pdev_communicate_work(struct work_struct *work)
 	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
 
 	guard(mutex)(&pf0_dsc->object_lock);
-	state = do_pdev_communicate(tsm, setup_work->target_state);
+	state = wait_for_pdev_state(tsm, setup_work->target_state);
 	WARN_ON(state != setup_work->target_state);
 
 	complete(&setup_work->complete);
 }
 
-static int submit_pdev_comm_work(struct pci_dev *pdev, int target_state)
+static int submit_pdev_state_transition_work(struct pci_dev *pdev, int target_state)
 {
 	int ret;
 	enum rmi_pdev_state state;
@@ -523,7 +523,7 @@ static int submit_pdev_comm_work(struct pci_dev *pdev, int target_state)
 	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
 	struct cca_host_comm_data *comm_data = to_cca_comm_data(pdev);
 
-	INIT_WORK_ONSTACK(&comm_work.work, pdev_communicate_work);
+	INIT_WORK_ONSTACK(&comm_work.work, pdev_state_transition_workfn);
 	init_completion(&comm_work.complete);
 	comm_work.tsm = pdev->tsm;
 	comm_work.target_state = target_state;
@@ -548,7 +548,7 @@ int cca_pdev_ide_setup(struct pci_dev *pdev)
 {
 	int ret;
 
-	ret = submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
+	ret = submit_pdev_state_transition_work(pdev, RMI_PDEV_NEEDS_KEY);
 	if (ret)
 		return ret;
 	/*
@@ -563,7 +563,7 @@ int cca_pdev_ide_setup(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	return submit_pdev_comm_work(pdev, RMI_PDEV_READY);
+	return submit_pdev_state_transition_work(pdev, RMI_PDEV_READY);
 }
 
 void cca_pdev_stop_and_destroy(struct pci_dev *pdev)
@@ -576,7 +576,7 @@ void cca_pdev_stop_and_destroy(struct pci_dev *pdev)
 	if (WARN_ON(ret != RMI_SUCCESS))
 		return;
 
-	submit_pdev_comm_work(pdev, RMI_PDEV_STOPPED);
+	submit_pdev_state_transition_work(pdev, RMI_PDEV_STOPPED);
 
 	ret = rmi_pdev_destroy(rmm_pdev_phys);
 	if (WARN_ON(ret != RMI_SUCCESS))




-aneesh

