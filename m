Return-Path: <linux-pci+bounces-21248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD3A31A36
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD0D1881172
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA315A8;
	Wed, 12 Feb 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QraXSjfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BA10E0
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319087; cv=none; b=CwiZfuPhMoS++e4XuZ/2/qVGKF6ad2quTt4L7kdadMVGSY32/lTo3uvjE2dhOv/4DpvCQTl43LBQnT5LzgyIiy01aNz6slsGimjNU0+oj3CAC9+ZqWBa9h8IBXe5exYiwwIyO2pY+PXmq4yrNJNVf0NbZ13scIMWuoT7RUwT9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319087; c=relaxed/simple;
	bh=qfqWUaxj4M5XI8X8hWIn0j03pFGWYZcGVqGDzFiPUfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWH8d9SGHoc+IpVQDfoaqmfBeLGPgEeOxKCYr5iAPCjWJvtHqdnZQ/LkR8ziHEZOUaONOshgDOOdF6up+iYc438iPk5sdLpd5sxrMWL+IRfRrWjY1XpYGgQufy1VNgxmvVhDebGp8JFRaOKR8FIluEjz7WhP/62+t2nl46+23B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QraXSjfA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c05dc87ad9so307830385a.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739319085; x=1739923885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=QraXSjfAWVOjH1StPU4l8HRAErmPT+Gm0pdnhEDejP9/qaj8snwSnYirygR2Zgiof3
         +jARFhrlEBN5bR4WCflWGI61CUt545DDL5vIxPgVSj5h1/VpeAhKBuOjTsMo4cQQbgUb
         6Qh0kShh0thOnGSPZwxs118qXP5MyLad43OA5L9y/6++EyQT1nlJFnROiCxOQmFDm8kb
         M8slzsWrkyHwld+oMJ8kC9ucYNk1jDP/dYtWwfu8jQAWViUHKLvln2snUjRgO8kRT1vU
         n5w41P4hadn7l1NHptslSHIbxU20mHW+R8ICinJqiYuMZtuya4ymNxzElp3da+Hol7tY
         Gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319085; x=1739923885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=LMHQZsj1xmQyRLeBTs6UFJ7/cpqyHq7lMe/Zpof4+S9hy4J7tYPCtNanZTu9Iz/Dw6
         gNyYKOZFdWf9M7kXpuTAuOxkK7IF6s342xkBjS+f8vo6+TY31N5ezZdmsqSmlT+tpSUH
         74wX5sfSZ+Nk4TLnuZQ4TyJoQarFgZ/ryXlLTNeJ3fDaE5mQ29q1VWm1N4pY35+Hwhgu
         OgmlDmi39tXjUDc4076j6BLK141uKwTY9xPDFnBxZl+p+akKsAKgQpuXRkP+RjRnc9W0
         e1g0ccAPNf7cW5X684Gooo1ieDTrxCAAIkQBKwwQGqtGA2sHoJYqcgLra9hL20G5vF8q
         kRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWhhcYgY6TJ67u3FGl3rEGcHNmf9hyj+VIyaapnBm5kpzy0tX1gXZm/rW0cOS63Hj5pafe8KdWwXkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLbwNiJKQQRokrHLEcYTRLOjmIjJxoNI3JqV+8hqx75YWcr2g
	u0VLbgdi1Eh+fHRa9gldS3Z2JcpYrJXtmRJYpHlHx20xNvZGbW+6QXWmHnCsE4U=
X-Gm-Gg: ASbGncs0TZhcwpqeiJCrYmziBbo0hcevQzLVCTolGpkt0+PKkPtcCbOmMdzNNny93vK
	+FdoC7jV4dRuBlrtKTaczOzLCRMkJtcSXZtV/lu37Y9mmDfl2shsFrmYXzt2HiNpD7defxpIJjX
	A+hK7QcqKq8qzZ7iW4Qbz7dQHpqYwsFRjsXmcWd7UqTic9Iw3GJbpnCLuApC0SifWWSlcB+6xv3
	nZZLUJfKTkaaelCUd9mzKTscglKXzehVyx5cx4lP1m6OpVw2K26wenbOEMW9V9VZz+TIEOzOkX2
	IbJKNhKvo4spgeZsXi40V586E6j7lqaGzl/RS30fC3MByrLfZd1WsGmeGcXkbshWYDUDx8gy9g=
	=
X-Google-Smtp-Source: AGHT+IEhQLIsJaG/fbU8sJBgBx+OFg8MFFCqDuN0KUnDhhirQwBhRT3I4eLnjVSHDoK5Bq2ymF340g==
X-Received: by 2002:a05:620a:6293:b0:7b6:d6e5:ac6e with SMTP id af79cd13be357-7c06fc57302mr210133485a.4.1739319084971;
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c065424c9esm257293885a.43.2025.02.11.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Date: Tue, 11 Feb 2025 19:11:21 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <Z6vnKT1pXuON2WNg@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-14-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:40PM -0600, Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging Endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Examples of the output from these changes is below.
> 
> Correctable error:
> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> 
> Uncorrectable error:
> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

