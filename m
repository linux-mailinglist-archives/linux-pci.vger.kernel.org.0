Return-Path: <linux-pci+bounces-33404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F8B1AAF2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC26180E19
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B228FAB3;
	Mon,  4 Aug 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMXiOvJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5F10942;
	Mon,  4 Aug 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346594; cv=none; b=NdNYbFv7ozkwM0fdiivF5DV0Gwhkj/7RXK1DLWHA7lGtVX5XIW+CW1g6wp42fOJktdTPxaVyKth/8nlp3CskVLJnT/hZXjmVL77ZMTNPPuejaPHKjReO1gaCPAn7C/6JQayI8SdDRguQJ5hZedVGIn+kKOrogjRUmjFNy/3pj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346594; c=relaxed/simple;
	bh=yCeoyLSrIh+81GUDv6mtuUfuIxz7gb52gaeHX1iNJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ijv+uSomVovBNKyt1fG7d9OYhIgJOY0CPqDdfakHe3y7BB5UYXyCcS4thS9HY7+Vp+jzHdCKSA5SsJzVncWvehucVhKMk2kCvPquWOwSa10kmbNASjeE3D5qGOJncKN9XJmtkSMNVzN+RpT/e1HZOhC/WFsxSkStzTjqkrB8bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMXiOvJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF850C4CEF7;
	Mon,  4 Aug 2025 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346593;
	bh=yCeoyLSrIh+81GUDv6mtuUfuIxz7gb52gaeHX1iNJBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uMXiOvJvu9R8pdgX8JWGgSBf1J5pb/yuxczy/tNfjXodt32TYU1eC+xbC72rHilVb
	 ul/oVh1eRbTB6EzZPFbNWBc4HAOw7tFLc94dLtpIWezTCJOLL77OUEvP7SMdDHVpt4
	 QNC+QMo2kT3VzpqzWQlrMNCNISfkuV3s+0NzuzjqAqO6IMdyXzyQJCTgSyJpfTfXwA
	 +Z87ysUn/WbeWkwDt5kfDJ8WbM+IAdBiE3j5xCwz3OL9BwF0qLV5U/TA7RQQMZ28oo
	 HolGnjynDFaEu2xVloIj0DkgJpLopVVpTKoV4p6qe2NYufTI4Hxb2eJsUC/V7c0Apv
	 Wauk6XwfYhWGg==
Date: Mon, 4 Aug 2025 17:29:52 -0500
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
Subject: Re: [RFC PATCH v1 14/38] coco: host: arm64: Device communication
 support
Message-ID: <20250804222952.GA3645019@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-15-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:51PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add helpers for device communication from RMM

> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
> +static int __do_dev_communicate(int type, struct pci_tsm *tsm)
> +{

> +			/* FIXME!! depending on the DevComms status,
> +			 * it might require to ABORT the communcation.

s/communcation/communication/

Even better, fix the FIXME :)

> +			 */
> +			return -EINVAL;
> +		}
> +
> +		if (io_exit->cache_rsp_len > cache_remaining)
> +			return -EINVAL;
> +
> +		memcpy(cache_buf + *cache_offset,
> +		       (comm_data->resp_buff + io_exit->cache_rsp_offset), io_exit->cache_rsp_len);
> +		*cache_offset += io_exit->cache_rsp_len;
> +	}
> +
> +	/*
> +	 * wait for last packet request from RMM.
> +	 * We should not find this because our device communication in synchronous

s/communication in/communication is/

> +	 */
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_WAIT)
> +		return -ENXIO;
> +
> +	is_multi = !!(io_exit->flags & RMI_DEV_COMM_EXIT_MULTI);
> +
> +	/* next packet to send */
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_SEND) {
> +		nbytes = doe_send_req_resp(tsm);
> +		if (nbytes < 0) {
> +			/* report error back to RMM */
> +			io_enter->status = RMI_DEV_COMM_ERROR;
> +		} else {
> +			/* send response back to RMM */
> +			io_enter->resp_len = nbytes;
> +			io_enter->status = RMI_DEV_COMM_RESPONSE;
> +		}
> +	} else {
> +		/* no data transmitted => no data received */
> +		io_enter->resp_len = 0;
> +	}
> +
> +	/* The call need to do multiple request/respnse */

s/respnse/response/

> +	if (is_multi)
> +		goto redo_communicate;
> +
> +	return 0;
> +}

