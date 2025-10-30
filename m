Return-Path: <linux-pci+bounces-39786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94325C1F3BC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82DC44E7EDC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9D34029E;
	Thu, 30 Oct 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9YhZlXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0331986E;
	Thu, 30 Oct 2025 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815909; cv=none; b=FVRhsod5JdXylQXIS1KIejXZuIDDHDfw2pxWk4NcErBGKLHrrBYlZxD4VrjwdikkMVKDox7WS2GsKuINUaYoIkichftzKVIJSNhnj8ycB6TCnt/fLhkRvCb396WK9rvRQ5rmmXcTtlXGfZb1P+mDfg/c+8eL6A4yeeot2/zrqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815909; c=relaxed/simple;
	bh=BWDl6zwh+JeTjjhMFmNzjglL13HrWxeKiSTcarPYJbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B/othhh6JlhxUEJKa4WRn2fvziH+cJH56waLgbXWYzAzmCIqQzC1+Z4yVtfb344YQEk6I2R1WKjmpUnwKMcuXFRjvCQDnKZ+0WYZFGJT/hDtncTLEJN/XXQqMlcTYVItOgWR0356ABcGqXsIzxWsRrDPRkZD0wGjQcYidCQznbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9YhZlXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5A2C4CEF1;
	Thu, 30 Oct 2025 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761815908;
	bh=BWDl6zwh+JeTjjhMFmNzjglL13HrWxeKiSTcarPYJbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p9YhZlXHAzUmuRgBC3pmUlvKv5niPfDuihXrKLhWfk7CS1xKlnvFY6wLGquwfS/i4
	 l8CvZNR4zDONFmzmN7zTB/gM8GOltY9aO9qn5W9kp/+F5tau3eckXdu5G8SoIei+l8
	 OpHvFtQsVeyv05AEDICks0NRC0Phw9zlCGRFbmR9fyu3ZOcJ/0B+9myOYuiiXinRa8
	 EOCsDKZCIWkH+92fuwJ3OuuI4A08ocQ8VUtwLyeWSiigtbaXYFn25yNNR7z8kIVh97
	 DO4yT3spzQAJxcGIgSCGxHNhHUEICIeVNLeoY2KWTIQeAhrWDg1H8EOYYdU4R3Ef6P
	 C+9lvXd+yhx6w==
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
Date: Thu, 30 Oct 2025 14:48:20 +0530
Message-ID: <yq5ay0osd9yb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
...

>> +		/*
>> +		 * Some device communication error will transition the
>> +		 * device to error state. Report that.
>> +		 */
>> +		if (type == PDEV_COMMUNICATE)
>> +			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
>> +						 (enum rmi_pdev_state *)&state);
>> +		if (ret)
>> +			state = error_state;
> Whilst not strictly needed I'd do this as:
>
> 		if (type == PDEV_COMMUNICATE) {
> 			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> 						 (enum rmi_pdev_state *)&state);
> 			if (ret)
> 				state = error_state;
> 		}
>
> Just to make it clear that reg check is just on the output of the call above.
> If we didn't make that call it is definitely zero but nice not to have
> to reason about it.
>

Some of this is because follow up patch adds more details there. In this case.

		/*
		 * Some device communication error will transition the
		 * device to error state. Report that.
		 */
		if (type == PDEV_COMMUNICATE)
			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
						 (enum rmi_pdev_state *)&state);
		else
			ret = rmi_vdev_get_state(virt_to_phys(host_tdi->rmm_vdev),
						 (enum rmi_vdev_state *)&state);
		if (ret)
			state = error_state;



>
>> +	}
>> +
>> +	if (state == error_state)
>> +		pci_err(tsm->pdev, "device communication error\n");
>> +
>> +	return state;
>> +}
>> +

-aneesh

