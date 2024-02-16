Return-Path: <linux-pci+bounces-3651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98B85890F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FE0B2D4A7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09411487D5;
	Fri, 16 Feb 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/S0GOyv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C512E74;
	Fri, 16 Feb 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123271; cv=none; b=lw1yNDX6zb7+XlrSpeHVS83/LkPq5WFN1NQjThzk+xTQtGpo5okHf2dg71TlmIkW9tjn3/IsVwFDtPLbZRC678Shrc0voy5xr+RiRbuxNLdbGzg4ZIDV4ZBfibjMNOz86aiSlByW+iioMApdc8KSXhyd5eXMFfw9ImsMNDbSP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123271; c=relaxed/simple;
	bh=e292qJjQFhsZInQ0eRF1VBAbrsLKErhBvqmnPaxMUtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ahZgJY34EUzYFzOgK6AfdLedAHyInuA41/0PCM21ZvHDfwoiVhM37dY6xxoaLcaiBWUeE2IX3cm3Jzx2Uzw9vJ40iXitxhK7ZfgwgnwJtsGtjbQFMA+hukeOrHYn1TndQYHjdwzFtuthJygV41tutTQb8cjC2UhnRuZ+cYQA3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/S0GOyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE0C433F1;
	Fri, 16 Feb 2024 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123271;
	bh=e292qJjQFhsZInQ0eRF1VBAbrsLKErhBvqmnPaxMUtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H/S0GOyvcwX5ymu0NXTl3ebsLPbUjjiTMAAyQeu/Dn8pOffXw+BwP+/1QCBjEje2H
	 WHL5UEhomle+NebgM8RW0wAsfVDcoj40ej6Dvy14fAKRxEhZ3d2tbuS8Y9dCJ/Mtsd
	 SXyPod30Dsbi80cdARV+OjxnYJnnf0DaNajdehIBSERAtXx4pjMxWjeOY49u4SmI2W
	 rJflmHMljPoeufDIw7SlAPdVKMAEfEoe6qouiW2WVWiyyKbtcJ8B9rFmC8WPgO7NXS
	 74W3kO7g/c+63IfY3rxCjrOkTTlu8D+vuPaPGmRvLDVFTd5B90Ljk+ipAC5n5NCkWt
	 uGD4ilsbSjL2A==
Date: Fri, 16 Feb 2024 16:41:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bean Huo <beanhuo@iokpp.de>, bhelgaas@google.com,
	schnelle@linux.ibm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Increase maximum PCIe physical function number
 to 7 for non-ARI devices
Message-ID: <20240216224109.GA1359930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4858e202-6097-493a-8405-86d3e8e17c83@linux.intel.com>

On Fri, Feb 16, 2024 at 02:26:47PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/16/24 11:01 AM, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >
> > The PCIe specification allows up to 8 Physical Functions (PFs) per endpoint
> > when ARI (Alternative Routing-ID Interpretation) is not supported. Previously,
> > our implementation erroneously limited the maximum number of PFs to 7 for
> > endpoints without ARI support.
> I would quote specification reference here, like below:
> 
> As per PCIe specification r6.2, sec titled "Alternative Routing-ID
> Interpretation (ARI)", up to 8 [fn # 0..7] functions are allowed in
> an non ARI capable device.

That's fine, just know that I silently convert citations like that
to "PCIe r6.2, sec 6.13" because I don't like having to grep for the
text ;)

Bjorn

