Return-Path: <linux-pci+bounces-22590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44633A4890C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C516C739
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 19:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF81C07E6;
	Thu, 27 Feb 2025 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgYqOHjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB61F582C;
	Thu, 27 Feb 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684776; cv=none; b=lS33DWwVE5+96PNcxcHHpSSzH0QOXQLSWheYfuACUKE8SyGM5Wk3t8euKepMSPWp86CknHs7ns0S8VAqaeuIUF4CMgVFPLOoV1anlJqEhLSfR04wP/DlSrZHT9vQ+GfeIDpZ3zDTgh2Sfvcy0UUpOUg5EQN44F6yLbSfzGzQeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684776; c=relaxed/simple;
	bh=xgAhLKI0/uc43y94Gl/Yidxo45BKOvr9DUD5p03Bwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5ygnoimrn+dTT+DykhvY9fKYmG3KkpH3fJf29ytLV+slW/R1suRgk96qVbh1qd5fzlyNyJFN8G90JCXYF/XgYcXbyalfMbRmHlH609j19zBX10LLO4LaKJvlDIg74cYCBwcg6iwxaN8Jm9ieszFKAKdnNiwWYi82gI/fVncVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgYqOHjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93535C4CEDD;
	Thu, 27 Feb 2025 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740684775;
	bh=xgAhLKI0/uc43y94Gl/Yidxo45BKOvr9DUD5p03Bwn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgYqOHjYM6ZsRIS2+UfyYo1kab5wmkKL3xQWQKGOMh6lzj8R5FKL1wceG0JxbpapF
	 6c+nem+MMroVYeToYC6LpYYUJynrsFK060oCDnPZvFncDIsGjQCvpI7x8SmHVqAvj9
	 PtcIKeQtJV4/ShvN0xhnUFfsT1DFIc+ffrXxRLic=
Date: Thu, 27 Feb 2025 11:31:45 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, ojeda@kernel.org,
	alistair23@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
	gary@garyguo.net, alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>,
	Emilio Cobos =?iso-8859-1?Q?=C1lvarez?= <emilio@crisal.io>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022731-culprit-pushpin-58e2@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
 <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh>
 <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>
 <2025022741-handwoven-game-df08@gregkh>
 <CANiq72n4UFUraYeHa6ar3=F61C_UxEJ1rq92aOF_hH9rtjN+Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n4UFUraYeHa6ar3=F61C_UxEJ1rq92aOF_hH9rtjN+Dg@mail.gmail.com>

On Thu, Feb 27, 2025 at 05:47:01PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 27, 2025 at 3:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > As this seems like it's going to be a longer-term issue, has anyone
> > thought of how it's going to be handled?  Build time errors when
> > functions change is the key here, no one remembers to manually verify
> > each caller to verify the variables are correct anymore, that would be a
> > big step backwards.
> 
> I can look into it, after other build system things are done.

Looks like Alice already sent a series to do this, so no need.

