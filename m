Return-Path: <linux-pci+bounces-39831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64238C21217
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4202188490C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A5314D27;
	Thu, 30 Oct 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7CalIiK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01227472;
	Thu, 30 Oct 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841231; cv=none; b=OLK/uZmYIjCJenjOFSXHNalLVCOXEgEOIKtfs9RQeqp1LsWDm1956bgbq93DP2P7IdPLJ6w3f9pq5MC2ZugC+BdxYM5OIxJxPS1d/CoHSD1d+kGjlRm8/VuOAeQWZBRL1BMaFD1UFGUUQvY3SwLNxWRdOn2mWKDF4ZFe6kHsBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841231; c=relaxed/simple;
	bh=JB1C63FfVtQnE2hu7z/BCXKPNzQrnk3QttrYxG2KxQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XoCVIVMrF6/3OP7YP/HgfOo9hbYZl0IOCLreGahQ5KVlyMSDy9xKhTJQhg/RfPI+3I4moUcoE17i+qI53ezdGqwLLqPhPFXhpP4Nrll3j7Ie8w8yEEe6qwGQOynKuICpjP0aUsw0H+8xk95Dd5hlmFAQ/t1mZoCmUDs+g3UPUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7CalIiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7425C4CEF8;
	Thu, 30 Oct 2025 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841230;
	bh=JB1C63FfVtQnE2hu7z/BCXKPNzQrnk3QttrYxG2KxQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c7CalIiK2A8c6CCtJsIt63iRMFSFGxtTIFe7BMY8X6h4vR0W8S92AlK5KRl4C05cW
	 uDCjy1VZUT0kn/80Z1z18NIwNWvcO7vZoOE/IzhuzoUqjKiOzLkwVseOB3/ZrAHzH2
	 mHwSyAMbCexrImiDlbLApzwhSm+Gkxf1/qDGXGwWEJ0hCT2pmc4u6f/hekzJ8liXsi
	 37ifxBRdU7wpW06lm4avhbtAdjL3WTTWylSIgFME5fCrRouNHpNe+A154w8pQuR/dr
	 E50BqYnYyemZbWvTZYjNJEguoQJv0DNc8i8nfM8NU1yqwf4pn1DfyvLCctNMju1rCe
	 xgA12toZ1QtfA==
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
Date: Thu, 30 Oct 2025 21:50:22 +0530
Message-ID: <yq5apla4cqex.fsf@kernel.org>
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

>> +static int __do_dev_communicate(enum dev_comm_type type,
>> +				struct pci_tsm *tsm, unsigned long error_state)
>> +{
>> +	int ret;
>> +	int state;
>> +	struct rmi_dev_comm_enter *io_enter;
>> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
>> +
>> +	io_enter = &pf0_dsc->comm_data.io_params->enter;
>> +	io_enter->resp_len = 0;
>> +	io_enter->status = RMI_DEV_COMM_NONE;
>> +
>> +	ret = ___do_dev_communicate(type, tsm);
>
> Think up a more meaningful name.  Counting _ doesn't make for readable code.
>

I am not sure about this. What do you think?

modified   drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -188,7 +188,7 @@ static inline gfp_t cache_obj_id_to_gfp_flags(u8 cache_obj_id)
 	return GFP_KERNEL_ACCOUNT;
 }
 
-static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
+static int __do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
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
+	ret = __do_dev_communicate(type, tsm);
 	if (ret) {
 		if (type == PDEV_COMMUNICATE)
 			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
@@ -355,14 +355,14 @@ static int __do_dev_communicate(enum dev_comm_type type,
 	return state;
 }
 
-static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
-			      unsigned long target_state,
-			      unsigned long error_state)
+static int move_dev_to_state(enum dev_comm_type type, struct pci_tsm *tsm,
+			     unsigned long target_state,
+			     unsigned long error_state)
 {
 	int state;
 
 	do {
-		state = __do_dev_communicate(type, tsm, error_state);
+		state = do_dev_communicate(type, tsm, error_state);
 
 		if (state == target_state || state == error_state)
 			return state;
@@ -374,7 +374,7 @@ static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
 
 static int do_pdev_communicate(struct pci_tsm *tsm, enum rmi_pdev_state target_state)
 {
-	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
+	return move_dev_to_state(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
 }
 
 static int parse_certificate_chain(struct pci_tsm *tsm)




-aneesh

