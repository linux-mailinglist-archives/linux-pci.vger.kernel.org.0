Return-Path: <linux-pci+bounces-31891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F131B00C6C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 22:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCAA7B47F0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B625744D;
	Thu, 10 Jul 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvqQXMeH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FDD3D6F;
	Thu, 10 Jul 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177723; cv=none; b=ta9Y6pGFjnPPJw4UB2x5aMVQ6wVhJ0EahMeKFQsdd5ZgHW3eT9m+n0Yp+xXBLhy/LD+EVF3midCHYF1PEdN1WF5aR2VEFDt9S3D6yGeVN+klMZ3NldUf4+SUOcOwitpHORviwJf5zpUoG5dXreB84QeXkoky7OK1niDLlpoqZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177723; c=relaxed/simple;
	bh=Ov1Gn09ZPG7kbc6CFvLpiuhTtSdn7773uGLpPwjb6qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogOZ/wvIAtfWt0DWIYOZ/K3KBhLpa146vQc931A8880YFDFgNa43cwb0fkg3EWdzsWC4nehBUu27JgwTQvOM19MnsutP6/Q97c25abuKD0g7W2EyEjENaGgl/JiYW9BB/rxZUFdEc6oU2elx9SJ3FwKYTpD+bOyX5OJFDtxVsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvqQXMeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7353C4CEE3;
	Thu, 10 Jul 2025 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752177722;
	bh=Ov1Gn09ZPG7kbc6CFvLpiuhTtSdn7773uGLpPwjb6qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jvqQXMeHZpO89kQcIpD7CqpIG61+ix9rEzi8WlCWGhXh8H9pcBwNv7vWfyNWs4sxA
	 pTuI5xOJZu7qXKOlmRtxiap1bidD8Hee9Y0q6iBInH8nCmpL87GiOKXZ8lGn9BKEFk
	 l/L8TcOtjmpZecg7//wAqMGAvStOC6NNFCGxHvLjSv/p6nKrUiGpEucHG9Zn7w77LJ
	 3TOnB/V6RK066hUVg7TxaLz4l1XpaK6ER4Q5tlHRiy84olO6olBPyhN9s1QAHf8dsU
	 F1j+p5hzklpKUraafF8DbcUSuIN6wcMGs3cEO3Z9CjOGeLoeOHjgK9Zn304LbhOZC+
	 VFLgKC+78c77g==
Message-ID: <bbd52251-a2ac-4d9a-9b3d-62f968c646bd@kernel.org>
Date: Thu, 10 Jul 2025 22:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, kuba@kernel.org,
 gregkh@linuxfoundation.org, robh@kernel.org, saravanak@google.com,
 alex.gaynor@gmail.com, ojeda@kernel.org, rafael@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
References: <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
 <CANiq72=Cbvrcwqt6PQHwwDVTx1vnVnQ7JBzzXk+K-7Va_OVHEQ@mail.gmail.com>
 <aG2g7HgDdvmFJpMz@pollux>
 <20250709.110837.298179611860747415.fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250709.110837.298179611860747415.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 4:08 AM, FUJITA Tomonori wrote:
> On Wed, 9 Jul 2025 00:51:24 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
>> Here's the diff to fix up both, I already fixed it up on my end -- no need to
>> send a new version.
> 
> Thanks a lot!

Given the comments from Trevor, do you want me to wait for a respin, consider
the few nits when applying, or apply as is?

- Danilo

