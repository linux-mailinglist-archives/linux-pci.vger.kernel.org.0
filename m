Return-Path: <linux-pci+bounces-9124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2291356B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA2B213CF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EB182C5;
	Sat, 22 Jun 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOtV/Hd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4B182D2;
	Sat, 22 Jun 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719078114; cv=none; b=u3rSIGWrInyf2jKATvHgh3+tjpZNTKaNQkU0bxIWQcymomwLhTg3BTQ1PFd8mbwzJzdVGlJegn1irzigGdTKmMU767M25q0GrRe4SYOLCU9ZK32FGs4Yizen0p4CgPluIawZGTmxQkxnZeTSwyoNEc5JIpPlieEkaSDD0lHDpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719078114; c=relaxed/simple;
	bh=RZ5LAEmzBnNGgd3UpEVbjbDwc57F7VOPS9Upg/UngfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V696rBYEQ7Dx96eyLqSSF4rFQsbBu/oJKEpLdG3YEz29Rdm91FAJDNb9Okcggb29w1CHYPk9sxp2q5v/EebO6eQrdXhzhbpX6WUaNJRMrhA4+LdcwN2bRuiby8wEugcdCZIQwdHCYtKsdAZZ0Kf4ayjAMs7eLujx2le0XPkVtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOtV/Hd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92DFC3277B;
	Sat, 22 Jun 2024 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719078114;
	bh=RZ5LAEmzBnNGgd3UpEVbjbDwc57F7VOPS9Upg/UngfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qOtV/Hd1R8oXoaExmi9nXBT9oevGv/U96wHKUIsbpA7OWkXF+/7GeQFrdTCp6Vm6S
	 gsOKqfSdU3lUzPl0ix2KdAXrQjxslZYPsqw6R0gpJpsJTrTucTPdLUVlg7gxhCG4F2
	 0vlVDq+VVHAVI79V2FxHOeFKuNx1kFsfPScEmWCDk8RFwUpeeUzfsV3ZIsRTQq37XS
	 LNE6G9zCLgUvua9loghitU3HGjc6ia9RUJnfpuG2b0Ay2lSp2mjlvMRWsZW7/NF0fK
	 NXFOgCm03Jw18EFd3lbK2st+caKmZJjsto1e7Mj4k/pjceGD3OTu69u9s6jHGHnfuF
	 eY++yOGg74bpA==
Date: Sat, 22 Jun 2024 12:41:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mrana@quicinc.com
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
Message-ID: <20240622174152.GA1432494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622035444.GA2922@thinkpad>

On Sat, Jun 22, 2024 at 09:24:44AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
> > PARF hardware block which is a wrapper on top of DWC PCIe controller
> > mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> > register to get the size of the memory block to be mirrored and uses
> > PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> > address of DBI and ATU space inside the memory block that is being
> > mirrored.
> 
> This PARF_SLV_ADDR_SPACE register is a mystery to me. I tried getting to the
> bottom of it, but nobody could explain it to me clearly. Looks like you know
> more about it...
> 
> From your description, it seems like this register specifies the size of the
> mirroring region (ATU + DBI), but the response from your colleague indicates
> something different [1].
> 
> [1] https://lore.kernel.org/linux-pci/f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com/
> 
> > When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> > boundary is used for BAR region then there could be an overlap of DBI and
> > ATU address space that is getting mirrored and the BAR region. This
> > results in DBI and ATU address space contents getting updated when a PCIe
> > function driver tries updating the BAR/MMIO memory region. Reference
> > memory map of the PCIe memory region with DBI and ATU address space
> > overlapping BAR region is as below.
> > 
> > 			|---------------|
> > 			|		|
> > 			|		|
> > 	-------	--------|---------------|
> > 	   |	   |	|---------------|
> > 	   |	   |	|	DBI	|
> > 	   |	   |	|---------------|---->DBI_BASE_ADDR
> > 	   |	   |	|		|
> > 	   |	   |	|		|
> > 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
> > 	   |	BAR/MMIO|---------------|
> > 	   |	Region	|	ATU	|
> > 	   |	   |	|---------------|---->ATU_BASE_ADDR
> > 	   |	   |	|		|
> > 	PCIe	   |	|---------------|
> > 	Memory	   |	|	DBI	|
> > 	Region	   |	|---------------|---->DBI_BASE_ADDR
> > 	   |	   |	|		|
> > 	   |	--------|		|
> > 	   |		|		|---->SLV_ADDR_SPACE_SIZE
> > 	   |		|---------------|
> > 	   |		|	ATU	|
> > 	   |		|---------------|---->ATU_BASE_ADDR
> > 	   |		|		|
> > 	   |		|---------------|
> > 	   |		|	DBI	|
> > 	   |		|---------------|---->DBI_BASE_ADDR
> > 	   |		|		|
> > 	   |		|		|
> > 	----------------|---------------|
> > 			|		|
> > 			|		|
> > 			|		|
> > 			|---------------|
> > 
> > Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is
> > not used for BAR region which is why the above mentioned issue is
> > not encountered. This issue is discovered as part of internal
> > testing when we tried moving the BAR region beyond the
> > SLV_ADDR_SPACE_SIZE boundary. Hence we are trying to fix this.
> 
> I don't quite understand this. PoR value of SLV_ADDR_SPACE_SIZE is
> 16MB and most of the platforms have the size of whole PCIe region
> defined in DT as 512MB (registers + I/O + MEM). So the range is
> already crossing the SLV_ADDR_SPACE_SIZE boundary.
> 
> Ironically, the patch I pointed out above changes the value of this
> register as 128MB, and the PCIe region size of that platform is also
> 128MB. The author of that patch pointed out that if the
> SLV_ADDR_SPACE_SIZE is set to 256MB, then they are seeing
> enumeration failures. If we go by your description of that register,
> the SLV_ADDR_SPACE_SIZE of 256MB should be > PCIe region size of
> 128MB. So they should not see any issues, right?
> 
> > As PARF hardware block mirrors DBI and ATU register space after
> > every PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary
> > multiple, write U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to
> > avoid mirroring DBI and ATU to BAR/MMIO region.
> 
> Looks like you are trying to avoid this mirroring on a whole. First
> of all, what is the reasoning behind this mirroring?

This sounds like what we usually call "aliasing" that happens when
some upper address bits are ignored.

