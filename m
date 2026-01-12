Return-Path: <linux-pci+bounces-44482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4ECD113B9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA553055744
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1E33E369;
	Mon, 12 Jan 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2vPQNJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C411FB1;
	Mon, 12 Jan 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206716; cv=none; b=F+XmsSR3b6ifb7/wR3bVnshyymuzTh5jDKI2JD8YSOIjbDwF/ql8GE2Ws4tW8vg46pvKoExLNbJkLvMTNnVb4kPrHwYTgb3NkafqS6dd2oMMy5T1uFpaUhfE8gF2j4o1pGvNwkRbJ4HBY40eFa7K5IIafNkoJEVKAml8STTdyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206716; c=relaxed/simple;
	bh=HKZ9yY4T9QlsauAEZ1qlA5Y17fZCpgAx0JSFyr1Otac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuXlMy7n1yLSRKjpceZCz0EXvkJ/lFpuRq3oCtlOAz8weHBWdpzPPn8RqDvEf+2Y9qc0XgtCQA+VkCIikNXQL/OGvRI2ZEVBiNqKxV0QKq9Cs91w/8yNX1CjmrDLpFPlvxJBrRcZmyhLdu7d5JNIGlwtvmA8uPVjqH+epoeyH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2vPQNJA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768206715; x=1799742715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HKZ9yY4T9QlsauAEZ1qlA5Y17fZCpgAx0JSFyr1Otac=;
  b=X2vPQNJAIMfdNW3PkThuT3reb5NiN1JqgajcUFdF84fSML+5ik1NfNgd
   6/KWBRpeWL5sx9yiBg3cDHf82VG4MGQ+cqjiz3ZKqPMZIOud6RJOucnUL
   eXJM3jwvaUrAj/g+cowe66oc3FTU6/fgAfV2XjJNrLT+Jqh/n2qcjCkEQ
   Z2ci+iz+iwyGENV9EKHDS7ot76KC0XITTjhdSVgDGt2Q54Qv2TkvE7zzl
   /BbsxGxMoBDFqANqhcBI9fvX4sReqwu7fmPSom5X1lykp7VoxvL2NQ0ka
   hVVUbac1SI9zMpgJ3wln2vJsPcq2y3jx0bUajFzDYUg8Yirj3cs8KhC8C
   A==;
X-CSE-ConnectionGUID: hmw9zR06Qj6kfGSFWYF1Lw==
X-CSE-MsgGUID: 33yTmgj8RTqPEHkbzU0e0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80583564"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80583564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:31:54 -0800
X-CSE-ConnectionGUID: J+MJNJ31SAKTMKb9r3A0gA==
X-CSE-MsgGUID: AjCX6HvQQK+ciNncyEcoJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204312347"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:31:47 -0800
Date: Mon, 12 Jan 2026 10:31:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 04/14] software node: Add software_node_match_device()
 API
Message-ID: <aWSxcJTLzBFbMGad@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-4-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-4-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> Add software_node_match_device() API to match the swnode device with the
> swnode driver. The matching is based on the compatible property in the
> device and the driver's of_match_table.

NAK. swnodes != real firmware nodes.

-- 
With Best Regards,
Andy Shevchenko



