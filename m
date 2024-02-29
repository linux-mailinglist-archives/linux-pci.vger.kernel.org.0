Return-Path: <linux-pci+bounces-4281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4F86D426
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FBA1F22F75
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5413F45F;
	Thu, 29 Feb 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJPC+Knl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039C13F454
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238414; cv=none; b=JwAta60myqZ6xH9iWGh/KQE0utMfIolPr/ueZHvZAeuEFzq5UADI+wqDBK7DE4A07BcUxpWWCIMQfvTQ9gZYUFi9mYR7laBtmWfZBDsfPkFmO54Mzyx/TQO0i4Mnf8LxTpOA90NxfWK1jt/OC5XFp8OvjbKENJMsMhe2sRyxWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238414; c=relaxed/simple;
	bh=oBtQF9LQszqkpR8tCO9pxz+eaYYzsw7xrDPp+hqrlzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bQW7SUCeKpi/fKqhLmxPkUq9s9ROnlFMUbcStM3bdQcSJIFjDQd1Y3mHneB7C58r0RPGgdgh8ZTfJgGskemE4Vx/2U1kvvL98Tq2jykkfTPz2LsfrHKH1DufhZcjJodE6Vr9HXpQ9IlGGdFHaVAAMZOsyNIL6rvgFYzMkyTJe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJPC+Knl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92DC433F1;
	Thu, 29 Feb 2024 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238414;
	bh=oBtQF9LQszqkpR8tCO9pxz+eaYYzsw7xrDPp+hqrlzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rJPC+KnlHlltF3BfOn/F2gP4Dqbgi2OFKHkpvhMP9ACo4CrTG9pMNUCPO1LLEti2d
	 IFtKA0Kdc9olbP1VWhEfToL74qEmTi3e/Pwz8xajptnyCiZWIoDc6abF0FuwsbOOWR
	 da1BMLBTF2CZg7r8VaW6dxJDcN0CX1y0SERqCjZtr1gb6I+AgQ1XLJ3kA9O7wuolTp
	 h9KTB0u2IIwoV5nxamYNotFsAxUGJM4IOEf6zj8s4iUCEBIzTE9VJNqjIyafcOWel9
	 mBwSDhxQjJF9DICV/Wx7e49FlY39gk1B1B+49doXg8uJ5Kmtot/noPesDsy98EU47t
	 rdlkz09u0DHng==
Date: Thu, 29 Feb 2024 14:26:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: AER: Corrected error message received from 0000:00:06.0
Message-ID: <20240229202652.GA361290@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67576689-23ff-4e32-a93c-5bebbfc647b6@aixigo.com>

On Thu, Feb 29, 2024 at 03:52:36PM +0100, Harald Dunkel wrote:
> Hi folks,
> 
> dmesg shows these messages I am unfamiliar with:
> 
> [Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
> [Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
> [Thu Feb 29 13:47:22 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
> [Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
> [Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
> [Thu Feb 29 14:46:56 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
> [Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
> [Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
> [Thu Feb 29 15:04:33 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
> [Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0: AER: Corrected error message received from 0000:00:06.0
> [Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0:   device [8086:a74d] error status/mask=00000001/00002000
> [Thu Feb 29 15:27:56 2024] pcieport 0000:00:06.0:    [ 0] RxErr                  (First)
> 
> Is this something to worry about?

Probably not, since these errors are normally corrected by hardware
without software intervention.  But we do need to improve the way we
log these, so if you could open a report at
https://bugzilla.kernel.org in the Drivers/PCI component, and attach
a complete dmesg log and output of "sudo lspci -vvxxxx" to the
bugzilla, I'll take a look and make sure.

Bjorn

