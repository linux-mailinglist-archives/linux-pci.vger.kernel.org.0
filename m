Return-Path: <linux-pci+bounces-12848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4EB96DFEF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35DDB2602D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11D19C579;
	Thu,  5 Sep 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNI+4NZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAE15350B;
	Thu,  5 Sep 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554245; cv=none; b=DV6tY9A2KSrUzj4z+ZIRNVO9/uE0wBaqHPXVfhLIugJUn0YGeVj5bTgCXaiLPm8PWRT8Kz/r/XkUWy+YweUGjdXPbKdycWnmc1h1UfCQU1JGLHvFqz+rSXZ+hFoma0Dm3+hii5RN3iUH9R5+MNOqSg6GtXOd7tDlkR3w7IKFhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554245; c=relaxed/simple;
	bh=E7v7Z0HlMLoNmX+DSerGozz5C0bXNePfRQsND3aKEqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B+d8A87QyaaFmPT5MeZz+bpOMwsTjXXKVow/MZFEOiQ15FSe17fchVxpVWOYdKcO48oPLpibCZlJebBmhc/8aGiN088OGq0pO3H1ZLn0KNvxQNo28SfcZuKPeqUpjGQCf3dEwn53WMpgRJGCbxvLXG8NPORn5m07PwQh1UgmU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNI+4NZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4488C4CEC3;
	Thu,  5 Sep 2024 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554244;
	bh=E7v7Z0HlMLoNmX+DSerGozz5C0bXNePfRQsND3aKEqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UNI+4NZTyYpjBLGk5ZuvOV4qi1M+tlz0PfnqWy8pTqeIU0VTy1gIiTpaOHpkNovXE
	 3+1QqpFgnxK3Eay0HqpTkRRoRuZSMfF20tR1LMNQ7ES73dlg8x23plJ1iSnsXov7H7
	 zVVQi/kzgmXTNgi3QJMiVrYBKXydwXdCtGEy5HFakbNp1RjzBdy+i+w62R7otsiFRD
	 TndtoXjYe2EsL4X2JRLYnYdvcd3CnHH86KOB2Xo0vFjFrSYvDHcmrdfta10Jwlf9Kg
	 lH6VZxc6frknBuBWoCC/C5WF77asi7Kv2F6zfiFg1koyJQyCNgIPR9w0FTZAInhpw2
	 LiB5ZRbUJ7NcA==
Date: Thu, 5 Sep 2024 11:37:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <20240905163721.GA390911@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>

On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
> to specific regions of host memory. Add the optional property
> "memory-regions" to point to such regions of memory when PVU is used.
> 
> Since the PVU deals with system physical addresses, utilizing the PVU
> with PCIe devices also requires setting up the VMAP registers to map the
> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
> mapped to the system physical address. Hence, describe the VMAP
> registers which are optionally unless the PVU shall used for PCIe.

s/optionally/optional/
s/shall used/should be/ ?  (Not sure that's the sense you intend)

