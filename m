Return-Path: <linux-pci+bounces-20866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36994A2BD90
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E771698C0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EF235BEC;
	Fri,  7 Feb 2025 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GTHNJpve"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F131A9B52
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915730; cv=none; b=kZo22F81hJzdbE6wdcI20uAR0W4U3sKrRHclPz6Nx2AQu9/EaOXu4Bv+QAppse53h7z7k15DuXy6ZCAUt7tIrAit2Bma0Z5XP3Ebqa4utgujAxQdkBSUDK5BHEcJ34GN59DGD1cAq9RnRoOIHuVh3CM8w8m+8c9ckVoIiFMd/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915730; c=relaxed/simple;
	bh=h3JF4kg25Ak8+7nLLyUwiuxQxmkQn+2HaY0HuhcaeGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwTYaiyHHMN5JEKnGpyPWxpKZulB32dG1/4sEYiGXFOoRQ0cEfZycCTWeIGMbHfI03bmPzu2H3SLN2cFQl+ou1IsFLJzBz5s6mXQLUh20aUkuteScjlmKcFQ6Qx4UHXQ0RjT/dDzFv16hEkdmZCTXvfiBetpJi0Ft/+GUC4rHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GTHNJpve; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e9586b82so159749385a.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738915727; x=1739520527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUqfa/7a3uRLS8Wt1E1OLUz0+AKRuiORplPEOlwtwdU=;
        b=GTHNJpvev4shxMIW0h+r+Ukpx+zVOG3Hxjc9gPtcsLQl3yETnJgjJwUvkCHNUut5p8
         8LhAB1fO6CExbw+vbrFzEfycyeRaImUtXufNvEKvBuZ6UjDt0cKCxXcUgq4VrFQyZBSI
         8qqUEVw3Tn3v8lW/mQD+eSOq4B2a5WaUFJkZNUX1ocdp48fpeTFZTAzxKOVs/ZrdaDar
         jroyiq0BHqOa4wn4KvgT4RoZrL+bDnypnFxxUS/X7eopJmHbcbcS6qRq7Qj850qxVAY/
         PHmRQUhfB/ZF9cOvu9Ct3XEaijXwxu3i86XGg6qBRE0pE3GI6RcqeCscdttaLcKF5mOj
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915727; x=1739520527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUqfa/7a3uRLS8Wt1E1OLUz0+AKRuiORplPEOlwtwdU=;
        b=woqg+Sq2K21s6uXHfJQ2S+JEIDW0D+U87RCLMkXybbcHDyohxBQHRq/kjL43h+JrLJ
         E23ZMS5TBr/X70mF9B9/S/yi6HEbV0Z3zI83yS234LEjCx8ZlB2mI4XoZsdzR4kegtZ5
         Zz7cMKQrOmUJUjoYgg+DrP+umcO0FJkWlUemhLHHtsRVwSZrR8yYC60/joUr2ZPn5CAJ
         iGtYu0L5yxfHnwtiQiVZOPX7GsH92cEGPJ7+Oxazx9q6jIgz98oYET4ZdWcd4dUr5yXr
         hSpNlbm1zWPdk9IXojiZnldVRAlRg22bplmj+YyVzerH2Pqe+aPfe217b3DlHDE/kzle
         4anw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRHQgtkSzRP2xbigtRYe5Y0Cy3ghihEzrrqBeGA3wsBofrx6hh0G+m3sheL3WWQ7erqZsh2kzLj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AsRQewT0iCUQbSw7ZfCHds2PtnLOJNn9WDo6zD8myNmdeWs2
	N+aUWby+vFLjHCL+ZrEpfo4pxWaAz5/fbW7zVODElLZ6AKZcMxbAamzjEJIPUco=
X-Gm-Gg: ASbGncv3KwKDTKwBHOBwjCISgKWn05JoI6KTBCfCjkSOAauv1NeFx6IIqm+hhTGPsh9
	mfVZWmBVABQlT7tHDb4SmP16zYWXla2wtvmP6vVewt9jFWHjsYapVbpg+DgEIQCZwLinMBhRIuN
	T4N4UzVZQo6Yt4Kg98wrtsYTCklSLxcbqWXcs4OvXvtobdeE0uZuzxBFoh+ODEZRZLvlSdbOuCj
	VO+hhlEBBxcIleuJyBugZKeBqXlqQ8MbiD36y1iLysIzAeW4x47Ravl36iocN2E5DSL18CQmAyR
	yLl/Gs8rL6xUITKpv8bbhRVkRW99/bB4HR13QhKG/carLy8GdveBiU5LBqHosm/sppFixDknOQ=
	=
X-Google-Smtp-Source: AGHT+IGSIwnmOaKReWyusyTMXh+GJeL3zpoikJuNLhCbaUo+fvusPWKlRI8qdyFQIn++zwWdc6+B/Q==
X-Received: by 2002:a05:6214:1d26:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e4455c554amr26905936d6.4.1738915726917;
        Fri, 07 Feb 2025 00:08:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacee1sm14268386d6.84.2025.02.07.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:46 -0800 (PST)
Date: Fri, 7 Feb 2025 03:08:44 -0500
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
Subject: Re: [PATCH v5 15/16] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <Z6W_jKNZfrRBIirQ@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-16-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-16-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:51AM -0600, Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


