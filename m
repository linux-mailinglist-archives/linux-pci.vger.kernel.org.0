Return-Path: <linux-pci+bounces-39586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7AC1735B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF365405421
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BC3563E6;
	Tue, 28 Oct 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1hOEuv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCD2D1319;
	Tue, 28 Oct 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691141; cv=none; b=QCNjmiiygOzLvfdDpL+RUIFH8SKwnqMbPsHHUpnxTDtWQ2V6s8It+ArFE/Wy07DGVAxmJI2zpW6mNOM43PPEyjqXDJ1VKGa4RskWmhNeVS0786wVqMMGaZNtFRu2W11Qg/bb4kha3k1bGIU7QHoRFQUfEVpIwG9s7mSVV2pjF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691141; c=relaxed/simple;
	bh=4XDrRjgMgePVe6D8cwsvwDhjr3zdZYOD7rLj0NQPFK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DE8iabDYEoewEzLy/mOc5KXMZ8LJJbFOVLBpvZWfqdMpLKkklG45XvjMDqV7CyFReU3p3m2s9MFrUI5KsolBZsb+Nv0fWeU8MB1R3A1gswc2koqIsjVxkFHFqNhSZy6YxI/WQeNKTPeTal1fff/MbPkgwOMPfJTyJDeyeDZoJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1hOEuv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2114BC4CEE7;
	Tue, 28 Oct 2025 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691141;
	bh=4XDrRjgMgePVe6D8cwsvwDhjr3zdZYOD7rLj0NQPFK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z1hOEuv6ySMU+0QmtzomMmC788GmtWwDm0T936SEt9rozV/2nOdsJX8BVmmb89pZn
	 q0z7H+pyj5INp367mlS8Ffp/7vyQMIgdW83PF8jJMcYZ+ZIg7n0oE8Uw97WJ5Uwd0M
	 LxcLUp1Jc3TGdMJQw0NZr9fp3DFtqGc5Z1ns28A48HoJNJSh3iA4y6fWgq7T5EGHS6
	 6OBYA1c25InFp1umvyk14JEt3n1HEo/nl6gGW+k5uNNCQGoWuV+XSIc483hLBUK3LI
	 tgb8JZa/zbh2nJBHC3lgRr6nzOtBi5EbozdbcMfteT3X0zkAyMt9WVV6GG59D+4AMg
	 z6jNlS7GMRYjA==
Date: Tue, 28 Oct 2025 17:38:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	regressions@lists.linux.dev
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
Message-ID: <20251028223859.GA1538617@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bf478b8-2194-4ffb-aaac-8e3e314ad71c@w6rz.net>

On Fri, Oct 17, 2025 at 07:21:06AM -0700, Ron Economos wrote:
> On 10/17/25 04:43, Krishna Chaitanya Chundru wrote:
> > On 10/15/2025 7:33 PM, Manivannan Sadhasivam wrote:
> > > On Tue, Oct 14, 2025 at 03:41:39PM -0700, Ron Economos wrote:
> > > > On 10/14/25 09:25, Manivannan Sadhasivam wrote:
> > > > > On Mon, Oct 13, 2025 at 10:52:48PM -0700, Ron Economos wrote:
> > > > > > On 10/13/25 22:36, Krishna Chaitanya Chundru wrote:
> > > > > > > 
> > > > > > > On 10/14/2025 10:56 AM, Ron Economos wrote:
> > > > > > > > On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
> > > > > > > > > 
> > > > > > > > > On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
> > > > > > > > > > [+cc FU740 driver folks, Conor, regressions]
> > > > > > > > > > 
> > > > > > > > > > On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
> > > > > > > > > > > The SiFive FU740 PCI driver fails on the HiFive
> > > > > > > > > > > Unmatched board with Linux
> > > > > > > > > > > 6.18-rc1. The error message is:
> > > > > > > > > > > 
> > > > > > > > > > > [    3.166624] fu740-pcie e00000000.pcie: host bridge
> > > > > > > > > > > /soc/pcie@e00000000
> > > > > > > > > > > ranges:
> > > > > > > > > > > [    3.166706] fu740-pcie e00000000.pcie: IO
> > > > > > > > > > > 0x0060080000..0x006008ffff -> 0x0060080000
> > > > > > > > > > > [    3.166767] fu740-pcie e00000000.pcie: MEM
> > > > > > > > > > > 0x0060090000..0x007fffffff -> 0x0060090000
> > > > > > > > > > > [    3.166805] fu740-pcie e00000000.pcie: MEM
> > > > > > > > > > > 0x2000000000..0x3fffffffff -> 0x2000000000
> > > > > > > > > > > [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
> > > > > > > > > > > 0xdf0000000-0xdffffffff] for [bus 00-ff]
> > > > > > > > > > > [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
> > > > > > > > > > > [    3.579552] fu740-pcie e00000000.pcie: Failed to
> > > > > > > > > > > configure iATU in ECAM
> > > > > > > > > > > mode
> > > > > > > > > > > [    3.579655] fu740-pcie e00000000.pcie: probe with
> > > > > > > > > > > driver fu740-pcie
> > > > > > > > > > > failed with error -22

> > Can you try with this series and let us know if it is helping you or
> > not.
> > 
> > https://lore.kernel.org/all/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com/
> 
> The patch works good. Here's the log of PCI messages.

#regzbot fix: a1978b692a39 ("PCI: dwc: Use custom pci_ops for root bus DBI vs ECAM config access")

