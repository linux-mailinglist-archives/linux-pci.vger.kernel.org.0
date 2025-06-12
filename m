Return-Path: <linux-pci+bounces-29533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33914AD6E2C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 12:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC94B1882CCB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3D1AAA29;
	Thu, 12 Jun 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO7KR46D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D754231A32;
	Thu, 12 Jun 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725206; cv=none; b=hC05j2i33x1uMcJ0QjZi81Lxv/ufcSCDyCz9QkboqW3QzmvLKJDUB2CZh2H8jE2hNL3zHUedYEz0DGyZEO2oa/OGlpg8ChU40JutA9FsMJVJaVVs0PpdhWGm9QOfg1LRks3lFeyYWBVTuSajOTzugi3K4R2EgMfsTts8vuuRayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725206; c=relaxed/simple;
	bh=6rmmiSB1nU3IQ0qw0+ckwjysahJXSea7GRNyqVg84jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bosuNaFonuA/yoa3JhG4y9ycAcXNZu+htItlMUPtDin5O5YzLbBuq/ZnRolOY+2CthTv/Pig3hHTIcKUjn9ohEFSyoPErmSvfFhBoFZKl05q3im8ZJUN831XIAiGOHGnzgjWKAMkceQvSjkVq8rmVznScgFbXTlRxiTD9/wFyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO7KR46D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA91C4CEEA;
	Thu, 12 Jun 2025 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749725206;
	bh=6rmmiSB1nU3IQ0qw0+ckwjysahJXSea7GRNyqVg84jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sO7KR46DWS7JVO+IVKFBlPk2axEZHUAA1mPsVrQhyIFlbSyq1ED1OzeAFJDimvO7G
	 G6BEIjTcIlUT/cKH20t6h/YA/87MVWs7mlZvrZzXPVTtscM2rfVY8KWOjeKlFNJRXl
	 DY/qc3yoiKfnWA3qiC8xH7zPh/3mNSCg/lZ+rFlQjJUFaeC0SYxHg8Ch0a2oZ/O3D8
	 pG2+WUdm7yq4u5ebZBMNa8hdL0RT+w5rdds9xDa+jKESw2xx//Z515r+P/b51IwZw0
	 r7X2GYvawtYlzqLha9iCrpyZ+8+cA3vWRmbuePGYiVMCW4UNtAFLg5E/bu1VvUdAY2
	 jMVYXidYHyTEQ==
Date: Thu, 12 Jun 2025 16:16:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org, mahesh@linux.ibm.com, 
	oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com, 
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v4 3/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <54nug57urubw5uhrwrdos3s3kta2r4qovzb6cf2mntc7kiora5@lg3p7vjmrvb3>
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
 <20250217024218.1681-4-xueshuai@linux.alibaba.com>
 <8a833aaf-53aa-4e56-a560-2b84a6e9c28c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a833aaf-53aa-4e56-a560-2b84a6e9c28c@linux.intel.com>

On Sun, Mar 02, 2025 at 07:43:41PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> On 2/16/25 6:42 PM, Shuai Xue wrote:
> > The AER driver has historically avoided reading the configuration space of
> > an endpoint or RCiEP that reported a fatal error, considering the link to
> > that device unreliable. Consequently, when a fatal error occurs, the AER
> > and DPC drivers do not report specific error types, resulting in logs like:
> > 
> >    pcieport 0000:30:03.0: EDR: EDR event received
> >    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
> >    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
> >    pcieport 0000:30:03.0: AER: broadcast error_detected message
> >    nvme nvme0: frozen state error detected, reset controller
> >    nvme 0000:34:00.0: ready 0ms after DPC
> >    pcieport 0000:30:03.0: AER: broadcast slot_reset message
> > 
> > AER status registers are sticky and Write-1-to-clear. If the link recovered
> > after hot reset, we can still safely access AER status of the error device.
> > In such case, report fatal errors which helps to figure out the error root
> > case.
> > 
> > After this patch, the logs like:
> > 
> >    pcieport 0000:30:03.0: EDR: EDR event received
> >    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
> >    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
> >    pcieport 0000:30:03.0: AER: broadcast error_detected message
> >    nvme nvme0: frozen state error detected, reset controller
> >    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
> >    nvme 0000:34:00.0: ready 0ms after DPC
> >    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
> >    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
> >    nvme 0000:34:00.0:    [ 4] DLP                    (First)
> >    pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> IMO, above info about device error details is more of a debug info. Since
> the
> main use of this info use to understand more details about the recovered
> DPC error. So I think is better to print with debug tag. Lets see what
> others
> think.
> 

My two cents: All AER logs are mostly error messages, so I don't see why this
one should be a debug message. But having said that, this new error log may
confuse users as if a new AER error is received post recovery. So adding
something that specifies that this belong to the previous AER error would be
good IMO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

