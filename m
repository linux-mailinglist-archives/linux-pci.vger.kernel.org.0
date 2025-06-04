Return-Path: <linux-pci+bounces-28944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BEACDA68
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839A417422A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870D2874F6;
	Wed,  4 Jun 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG8Lpspg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F01DED6D;
	Wed,  4 Jun 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027586; cv=none; b=rky1JNdW4LfBgwo1n/TXoPo3xFqoTbRrHDdAZjHd2GVr6gWn6PAlPnzy0YiWOX86vEy0iZBHBtX1yn1mvr3ABVlYm7wBly9Nl3t1XUTqllQko61BKzJAlDL+W28fm6v7K91CLVGaYoUcTmwHGCt1/4Q+7o7zt7KVtVMxpqyabMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027586; c=relaxed/simple;
	bh=Gv/8dSQ35RXpPTBT+MBnEM0acL6Cg6eS+qdQegxOfLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuCAQTiQ7Q8wlqDL9bEehGfI/ZaVU5XUERuAJp61x8YJc63SHZSDbJ6ULb1fiPbcD1SLG5gtMsfGVydTyQBss03Nm0qucEWK+B0F7EY5ic04//UJCHsuMunTWquVnxSuPFVm3I2/VnXkUm3Faq/09PRPtnObAGkK/BNGN+OGr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG8Lpspg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A62C4CEE7;
	Wed,  4 Jun 2025 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749027584;
	bh=Gv/8dSQ35RXpPTBT+MBnEM0acL6Cg6eS+qdQegxOfLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XG8LpspgQhEOozu2MyvW7S127w1bVqmyeNdTsZ2RM3Df9LJ8TUIT/F67GMO8KFSq3
	 ngO22sPZKSE4PvSuc+Vjnoy3kGI4mvd1uYp7OXoRwMGsncOp5ThdnCbBK/nIaQJA6x
	 YfjeM3RPQxCMa9vMohlDOOsf/cZj/CDypjZF9kW4LrKjErd3AIRLVI5/zzlGv6dMQJ
	 KtPTzA1fW5CRQ//ICfPzL9suDum53JrZwn/HOqvtEqFeh/cxWvxWd1gutog99q1D9k
	 n3A8Y/HoW1K0JOqlsoPgOV/EsQj3b30mOchfNn6lwt4Pv/Fb+zTsWTw7v9wZC2X9xX
	 anohPmBaCiiXA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <683f52b1aa2be_1626e100b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <yq5ajz6a3rp4.fsf@kernel.org>
 <683f52b1aa2be_1626e100b1@dwillia2-xfh.jf.intel.com.notmuch>
Date: Wed, 04 Jun 2025 13:34:32 +0530
Message-ID: <yq5asekg7x0v.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> ....
>> 
>> > +static void pci_tsm_pf0_init(struct pci_dev *pdev)
>> > +{
>> > +	bool tee_cap;
>> > +
>> > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
>> > +
>> > +	if (!(pdev->ide_cap || tee_cap))
>> > +		return;
>> >
>> 
>> If we expect to use pci_tsm_pf0_init and is_pci_tsm_pf0() from the
>> guest, can we have the ide_cap and tee_cap check here? Will that be true
>> for all devices assigned to the guest?
>
> I do not expect this path to be taken for a guest device. IDE is not
> relevant for TDIs in the guest and function0 is not a requirement guest
> BDFs. I still need to add this to samples/devsec/, but the expectation
> is that in "TVM mode" the presence of PCI_EXP_DEVCAP_TEE is sufficient
> to route any PCI function to tsm_ops->probe().

We do that because we expose /sys/bus/pci/devices/<x>/tsm/connect to
guest and we have

static int pci_tsm_connect(struct pci_dev *pdev)
{
	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
	int rc;

        ....

      	if (tvm_mode())
		rc = __driver_idle_connect(pdev);
	else
		rc = tsm_ops->connect(pdev);



-aneesh

