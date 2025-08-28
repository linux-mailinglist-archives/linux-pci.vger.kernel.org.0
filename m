Return-Path: <linux-pci+bounces-34979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C74B396C7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3733BAA08
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B90277C95;
	Thu, 28 Aug 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU1qQXHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081921F4162;
	Thu, 28 Aug 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369183; cv=none; b=Ihds7nNlQnaZuU2+2LGCUYXlJFQv7Bw9zQf0Ce99hQFgLsxQZOrvryVyJ3pK+GGY908lm6rHnV3wczHtnqQpBeqG9Oqph+YEGPIoT/sk2aWgbb1r3GVUmawq1CFzNutz3qrgbRdGydJpAnTAxTKkBDj0aqqbN29W5J1fe9FIqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369183; c=relaxed/simple;
	bh=vpmhZ/BYgeL0lpRK+9nXFK6vdfF+/Xs5Wi9tJd36oz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PEpKeHgg+n+DCg498hduTDsh1R6tV+rZCjaFZuReJoYKfzJho4G00yPs07mY5Cz7jC4a9UMqSacyJAOnU9JMNrxv511FVtB5HbKNMVcvTRdjNUj2Ph6QrAFNZQlfPNg4zFXRU8PhHLXP1YCSqj2A+F/QwQcBdln+Crh0YkWfulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU1qQXHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39532C4CEEB;
	Thu, 28 Aug 2025 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756369182;
	bh=vpmhZ/BYgeL0lpRK+9nXFK6vdfF+/Xs5Wi9tJd36oz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cU1qQXHOJOCqzk11O7vUeUhhKuSChzzT3cSwJ6lDf6nO85AzlReArl6PZcK6NUzJz
	 upq/uZs24GYlSUijV5eeDnm3VYMMJc0QqDJ03E/5WvBhKSW0jyakllq6Mb8kH5HHMa
	 0s+t/FyXe6Xx7rO+4rehR1ZeUwRAOJVQsu1l/DayprsYz3OgY1+fZzIECslGOjRZOH
	 8OgwwDvy385bE5H6ojQCn6AjJz6zuL6yLy85OxqyOjA1+txNqW7mtal/6TyGRvpnMT
	 59cLrjo3fcL5+zD6MTgJOHPr8kD93aUA4xYw8YlF+RdFqKI+ABuTEGvrCy1gdXOTVk
	 0RpmBOsezBiGA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Arto Merilainen <amerilainen@nvidia.com>, dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Yilun Xu <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
 <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
Date: Thu, 28 Aug 2025 13:49:32 +0530
Message-ID: <yq5azfbjq2nf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arto Merilainen <amerilainen@nvidia.com> writes:

> On 8.8.2025 20.26, dan.j.williams@intel.com wrote:
>> Arto Merilainen wrote:
>>> The first revision of this patch had address association register
>>> programming but it has since been removed. Could you comment if there is
>>> a reason for this change?
>> 
>> We chatted about it around this point in the original review thread [1].
>> tl;dr SEV-TIO and TDX Connect did not see a strict need for it. However,
>> the expectation was always to circle back and revive it if it turned out
>> later to be required.
>
> Thank you for the reference. I suppose it is ok to rely on the default 
> streams on the first iteration, and add a follow-up patch in the ARM CCA 
> device assignment support series in case it is the only architecture 
> that depends on them.
>
>> 
>>> Some background: This might be problematic for ARM CCA. I recall seeing
>>> a comment stating that the address association register programming can
>>> be skipped on some architectures (e.g., apparently AMD uses a separate
>>> table that contains the StreamID) but on ARM CCA the StreamID
>>> association AFAIK happens through these registers.
>> 
>> Can you confirm and perhaps work with Aneesh to propose an incremental
>> patch to add that support back? It might be something that we let the
>> low level TSM driver control. Like an additional address association
>> object that can be attached to 'struct pci_ide' by the low level TSM
>> driver.
>
> Aneesh, could you perhaps extend the IDE driver by adding the RP address 
> association register programming in the next revision of the DA support 
> series?
>

Sure, I can add that change as part of next update. 

>
> I think the EP side programming won't be relevant until we get to the 
> P2P use-cases.
>
>> 
>> The messy part is sparse device MMIO layout vs limited association
>> blocks and this is where SEV-TIO and TDX Connect have other mechanisms
>> to do that stream-id association.
>
> Despite the potential sparsity, I think there needs to be only three 
> address association register blocks per SEL_IDE block: The routing is 
> based on the type-1 configuration space header which defines only three 
> ranges (32bit BAR, 64bit BAR, IO). When enabling IDE between an RP and 
> an EP, the SEL_IDE address association registers in the RP can be 
> programmed with the same ranges used in the type-1 header in the switch 
> upstream from the EP.
>
> That said, if the RP implements less than three address association 
> registers per SEL_SID, this scheme won't work.
>
> (I vaguely recall that the PCIe spec might forbid IORd/IOWr TLPs when 
> selective IDE streams are used so the limit might in fact be two instead 
> three...)
>
> - R2

