Return-Path: <linux-pci+bounces-30070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B287ADF081
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860257A85C4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390A2EE605;
	Wed, 18 Jun 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKinX9kJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A72EE5F9;
	Wed, 18 Jun 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258630; cv=none; b=MNNCcdWAn6dhxDTQ1PO3vbLPeO5naFp3DPLXLTlYjGre+ee82Z1S1MxZNtOEjG5+hUZLTIUNrX6j0+p/VqxPjlfF6JAKEey4vUDPedMAvSVCXoGwjhOPKggLnVE5tfTlYofZqARwiWezfmMtp9bosfJPNrT+G+8ygKX7b2rf4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258630; c=relaxed/simple;
	bh=1Q6aOTiXFFTMQvJwg4MCx9dBoHXp49iL/WVCWF12SPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC7NCXOtXyQ4ykUiZhZ8CwGGXteJiKwdbGH0zu2UOyn3tL00UYJh86Wa1HJx0EwZj3hzO9LOJND8sNyDz9Y5PdzIpVGE+c8VkWpJKtw0xMNN6R1yn4gGqn2txG5cQP7Ymd77kdi/koRFL3oNmTdIsKPSvtGZP6FjjIkhWAMfe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKinX9kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2CDC4CEE7;
	Wed, 18 Jun 2025 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258629;
	bh=1Q6aOTiXFFTMQvJwg4MCx9dBoHXp49iL/WVCWF12SPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKinX9kJnqTejARxXhz/UtTXpMpi3bmGLMfHO1mKWQkfzTzlTwLPXhvQOhi5tTKXN
	 dCSNQ7BTBh/LFgUc1EaeBIX7eGokQf1asIp8kK5WHovidTL5zsXHM5xPrzVvawYtrm
	 kATemcl5moH7ysMmybsn9/6WX7KA5RyjQddhOczkux+zHapJTWa3NPD9trnIJ1hLI2
	 gEwx4awAwK58QpiW6SiKKNB/eMIWSLwEiTt/VaKw/Ss9OF2Wa6bxZuYE7fvgQIT3sB
	 klU1GZgoh7CjMOYts8hmySzZ9WNOJNgQiVxPBxVxIY7ree7iXVlG6gqnKCF1rCdvIU
	 y+yARPH94ezCw==
Date: Wed, 18 Jun 2025 16:57:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
	bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
Message-ID: <aFLTwWG5lOTunEq3@ryzen>
References: <20250611204011.GA868320@bhelgaas>
 <c31c3834-247d-4a28-bd2c-4a39ea719625@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31c3834-247d-4a28-bd2c-4a39ea719625@163.com>

Hello Hans,

On Thu, Jun 12, 2025 at 09:07:40AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/6/12 04:40, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 12:30:47AM +0800, Hans Zhang wrote:
> > > Register bit manipulation in DesignWare PCIe controllers currently
> > > uses repetitive read-modify-write sequences across multiple drivers.
> > > This pattern leads to code duplication and increases maintenance
> > > complexity as each driver implements similar logic with minor variations.
> > 
> > When you repost this, can you fix whatever is keeping this series from
> > being threaded?  All the patches should be responses to the 00/13
> > cover letter.  Don't repost until at least a couple of days have
> > elapsed and you make non-trivial changes.
> > 
> 
> Dear Bjorn,
> 
> Every time I send an email to the PCI main list, I will send it to myself
> first, but I have encountered the following problems:
> Whether I send my personal 163 email, Outlook email, or my company's cixtech
> email, only 10 patches can be sent. So in the end, I sent each patch
> separately.
> 
> This is the first time I have sent an email with a series of more than 10
> patches. My configuration is as follows:
> smtpserver = smtp.163.com
> smtpserverport = 25
> smtpenablestarttlsauto = true
> smtpuser = 18255117159@163.com
> smtppass = xxx
> 
> I suspect it's a problem with China's 163 email. Next, I will try to send it
> using the company's environment. Or when I send this series of patches next
> time, I will paste the web link address of each patch in by replying
> 0000-cover-letter.patch.

Perhaps the git-send-email options --batch-size and --relogin-delay can be
of help to you:
https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---batch-sizenum


Kind regards,
Niklas

