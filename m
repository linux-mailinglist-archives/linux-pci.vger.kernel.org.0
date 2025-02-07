Return-Path: <linux-pci+bounces-20863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB4A2BC69
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58021888831
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BED1A2C0E;
	Fri,  7 Feb 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IjRQZYGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B11A239A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913961; cv=none; b=avVy/lWHhaQ9VlpjnfchMH4RMC0WAdA4LuChmq7cLR4lEvBSkB4c2+RD+gLaYTInkOSmUS3A+LfARW2cV9IyiG8OIW9XMvKc0Wr1f8zDhyyppYVflgq4KexBdX1qIHt0vS4ZD0zWndJ2KqUnQc8sh3vMW/5EGjzlc00LyiO2WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913961; c=relaxed/simple;
	bh=T0OzFQ25NNpKEMqrsEINMLVO111cmFwxp6NCZRfeuHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9z5TZHd7etAXw6mfgqfx//nd6UTvazCEJ+hTrjEjUcED3umOxDLF/SkQhTk7qzA1xLWj+vh8duCeYmWtTtaNX+jQmlWE6jX7Zf1cPc+c2eCG0+3e/KeqeoxIS7p0i7C2rMfNotO9m4TW9uSYIRb7ZvdfM6x3ufkbxIRvtNuJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IjRQZYGY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ddcff5a823so12959586d6.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 23:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738913959; x=1739518759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9WB/z3RvHjUSgTF40v0k1EWxh3NsznaOtJc4SyxiSE=;
        b=IjRQZYGYNRubYrTnAuWLv3E/GkTIdyjgmctNMRdA1la7nujWYDB6JuszWY1aLce630
         micTymt6a/sXXZ9agONYL+C/TEOLj6fHZ5utjpOCg0SzpkrW3Kec9mhEMyG71EmIlWYg
         6742hV9Db1hpLwez0AoAMdw90kJqbCFZ7YQ4wp5VIYQve9p6KrcVQBBP8JnF4WjCo1uE
         HdCsRVZnKvAaezqYdtk0EE8B8W56B5fwKqNkz6UwmrbtcCD+z1l4ti4hAPXZ/fPPLAwH
         UpxYeeiS9PLrkFCiSFmSHPWX0NoEMyS9raiAtvwJc4nW8Y7JiUFHyIj0W8tvrFiQIg9a
         SQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913959; x=1739518759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9WB/z3RvHjUSgTF40v0k1EWxh3NsznaOtJc4SyxiSE=;
        b=TnQkz1oWfmEdRgxxagJuGNwreuRwulqIkKIngpQ3LhQnMbLa1j/ktNvGuJGRLSq/Hf
         xFOBEmc0JfyxjUEQavDM8A8mDvuBv2ML/7gDOSkLlLhYiyndrnFwVHDVS32WxVAPoKm+
         0WgXoHZCm/F1dHXcbbZ5XcEqFTPolKg7iHJAQdmb4wVSk6daG5uuyHMu30+73yAsgmsL
         1Pcwq16GkQENTf19/oBOdKDXGuAAUXTIoFLbKm9x/Rx07QH3ZyvEq1hAfzw7ONzZrIAL
         vFROhym+w4U0N1DQ5f4zJ0Jj+HEKZ5aZ1whaKKd/tJkj2Z1iLWXtdg16TxdGTar84HKV
         smLA==
X-Forwarded-Encrypted: i=1; AJvYcCUI5r7wvgrH8W60gxBa3e2BgiVQ9+xRUsMHZdPy1Ksbp7rvgz7MYByvd54c4TmUT1ZYFGW2zoISGSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCemgxnLny/xzz4MTtkpBa/UVzHFJLYmOEHWwWdOi7MCsr/8lr
	B0p3OiciD12qisd1GAChhOVxmQPNJpJzGdjyPwQz5LvBPdQGW9xaV16kSIgYXQ5Bb0iCZ/wp8Pg
	d
X-Gm-Gg: ASbGnct182tpb4UKlHZtKrOCw6vDX5WWEnVRgCGeIQP3CUk6yLVJQFxicfMFHNe1tGA
	zbAZ/zNi57zGAFBdFNkRFWhqFCkF8LBzftsUpWNUtAMfll4vC+3+u1OhEjs2YRQlrATRFJu4zlc
	6tsQLhZvoejFVf7E3QY/blV3Jco2LEX2fJiG0bHbjnaTbuqbHNMTF9xnOQpjpqReP/IFKtZbIwU
	PTV0P5fQXVQtYm0opNFYhjPLwIpefr4IQrUcEvORtPsB95os27jEVPsN0lVR7WdMp6Ncv0LMG/H
	Oe5QSHESkGTCOxmhx25uW00UwngPZEkcgDkwAGb/R2n2pRKMu30/MiwGVZOkpQ9V5/TUxlcS4A=
	=
X-Google-Smtp-Source: AGHT+IHDzoBp3X6CRHsU2yZZWyH/mbekkDtWIpTmfCiTByGWrM9WWa9/4B05Q35c2BVVbDnKZGl0eg==
X-Received: by 2002:a05:6214:5188:b0:6d8:a7e1:e270 with SMTP id 6a1803df08f44-6e44574ffafmr22618026d6.40.1738913958833;
        Thu, 06 Feb 2025 23:39:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babc865sm14064106d6.101.2025.02.06.23.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:39:18 -0800 (PST)
Date: Fri, 7 Feb 2025 02:39:15 -0500
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
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 11/16] cxl/pci: Add log message for umnapped registers
 in existing RAS handlers
Message-ID: <Z6W4o12y1wACt2a6@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-12-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-12-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:47AM -0600, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed inorder to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

