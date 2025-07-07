Return-Path: <linux-pci+bounces-31598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811DAFACE1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49A81673C3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF365275844;
	Mon,  7 Jul 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDMz5R+L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712A1BF37;
	Mon,  7 Jul 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872679; cv=none; b=HWW6FXxIiPacDGtjKNqoYTCeldlOQ1L467ZXv17bgUjFySSr9Yq2NgAhuoL+fmLbsabxz4EBSjT1v3tXo2lHOSxc305TLVZrPE0S5CzNb62YzVY+JuD1Yeqb08oMvET2EPXsDLwG9A76KXulnbQpt0aXyGGvFe6nCZClbVBi5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872679; c=relaxed/simple;
	bh=3huX8IwMqv3kRZyT6eUcj/462sKM6tkRg4qWNK+wskQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U5cImXdMw9+J/lnfVSi74y4yovGMtRM3AWnThEEplOmueBkYiDoy6skIBhKXAbCUO1Vg8r4LGsC/CxdzYr8wtNxTND/lzYf71M/x1yD8P6NCzBd3o2s2HH21eq8zQGU0EuWDUHJMVqxKn4RXJnHl/wWw+7lDxlFrkgtZmc04OHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDMz5R+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0925FC4CEE3;
	Mon,  7 Jul 2025 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751872679;
	bh=3huX8IwMqv3kRZyT6eUcj/462sKM6tkRg4qWNK+wskQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nDMz5R+Lo262REvG8Ey1RqHTOiJHHcCdR/AmzWyvW1s7UJEQO3eUShSlZ14Hj3dOq
	 mpb0Z136A2fJunoiigiYRmZ43oN+gv2tgx4FV3B/ItL3tPCoG1nRP3Hi5COjpgn6u/
	 wh5Lns5vSZGXoI2XpPMRX/y8NSYJQ7o3OQwfDrmOXsZiLZLp2+Kr2rkG3DQL/65Zpm
	 nWwKR+HoD8v6bujlRXcAilgldUqG7NADjiCW/Mb0wKXT7kl1iVxm+fSSpiHVRnYTFx
	 axTdMV6VDxw+LHYV25aZ6ZT0bJZI5aClSAnY1B382MIOqGOY1Vd6XfPX3iH6jVnHIc
	 zg4oRaM/B5qxg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
Date: Mon, 07 Jul 2025 12:47:51 +0530
Message-ID: <yq5aqzys1nc0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 16/5/25 15:47, Dan Williams wrote:
>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>    * @probe and @remove run in pci_tsm_rwsem held for write context. All
>>    * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
>> @@ -102,6 +145,11 @@ struct pci_tsm_ops {
>>   	void (*remove)(struct pci_tsm *tsm);
>>   	int (*connect)(struct pci_dev *pdev);
>>   	void (*disconnect)(struct pci_dev *pdev);
>> +	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
>> +				struct kvm *kvm, u64 tdi_id);
>
> pf0_dev is not needed here, we should be able to calculate it from pdev.
>
> tdi_id is 32bit.
>

ARM rmm spec have this as 64 bit.

-aneesh

