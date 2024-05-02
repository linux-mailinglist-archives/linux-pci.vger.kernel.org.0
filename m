Return-Path: <linux-pci+bounces-6984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08E8B93E8
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 06:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC7282ABB
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0F1E890;
	Thu,  2 May 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKrfFa6b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA821CA96;
	Thu,  2 May 2024 04:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624718; cv=none; b=O45YQv7hEWFgnriPRQjzc/0NhJYX9eIn80njRBLbfNnQZ1DPEVoXxxhTHRIH/j/N3WPcmJFgZI2TAT6K1TWLQnzMs2MFbGda4M54NNPjEtyA8JqipI+YD1R6GVycKMFSZWBYvvUT/IlcHnM0kR7h4fFmjCxHk/6ePSpat/z3K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624718; c=relaxed/simple;
	bh=iqDPL/4+3LZeCAyWrv8v8742qWzwRO2nfQRrK3+TVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZfO1EtVFYMjFyM6S/pSM53ERRI+tam7Attlo1uq3PX0xV17UfvicQwESem6tmM3zb2xWE0e0ycdL5NHfgz9OfLlyTHTuR4nYbx9/5iYFdGFmQq1t4OwPYc5EhrNB+/zqklt75PWY9vJROSJFwLI/elYXE4Ml69Y5tJP4nGjYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKrfFa6b; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714624716; x=1746160716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iqDPL/4+3LZeCAyWrv8v8742qWzwRO2nfQRrK3+TVkY=;
  b=JKrfFa6bRmtLoMUyeG1MiENYg3KCUnjOIczt3m54EzziXsEq4w4TbNM9
   KvovhxTIBnU6w2QCLQSz8s6i6nQiXvQbJHZ1hGgel3FrZp1GficTohMn8
   44XSO2aeAy7bXVLqH45cReRkZiF7DtHcUEGE30c5eT+/MPR50dnOrie6e
   Z95khGbQrNnoxTcHIzo4jy09c9PkD0tXtNIeMSJVk/B7LNHZMle0uVgCZ
   hLs8CYvgsId0ldDYsZV59kvDhHV/Xuvi/WVZVbQpLUfm3Ibvp+8SzZJo7
   WDl2SfAOOZVYKhPjP1z9l/JWTOeolLydyKTlmUk02aWHvTOT/oKdqNNhp
   A==;
X-CSE-ConnectionGUID: 3PYstz8XQ3+fNvkWxboPVw==
X-CSE-MsgGUID: 2SL9dtROQLq6nFnjsyq3Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21064277"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21064277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:38:36 -0700
X-CSE-ConnectionGUID: smqUURnxRgWqfQsD8/ndeQ==
X-CSE-MsgGUID: D0zolZSVTVq7v4YePvXBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="57887937"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 01 May 2024 21:38:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7F602161; Thu,  2 May 2024 07:38:32 +0300 (EEST)
Date: Thu, 2 May 2024 07:38:32 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240502043832.GG3969176@black.fi.intel.com>
References: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>

Hi,

On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> I don’t have this device available at my office. I just saw that
> StarTech sells a universal laptop docking station with chipset-id
> Intel - Alpine Ridge DSL6540. Then I looked up the device, and found
> it here: https://linux-hardware.org/?id=pci:8086-1577-8086-0000
> 
> Therefore, I concluded that the DSL6540 has an NHI component.

Okay understood. Yes Alpine Ridge can be both host and device router. In
device configuration such as the above it does not expose NHI. If it is
host as in the above list you shared then it includes one.

