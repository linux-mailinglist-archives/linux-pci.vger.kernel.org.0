Return-Path: <linux-pci+bounces-27438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCFAAF92D
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 13:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB091C20076
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A540221FD6;
	Thu,  8 May 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3RM5ALr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2720B20A;
	Thu,  8 May 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705240; cv=none; b=dEF2/1mVMpsuLWLDypFLl3bI/7VYBK7V+v+vutnnJbLcxFApumBuiPGmfAq+PKIe2TkVaDex6ra/3/J1b6a3XPrcsCqw5XlnBDtwUt1ZemQI1uWRqJmX87LZefU/VUWgCAK57kDHIh0C6xkkHUqK11FJsVUH0Rb5Lv8GnwWTAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705240; c=relaxed/simple;
	bh=ATEwHpgNA6jqamANm5hBaVYVO/dqwcBSYhIXw4FvfOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imBUZVDtJPfY4a5F4VWEydN5lKlLWxG6aV8d2qZNBMkmofzP7ofdf/5WuXumwsru8F4Qu/vHSDiRAmdOL63VP+ybMNmtkMqon+/klIhvDG/8z1980nlgzM4786jXS6GVHV5U7n5GSBJeNGbgl66kjd102Ty4fcS5fvdycP3PFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3RM5ALr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59FAC4CEE7;
	Thu,  8 May 2025 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746705239;
	bh=ATEwHpgNA6jqamANm5hBaVYVO/dqwcBSYhIXw4FvfOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3RM5ALrqSnfQa5HbX8moNUhsGOjpcfcy5lA4yc+FmPmsGqzLmElL/eAXgP9r3k4z
	 Rubst2i6+x9slEhbAguGyXaZli1sn8YNW9zPw/tkLfr0VxTPxXrs0xw5aVF4MuYEU5
	 8G+QnU8r6onc00RyOW9QjHHiFEixVWTv1v6mq7xZ5ebwt1wKaKrtGNQLCvNYAc46GM
	 1zq5g44NCqS0dgYhh/RiFgTRvIusk2uUIu0bQQ+x+2s76kyWmK5lP8frGn1KXt+kCA
	 MB97EmoRnKLis9eJd4gykwNx9AIuZNcMEBnm/HnLDZW+7EHGFsCIMgd1F6A2NNxKLD
	 ZBirUqSL+XuXg==
Date: Thu, 8 May 2025 13:53:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
	neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <aBybUYYhrmlOeLAj@ryzen>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <b364eed2-047d-4c74-9f30-45291305bc4b@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b364eed2-047d-4c74-9f30-45291305bc4b@163.com>

Hello Hans,

On Thu, May 08, 2025 at 12:47:12AM +0800, Hans Zhang wrote:
> On 2025/5/8 00:36, Pali Rohár wrote:
> > 
> > Sorry, but I stopped doing any testing of the aardvark driver with the
> > mainline kernel after PCI maintainers stopped taking fixes for the
> > driver and stopped responding.
> > 
> > I'm not going to debug same issues again, which I have analyzed,
> > prepared fixes, sent patches and see no progress there.
> > 
> > Seems that there is a status quo, and I'm not going to change it.
> 
> Dear Niklas,
> 
> Do you have any opinion on Pali's reply? Should patch 3/3 be discarded?

While I do have an opinion, I'm not going to share it on a public mailing
list :)

With regards to your patch 3/3, I think that your patch looks fine, but if
the driver maintainer does not want the cleanup for >reasons*, that is totally
fine with me. However, I'm not a PCI maintainer, so my opinion does not really
matter. It's the PCI maintainers that decide.


Kind regards,
Niklas

