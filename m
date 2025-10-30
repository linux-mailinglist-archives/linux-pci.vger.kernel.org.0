Return-Path: <linux-pci+bounces-39767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C532C1F0C0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3793A6352
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7A3321D8;
	Thu, 30 Oct 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl3YINTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4C329381;
	Thu, 30 Oct 2025 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813892; cv=none; b=AqQsyCabaPY7wyU5ThmnHgo/omVtz9EBn5pykocWwQ9MO3+BMO8opUJhdewvnbAzjoZ55bgSquN1+EVcU5ZNflcb385OCsN6coRx8I40rXQSV3fw7JHPgCHmemRtpaw0yrMbfOxB26iK668WrDIR0w4DthG133UVDR5bcPnPKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813892; c=relaxed/simple;
	bh=6dybDKX7+8hY8anqIxc/y/vMKgfpFG/JnzMwdU4JUOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3jvNpgwoOvMMepPMOI6pVUQl6BIVJDRaeI3EJc+1sve1tnFyEcbpmJPJGka9xx8jUP+LNJg9LA7JCrZOqXlVdaQiY0tMdu0JilevjrPZ9fdSB9BiXgn45TJ2wvC3Gt0yeiQL1b3TncYF5dBXqKzUEofD5e9opdUcQNNceIDrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl3YINTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98F7C4CEF1;
	Thu, 30 Oct 2025 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761813891;
	bh=6dybDKX7+8hY8anqIxc/y/vMKgfpFG/JnzMwdU4JUOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tl3YINTBCky5gPU7q3VpgRownmw4sMgXMIb2LK5ZwSqU5X941nZo/d/8kXncj0GTJ
	 yaYH796cLicsWvjv9/v1lfIeqf3xdkxFXNiQVo+DXm/ujU/zHVn452RZezpRCA+hhl
	 8ZH498Je9gE+6t8cuyiG8/Y6UQgKXQKbPOFyH3AftHaCoS/RASEhNCSkmxj3d1ex6b
	 4AWEe9CwKeEcPQqJZ6QYK9JyPp4PcX5QdFhL3W552iAOHutDdBcClRnrl9qVX5B7/6
	 tMIiZNCipVRcRz79gKpP0aP2o1kzFhHbWsFrso7IRDVILAd0o0dthaXZsBjx0d2sqI
	 kbSlj2FsIFrHA==
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
Subject: Re: [PATCH RESEND v2 05/12] coco: host: arm64: Build and register
 RMM pdev descriptors
In-Reply-To: <20251029173743.00006d48@huawei.com>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-6-aneesh.kumar@kernel.org>
 <20251029173743.00006d48@huawei.com>
Date: Thu, 30 Oct 2025 14:14:43 +0530
Message-ID: <yq5a3470eq2s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 27 Oct 2025 15:25:55 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

...

>>  
>> +int pdev_create(struct pci_dev *pdev);
> That is a very generic name to find in a header, even one buried deep in drivers.
> I'd prefix it with somethin more specific rmi_pdev_create() or something like that.

May be I can call this cca_pdev_create, because rmi_pdev_create()
already exist.

-aneesh

