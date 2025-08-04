Return-Path: <linux-pci+bounces-33393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E35B1AA91
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1583BEDBB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D322259E;
	Mon,  4 Aug 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glFBQ7BW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C97634;
	Mon,  4 Aug 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344487; cv=none; b=iGLIU/JsF9Pii+RNs+hWJBvHMzcYU6SlYydX8tUKUZ502CWmCm2rG0sVGwQBoS8nxPTQ+mGhFvfAxMvE2kol5ea4YBWdbMfEOoEFx/HiZ17pDWdgEanjJv2tajWAWIXJv09Lut0LGKVwWOb3yZgFXfwNmoNsDpdGWiDP9gfIhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344487; c=relaxed/simple;
	bh=uLPtm0HcssgYvZ/viuCH382QW0ADZ6ZxYfWJVn9+ybo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZZxf12mBOv1rkNMeHdcoZt4lGly6+4RqVPhGDS3qg9yG1VHgVPhz5a38r9pZe5U1gYsy2ZHTavYrpPFwV28dxh9lnAWJ8f7d0OFqt0etMcr8Yew+iBXmSRZ9HLnLnWReFm6jB/WhkDPbKvabvzBOxQeunHuagAOTmz5UVlFX97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glFBQ7BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F81C4CEE7;
	Mon,  4 Aug 2025 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754344486;
	bh=uLPtm0HcssgYvZ/viuCH382QW0ADZ6ZxYfWJVn9+ybo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=glFBQ7BWteoL1qqVk/4bASVhVFSWmPgMRQnEpyydpj7sYqJ78B9e+5RG1cQ0doJQN
	 JaMxPSwUHJX7aAetWNSR2ZUI56LXE1iaeBEu151WVJ6IRDQHB6uuXOdQuM22oi10aI
	 k1KnwlEVkvSEfzL1vVaHLxnGSjUUdBEp57GjVyeFNn2WozxqgRNVAXWg021gkWVaWY
	 4JOUYiqmArauS/0G+E40f5UrvKE5rSEy9/sociYdsWOsk2+0WrRtj5HsS+bZPBVNio
	 j7hxGY8cHq1VmK1DUtlboskkTUYzbDHYAhZRQiMBPwilozVCyC9v3PXf8u89X2Y/LI
	 89rMBHGOPTG7A==
Date: Mon, 4 Aug 2025 16:54:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250804215445.GA3644210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-5-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Currently, we enforce the use of bounce buffers to ensure that memory
> accessed by non-secure devices is explicitly shared with the host [1].
> However, for secure devices, this approach must be avoided.

> @@ -557,6 +560,9 @@ static void __pci_tsm_init(struct pci_dev *pdev)
>  	default:
>  		break;
>  	}
> +
> +	/* FIXME!! should this be default true and switch to false for TEE capable device */

Fix whatever this is, or make it a real sentence and wrap to fit in 80
columns.

> +	pdev->dev.tdi_enabled = false;
>  }

