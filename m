Return-Path: <linux-pci+bounces-12952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39A971C25
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DE91F2290F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3A1B3F23;
	Mon,  9 Sep 2024 14:11:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7120178CDE;
	Mon,  9 Sep 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891082; cv=none; b=l0PmKnwg+EC3T5XOdapAWsLYYeuc6MnzZI9AZ1DMUd9QMFy3Tp2MzFY7y/w/h0FhIAhvJRvdrpNGQVh2KCjta217Ozwga4LPLeuit4rtfhxRVTxJNO/GnBsO0rOifpIyKQwb52Hz4238BxXN9Fa0iCqpMTUhlWzJKPO4N7SMhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891082; c=relaxed/simple;
	bh=KQERd0/HW0azgOfhyuune9R/Lp8/VYQZFm6Fc3RiqyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTpM4Um5h7+QPJGM1IqK4AIbKaJyR4nLqVJFChrmwUNWLzQcYbgNlKBlcUXygbw/wie5njtLjwUKMzJLK9Zi5yboLMeu+SXx7fyBiWjleg6qY5Ij2Tk787kVz3DDrsZdxfBtYw9MdqynkK8PGX1M5uJcVJL+uXhHGgD6AiHE1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so3437531a91.1;
        Mon, 09 Sep 2024 07:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891080; x=1726495880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PE9JmQQYOyPtJIHrjl9PS2qZKnpQmCLvdsLa/Qttxs=;
        b=Bpw4q5p68h+dCjOx5VWr1AvhXDEuJpoGT9CvT/nINM60zKw2HThtvb4UN49LshpcxT
         dNOxiWBk755a41nlaBasFMGGIrJW7SOAID+kMPLOtOwgFGPfylk+kYocyiNUkIcMZ+Nc
         eKXeB64w6NpJJhfLV7ORU4pOIQhJHJEJplnR/k/Fw0LlQnDUwt9j8mmHRMIRVq3Wy5WL
         IoZPwxMG1RyUvKVKtqkXa96Co6Rjjm3KEx8725guDxT5VmaOI4MUqNvzxUKlzI/1JSpm
         OoVROXMsf+L3U5kqVfiMdhzCEqh6/RZ9fx40RAFVA/DbYskq9lIhiZFkSTkQFNWpQFtg
         OmAg==
X-Forwarded-Encrypted: i=1; AJvYcCVK+SMxE6f9XPqJ1kX1Chgp/Mg5bXvKEXcRrcquFJ9jRj+bcsJvkVVmohMv4xZs9/gZQd5ZBoKovbAE@vger.kernel.org, AJvYcCVO3rQ/cXVZnwx8KLgv0XlsSx52p4c54EMmIiZIk2WP4S2GwaROTXaxfoQps7lQ9urbX53TpGScvQxu40Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYoz1HDJB02tSye4CmAUdGFgXEyE71A9AB+8jJdM+qwoRCov6
	NW0gjqpASl/NiJO2wCDg3dCP6f9CEvK/7UKt3YMDlc/3E04wbsLD
X-Google-Smtp-Source: AGHT+IGE2Vfy6top088oA1Few5Dd9p5vIxVFXKV6EhhKEYq+K6sABKcFckGkYa68sfsqolhHGPV0Sw==
X-Received: by 2002:a17:90a:bc97:b0:2d8:7edb:fd2 with SMTP id 98e67ed59e1d1-2dad501f815mr14424336a91.22.1725891079882;
        Mon, 09 Sep 2024 07:11:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0419aab4sm4636565a91.15.2024.09.09.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:11:18 -0700 (PDT)
Date: Mon, 9 Sep 2024 23:11:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Matthew W Carlis <mattc@purestorage.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
Message-ID: <20240909141115.GA2663203@rocinante>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
 <alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk>
 <db382712-8b71-3f1c-bffd-7b35921704c7@linux.intel.com>
 <fad13835-c426-fde5-786c-bd4c88a4d35f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad13835-c426-fde5-786c-bd4c88a4d35f@linux.intel.com>

Hello,

> You still seem to have the old version of this patch in enumeration 
> branch.
> 
> Could you please consider replacing it with this v3 one that is slightly 
> better (use_lt was changed to true because it makes more sense).

Done.  Should be up to date now.

	Krzysztof

