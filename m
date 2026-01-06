Return-Path: <linux-pci+bounces-44097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB7CF8539
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5024F30223C1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916B309F1D;
	Tue,  6 Jan 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5x29lis"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9D2DA749;
	Tue,  6 Jan 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702818; cv=none; b=hD3SO4B+Ue8yz8IOrGha/Au29Jq1yT/XnWtH28Als6+XiV4IVf6MVeb2CCWEocP03uZCoOtMfY6nryfwAJqw4/US5+4a3yvapjl7HbU1gI+Jo5eZqDsi4ykan6zV9kN6uKiLQFTiaRwsOhwKWxECISyy7tD9SuVEBYlk/WYu/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702818; c=relaxed/simple;
	bh=NKuQ4J3vb+AcCMJEqC24muJulnURcfe4CSmdUQXNKfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VgWmGj9UhvjVveD9eR4amePFFupmYH/7Kp+8OurPfWw6UfIB8wYNQM73t6RV/SI7b2V6MZuzs113YrhQNWCMYzTbLbTCaao6I0gr6nIdR1yRwpMFjn3mOxNEjF2ueFYWzN6yhbyVCB0W+0hLwqk4P5TLjvOAT9ccminJOcFqbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5x29lis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1E7C116C6;
	Tue,  6 Jan 2026 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702818;
	bh=NKuQ4J3vb+AcCMJEqC24muJulnURcfe4CSmdUQXNKfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K5x29liscaKk4hONEVqhfurTd2AKG7woXd/gwx3JcEBvNv8xbPo6tPOYRszcBe8vb
	 OihxRz6+XjuVUXu0ecZMv205pM1WM93HOz5Tk44DIXJB3nokFCny0ZR9VYJQ3zu2KY
	 qeK3TLkR0FrVKQecRyabAcl6QPZ1eRb+BXL8szS1uR8KzR/RPk5ZxOKj7d5eU9doFv
	 OtyIGLdkJ1DKRHNZhvpSMUaaUUwbNhI/kCaFPSR57BctuvJZQjm43vbw6kWgAbYwOh
	 t3Ty9v6xodGPsBSdQKO1BhR7J+v3gUKtBZxQ3wLBooUn9UU1yi9RptVQ1dRtNQtK98
	 HIjefj+fNxnRA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RESEND v2 02/12] firmware: smccc: coco: Manage arm-smccc
 platform device and CCA auxiliary drivers
In-Reply-To: <20251027095602.1154418-3-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-3-aneesh.kumar@kernel.org>
Date: Tue, 06 Jan 2026 18:03:27 +0530
Message-ID: <yq5a1pk2kjjc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Mark,

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Make the SMCCC driver responsible for registering the arm-smccc platform
> device and after confirming the relevant SMCCC function IDs, create
> the arm_cca_guest auxiliary device.
>
> Also update the arm-cca-guest driver to use the auxiliary device
> interface instead of the platform device (arm-cca-dev). The removal of
> the platform device registration will follow in a subsequent patch,
> allowing this change to be applied without immediately breaking existing
> userspace dependencies [1].
>
> [1] https://lore.kernel.org/all/4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.=
com
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>

Just a gentle ping on this patch =E2=80=94 any feedback would be much appre=
ciated.

-aneesh

