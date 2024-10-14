Return-Path: <linux-pci+bounces-14434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9D99C548
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A41C225BF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5515820C;
	Mon, 14 Oct 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtFuW5uC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3315531A
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897041; cv=none; b=PPiHO3W99+Hz/93C4u1cxpMRweGoTM6LauIUcxxMyGnInTeEHtH73+oMzQt81ytv//UCsq7pfbGDX1uNhpGzZAz35UUG5UmtG1VDdtPiOA5zvV+Dy816ORfviZ+Uk9h2lXISjg2NPVQP8bjG6YaSbavTznvLHhE+Bl1VZUYJTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897041; c=relaxed/simple;
	bh=trSRhS03qp4HKvL2dERLbqHVvB36sFOgTjMjlWIPVuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTuDqHv0sOf/MXEXWpUZPrRzm25iVbLm0pSR3m397NJporzGRXvmIw0AD2gBxK+fKqoVGRtDCoU00abWgAJ15+WQU+pl13euFLhPJoSwcmZgJIx+vUDrn2YNlBdkRLariecSmD4k5bGJKYVeizdharS7h9pIgZbtezJ7t2GRLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtFuW5uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCFC4CEC3;
	Mon, 14 Oct 2024 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897041;
	bh=trSRhS03qp4HKvL2dERLbqHVvB36sFOgTjMjlWIPVuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XtFuW5uCiYp7xKZwDdaxhC1273sMW+l6VbwktiGz9lUaAAg4emkH2wQfmRnCavdkD
	 KqS631jpHLYiV3m2bugF5fx2tsb2RHLX3NPJUvSyzO3KT4blNSmkBy2uHW0d/IW8lN
	 KOT7CTsY+vtgoIETjqiYlZYpms7vDj8UdiO5LdrfjvtZm6DZ6q+SM+8hrutVaS7Puj
	 sOUrevOdahGVztw+riR9FifEiFEpsaC9vrWJBsEqoJRMPgEVstl7kLrU3QiEVWARgI
	 Htbu+EAKTgFYR+QfBiU+6byHzoRKRoo1XbTNUxsBa+rMRIRaNRg/0n1dHS3HP/yWCz
	 +RZA/I2mbv5Ig==
Message-ID: <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
Date: Mon, 14 Oct 2024 18:10:36 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-3-dlemoal@kernel.org> <20241014084219.GA23780@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084219.GA23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 17:42, Christoph Hellwig wrote:
> s/nvmef_create_ctrl/nvmf_create_ctrl/
> 
> But evem looking at the code later using it I fail how this could
> work.
> 
> nvmf_create_ctrl is used to implement writes to the /dev/nvme-fabrics
> control device to create a fabrics controller out of thin air. The
> biggest part of it is parsing the options provided as a string,
> which most importantly includes the actual transport used.
> 
> But you really need to force a pcie transport type here, which
> as far as I can tell isn't even added anywhere.

Nope, the PCIe "transport" is the front-end of the endpoint driver.
What this patch does is to allow this driver to be created by passing it a
string that is normally used for "nvme connect" command, which calls
nvmf_create_ctrl().

The entire thing was created to not add a PCIe host transport but rather to use
a locally created fabric host controller which connect to whatever the user
wants. That is: the PCI endpoint driver can implement a PCI interface which uses
a loop nvme device, or a tcp nvme device (and if you have a board that can do
rdma or fc, that can also be used as the backend nvme device used from the pci
endpoint driver).

I only need this function exported so that I can call it from the configfs
writes of the pci endpoint when the user sets up the endpoint.


-- 
Damien Le Moal
Western Digital Research

