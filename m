Return-Path: <linux-pci+bounces-15125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E79ACEF2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059D81F21C2B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3F1C578C;
	Wed, 23 Oct 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8i9ZywW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4421ADFF5;
	Wed, 23 Oct 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697825; cv=none; b=pbEVo4rDd1f01m7ohqaHYr3e605dxsPqN8qclk9bSIBLhc25W3p38jX99yQihgn9D/5L49rT/tth165J75M45IIAySDxkebvGgTvR3QEYXpWT20kG9M8qlz8settipID17Mc9Nd0qZNB9BcikLzePPjzhCRVWUJS1ivfjW1UiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697825; c=relaxed/simple;
	bh=lk0BVWNF7JihPDu8AoY+TTLyFPUHODOZeiL1akPZRvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THPpjEkw6yPWzsVK0Jtc8QTHittGbfEg/Qwj73djwKZEu2EWTaLuSMYHj+LNDgmzdTIOyV5xmJJtMwkBc8HAczHQHu1JNdPUUSzxJvz/+7CmsnJxdPnsXuf4Z8MIVUITfcNWWT+UETOcBgLPs3iB9Zx1zkLee+M+FSZAaMe2Jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8i9ZywW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B042CC4CEC6;
	Wed, 23 Oct 2024 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729697824;
	bh=lk0BVWNF7JihPDu8AoY+TTLyFPUHODOZeiL1akPZRvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8i9ZywWG1tpdwujXwquT2/K5g7j+78KPhFfoMyqJmVgJDCqTdlotB1hX/oUmisbr
	 yuI5GmWmRTqXUNPTuRjJGGQQjv7JZrcpmof2zYnc5lHVJVc/om4nkUXf7Y2beDYC+O
	 YS4kUcLC+z6Y+7m4pgidBbx4UHcuSr29AOqWWv14LqVOeMeEtWDaXjQ4byxBuhZ9B9
	 UVhfnAWMvgAKJv2SLlVScKAQs6H2XWbKq4mwQ1YVE7h+AqK6GM4d0tj2sGA7TFpc5G
	 Z1DUYs2oocSPMv273HEkHfX0RMUhAQ7oIhDludID8sNHB1hEIROK2wJNG2gWNMjI4B
	 aDGLVMl6myaWA==
Date: Wed, 23 Oct 2024 10:37:03 -0500
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
Message-ID: <20241023153703.GA1064929-robh@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-17-dakr@kernel.org>
 <20241023000408.GC1848992-robh@kernel.org>
 <Zxie5Lu2z_Xc_RXM@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxie5Lu2z_Xc_RXM@pollux>

On Wed, Oct 23, 2024 at 08:59:48AM +0200, Danilo Krummrich wrote:
> On Tue, Oct 22, 2024 at 07:04:08PM -0500, Rob Herring wrote:
> > On Tue, Oct 22, 2024 at 11:31:53PM +0200, Danilo Krummrich wrote:
> > > Add a sample Rust platform driver illustrating the usage of the platform
> > > bus abstractions.
> > > 
> > > This driver probes through either a match of device / driver name or a
> > > match within the OF ID table.
> > 
> > I know if rust compiles it works, but how does one actually use/test 
> > this? (I know ways, but I might be in the minority. :) )
> 
> For testing a name match I just used platform_device_register_simple() in a
> separate module.
> 
> Probing through the OF table is indeed a bit more tricky. Since I was too lazy
> to pull out a random ARM device of my cupboard I just used QEMU on x86 and did
> what drivers/of/unittest.c does. If you're smart you can also just enable those
> unit tests and change the compatible string to "unittest". :)
> 
> > 
> > The DT unittests already define test platform devices. I'd be happy to 
> > add a device node there. Then you don't have to muck with the DT on some 
> > device and it even works on x86 or UML.
> 
> Sounds good, I'll add one in there for this sample driver -- any preferences?

I gave this a spin and added the patch below in. Feel free to squash it 
into this one.

8<----------------------------------------------------------------
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 23 Oct 2024 10:29:47 -0500
Subject: [PATCH] of: unittest: Add a platform device node for rust platform
 driver sample

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b3..575ea260a877 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -33,6 +33,11 @@ dev@100 {
                                        reg = <0x100>;
                                };
                        };
+
+                       test-device@2 {
+                               compatible = "test,rust-device";
+                               reg = <0x2>;
+                       };
                };
        };
 };
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 55caaaa4f216..5cf4a8f86c13 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -15,7 +15,7 @@ struct SampleDriver {
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(
-        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
+        of::DeviceId::new(c_str!("test,rust-device")),
         Info(42)
     )]
 );

