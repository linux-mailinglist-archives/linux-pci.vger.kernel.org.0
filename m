Return-Path: <linux-pci+bounces-20823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30EFA2B0D7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC361691B9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153A1BE87B;
	Thu,  6 Feb 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mbSs+E6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4581ACECB
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865921; cv=none; b=j/dtQYP4CvkNRPuRcQa09HMoeTl821KvG4nA4Y7X/heAAWsjtOaJk8moB32Bgbzu/KQj8DH9seboeYhLDjQ709ok4aQBscT8/Sz2AoQpyIb9qYu7zHMM+cImm67NOL/VNqwAtjYWFf4pQ+pvy0gq+eZnp+iI6tNqbw1Nax4iwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865921; c=relaxed/simple;
	bh=svxamlkxBUKcTv2w6ZafIS1La0uoCbSywKilubANIRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk9VBxJ8aIIOoM5Frqppf3L4ny3kq5tUVc0Rd9AycX4nPQak4SfnVc2ky4dBh8OupO2TTzf+WYZvpscPAKNlJE+BrZHdC+M3amj34ymPHHgJi8Rvzs+69VdTZvhga4KTDlbNOl63G9maSqyOXhmKKJxfwMOnvAjfh4i5j4Drny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mbSs+E6K; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e9db19c8so97855585a.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738865918; x=1739470718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUG6NzheiadFCQgj6TrWOr68/8bmtDa4jtIU00ptXAY=;
        b=mbSs+E6K1mng+bdaDcGEHpilu6UD9hQ+MzTDmdB0rMQViksbRMFL5Y6WlrW2SA2tA+
         K1mjJ2eoEShi78wee1z1RUpdF2a/WvieNFxjY6ZM74woVzYTmvesov0oCDwoUJAaRAOT
         Zbsx5jvu465jpl4LQUWVy5K96G32hhd6WjZJJMLYRVrjbHQ4/1Jr9mofTXMfyyACkWOS
         TUvPkB0eaTxJnAwmUS0kLy/rnHZi+32AcOoyF5RRQeOtfhPjV+vtRP1ge6PrWk9fdpQt
         Yf9l2/+bFZ+bTJN/wHbGRyioUtpupBCAX3L5YWRvWA81YZlIRaExlWC1R4ti/TytXugZ
         8tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865918; x=1739470718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUG6NzheiadFCQgj6TrWOr68/8bmtDa4jtIU00ptXAY=;
        b=aYld4V8qFLMJNRNJQBAq+Ct+B1ilSK03K/zsL8kl28VnIkhmIwJXTbWvK6Iqlrb/wx
         nXPvtXHgMl9G9AeUq+F/zd75F7fMXrGSvXAChg0bSmVyQ8hkyQ0EblP1F3O7FcPMGxxe
         LsS90F7cmV+CNyOVeftLNuI+IPVqCadnUfsd1Ly1v7uf2BILG4BwvJmeqVgYXrQ17Zwu
         MvpQ3x3eXo3daCboTefBzIaY3t8lG2IPsWfcpC0qEc9UJd41AUKXSvtpjdzqhedjMRa0
         aUyaRaJSi9qbgBqA9M9Nm0bLlkaQtUcYYigl73KM5knupar+l1i3Cc6kRZLQmkbOQgQx
         1V7w==
X-Forwarded-Encrypted: i=1; AJvYcCWEi9q09sSmX5D6CHBu8CKGTKWC1Dg1+z8efBvBPJJN8W1kmrIM5rWyau6M0mPUS6fO3XE23/RfK1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSz39qJkyCfg8sC8wezSWTezBIg9YKdOLF8ynnPYcfDmZRoAI
	+YMxGtVz6X6wXPckaARR1ZnncomxBGGNo21InQ60lzeEUU+vnDNV+WCIMkidJ0s=
X-Gm-Gg: ASbGncsFKiaCvNmf4zkGq6XMJHDcYN61D03IMki+1IKJAuyqW1U3EftTtaKC53+G7mD
	0tXDG9foe4K3EWMIJtG7vAthyxaB0QqnQGpX1yFgbHlRZMDmSHkpp84yvmVxuCt0dJ0bwbV6mTS
	f+3rX8qPC1aLb3NV+8cfLBfR8kJUFoLU2EgXrpgalhp4FqWsGVzdGwXVhfD1eqQnM6ghZ8Ilza1
	CMR0aadkTQopBpHsI+2cqeF6+qdlHCdJ/Kk7Fg3nzYnZRUYa171B8q13oU67wLdS4s5ZBelLChV
	6ZlmSUfyvfrApmr2aScRTndl0xl+UdipM1ciWO5ZFboZJ4HAnOf+YMXdy7QWHyfMVm6sOGzikg=
	=
X-Google-Smtp-Source: AGHT+IE0GG1TtDuISiUGDhpqfV/qZ02GwpSV6gJbe4kGblMEMNURq4Dlgd839ByGnXLwhq51VKDVqg==
X-Received: by 2002:a05:620a:43a1:b0:7b6:d6dd:8826 with SMTP id af79cd13be357-7c047c9512bmr16375185a.55.1738865918192;
        Thu, 06 Feb 2025 10:18:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f94csm86724485a.78.2025.02.06.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:18:37 -0800 (PST)
Date: Thu, 6 Feb 2025 13:18:35 -0500
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
Subject: Re: [PATCH v5 04/16] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <Z6T8-zXvcdQrCWdu@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-5-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:40AM -0600, Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
> device errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Worth a macro/static function?  Wonder what else could use this.

Reviewed-by: Gregory Price <gourry@gourry.net>

