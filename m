Return-Path: <linux-pci+bounces-7568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C48C74C8
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FED287157
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438014534F;
	Thu, 16 May 2024 10:44:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B79143C4D;
	Thu, 16 May 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856254; cv=none; b=W1XaEEPZnTipeJ+afJBez0H/zlJFJCPz560AsL/0d4LkHELchwr70CQ1G94k6PQGrdA5h7yuv7tWMAqOgbZmAUzNdpIOLKOYerkwOnH+DTuJpH3pLCAD9N48ryeUKwCO4WtHkiQIcFrn2OAgehdhy5KRdn2YP5S0qjIxGiJz/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856254; c=relaxed/simple;
	bh=S4/6fMot0IIvuBHOvTWsbFm5x41qkoolMUSi+NhgXHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0N6A0O352EY9P+suNWRjOQOXcJfotWIm8sC5YN0uxocu058BRLXunk5uR9yuY+WHEMOeIKSsgFD2/Qp+l9C9WLjc7//bq850wb7PCF7StvAtjJm7t772hgiUpIcwnaaTUxtmbWFo4ljTXTArGyH+WAZKnVEYEMHCKo8B9/EpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15657DA7;
	Thu, 16 May 2024 03:44:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC8F3F762;
	Thu, 16 May 2024 03:44:09 -0700 (PDT)
Date: Thu, 16 May 2024 11:44:07 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, liviu.dudau@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	ketanp@nvidia.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Message-ID: <ZkXjdzLGH0wy1SJz@bogus>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-5-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429113938.192706-5-jean-philippe@linaro.org>

On Mon, Apr 29, 2024 at 12:39:39PM +0100, Jean-Philippe Brucker wrote:
> Declare that the host controller supports ATS, so the OS can enable it
> for ATS-capable PCIe endpoints.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

