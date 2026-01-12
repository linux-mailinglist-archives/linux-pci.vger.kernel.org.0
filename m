Return-Path: <linux-pci+bounces-44483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B8D113F5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 143AC30388A5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBC33E369;
	Mon, 12 Jan 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ress5Qyu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871D32E6A3;
	Mon, 12 Jan 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206753; cv=none; b=Rz2WBvC8Jt0K4mTL7gj05ci6XOIkvvvyw5mY92YSJJ3CvmuZP+WOJFfNFJTVqfph2btKKe3kKVXUwXVn9z4dOJMEjCTx6r55odu0gBqcNTe7Eopb/NtDfQUdXywVyUxvQ1lVZgXAJ4bTaUL3Hwz7uPyrNuWkqoQG8hBR16Uc57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206753; c=relaxed/simple;
	bh=vZmtTFdf1WfS3J+DgdEQOXV4WlPnID5PJxe1R+uRVU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoGTkejwpvudA5cX/JGCKV0LF8xDg7VYhXhD0PssqMqHT54rN5Ika5zgHw5qiBGxlwHOQxbH+q6BVt+BF6iMKBxvhsMb8hcM0xqhvL8xNs5ZczAI297zPQ+/Zv+kp+NdK33gvd+BL5M1xQf+e5QZB5HSCdfbp7jXwBjkHAGHXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ress5Qyu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768206752; x=1799742752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZmtTFdf1WfS3J+DgdEQOXV4WlPnID5PJxe1R+uRVU4=;
  b=Ress5QyuTyIHUUCLXTdpgdnsT+1MvEaIgnbxESdLtkn0J+e/Z9abiLFK
   IzF6JUK/tKHSfHydnmPeep+iGp/NpCX0npQwADJhjgGDPJWNkHTYxGwNv
   VMCh2EcNM3ucca5CsrclQJjDyhSJsML2wZA++fn0aSIxi+spG49HVl7bL
   ebdLW/bwKO3/a3CgKGH/QphfLbxMP8VN/a6hCvfkiN4kSJpWynM2YcN56
   fyEJfnHO4P77in4qsO6bQJXDHmMdvRYB1WAQzQbao1BRtjtKRfsytf6yG
   vkxlNnp3rgg5I9cVMVra2Uw4aT/dPPTCFuHYX3NCe9P5oXjz6MHWSKx+8
   w==;
X-CSE-ConnectionGUID: 14xqpxwvTbGBgK/lQRPHww==
X-CSE-MsgGUID: PB5Yoqu3Reqj4ABTJtX0rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="57027492"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="57027492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:32:31 -0800
X-CSE-ConnectionGUID: sNlCI97QSyiEy94S2oMxsg==
X-CSE-MsgGUID: uKHr7F8GSfCtIr3y8QPFCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204108597"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:32:24 -0800
Date: Mon, 12 Jan 2026 10:32:22 +0200
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
Subject: Re: [PATCH v3 06/14] software node: Add
 software_node_device_modalias() API
Message-ID: <aWSxlilPbsLVgn10@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-6-4faee7d0d5ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-pci-m2-e-v3-6-4faee7d0d5ae@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 10, 2026 at 12:26:24PM +0530, Manivannan Sadhasivam via B4 Relay wrote:

> Add software_node_device_modalias() API to return the MODALIAS string for
> swnode based on the swnode's compatible property.

NAK. swnodes != real firmware nodes.

-- 
With Best Regards,
Andy Shevchenko



