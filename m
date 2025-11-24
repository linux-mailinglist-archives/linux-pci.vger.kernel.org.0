Return-Path: <linux-pci+bounces-41930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC4C7F62E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 09:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77FD8344E9E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D225F7A9;
	Mon, 24 Nov 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMXCiXOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A025EF87;
	Mon, 24 Nov 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972927; cv=none; b=lGItb1JXkpQQ/H2pv7yOMMRdKe/Zy5gFKzG6quC2tUpCyhvLxo8lIGD++siYk2X9vXvO5YKKuzMWbnPXHuQeXkaln4/EueFboELVPU38cuWPxfYir4yLDMfgCw8LsE+Zur9mKrkTqNYNBqWl2fYzLqZ+glMaRl02kSCb9JXeKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972927; c=relaxed/simple;
	bh=T+MPGyJriR1QBClsWWwkOpi+qR0ocPEU1Z7hsuWSSiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FcC41yG5MeegTgvMxHhkPRRXImTxDl9+Go/qDR6p8xR0IpeaG+u0FTD67lJV3Kf6Di3kNF1c4zjY3OHc6ChK8+zvkQbwX5sdnclgzmIe6zPmN06dpCulc3IVYoM60tyQGXMSoZTaZtwtv9oP4yX6to8U/Jx3VG4QhgJ8Dsau8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMXCiXOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2BDC4CEF1;
	Mon, 24 Nov 2025 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763972926;
	bh=T+MPGyJriR1QBClsWWwkOpi+qR0ocPEU1Z7hsuWSSiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UMXCiXOunP9qrY+cJl3V2GxBKEcQ5LWV6YoWhqw3NnG4I8HkHc2YhDwNjSxWpv2vr
	 5YU7olXypGz9sXJkztfarx5lTI9NMaXFE3j6svmbZxEAkAH7o5KyIawMQFamFKEU7C
	 N0rk4Nyv+/CK7KduzjmTOMQMimuYRCH9QIoI0ooMeEj7E/e25EwVAKxEutCLB9GU/u
	 wwFktzNVz21GhHtCV0K/I/8WiH3cfmz9gHacUg6AatcdM08nszOsTq5J85cc3s/oYH
	 Fn59NNJhA/UE0s0yuxpeD/xFQzQ7VFVADS58DkmjLsRMuyhc+SrpqNp4MJcSp3R2O7
	 RtQ9Mct5vq/0w==
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
Subject: Re: [PATCH v2 08/11] coco: guest: arm64: Add support for fetching
 and verifying device info
In-Reply-To: <20251120175432.00004af8@huawei.com>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
 <20251117140007.122062-9-aneesh.kumar@kernel.org>
 <20251120175432.00004af8@huawei.com>
Date: Mon, 24 Nov 2025 13:58:38 +0530
Message-ID: <yq5ay0nvltqh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 17 Nov 2025 19:30:04 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>
>> +		return -EIO;
>> +	}
>> +
>> +	dsc->dev_info.cert_id       =3D dev_info->cert_id;
>> +	dsc->dev_info.hash_algo     =3D dev_info->hash_algo;
>> +	dsc->dev_info.lock_nonce    =3D dev_info->lock_nonce;
>> +	dsc->dev_info.meas_nonce    =3D dev_info->meas_nonce;
>> +	dsc->dev_info.report_nonce  =3D dev_info->report_nonce;
>> +	memcpy(dsc->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST=
_SIZE);
>> +	memcpy(dsc->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST=
_SIZE);
>> +	memcpy(dsc->dev_info.report_digest, dev_info->report_digest, SHA512_DI=
GEST_SIZE);
>
> So copy everything other than flags.  Any reason why not flags?
>

The flags field currently carries p2p_enabled and p2p_bound, but these
aren=E2=80=99t used yet. I=E2=80=99ll drop flags from dsc->dev_info for now=
 and
reintroduce it once there=E2=80=99s an actual user.

>> +
>> +	kfree(dev_info);
>> +	/*
>> +	 * Verify that the digests of the provided reports match with the
>> +	 * digests from RMM
>> +	 */
>> +	ret =3D verify_digests(dsc);
>> +	if (ret) {
>> +		pci_err(pdev, "device digest validation failed (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D cca_apply_interface_report_mappings(pdev, true);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to validate the interface report\n");
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}

