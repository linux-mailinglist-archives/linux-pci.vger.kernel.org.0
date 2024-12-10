Return-Path: <linux-pci+bounces-18079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9179EBEBF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C521283097
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED7211273;
	Tue, 10 Dec 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG6EuRyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5971F1912;
	Tue, 10 Dec 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871560; cv=none; b=ZTzrXwWyFkUhtRyhaoVvoV5WRc5MRdtiWZ5rgvK9sg7cCO3dn5Avrf7UgCGs/1DoI1YTWhIQonHlmt7chpffAcJE6CZonAlxUK/WfFffAfhy6jr8sqZ4sgGgcEoZ4MoCwukg6HDfu0iOJQlHHVLcJXF1JvSukWQ/OR0tNX6iLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871560; c=relaxed/simple;
	bh=dD2mKRDy5lRQV+FW+b/gBCwz6fUCCzx2LybpTbR/cAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkntQlL52K9wVCaV1MjdcnQQZLiNqmP3reeEndMA/vCqs+L/AgVl2cpzfqHJVf+fp2undA4ao28zzklN5tuV2tD6cEu3SKzaebM9yS79A/D3XNkNwn2BwMq1KjqzrTyfRcgEKH+L8eQY78za3+pcTiHfUrc6scuaN9fuCwKYrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG6EuRyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95FAC4CED6;
	Tue, 10 Dec 2024 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871560;
	bh=dD2mKRDy5lRQV+FW+b/gBCwz6fUCCzx2LybpTbR/cAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DG6EuRytjWYn/pfVmNp9UMZ/yx6mXgR1HwFWHYeq7+JRN31qYff5/vE7Ct3wRvCCA
	 7I3k9l/6NHJdOkkG6NcBZ/N1JzMrE6xWyn9m+yuQndjI5W4wq3aRcc+Ati9wRPigZl
	 4iMsPgwS9NVKwux3YmJIg+QqMuIZu3zB9i28SpvDoQejOX0vznrY/ArerlxSAAQvmB
	 ySlaEM8jtBgamxsLnEJ6sENR9SIkpD9ol+M9n5Rf3zyjdaAAGT4M5T80yGu0cXOI3W
	 RIEAmyXO5kZnDC7pHN8gaHvIjjaXUOu77J/+3unsxeF1ACSH349HnS+Ojf9rXTIh83
	 XPuyfNJm4R7Pg==
Date: Tue, 10 Dec 2024 16:59:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, dirk.behme@de.bosch.com, aliceryhl@google.com,
	fabien.parent@linaro.org, fujita.tomonori@gmail.com,
	lyude@redhat.com, alex.gaynor@gmail.com, devicetree@vger.kernel.org,
	j@jannau.net, ajanulgu@redhat.com, gary@garyguo.net,
	daniel.almeida@collabora.com, chrisi.schrefl@gmail.com,
	a.hindborg@samsung.com, ojeda@kernel.org, boqun.feng@gmail.com,
	linux-pci@vger.kernel.org, lina@asahilina.net,
	bjorn3_gh@protonmail.com, tmgross@umich.edu, airlied@gmail.com,
	saravanak@google.com, benno.lossin@proton.me, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
Message-ID: <173387155606.758930.14011943765137919226.robh@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-14-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205141533.111830-14-dakr@kernel.org>


On Thu, 05 Dec 2024 15:14:44 +0100, Danilo Krummrich wrote:
> Add a sample Rust platform driver illustrating the usage of the platform
> bus abstractions.
> 
> This driver probes through either a match of device / driver name or a
> match within the OF ID table.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                                  |  1 +
>  drivers/of/unittest-data/tests-platform.dtsi |  5 ++
>  samples/rust/Kconfig                         | 10 ++++
>  samples/rust/Makefile                        |  1 +
>  samples/rust/rust_driver_platform.rs         | 49 ++++++++++++++++++++
>  5 files changed, 66 insertions(+)
>  create mode 100644 samples/rust/rust_driver_platform.rs
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


