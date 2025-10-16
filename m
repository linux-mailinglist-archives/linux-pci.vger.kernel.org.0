Return-Path: <linux-pci+bounces-38303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55288BE1EC1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29F824F7A40
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4EE2DECDE;
	Thu, 16 Oct 2025 07:26:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F82FC020
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599619; cv=none; b=HNHOLGYob3I1oVjz4q2wt/fnojhgZJb7Tl/yTrqdIbv90ZZQlguOLvFkwtLSLdo+0ByKOg1AHm7ZtQ3UN0aCgkWKOUcYFoVOSN8+oHtw3aWALw5BijUxLMbTMPc1XMic7eoNtKoChkss63t2D4cCGYGZ/KfFuCX1mpRCgLWP3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599619; c=relaxed/simple;
	bh=hT1CnELTD2vTiqYxjKg8N3hL45TUMY+3+LZSZl5w0rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ2lD7eOwV7Jf4d3xR8r9K/O5ks6fFWb4lZtr1WlqG4/tPMxle+AS8GHTFB0/uz/q9gHyOoGNDQjHVxcQWwUSayz4BS7T2s0TqVEkRThgcj6eMbGNYvoO4AFNuWiBJOc0wfsMn/k2zzSV8jHKUAa3HXG5bgFwC4gC28WtlqJ2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 039FE3F019;
	Thu, 16 Oct 2025 09:26:46 +0200 (CEST)
Message-ID: <9b85a5f0-8407-43d9-993a-0f6c3cef2f5c@hogyros.de>
Date: Thu, 16 Oct 2025 16:26:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BAR resizing broken in 6.18 (PPC only?)
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>
 <yn2ladybszyrxfridi3z3rx4ogfh6c42bcxq5qld64gul2xltt@6hir2oknxfmg>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <yn2ladybszyrxfridi3z3rx4ogfh6c42bcxq5qld64gul2xltt@6hir2oknxfmg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/25 3:47 PM, Manivannan Sadhasivam wrote:

> This could be due to the recently merged patch that changes the way we read
> bridge resources. We saw a similar bug report with Qcom platforms as well [1].a43ac325c7cb

> Could you please try reverting the below mentioned commit and see if that fixes
> the issue?

> a43ac325c7cb ("PCI: Set up bridge resources earlier")

No, the problem persists after reverting this.

    Simon

