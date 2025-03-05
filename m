Return-Path: <linux-pci+bounces-22987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5EEA504F7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B2175A07
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC818D65C;
	Wed,  5 Mar 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwz4vhS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D31862BD;
	Wed,  5 Mar 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192370; cv=none; b=iVrM70wQNUG4xBWJDW2JCHpQlpH5rGfW6kL83OlvtAwTWyMHT5wCW45J+9iZYJu7bavzzlhspBvcGDPPIC+dkYiWJ4+jdvt+MEk6AhlUxceAMrg2qRRoxSpp+szKZsFmiTEhld6jY+tx2qbvTFugw8HhBQczoSNvBnoTSGo+BO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192370; c=relaxed/simple;
	bh=C407SjEtF5EwtDuKzqsoF8QnQAa+zhjlXin0WeMt4nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgCrgrTzERXYS1zICOn6Bwew8oIi0CFZL4nc3U8gB8+UYAQ2YIoZPt0YXGzffmow6RYcuU6ryeV6m6c7x4/oB3Vg/CfR+Wtu2BfoSJ9AB0+KZn6gwg8WLeEpTuSVsEsarXGNyh9r3eXfgj2pHMJwJvK7vToJg4PYRNyEO2vcOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwz4vhS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A6C4CED1;
	Wed,  5 Mar 2025 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741192369;
	bh=C407SjEtF5EwtDuKzqsoF8QnQAa+zhjlXin0WeMt4nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jwz4vhS0imWRcGJiRLA4qIUoweASXnEpf6CBKZwpsqd/taeSgnKkWrdDj/Tb5qw0W
	 qFZgFg84IhtayaqgH3zYeGszGoi7SzajMMhDZTzYpbNV32aXWzHXlE3KcQ9VfV68iO
	 qOUOaCM+29l6VZsxLBgucuDeOJwEV65IAg4zSy+iQyiZXni546MM5YKlJnppFAqAop
	 dVTjrUrioCb8HpcSg9Pp+rfXPAT4/CthE1xqGvx2T9TZEJsdVh3H9bRacmfoheTJ8F
	 jLzfLOzRSAaRazBOrYvEeDySJWYKxflomn7HO5XOdtFoTAvo4H+6dkCMMqm6iUAfTv
	 n5hIiPoeAGGbg==
Date: Wed, 5 Mar 2025 16:32:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <20250305-sank-hypnosis-5a41d4e59d38@spud>
References: <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
 <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
 <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>
 <je4falvfemkemlvdfzdmgc7jx2gz6grpbmo6hwtpedjm7xi2gk@jr4frv3tn3l5>
 <20250303-aground-snitch-40d6dfe95238@spud>
 <ktnqf4s4hw2o6x6ir4n5hsrvbxri5cxgjyofrl76by6fwazda3@4ejw2k7k2ush>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+dlkPVoXaUWfOU9"
Content-Disposition: inline
In-Reply-To: <ktnqf4s4hw2o6x6ir4n5hsrvbxri5cxgjyofrl76by6fwazda3@4ejw2k7k2ush>


--m+dlkPVoXaUWfOU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2025 at 12:43:54PM +0800, Inochi Amaoto wrote:

> It is complete a mess. I think it is more clear to just make the
> dmac and eth device as noncoherent, and use one soc bus for all.
> Do you have any suggestions on it?


If splitting is worse for read/usability, then yes, keep it as one bus.

--m+dlkPVoXaUWfOU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8h8qwAKCRB4tDGHoIJi
0lgsAP9/rO13dyY/5sap1YMKjbfizrx1aPd+M21mdzhKleFSAAEA/3Y6yihO5r3K
7gUW5/g2qHLCepdOrlLdq8AiMiYjmwI=
=hMTi
-----END PGP SIGNATURE-----

--m+dlkPVoXaUWfOU9--

