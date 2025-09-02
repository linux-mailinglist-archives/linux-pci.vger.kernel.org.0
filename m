Return-Path: <linux-pci+bounces-35327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAAB40870
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E885E47E8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE62DFA26;
	Tue,  2 Sep 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3UxqJoN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE942BE03E;
	Tue,  2 Sep 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825472; cv=none; b=hpi4lp+q5hljiFfyWlFJIO1ArhVG0DUwhsXzEa/vXwjRB13LtbR/9ob53p9g7+KFySaJ1h4oUpaAWmka1RWUr4waNEMmtswOtSWaw8YvttW7599G58IUeOBZaiXigoEUw/D7KzNSp/aR82PXJ08FlvQvlS5Vzet7McOFx1Tcy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825472; c=relaxed/simple;
	bh=L+4eJKu7HwlUVbOOxAqN2Ei+WeAoK62Jl9pbD3qzOxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqCxGf5LjMf9vdJ7B8LAt27mQWSR9kRZqJJE5aArR6wGZqZkrqmcgBX5IRL8Ax2frASWNSDxNUw6ivmOo7mqMz0gltPbRfd1HAzuSjwJvBU9ygEv6WSoOxgK/tkeOjNXkcM2/7uNYFf12KghgIsr2pFzEFICt7W52EYcoAWiydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3UxqJoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495D5C4CEF5;
	Tue,  2 Sep 2025 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825471;
	bh=L+4eJKu7HwlUVbOOxAqN2Ei+WeAoK62Jl9pbD3qzOxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b3UxqJoNOYv5Sq7Mj52yRs7W9X28ZJDFIrKlLoKts24c9vsBgzKP7j+ULl9Xz6vNj
	 2hzSH8ke6smaMr9eVGqLTpUHeDD25Hdx0p1BLFXFSWTgCdEPvVrOlc33DQGbUzEERp
	 U3/0VzODmaggg3ts1BLpg7l3IBQU28aP1aN6yA1F/A/vB3muSBj6Aoo8nFzLHQLBi2
	 vxgMNyysyh2h70qwWYUvy2gXO/Bj+qtsPtLJuYSYk8I45tO2UBWFzhJrmGTy5yqREH
	 YyZ3AW2bC8PTgUe5SohnFfNAPpkvGOwiZF2BPCke4Dd09CG6c7sk47ZFvL2p6lGgnN
	 /YiW514GnlX8A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
In-Reply-To: <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
Date: Tue, 02 Sep 2025 20:34:22 +0530
Message-ID: <yq5aa53c3ngp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 27/8/25 13:52, Dan Williams wrote:
>
>
> I suggest changing "pci_tsm_{bind,unbind}()" to "pci_tsm_bind/pci_tsm_unbind" or "pci_tsm_bind/_unbind" as otherwise cannot grep for pci_tsm_bind in git log.
>
>
>> After a PCIe device has established a secure link and session between a TEE
>> Security Manager (TSM) and its local Device Security Manager (DSM), the
>> device or its subfunctions are candidates to be bound to a private memory
>> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
>> Device Interface (TDI).
>> 
>> The pci_tsm_bind() requests the low-level TSM driver to associate the
>> device with private MMIO and private IOMMU context resources of a given TVM
>> represented by a @kvm argument. A device in the bound state corresponds to
>> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
>> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
>> it involves host side resource establishment and context setup on behalf of
>> the guest. It is also expected to be performed lazily to allow for
>> operation of the device in non-confidential "shared" context for pre-lock
>> configuration.
>> 
>
>
>
>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/pci/tsm.c       | 95 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-tsm.h | 30 +++++++++++++
>>   2 files changed, 125 insertions(+)
>> 
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>> index 092e81c5208c..302a974f3632 100644
>> --- a/drivers/pci/tsm.c
>> +++ b/drivers/pci/tsm.c
>> @@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Note, this helper only returns an error code and takes an argument for
>> + * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
>> + * always succeeds.
>> + */
>> +static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
>> +{
>> +	struct pci_tdi *tdi;
>> +	struct pci_tsm_pf0 *tsm_pf0;
>> +
>> +	lockdep_assert_held(&pci_tsm_rwsem);
>> +
>> +	if (!pdev->tsm)
>> +		return 0;
>> +
>> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
>
> What is expected to be passed to __pci_tsm_unbind/pci_tsm_bind as pdev - PF0 or TEE-IO VF? I guess the latter.
>
> But to_pci_tsm_pf0() casts the pdev's tsm to pci_tsm_pf0 which makes sense for PF0 but not for VFs.
>
> What do I miss and how does this work for you? Thanks,
>

I guess this needs

modified   drivers/pci/tsm.c
@@ -44,7 +44,7 @@ static inline bool has_tee(struct pci_dev *pdev)
 /* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm == ->pdev (self) */
 static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
 {
-	struct pci_dev *pdev = pci_tsm->pdev;
+	struct pci_dev *pdev = pci_tsm->dsm;
 
 	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
 		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");

-aneesh

