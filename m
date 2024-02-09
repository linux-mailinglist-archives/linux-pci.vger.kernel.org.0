Return-Path: <linux-pci+bounces-3276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0784F1B3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC42B2557C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46965BDC;
	Fri,  9 Feb 2024 08:52:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE8664A2;
	Fri,  9 Feb 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468748; cv=none; b=PrYnnhnDhZh5jwrKGaL/JrfO9LKp6zKK/NMlVE2ppTjpsHRzd8cCG+eFiJSbnLBzgcFapGZTVzkRqU5FxKiS2tV84kWxt9NgsQdTT31I0vZwE/A+M2fDfxOiVtWRSE67KQRSfQuDK7+kWOSfUdOHgUiRwtVvZSUJUKx5jQs8ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468748; c=relaxed/simple;
	bh=Y0rlItVWJKIx4vyKWXfeBbXUAJzehrbMX1mvGaK04fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs55Z1adyD7UIPuMc+6rVs+ofsF7Yeg17y8ldSmUxr82AHLNTPYZeczpwBJ2gn5K3ppgKh/57yHehu7GK7y6J/N4w6vSVcoSeV3ID4a4gukXCDgf4JpxQD6Raya0sijdy74nCBbXUVVDhCJ41VIIrei4CXzT7OFb8oOTvwd6sHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 807EF2800B6E4;
	Fri,  9 Feb 2024 09:52:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 765B7DEFB; Fri,  9 Feb 2024 09:52:16 +0100 (CET)
Date: Fri, 9 Feb 2024 09:52:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH kernel 1/4] pci/doe: Define protocol types and make those
 public
Message-ID: <20240209085216.GA15263@wunner.de>
References: <20240201060228.3070928-1-aik@amd.com>
 <20240201060228.3070928-2-aik@amd.com>
 <20240201065040.GA31925@wunner.de>
 <895b31de-f7f8-425c-870b-1524be21c688@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895b31de-f7f8-425c-870b-1524be21c688@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 01, 2024 at 09:16:37PM +1100, Alexey Kardashevskiy wrote:
> Or the plan is to add pci_doe_secure_transport() to cma.c and force everyone
> use that?

Right, the plan is to pass an additional callback to spdm_create()
which performs a secure transmission.  And cma.c would define that
to use the separate DOE type.

Thanks,

Lukas

