Return-Path: <linux-pci+bounces-21247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EFA31A1E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852F11884A8C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6B1367;
	Wed, 12 Feb 2025 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dJUzPjTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101D10E0
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318569; cv=none; b=PwDXFrJvFgmCSAIzIoD4kv5DqhC8fkLEU9rWPwK9dtQopK4NfsNIbZ9V76zUoFHrJwJGrliNWJNJKKIVkBCU/clxe6iB2jzAuLXP0B3nEWx5xD/kmp4cnv38c4QrA9kbAkLZRAra1uDL476NcKd3HY4ODA6FGzF2aM0REIHUqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318569; c=relaxed/simple;
	bh=fMMFv+jSo7zzi7KLoGFNtsOVq+2ktkT4wQ9W9F6Rhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSKIUAi3LoZqq722CKYPf9LRHUP93rfj1FELOBmo77ZxLjKG38HnsGMEMwBkW4BVbW/F4sDltrTxEdhWZnZiugcqUz4xDpulAnvNPcpeYXQ0XhwBppvX24rVgyLTPzza9s9UISq1dh5nTjXDxDAEmVVEi3yqvFSQZoOPytnBZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dJUzPjTt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471b1d7856aso739741cf.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739318566; x=1739923366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=dJUzPjTtUztTCFH4SWClXrzf6ng8gwdoQ80K+RYd8xbJGpA5mzr1KTDitosZzfaOVe
         kvZ7a6rL43cOjdJE4Sio4hTsK7iXvIicLkiv6G5n3BAWlngz8dQ+qK21KSn7hzjYBPtO
         zuhdL2tlZKLhbzy+MbBE5kJEzcMRg95HfJtlxpoWXlUAoYf2tTeReedyA3lfaA1TJqw2
         kQX7EtdDad+amajBBEUXhpTiQMLTabSH6bsduzgypgRZ8S/PyVm0+UEmwPH8+S8erECN
         ij78Ic8eSgq7ZlLY3lMCi7cyp/MEqs8UHkUEsI3+wKkBj6uCBO8rzjEPxxT+y+4BP/lt
         rXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318566; x=1739923366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=P5swaUSPzNyfx0tZSVyqnPFZv0MhDgDiR7kjxxW+5CeVXVRlR0TEcxZDFBq/kjkV78
         pSuE2a2wSukCpiEYpdbYsIEJ+Raq3BlKxCHA57jTpEnH5NcuojTdUmQyFD4lZjYagVGJ
         3gu7KVYpB45lpEgG9jKOZCl8fHpMbS5jmkv2YRTPhv/fE0QzgUIyO7BJxpr85/CS1dBZ
         hn5mulRanvntELW1ly4eDws8jeOGAwqQe3Hwi/r51/2x3Jz9esiG04an6aBWgPE8/wOE
         MSGtN9DNuMu3CrIwEAm+UFnkau6y1X51BZrJFzvuNSBfZZWNfsCpZTZMctt2gENgwEEO
         sUKg==
X-Forwarded-Encrypted: i=1; AJvYcCWrXOUTz0KboyPa0NFlXXJULExatB4NO0NTuQ8E8PjbuZ00Ev/hoZJ1R6cSEWoOc+P/3PH/G1KH3Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMlVgFHq9g7UPFrpsDWrS1ZtFCq3cRnQ6hll1162YwwZu0Q9V
	TsLTXzO1lHlzPJ/mmgYqf7LL1WxsJb2UqaOQSB9Zvs9M92ZLRR0A/xssYILr4d4=
X-Gm-Gg: ASbGncvCD2bj6FfOIuHyIwKzcwjEtomO0hH/eFSPcN3vZYtWKWFAGSP+1jsXMr592nn
	ZMQKfylIpmSJ982Ds/0nIUMGt0zPOX61EODzUAeYNosZA+kgek+fKJZ3GzZGPVEKyYNbrprFZZp
	6uyTWbTo+jlmpmxdrKBNLcag5xH44pEQ4kSo28zG1zvYKNMUVFmg3BX1nbKSBCaOfA/wGVOFvAO
	TBcA+xRgq2hM5CBlCmNKz926i4kT/m+uuMyK/y7WNgP2BJ/Q3AqeS1kk5LcNH9VrRx5/S1SqPv9
	F/R5ZE5nqcl+yp1LvaYY9IFihRAVvcydFJGPLvOBlZtwhFxI9IUd7ek63zJod9wt89wKF/ADCg=
	=
X-Google-Smtp-Source: AGHT+IEZ3bke8jjQfP0MZWNv6laQYll9viopbjSznSPRl/BmTopl9h8Rj2ahTL9C2o5Xhb2Twsk4aA==
X-Received: by 2002:ac8:7d47:0:b0:46c:9f53:4a45 with SMTP id d75a77b69052e-471afef8df2mr20155001cf.43.1739318565725;
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc6c85sm67018281cf.53.2025.02.11.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Date: Tue, 11 Feb 2025 19:02:42 -0500
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
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <Z6vlIhKFFqYKaivc@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:33PM -0600, Terry Bowman wrote:
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

