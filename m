Return-Path: <linux-pci+bounces-38720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1BBF081B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 12:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E96E3A1F08
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F52F6587;
	Mon, 20 Oct 2025 10:17:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45C2F619A;
	Mon, 20 Oct 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955462; cv=none; b=qCTIZ2O8GVzrrdrdqxYyvmfl7PWj0R0UbuLghaJpo4a654Do+FayIVyGB6H0reGN/VmBLs7HjPAMlqGlu6F4T9OY/ed8b6uq0vcgSdT1MjCxpmckGWJAPYyxNB/lPqTUZRKna/AIvlnKcan3SLjYQB9JFw6EnyBVGBxn+WXyPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955462; c=relaxed/simple;
	bh=HXRNT1nKCnRIMInPjGW0GsvA34xv8hNqTeF79BAFpf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEKx0vmEBSZTkhZNIVVr7UgvIsdh18JT49ofz9Eihp8DScnt71iT+nphjL3gU8YnAq4/WSSZHne6HEGYzjJNva/sAfHrQeKQhQR6PoFdFSefdYo2yXt4gMEjATxm5YIoR0GtWWCWvwRa+mLO/6hM+uveE+1wmloAQ20qrjHPSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D87A22C02BBC;
	Mon, 20 Oct 2025 12:17:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BD5754A12; Mon, 20 Oct 2025 12:17:31 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:17:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPYMO2Eu5UyeEvNu@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015024159.56414-5-xueshuai@linux.alibaba.com>

On Wed, Oct 15, 2025 at 10:41:58AM +0800, Shuai Xue wrote:
> Replace the manual checks for native AER control with the
> pcie_aer_is_native() helper, which provides a more robust way
> to determine if we have native control of AER.

Why is it more robust?

Thanks,

Lukas

