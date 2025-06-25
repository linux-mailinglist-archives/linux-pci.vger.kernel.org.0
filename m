Return-Path: <linux-pci+bounces-30659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA92AE8FC3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0575A58AE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131631DE8A3;
	Wed, 25 Jun 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTponAlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D51C861D;
	Wed, 25 Jun 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885233; cv=none; b=NRj2MSQc6CHVUMvAoNBrB8iDpkV/69kwU1eXOeJ3wu0707wEPBTNAGrBJg3+F7tiXn6asMK40aSBnNsJYfOrMr8BMcjOkhgb+GSDVT3npKlxvCIaQyBeKEmCzHBGL1zUc1lrVdcP4XF/350yA+Evt7mUV1xYMpm0zkqUZ8YA8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885233; c=relaxed/simple;
	bh=KAXgOO/sEs0vh6iaSl7OMsu64ypTJ6ferJb1F8avREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR8aYRbKgA677kQhPiXfYsmnvtFKUvctaMiAFlngWl5byZH7U4Fhs1OWTqM13LeYwMhBgM9TAP9fh2yriZKmzbMLPayiA6F7L5uOGoQCL6sVZGpaoBp2d61ey5jaZ7kEH0p3TDqUD0FJJ+Q+3bkOwUPa7eHm3Pleu29GDRVPZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTponAlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25093C4CEEA;
	Wed, 25 Jun 2025 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750885233;
	bh=KAXgOO/sEs0vh6iaSl7OMsu64ypTJ6ferJb1F8avREk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTponAlSl8dPj/rGRrSSvI5XHBDFCpGiMAVrOOrdV2qiQ0LH2ANF8ZNToilc8WG+u
	 jiXKd0Su5kFWm5cHXRtAYMbsBEKjyzrYKYKGEqZtCfFcMt+EBOeon6uqDj0KMNzCVk
	 Sgv04bqOLffQlVLWwFEujb6fSOd1MKuYxT1OkN291Db3OUDaQT1UtY4bcnA4+IZyQs
	 jLrOtaK7vju55gCW6vKZ4S+DJt7I31O1cGk9Ch6b9gLHda79/e6E8Js+EnKo4smmAi
	 ezjHij5EwnTkC/+yvLadGKJO8CK0EPw5LryFZU2x2YKRZUY2+A/LReRVCxPsz+ZzLv
	 cWJ2Avfi8a/0Q==
Date: Wed, 25 Jun 2025 15:00:31 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
Message-ID: <yw5ex3su7gjepctaqwkz3u5orcau55hibb2oozdlc2bkdopd3i@ftd34glarexm>
References: <20250618152112.1010147-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618152112.1010147-1-18255117159@163.com>

On Wed, Jun 18, 2025 at 11:20:59PM +0800, Hans Zhang wrote:
> Register bit manipulation in DesignWare PCIe controllers currently
> uses repetitive read-modify-write sequences across multiple drivers.
> This pattern leads to code duplication and increases maintenance
> complexity as each driver implements similar logic with minor variations.
> 
> This series introduces dw_pcie_clear_and_set_dword() to centralize atomic
> register modification. The helper performs read-clear-set-write operations
> in a single function, replacing open-coded implementations. Subsequent
> patches refactor individual drivers to use this helper, eliminating
> redundant code and ensuring consistent bit handling.
> 
> The change reduces overall code size by ~350 lines while improving
> maintainability. Each controller driver is updated in a separate
> patch to preserve bisectability and simplify review.
> 

Thanks for the cleanup! I spotted a typo in patch 13/13. Apart from that, I only
have one comment. You are initializing the temp variable like 'val' to 0 and
then ORing it with some fields. Here the initialization part is not necessary.
You could just write the first field directly instead of ORing with a 0
initialized variable.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

