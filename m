Return-Path: <linux-pci+bounces-33095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09935B14A1C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF437A34AC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456327FB3A;
	Tue, 29 Jul 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6VZf41W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2C20297C;
	Tue, 29 Jul 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777742; cv=none; b=qdTs56Xjkus9fOjFboIauaSMQYzNqi6PvVPcBfck+DaQUFB+yNBKdztADSWNzBV8MXrvpo1kQPDPmcDjOga3c5FO6YBapfAbiOAvfxLEOqARbbdKeUnlu/STDGmaM8Ydwp7mws9+v75hMyYOPS1KF9qscSb97iMViH7qqmINRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777742; c=relaxed/simple;
	bh=K3BcUd/YctGhDw6vqaFn+ll0qNd9qomGN0pIy0wIoYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWnA+h6W5+zb0HRhPHLjYChPkzodYXnDImFvCsqJ0oBmRuRkONzawhfVCGIktevWGqqBmqRBWpSFyvIBuWS8YImSL/s+X3Yf+EwBJU2ko+PVQ6y61refHPPUlD27mVGj3YmNlwLwvOllMKVsSYW4QEN2UPSldhk3cZKLBDhBhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6VZf41W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC0EC4CEF5;
	Tue, 29 Jul 2025 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777742;
	bh=K3BcUd/YctGhDw6vqaFn+ll0qNd9qomGN0pIy0wIoYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H6VZf41WPH/OLHCLieY9YlBtbpK9t0RFg+/4zw2Qsf8pEmELzQMEkCDwM/IwvEF+P
	 Ks6UkkDJh2d+gRAD/PWOwFkFfmU61wTVBtb064Y4/l1LCcLU9CEozAEnk223qKCmiv
	 qjIc4QTogiEeTpr2MZfbtH8sj3O69THGjJQcePGQvXSmTgDQdRvXs9IZj/X6VfucTX
	 afgxX1guhR/UkjGjCMVdE+JITWmoWQW+IlN4sNKzx1KevLBeec1QXr8Jqj0B2wI+lP
	 szWqBlVNVCIHv1t14QZQH9SMapaH5pTyh4MfUplPaMJhrELUvvYS7QWkVYFkQa5lVj
	 G1JyxBmahzg+Q==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
In-Reply-To: <20250728140841.GA26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
Date: Tue, 29 Jul 2025 13:58:54 +0530
Message-ID: <yq5a34afbdtl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> Why would we need this?
>
> I can sort of understand why Intel would need it due to their issues
> with MCE, but ARM shouldn't care either way, should it?
>
> But also why is it an iommufd option? That doesn't seem right..
>
> Jason

This is based on our previous discussion https://lore.kernel.org/all/202506=
06120919.GH19710@nvidia.com

IIUC, we intend to request the resource in exclusive mode for secure
guests=E2=80=94regardless of whether the platform is Intel or ARM. Could you
help clarify the MCE issue observed on Intel platforms in this context?

-aneesh

