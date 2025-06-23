Return-Path: <linux-pci+bounces-30353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E92AE395C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BF73B8B05
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BB18BB8E;
	Mon, 23 Jun 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN9L0PwE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B92AD04;
	Mon, 23 Jun 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669436; cv=none; b=T4cpg84JuHXgoUYw6+MjtKXr1ugnBT7cZ1NI5SqvzdYUJ5sbsVqIilExbRNiPs86htNygBna+Sm4DqyqY81M1ufwe6Rw3uakuBPdtZ2lLCk+urCYGsrVenwjg9b9WB34rmTIEVg/4mkGy335P5DCY2m9wWZQI8qQoC+aVg7b66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669436; c=relaxed/simple;
	bh=WMeEW71Xdq2ImqfTThMcOgR/sZmGRoU60zXvKkMFza4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFK5nj99r+chdibvPvnBXVrL/2wJVaQLihhizqgwV85uwkgpCgVPVDOvERQSTuy260kVeA8ENBHfzQ+Grne34pZ9m9g6KP0pvBKNb/Qq+uNNsrozHrLSlRaCQCVqwt9RPth5qhOUu9zyJHkqxfBvOvkvvD9q1Cu9UluV4tIzwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN9L0PwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDDBC4CEEA;
	Mon, 23 Jun 2025 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669435;
	bh=WMeEW71Xdq2ImqfTThMcOgR/sZmGRoU60zXvKkMFza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN9L0PwELUUOtTfwVpPRzaEkxywCB5Aptk70y8l7NmLSpDDGsR9eWzpxY8kGSrFKy
	 hnb1YnyaOc0yQhuy9HWot33LrDioD5drYUZzF5HNpF7IiwqXPzUyCzBLUO2g1F+M3f
	 o6qT5dHI/WHCGzHDp7MMm3onSef0Q2rK3/aN8k5tV2wu/Xy1K+82Jk/ZlkT2N4suHR
	 N0DEFTwyMh2MC06W+dn9MT7gxRimOiq9bhv7M3mO6OdW3UkBidDz/I3NcSDFxHawyk
	 CiZ9HnCeefZ/19D7T1jNHRh2f5jN58yUdJltg3D0v/G1sBZiFgAJrvgKFymCugTAHX
	 hfwwhpP7ePP6g==
Date: Mon, 23 Jun 2025 11:03:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
Message-ID: <aFkYdRkQpyE8pOVD@ryzen>
References: <20250620155507.1022099-1-18255117159@163.com>
 <e9eeeeb4-77e6-48f1-bedc-15207f39d7b6@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9eeeeb4-77e6-48f1-bedc-15207f39d7b6@163.com>

On Sat, Jun 21, 2025 at 12:05:43AM +0800, Hans Zhang wrote:
> Hi all，
> 
> I'm very sorry. I forgot the review label of Niklas. If
> it can be merged, please ask the maintainer to help add
> this tag. Thank you very much.
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

If the maintainer is using b4, it should pick up the tag above automatically.


Kind regards,
Niklas

