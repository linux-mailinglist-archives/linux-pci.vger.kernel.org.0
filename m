Return-Path: <linux-pci+bounces-26621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF5A99B76
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BF917C197
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220520100D;
	Wed, 23 Apr 2025 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d2bBrZAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5D1EF099
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446912; cv=none; b=J+COKdFcujKJrqDCt4r2gqQ8rjZ2u5LTue8uS3Dkh73s9eUESXPT6+AmY8q2h2Iph8LLH2s41O3QJuONss1zMlTAWH4mpfmaKeOd9steTDUDGXk7L0xyMSCn8ggd9/P0BDgmgpjIbpvvYhPqFInSo9RVjwG7eh19hNboGNd2n0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446912; c=relaxed/simple;
	bh=3yB5m0NyUXUmVsetwBc7N61EfrdICLsTvEHds6YZI/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul0HpkwQk7PC7rEpDZey49YcvjmP/ZUE6eaHljiqI1VMfH/T92SCYKc44tVIEPTifibLMDQj3wZyuezhwn9EY8/D5Yzl+wxBKWz0r6HN/W/4bQEEHe4mMXJAVoJUdcRZnUMqhkyixyWYjxGBXzDNHgM83OUoFhuToCbAe3WcXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d2bBrZAS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4772f48f516so16570981cf.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745446908; x=1746051708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5F1rkWnXVQCxgZlMjPH04KG8PhXxdy/Np8jue5oE4Y=;
        b=d2bBrZASJqJ7H9kn8HiJHxvHoKLw/JetnyIYNXsUz+Dib34GzV7HT7JHl+VZq4nFZL
         ZDmtufvaQfgI3e9nFXvZt8PPjwvWeirxzZjMvCfDiqwVDuMFPH5v53o34TYJjV56COOr
         6igf9MMidpu1vptJGU0U1MsbCo4TMi0cfQ/nlh7cyrO19zDgjVgaSn+9GlNyrcZ+Au8z
         Y7ep8+colG5hw8ka5QwPr6V89xtkmsyOAyONhjj7yCteeL5SI3E0XpeAcQKT9ARvdT+J
         YNmzlvkJofE6WG+bm3xD2EQE2IzglR/4JhIFxOm2dgca4Oh2Ndc+RDwQIDThEyFVVqv2
         gA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446908; x=1746051708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5F1rkWnXVQCxgZlMjPH04KG8PhXxdy/Np8jue5oE4Y=;
        b=KtKHj4CxPRIfNDlter4PMQblP861uKO0e+jarz2SnXXLSOT6/XZ6Gc7eiqrOslNyYA
         b3Jg41AfOEWCxkfM+TKyfhnAGy5Yff7H5JJHvB+cwPFvfn1yU9mjrIC63P3CxY39YxTQ
         v1WaCkE41F8IyXJ03eXdcBLOY6mEqRwMQIA+UmvKB3M9Ddpkil6JNy/nk/ASWTTCUB8D
         fp8PZR/VuEHHGJdElefaqOlvnAbs6ov+6uIzoVn9gY09hrZSWrCvFhRAUeqla0qQ/g+A
         7J2ffwyjbfYJzobPu29a35Ac/AhQsJm4omW1z5xfSTEPSS0aBT3nVnyj4vXN+8RWhQDR
         VmIw==
X-Forwarded-Encrypted: i=1; AJvYcCWEogqc/U86T3KcNxo+tyU4pbpRzK1m7O0G9itAOP+oDGfNQ4vNH0N+f4itt9o3Zly/AZPpY8yeGHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc990H2BdR02BYE8dCct1ugMcDcxI6A8OZ2udeRLGOqvmWQ+Y
	9hNHmrL9hDUn7rgDkkpj/Fwn1tiJruWfUdCDlOdtzmr+eagcrrt8Fai+GF5sP7A=
X-Gm-Gg: ASbGncvScgFx0KBRXIW6PeGDksKxjjgTrhchwfW9/a0RVe+qkltTAKYbyV06LO4P43P
	iRayHSbRPFqQ2vYqzOPrhU20tr4797WczNvAvlE97r4MnyEVEzFcOz71jXJ/jzqd282HLE987PQ
	HudEe+G/3a1VeoiuHu+E50yEsHzTyQ4f7y6z+ka87njWhALAWjxzcDBETDPi7kOouwyjPY3RW5F
	vfqGcN1zImfAA4VY10gEeZ0PzW2F8JtbYWBbjdHe/2lnZMwSG3RDogLq1p5pTpeSrpFydm9Z8eZ
	X6jZrGz34Y5kTgjRgiim0y/fxXNlZWYdJEDkWCN2Wb/gVPvR5vmKXz7bit18n6g/GzydDcpTwJN
	qYZHJzqF8oDRDPnmlnCvnQJM=
X-Google-Smtp-Source: AGHT+IHvLKmVbePb7fXOjg/ctNGWVxPz5bpBsO6AskThbz6jfaCCslzbr34ZGd4Tr3a19V7j4alfrQ==
X-Received: by 2002:a05:622a:229d:b0:477:1126:5a33 with SMTP id d75a77b69052e-47ec2b56ba6mr604641cf.1.1745446908445;
        Wed, 23 Apr 2025 15:21:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9bd6c1cbsm1927781cf.0.2025.04.23.15.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 15:21:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:21:46 -0400
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
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
Message-ID: <aAln-k3lQnylTFvV@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-5-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:05PM -0500, Terry Bowman wrote:
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 46123b70f496..d1df751cfe4b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1123,8 +1169,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);


This appears to remove that last reference to cxl_rch_handle_error,
build throws a warning saying as such.

I see in patch 5 it's removed, should probably be removed in this patch
instead.

~Gregory

