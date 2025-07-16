Return-Path: <linux-pci+bounces-32309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF85B07C20
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924B9566828
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0E236A73;
	Wed, 16 Jul 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="S7U/Frle"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49123BD0B;
	Wed, 16 Jul 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687281; cv=pass; b=Qg4ufshAujvum/dFZL1bBCg8NB49AFE99Pm6JLE3G0LeKvKOMV/7n6eB/thIOGBEuoMuGN5g2adyMxryO/vozUf70kNeypVr/v+fiEX6IKRBV0h2vJntjXqUeXDaMf++TYgrC3fZrMv8Ld9UHQcpD3cx4lZzjqjjOeNBOcfbxkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687281; c=relaxed/simple;
	bh=Xn9Nc6heiGH9BGacyqbpTO0b3BaYNTCxvx8fokLjeNs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RtFpOZ/9iDcOX6w7e0DMNgvOLWM2DAiMtv3n0dEQDDMScg6T5cF/Y7p4JabMlX8dMAF5m0rfl/ru5ClR3Q8bHjQBbxfTpUZFyf91jyVp9mYxTicPsKdu93qKqiaAq4/ZcETRRh2XMocFzbvljsDNBAzBIomRvffDaJYnUN4s80g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=S7U/Frle; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752687263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IhSYhH2eU4ZBwengYthG7xf82PRUZZ9OQFNWu8hxyejof+Bk3saAvyVcdohuWSJ0xKDV8iBCVczd4eWJ9bI0GRrmZmYJ1tML+js3eK2xtZxl3Y2sWzssrea6/55QfLAiLc6dl9BW8AmGi1G+vNWoryOONd+4KGox80QBQeKpxzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752687263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xn9Nc6heiGH9BGacyqbpTO0b3BaYNTCxvx8fokLjeNs=; 
	b=Bxezh6CXgTUqN/71XN29PLPrhgegEvu2v/Uo1UIadZBk5ZV2LrkpnOxy6X24UAQiBJaXTZQq3FlUe6ORm0hN9rNWh/7g3Y/l/W7lHU7VnlMENXTdFz2u19LOenj8XxPMbdhq20wKM+lxzonHbvZHnytXG6qaX86/TOwPvs7M8C0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752687263;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Xn9Nc6heiGH9BGacyqbpTO0b3BaYNTCxvx8fokLjeNs=;
	b=S7U/Frle4r0y2ct2t4d5Ob0Ml0SOc6bDX3idiHDEd2/gsMJ7569zeApgMVPGTUY+
	+yOdUktIL1+EXne7oYmf+F90tVaTH3+1fEvbyJgGQiKoVz3VggSdJBbXUZ+XIziAgb2
	Nf89vOdWNjbCh+ZAbbkmfHn7moNaH48qjU5aBRo0=
Received: by mx.zohomail.com with SMTPS id 1752687261314667.0180914754726;
	Wed, 16 Jul 2025 10:34:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 0/5] dma::Device trait and DMA mask
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>
Date: Wed, 16 Jul 2025 14:34:03 -0300
Cc: abdiel.janulgue@gmail.com,
 robin.murphy@arm.com,
 a.hindborg@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E9D30126-0EE2-48EB-9A5F-938C4DBE10B6@collabora.com>
References: <20250716150354.51081-1-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

I think this looks good.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


