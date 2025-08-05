Return-Path: <linux-pci+bounces-33415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72776B1AD46
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 06:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AC37AA809
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC6217F34;
	Tue,  5 Aug 2025 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4El6S8+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A721639B;
	Tue,  5 Aug 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369438; cv=none; b=puEXYCZsR4zgM7Cm3M0q52jbXSkpZOn+FjQK1k2hoE7R/cqfHNzS4dxL7vceWM1t+0l0xSnq0JJ+fWnOwI/qKloxIa4/oSc2lT9d7dVqzbyML8q5C8rNGaCyh2uEUKReIC/WQXo0K/nps1uOx3lSfPggkZuF4EL5N3nUsTsMJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369438; c=relaxed/simple;
	bh=fVWNpB6uzPWSzmZr0uT2aPWOOivAck8Ett7wh/W2aVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbWomXF+kHdzNAgdXOT4JlwqYIdgwq9m8ItiYCVtIeeqn7JM98QVt0CZoVAUgAbnNzzcXwJkOBwO5HaWklQk7s2mi8G6yqjqNGP+4ulX/vIpKWnUERBK3/2aj9NhoIUwyUzyA8mQy11FbnQ63Y7Yl+j6vl+EGA+zJwL45a2A00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4El6S8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC47C4CEF4;
	Tue,  5 Aug 2025 04:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754369437;
	bh=fVWNpB6uzPWSzmZr0uT2aPWOOivAck8Ett7wh/W2aVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F4El6S8+IawdSAD8fksaTfbbKtGS+nE3I8MKiRTseeG1AB8uMLPCSOwknxK1ojb6L
	 tuz+9TP0LScVsHNyhI/gmm5Z8PAcLdCbMxLsE62MGeaUaJ/XCqA+xXKBqIrtUMlGAT
	 JUhT96eHUgSgdImjhUz+QGwj2gq+bEeMXpvn1gDFoaEO53OdfiwbvX5cyYHRwOzXj5
	 RtALf24V53/Ylb26LE/blICqBGvmpptJBNrEH6lWckTpjGlQqIUfQTQN3RWhUlinAE
	 BDRNtEE3xYA4DAy4qeJiNy7kEXmfqPEaYuc3lMyb8K+ES7dvnNZA+02dIOlUXhYwGM
	 4nBnPfrzC21+w==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
In-Reply-To: <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 05 Aug 2025 10:20:30 +0530
Message-ID: <yq5afre68j8p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V (Arm) wrote:
>> This patch series implements support for Device Assignment in the ARM CCA
>> architecture. The code changes are based on Alp12 specification published here
>> [1].
>> 
>> The code builds on the TSM framework patches posted at [2]. We add extension to
>> that framework so that TSM is now used in both the host and the guest.
>> 
>> A DA workflow can be summarized as below:
>> 
>> Host:
>> step 1.
>> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> 
>> step 2.
>> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>
> Just for my own understanding... presumably there is no ordering
> constraint for ARM CCA between step1 and step2, right? I.e. The connect
> state is independent of the bind state.
>
> In the v4 PCI/TSM scheme the connect command is now:
>
> echo $tsm_dev > /sys/bus/pci/devices/$DEVICE/tsm/connect
>
>> Now in the guest we follow the below steps
>
> I assume a signifcant amount of kvmtool magic happens here to get the
> TDI into a "bind capable" state, can you share that command?
>

lkvm run --realm -c 2 -m 256 -k /kselftest/Image  -p  "$KERNEL_PARAMS" -d ./rootfs-guest.ext2 --iommufd-vdevice --vfio-pci $DEVICE1 --vfio-pci $DEVICE2

> I had been assuming that everyone was prototyping with QEMU. Not a
> problem per se, but the memory management for shared device assignment /
> bounce buffering has had a quite of bit of work on the QEMU side, so
> just curious about the difference in approach here. Like, does kvmtool
> support operating the device in shared mode with bounce buffering and
> page conversion (shared <=> private) support? In any event, happy to see
> mutiple simultaneous consumers of this new kernel infrastructure.
>

-aneesh

