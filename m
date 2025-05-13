Return-Path: <linux-pci+bounces-27621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B0AB4D8A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699CE466F16
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBC1F3B83;
	Tue, 13 May 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAV8YUF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178E1E5B95;
	Tue, 13 May 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123279; cv=none; b=kFFf3pvvX/S10A/2ZOPPJpLK7k5e1TfeafiJKxo8ORW0omGrjE6MiAIAZZC+UCguBNG+VVxUldhkh4wxJI/8A/9rlBEhsJU7MLrvfnE6DGMf+9xZAx1ZuwHsW/yuSoRc2AcYSv5KYtWIWU+0Yez7+Y5RlqE3KWR1cNk9rkm+0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123279; c=relaxed/simple;
	bh=Oc573kWEBDdTWIpT2n5etLi98rzFaM4fnmjFYoe7I64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5rg/bbtQQZtdWSHGVjm9S5eBY5WOc6DYKvpfNHAxeiT1DZaVYcismwp7oF9q0q7gOtgBuEk/Won/sX55BCqBz6NXXVDYSNOZqrU0PA78RzJ0plh8aShgXz/bmWm8axqVk+Ex7brlXGIDM5J+8s4N+v9PNsSS+Yf1JMvf303wPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAV8YUF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD480C4CEE4;
	Tue, 13 May 2025 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747123276;
	bh=Oc573kWEBDdTWIpT2n5etLi98rzFaM4fnmjFYoe7I64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAV8YUF2LYcx7wf2j5tZVzMLvL23ks5ih1tII1kMUYlT31j7ZLYlEe0QFY4pRb7zX
	 gj3bmx5fwvIPlHq/Bs5wW2WtebyH14CiBmf4blZZaaEmKMfgLq60UCdT58HkYjA/ua
	 E7AFcni+zhyjURXmj7P0YfNN4Gu4efciW5e8z/yTVzdo9zj9b33Pzfy4y/ifdTh+r7
	 LL+2x2l+6cPQBzZn/XMsD590l3a+n5Emw8B8Fa8Q7rtDcrNRPl113qDEQPJW3lq2bA
	 1uJ6a8yLDPIAcOpUWeXmQKkn++ju2kN4ct0pD9s6cJTP7LmDFlsk65Q1CVcF+gu2Ye
	 VZ6kLWx5tXdPA==
Date: Tue, 13 May 2025 10:01:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 3/3] PCI: cadence: Simplify j721e link status
 check
Message-ID: <aCL8R7Fa-6VXOXXq@ryzen>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250510160710.392122-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510160710.392122-4-18255117159@163.com>

On Sun, May 11, 2025 at 12:07:10AM +0800, Hans Zhang wrote:
> Replace explicit if-else condition with direct return statement in
> j721e_pcie_link_up(). This reduces code verbosity while maintaining
> the same logic for detecting PCIe link completion.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

