Return-Path: <linux-pci+bounces-33403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D054B1AAED
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7A518A3165
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361628FAB3;
	Mon,  4 Aug 2025 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU4/hIaU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4323AE62;
	Mon,  4 Aug 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346504; cv=none; b=VfPB9zcg8JWFD7gtv9UCMeHg6KcNt3VsI3rare4q5EM2mEL2iEdIe7Al7ACE3i9lH0rRRDIFBZHlzRsQyLcPyq8KtOWyXuruAj9paEQvqSCTCrlxhBwmBl+XFxZCBL/ThjOAPtCk6nPmY7TzhMQjp1Stl+xrRFh5ERcnCmYC49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346504; c=relaxed/simple;
	bh=q4237OQdbICcheydjchcyh2EA8wjg3mYtLiH9eZRtWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iOSfvMo90QEjs5WrDnBESfNd9qPmCzmf7Cx87Z+sYp6tt27DIYle8Kcm1svQqK4ykHAhTnVedl3dxnVP7Ohki2aJKa6bFicsraU0Gz/PPhQWneLJPZ8xdiV/sLOk/bNgvQYk2zUS15MeQxAJOs9JBJoqnhzJLeezunDppudUOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU4/hIaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DBBC4CEE7;
	Mon,  4 Aug 2025 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346503;
	bh=q4237OQdbICcheydjchcyh2EA8wjg3mYtLiH9eZRtWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GU4/hIaU0WfdPkSg9xAP+5KDOEq5OtZaqUclyAnHfYy3MAdDJ0D5vhtXgfe+aulK/
	 NCMfaBUa+JyI7FlbVkSiL+RanggBwpTNO5BUwuB3akaBBxBodD6fEcRE7gFMMW0eWD
	 OgIntqtC6FAUM3q5axot4APChRsmgRLB4tu27lREMrqOV4lhrffwQjXcBzOr9lmH11
	 KghukrGkOYdgkq/28Dbp+7vJmIOWQKs9HeqiuoAUxeYYbulVQMYB623kYkBjJ/A0Lb
	 r3CffjTdFWGArOjpBUV4a5dBYOW3be+yWILzC8w7bm1aMeJ6GX19wgLyixT+grypr/
	 kkalhfYvyB4Ww==
Date: Mon, 4 Aug 2025 17:28:22 -0500
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
Subject: Re: [RFC PATCH v1 32/38] coco: guest: arm64: Add support for guest
 initiated TDI bind/unbind
Message-ID: <20250804222822.GA3645600@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-33-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:09PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add RHI for VDEV_SET_TDI_STATE
> 
> Note: This is not part of RHI spec. This is a POC implementation
> and will be later switced to correct interface defined by RHI.

s/switced/switched/ (or maybe "converted")

