Return-Path: <linux-pci+bounces-27451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF086AB0063
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D1B9E63D0
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B52798E2;
	Thu,  8 May 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5/5xfBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467022AE65;
	Thu,  8 May 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721637; cv=none; b=sr+z1zHB00Fd4m+JX/OKoSrqriFZ/jOx7E0Y0rmlB8D5xCI0dD0nXXZ5n+Emxbdxw60Gfn+ZuGaamZ0/8UOXLfuL+WYC7zLED0vv2gnwfJlyyLumVWJDqPjmY6I+QzT9BevgcnH5X9w7M22IwbLoO1dBY9Frj9l672JNH8sIwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721637; c=relaxed/simple;
	bh=akmsc7Idl/CS0YX85M/o15zpf4CB1w+47LOq+bjRS/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI1GWaheq3IUH4yaBUhtWSMB0MIS0rATKKObty2T74lqStkGydFC5uU+8CeYVRqBY/91tMYMVumNiZUXuDb/kRSgMEHCChsxBahgUSxd4/bTDT0wi1U1TrSlcxkXsD6z00KfCeGvuvfm1w71zj0EOM1jNr/IgCCePfzDJpa9Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5/5xfBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E909C4CEE7;
	Thu,  8 May 2025 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721636;
	bh=akmsc7Idl/CS0YX85M/o15zpf4CB1w+47LOq+bjRS/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5/5xfBRDFswxUWUryDcM0QjyXtAEY8zLiRXY4VPEOEM/xStV26trqrotb89c9/Do
	 VME/iaDiEdNFxRk0GE19jJIdjvnB1KDSXwjBRzAdP491FP5N3gae5Jz/KbxMb1K+lN
	 fXDy4W/oBRhkXNCaekaWj31auEzVIvf47OoTbcuJqgWJVVj1oehXZfJCzHtuqs28Al
	 U5qE4ureMfEPxPc4O6hCo+ULcn6MOCT1MMszpouHZurWM/0aLG7Nh5GAe6SUasPWYN
	 gbs2yXjMZ+fNDTSR3GjS65d5b7VP9tgstySbba0OWO0PmDkULBO1su5ts+TZLK/0pJ
	 f1UQMp17UvSWA==
Received: by pali.im (Postfix)
	id 4CD036FE; Thu,  8 May 2025 18:27:13 +0200 (CEST)
Date: Thu, 8 May 2025 18:27:13 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Niklas Cassel <cassel@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
	neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <20250508162713.tbdeggybijz36dia@pali>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <b364eed2-047d-4c74-9f30-45291305bc4b@163.com>
 <aBybUYYhrmlOeLAj@ryzen>
 <25c89e3c-9625-49ac-b816-945ab9145f87@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c89e3c-9625-49ac-b816-945ab9145f87@163.com>
User-Agent: NeoMutt/20180716

On Friday 09 May 2025 00:12:24 Hans Zhang wrote:
> On 2025/5/8 19:53, Niklas Cassel wrote:
> > Hello Hans,
> > 
> > On Thu, May 08, 2025 at 12:47:12AM +0800, Hans Zhang wrote:
> > > On 2025/5/8 00:36, Pali Rohár wrote:
> > > > 
> > > > Sorry, but I stopped doing any testing of the aardvark driver with the
> > > > mainline kernel after PCI maintainers stopped taking fixes for the
> > > > driver and stopped responding.
> > > > 
> > > > I'm not going to debug same issues again, which I have analyzed,
> > > > prepared fixes, sent patches and see no progress there.
> > > > 
> > > > Seems that there is a status quo, and I'm not going to change it.
> > > 
> > > Dear Niklas,
> > > 
> > > Do you have any opinion on Pali's reply? Should patch 3/3 be discarded?
> > 
> > While I do have an opinion, I'm not going to share it on a public mailing
> > list :)
> > 
> > With regards to your patch 3/3, I think that your patch looks fine, but if
> > the driver maintainer does not want the cleanup for >reasons*, that is totally
> > fine with me. However, I'm not a PCI maintainer, so my opinion does not really
> > matter. It's the PCI maintainers that decide.
> > 
> 
> Dear Niklas,
> 
> Thank you very much for your reply. Let's wait for the decision of the PCI
> maintainer on this series of patches.
> 
> Best regards,
> Hans
> 

I do not see any cleanup in 3/3. There is just a removal of the step
needed for configuring the controller.

