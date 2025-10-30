Return-Path: <linux-pci+bounces-39814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13CC20808
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D4188DE6A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D51FDE39;
	Thu, 30 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsfZ0knt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFE1EEA49;
	Thu, 30 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833100; cv=none; b=queg4CYBNHDFApsjjA1ukhWcc3W6o7soP0UGbcKLqtuaGOMCf+F4B0jduGJwnVmXHRKmoFpg6yN9mxPAr5J573ZJWBI4njAN+CVkID+0eqRK1QPWjnTdA/wI9ryHFZ+OurmCVe1G9bff1Pa0xoado21a4xDcBTnZBnNuI44O02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833100; c=relaxed/simple;
	bh=LKSA5kjPUGMHZZpJTjFfuRmu0oSOpXV4X1NFS+NHl88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lZ/IfhuG08XtwQTdQEYEmVw+yBcYzRg3kM4TUBI6CTdl1IHn7d1WUowtPRx8SXBL9catbsuvfvhAUsozEYwAhcAe+7kaRnl0/VcIuvmkanu0kPJkp3GuMUopXgugaoCW3I/DZlT2S39XwE60WUxSbeH4dB36wFvW+ylcvy+Nejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsfZ0knt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829C7C4CEF8;
	Thu, 30 Oct 2025 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833100;
	bh=LKSA5kjPUGMHZZpJTjFfuRmu0oSOpXV4X1NFS+NHl88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NsfZ0kntiAAsYA/kbFbts7G/hkZ5mjULzmVn4OOb+bvMDEeI4UV85RG8tiH3Fy/1n
	 ATqDUoQCP40EGyAa3WZG2f43NTwWO8F1BoslC2m3O9V+WzT+UD4ho9n/MHaQoQG6Cn
	 QQvtBUKZlcpiHorOKaknMwCMzty+K/OkYxh6LXlrMvuE9GzXTNz13HKx6EEdkHUrz5
	 DANQe7JhWNbNQBSvIs7LqhWC79cp2d75NzIrgFU9MLRoPoVHnzdn3hgAxP6HyGd/LP
	 dvnsMZMCUga58NKKuAWhUab5ncePZz9/nAeS+gQCRLTm3QeiPMY1zXiFVQXqZz8iaT
	 tpMYVKxttIE6Q==
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
In-Reply-To: <20251029183306.0000485c@huawei.com>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-7-aneesh.kumar@kernel.org>
 <20251029183306.0000485c@huawei.com>
Date: Thu, 30 Oct 2025 19:34:51 +0530
Message-ID: <yq5asef0cwos.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 27 Oct 2025 15:25:56 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>> +void pdev_communicate_work(struct work_struct *work)
>> +{
>> +	unsigned long state;
>> +	struct pci_tsm *tsm;
>> +	struct dev_comm_work *setup_work;
>> +	struct cca_host_pf0_dsc *pf0_dsc;
>> +
>> +	setup_work = container_of(work, struct dev_comm_work, work);
>> +	tsm = setup_work->tsm;
>> +	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> Could combine these 3 with declarations for shorter code without much
> change to readability.
>

Not sure about this.

 static void pdev_communicate_work(struct work_struct *work)
 {
 	unsigned long state;
-	struct pci_tsm *tsm;
-	struct dev_comm_work *setup_work;
-	struct cca_host_pf0_dsc *pf0_dsc;
-
-	setup_work = container_of(work, struct dev_comm_work, work);
-	tsm = setup_work->tsm;
-	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
+	struct dev_comm_work *setup_work = container_of(work,
+							struct dev_comm_work,
+							work);
+	struct pci_tsm *tsm = setup_work->tsm;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
 
 	guard(mutex)(&pf0_dsc->object_lock);
 	state = do_pdev_communicate(tsm, setup_work->target_state);

>> +
>> +	guard(mutex)(&pf0_dsc->object_lock);
>> +	state = do_pdev_communicate(tsm, setup_work->target_state);
>> +	WARN_ON(state != setup_work->target_state);
>> +
>> +	complete(&setup_work->complete);
>> +}
>

-aneesh

