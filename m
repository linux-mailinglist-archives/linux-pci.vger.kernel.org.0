Return-Path: <linux-pci+bounces-10512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE0934FC2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5A91C21B05
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF214037F;
	Thu, 18 Jul 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqUIS49B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5E2AF12;
	Thu, 18 Jul 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315892; cv=none; b=hk05gRxPZM0xqS6XSyNmGXZaWhsaovQs+T4xKR0K+KMoBrR5XAGW3bKMTO0Sqo+MBZG0jme33bEVFR4LhWEvwEHKV1NTWwX5T+grK+jmelXgsYbEC6M9y4E2pKaVhtEDK4S+jsd0Tkgjyvc06d2DlZk1dirISsoCGG0hkZunwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315892; c=relaxed/simple;
	bh=iNa1tefSB/FdELqCaRRlM6i/wDIOifcN7591bc9zUEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQT9E5tY59+EUx6WD8SP9zjHaUNTKvUoyUYde2JiYfLuG49ZaE8fLu4tYlqkwRudMs5dJ8b43ESL8XPsUU5I2DH5iUJKVg+/bWQ2Fo9nSmVkJGcaaHSeRUqZ34r1NkqeuEsdo8b8bvef58hmZKZBfsrrSLYicdPsZWcMEFnY8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqUIS49B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDEC116B1;
	Thu, 18 Jul 2024 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315891;
	bh=iNa1tefSB/FdELqCaRRlM6i/wDIOifcN7591bc9zUEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqUIS49BUFLZplf+8ABMSghbxWFob1qmicPQoRxSSmiuFvgag/qwWvITzFgbo/Mk0
	 mnI0Z38D00+2rlyks+4FV8CyVHusUrJ0JBGzhPomniMjIhlOrmsj6xUU/qc8WuFatY
	 DPnw827MQZ47jcph0OcDG8+AW1uE9p+rL5JJDRn9icK60L+/mA8SloSXSxp4Fp3T2K
	 O57ZqKdesQnKneiPpaWj9mlwSUZECRgkDiCjATlZ3zJfL0TFkGrWBS1/Uz60CUL+gD
	 Sx1Y7PlyiStGg9Rgfp1de9aFXAE16ubnDaHY6OT7o9MUONEEtqkz6eAWmqbEWnvze7
	 Ppl8ASpfLspzQ==
Date: Thu, 18 Jul 2024 16:18:07 +0100
From: Conor Dooley <conor@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
Message-ID: <20240718-pounce-ferocity-d397d43e3a3f@spud>
References: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tzTR5lZJg29Tid9B"
Content-Disposition: inline
In-Reply-To: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>


--tzTR5lZJg29Tid9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2024 at 01:17:56PM -0500, matthew.gerlach@linux.intel.com wrote:
>> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    msi0: msi@ff200000 {

nit: label is not used and should be dropped.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--tzTR5lZJg29Tid9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpkyLwAKCRB4tDGHoIJi
0kqUAQDf7lFvCMOxzu8vAxd7JJg34UuNpyie9ez3yXIX4aeYAgEA7TY6dRh1aKpc
pYWUtNFJ40XNQorCHJnf1gkvj0KHxgw=
=E6Hq
-----END PGP SIGNATURE-----

--tzTR5lZJg29Tid9B--

