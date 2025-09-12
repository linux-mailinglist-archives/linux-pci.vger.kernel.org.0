Return-Path: <linux-pci+bounces-36056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32046B556D7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38E45C0DE5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82463281526;
	Fri, 12 Sep 2025 19:17:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC4CA6F;
	Fri, 12 Sep 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704663; cv=none; b=UkjRv5RRjBOE+hvfktzUF0DWtfBA8cieTgFqu/LjCkGePZ4LZz6q208QDlKsmt2yXISSSlI1C7oPUDwHhNmEZv+MobMehGxLNlNgZ2FXMiARebVO2q/QfUnQtkvMd0gve81WjlRNRpGlFT4Phq93iuBw8/MdInFZU4KYCzmdXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704663; c=relaxed/simple;
	bh=EM2F7JCOBK983i5qh1AozmAebcYg09wkr2nQauyIpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKY+er2+IFiCRcwfjBpiczdJciHpDSjqvH2V154OYMLw3C5xxImO+gUDpOtmMVvneIaH9JAIRrEm4iphC51BnaTUNqQ5tt9YMJSCyq0WE1uXOmUX0oDF7zKXkSZOs9pmJ+otefQcKbOPkatVfN1FqRbT/PEaKWra7UAUVBA6aAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7964F2C0E223;
	Fri, 12 Sep 2025 21:09:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6EF231213AA; Fri, 12 Sep 2025 21:09:23 +0200 (CEST)
Date: Fri, 12 Sep 2025 21:09:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
Message-ID: <aMRv47i-qpSHbw-9@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>
 <aLFnKbWtacLUsjAi@wunner.de>
 <52a64372-098b-4656-a1c0-1a6cfee126e3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a64372-098b-4656-a1c0-1a6cfee126e3@amd.com>

On Fri, Sep 12, 2025 at 08:59:37AM -0500, Bowman, Terry wrote:
> Hi Lukas,
> 
> After discussing off-thread I understand you prefer changing the
> name here to be drivers/pci/pcie/aer_cxl_rch.c.
> 
> Also, the non-RCH changes should be added to a file named
> drivers/pci/pcie/aer_cxl_vh.c in the later patch
> (CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors).
> 
> Can you confirm the name changes are as you prefer?

LGTM -- Lukas

