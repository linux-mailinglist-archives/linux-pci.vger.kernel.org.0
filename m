Return-Path: <linux-pci+bounces-42431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E67C9A00D
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 05:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56F13A3FBB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE902F5339;
	Tue,  2 Dec 2025 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBqd57c8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894E281369;
	Tue,  2 Dec 2025 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649470; cv=none; b=oZBvdIgJnUUO1U5oIrP2uqhx9RYo+pr9OmfTJjsbBMCMq04/dvCZI9hZko/rYUeYG8YctuqfImzwjJ6qS801wfNbfTeS2bm5YW0+Rat/IU0ARxTo17wa+xaGXvwhclyC94LFshwU8/YYLELtmfejQelgITVg5s+29jzbTiIMJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649470; c=relaxed/simple;
	bh=cRg/1CaqqZPrJW4h+GCNv/Da8WjfkimOPAM7FixK0Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoveRNPII+fxG/3sTMKV/h581O4ZSm9fNZqr0It+hqZ+nsFN1jMmiBEZIiybOcsxCDdaEia2WRfUkuxCRSUV6GGs6pkPGYkDrghV+XfY4lObRoXMvo/WdjqKzybBt1UVRxEadQU+kMKak3RwEF5Ua/uAMAD/wPCMN+3IRI/6YHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBqd57c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A4C4CEF1;
	Tue,  2 Dec 2025 04:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764649469;
	bh=cRg/1CaqqZPrJW4h+GCNv/Da8WjfkimOPAM7FixK0Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBqd57c8AVkKeH5vatUw0RzirAcI6+nz/gAZJGANUWKWmymfiWuJH1UbJBO0hnHy4
	 sdfid1ppnWyOuev1UqMxR736qxw+jPN/BpvsbsXHs4fnso32QuWW1zrCINxVHAqqoF
	 yNfFsx2Ry4lLfn8aP8oaZFn3fwnbU4Et2OP90YJJkDe6D00NXGfmc54dnx2fsHQnkK
	 zaHjhy0MSBfNafYH+EQ1XJcanzQJe5MPU2qQR5+vUJAHVKoe2UAv4idpGgywWZD8Ou
	 qFOySg4ZwIVAn+NaHxFWvMOevkrxk2eLBTKSsowmi56KDSQci6jbODK7DfwH32rrZq
	 f+dLhGrxKtUcw==
Date: Tue, 2 Dec 2025 09:54:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	NXP S32 Linux Team <s32@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
Message-ID: <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
References: <20251128162928.36eec2d6@canb.auug.org.au>
 <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>

+ Vincent

On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> 
> 
> On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20251127:
> > 
> 
> on i386 (allmodconfig):
> 
> WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)
> 
> 
> -- 
> ~Randy
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

