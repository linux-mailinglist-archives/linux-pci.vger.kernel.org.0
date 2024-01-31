Return-Path: <linux-pci+bounces-2892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A6884470F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 19:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F1B2556C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1612FF91;
	Wed, 31 Jan 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrn0I9gm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760812FF78;
	Wed, 31 Jan 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725387; cv=none; b=oDqlLAXT2lTALKlb2Frja4mooM7sA0j2IEvkXr392XR0DfTpT+3/sRwfxlxxtDna0UYwgIXtimNP+YyT7ewpvLJcBKG0ZZ5t2NqxDrOufyNgvKi7vN3SZW+HHxj6jeVp26lg3VuKunlmHuZqmpCljqNxJoreAfgM/5WHANtGn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725387; c=relaxed/simple;
	bh=qk9rD4Rs0rTn7ErsxotAWyhfe4whNmeXkFGBtrf5pIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KAYgil1ZkOXkxoxG7GuPcTzEGAaxwkMaW6Tv44UArOzj4muC/ZKc8uCerOAFJZZ8xLrlc8MMHPyEgUKXHAq7+UvmE3gpbKuBVgeVoDrUpzFYFMwxe/PGUxF0NGHbdtFjSrDtHFHXnU/ffPO64W5Zr4uZ9gzVxQM99viKS1MCbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrn0I9gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A01C433C7;
	Wed, 31 Jan 2024 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706725387;
	bh=qk9rD4Rs0rTn7ErsxotAWyhfe4whNmeXkFGBtrf5pIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qrn0I9gm0jmbjGT09UU2RNg94S762XZ8sFi9eOaICW1cRDn9C1K+aj+XqV709CBBi
	 yw5Lk7k2ZiPRiHWmanCjHX15vDMfAD6f8NNrT4W4K8KTNaXlqI95IHjn8/APbiyW14
	 25gztGsM2nTm4dXeBdNZb5kj/T5hoCXajF+K8OJuoUQT9gzCQGSgCXOFG2LvwwYvyJ
	 f1fsSLW+m14YZpZajoO4T9p9Yb/Yt1DtPNpD8tNlPxGQ8uR2giixM+KtbKpulTRhx0
	 lYw51sy3K3ME9yeZ4IPy+O5xjT1ztnfoYmBKpgMaIoyp+/AT52XOVCHxgFt8BkRSe7
	 bB8J8EdGSRXJw==
Date: Wed, 31 Jan 2024 12:23:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 2/6] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <20240131182305.GA592553@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbptka6O7T1tdTuZ@lizhi-Precision-Tower-5810>

On Wed, Jan 31, 2024 at 10:56:01AM -0500, Frank Li wrote:
> On Wed, Jan 31, 2024 at 09:41:15AM -0600, Bjorn Helgaas wrote:
> > Nit: could the subject line be more specific than "change arguments"?
> > E.g., something about collecting dw_pcie_prog_outbound_atu() arguments
> > in a struct?  If you know that's the fundamental change, it's a lot
> > easier to read the commit log and the patch because you know the goal.
> 
> How about 
> "Consolidate arguments of dw_pcie_prog_outbound_atu() into a structure"

Sounds good!

