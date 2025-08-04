Return-Path: <linux-pci+bounces-33342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC8B19AB5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A223B42FC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E761A2C11;
	Mon,  4 Aug 2025 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5NkdEa8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030017BA9;
	Mon,  4 Aug 2025 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281352; cv=none; b=SuNeg3kX37W86kDlYFZigRpp2GxNuHVsaNUXfXSMeu06Pjm01gmi9uRlhWKQ3zfC6ZhNizPRzmjX37mS4b1bsWz6hD4cuNzyfO4qXrXSuMpdpSywSYhrdV2RA9NGe+UB8TY9yVZk+6NqYAPspODIoerXVAQ/eejOYtmr2jHr6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281352; c=relaxed/simple;
	bh=yp4jlZtOZv8kbYVea/DbhZgPx0okCBgip5IWbH1WmLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GUGZ5g2XBmS5cI1Qx0xBq7HFVU0wImLJgCTM4c1o8g9Z6woSpNxaafi64C/7M/WLSUJhdlH3EqkLVgjQ6LVCA2GI/oBLUGjcu53gmCnvY1/bS2LjKwQ0cccs2sBKDigDGXjl8L4d+0b5W2W+TgDo969ekBhvRjenXmq8LLccMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5NkdEa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40BC4CEE7;
	Mon,  4 Aug 2025 04:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754281351;
	bh=yp4jlZtOZv8kbYVea/DbhZgPx0okCBgip5IWbH1WmLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y5NkdEa8qg8OIjCScOtvSiciAyN5GHJyyjZOpvnpWsSREB9+RZ25BnTQDdNJNLcCD
	 XObYSzTVSy66OFI+NKxG0AxRucMmRWwq4mjkVFEtFfjQDvfejK8ZUIxTP/DUUbX8cA
	 pcChbrQoZne4qcTCq2jQPKnnYc07YLsUJMTyf9A6YLT/LijRektCqFzZ4KdbXZM+wJ
	 i2892BvG+RoJrFD5v+iT2A/T4YWM/5xlHf19R2ZxGZIVUBCX3dYnY/iLZaY4rj6USM
	 sSh+cM0MUV2yIGCikbVc5KmwOD4y/8H2cZRjAg/HCte3FH62cYCRZ2gHo7ksfGxXYY
	 5rAUFtzRNeQag==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 15/38] coco: host: arm64: Stop and destroy the
 physical device
In-Reply-To: <20250730145708.00005181@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-16-aneesh.kumar@kernel.org>
 <20250730145708.00005181@huawei.com>
Date: Mon, 04 Aug 2025 09:52:24 +0530
Message-ID: <yq5a34a7af7j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:52 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Add support for stopping and destroying physical devices.
>
> I think it's an odd mix to not do create and destroy in a single patch.
> Same with start and stop.
> Leaves reviewers thinking perhaps you weren't cleaning up properly
> an any error paths are much less obvious.
>

I=E2=80=99ll fold this into the patch that adds the `pdev_create` functiona=
lity.

-aneesh

