Return-Path: <linux-pci+bounces-25596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42785A831A2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C80F1897C41
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0821127E;
	Wed,  9 Apr 2025 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra99G1Pf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD4211261;
	Wed,  9 Apr 2025 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229467; cv=none; b=mSO9P++ELY8ardbvFJhkHO7uoCT6NZ2SlNOm2cvlqnI/TwozYUJKFfGh1UgE92XFgvyhLehVoF71KZHFc0/gTU4LUMKFZmNEUqeqfg4hKwpqzkrYUDKJoWxyJtPtn15sJa4KkmV3D9A7I5vCn7iG/7z3alkdrL1qrZFS/1+CJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229467; c=relaxed/simple;
	bh=0e4FkhqyEYt7yqEDX5mzHFyo+DedyZnaA98fEUnVjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hwWi5LqmcRXg2I4KL41o/ClzB+uPLlcm77T1+C6W5lIDUIi2HS1vNZMSqJYu8URCjUZ/Er14XFWRoRxkHKXtt4OxBbaArXBjrlGh5+7tx6K6Hvgu3PCEnNjr69q/PREYbeKsnfcWEeuQR76xrrwO4sdNOOV37cDCtRYCpYNIbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra99G1Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178BAC4CEE8;
	Wed,  9 Apr 2025 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744229466;
	bh=0e4FkhqyEYt7yqEDX5mzHFyo+DedyZnaA98fEUnVjQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ra99G1PfH0mlQl/VvEl7lYnGVufgYLzq9Zt9O6BLMeY1V4NySIUGR6y/NiQr8ZLYW
	 N69ZO91wXYEbLNtWPY8wxT7AuXEAzO78u9G+0psZ1kMSKYKKxcaMXJfnEwelHhlH9m
	 dRh8uznYDtXA6yGSe2/veKd6CDf9UzAOieEYzwbgVmcAsLEaJvfRnP7ZzN6A6UyQmI
	 mMZlDun1fLrYbU/Q14hat91MBSASXC7An31Bo8dNANFOhT16ssBDj5pgYsdom7rygK
	 7W5qS0Ncj+/pgKC2pc8axYwJKdkQxO+gZ1qfdS4l4KYCnQADF1P1jftCxmNmNPpRD3
	 9laeGltrrdgog==
Date: Wed, 9 Apr 2025 15:11:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Milind Parab <mparab@cadence.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Enhance the PCIe controller driver
Message-ID: <20250409201104.GA295084@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 10:59:08AM +0000, Manikandan Karunakaran Pillai wrote:
> Enhances the exiting Cadence PCIe controller drivers to support second
> generation PCIe controller also referred as HPA(High Performance
> Architecture) controllers.

Usual convention is to include a space before "(" in English text.
Apply throughout this series in commit logs and comments.

Others have mentioned the fact that we can't easily extract the
patches from this posting because of the Outlook series.  That also
makes it harder to review because we can't apply the series and see
the changes in context.

Bjorn

