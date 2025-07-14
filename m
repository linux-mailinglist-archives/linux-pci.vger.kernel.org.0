Return-Path: <linux-pci+bounces-32059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8BB03ABA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FF7A6724
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE424061F;
	Mon, 14 Jul 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXQkze+W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334823BCF5;
	Mon, 14 Jul 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485069; cv=none; b=MDIJfraGcLFbB716oQEPzhuZorqD8z5wwiskXKkE2usRl5qG1vci1miKN0OlwBAO6xvRs+DIS3qZWbCwhkZyEiQPTtxrhET3DYa2CUitsG05X/VuTYfGYqQyzOJTPvjIxew6GceKwISlG6FZ5Bt3EANPIPd+VLyQ6aNoDUsflb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485069; c=relaxed/simple;
	bh=/eadhd0NBOYZ8stO/NS2w2HdBh1nU55R+CL5wBLaJPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NGAPcWwFw58myr6gNIebGdcG0McYzjpMo1KTzSvo8kPJO3qzUtprYRqEom63wt9yXTD/469Ll9vh04fVbhfe+LfMdYJM1u15423D21NoQDDSCxdPIQi1yuuzvh+7sVNRxGTyFRiCLJQshsacQZjAzeX2Q0eHqoyuKVSyorPs33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXQkze+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D063C4CEED;
	Mon, 14 Jul 2025 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752485068;
	bh=/eadhd0NBOYZ8stO/NS2w2HdBh1nU55R+CL5wBLaJPY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fXQkze+W46crDwI/LOdY7uWEKKxLFLAQMsT7/dttPZrL0Fub6T0aDgtkqwPDWzAHJ
	 PExKIwLuTosFQGxxjPXwgmy5P0g3Defk0GspGcTLYoyzmoTbLn086DPt7Ccmq/X2jL
	 V22AHIhHqqrWNPpekcA2183bfyzBc69Cw1slU8lt2aaNhaLO9L4WtBvMyNgkGXdT1K
	 pgyNr6ogxIWUQHIewBbPbAcwCPh/acFglsMJjP77FmCqmu6vhxFsBCFHZhGCV+KSXf
	 WFjux4N0+FnxBkuNuoaxSCkB1b6Fb9OdrJaYZbTTTttJ1KEFhQOZvT3uCDDL7FJD9x
	 BD14MEJohcs6g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 11:24:23 +0200
Message-Id: <DBBO3VS9NXJR.3B2DZLDIJGLPS@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Benno Lossin" <lossin@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <aHSmxWeIy3L-AKIV@Mac.home>
In-Reply-To: <aHSmxWeIy3L-AKIV@Mac.home>

On Mon Jul 14, 2025 at 8:42 AM CEST, Boqun Feng wrote:
> I think you need to reorder the initialization of `inner` to be after
> `dev` for this.

Indeed, good catch!

