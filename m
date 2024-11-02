Return-Path: <linux-pci+bounces-15826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A89B9F33
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF502814B8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE2156C5E;
	Sat,  2 Nov 2024 11:09:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D56155753
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545781; cv=none; b=cTiMJN6gTFryoebN8XOtpjX0Zw3pl9IAnbn4mLilZ7tvaUlcfGYHuOjZHv1YFrzhJEHa+5JizcHHmXRPZLNI62OCxdJ8tT5CGWCh2lmrrcEDlS0AQ6Szcj5WTf18CLPgm41XMnYKqh/409kW9DrdjeEFQCPQ3lRdxxOkO4/oD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545781; c=relaxed/simple;
	bh=oIK1NTMLil+PzrrX0pJnjJQQQG1fUZq+GtVoG59+bLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFNM2VOgJCof92vhIZhaDmCGvTkJK2aN50WIeiYcu4IYMaQbMBFSO26hHxBef95MafhCqRmfbou3YyZvaLwO2vIpqIVB18y3lUZz28GKDkB8AixPpoKozUTycWO/WxT1C1rkwbMvnqPzw+3O1wMZiV1B8Iqraic+Rdqki4GRPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so2249293b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730545778; x=1731150578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wd+bJqnZ0VGp8TVAbyOqmGSMAZsV7zJ8AiRoaRf0Ms=;
        b=CNVJYdeDaCm2mzxWe1fZoFV0d8jC3PCUbpSHf4533vH5iaOTjWW9qn3aoCYVmlXcfC
         GUUmo8MJ/lGyLCHIAmgDNHhORj7hEDsAWz5jQreE+plUzFeYEX5QToZkvK5zAvkAwnT9
         aUXU0t9WVX40ciF5d9kQ68LnYclo7bklyZpEJXLBP05/KGwQQcvG/wqkUXJxjLLiLTme
         k2DgguK8R9w51qD0aO9chpN/IhQaRxNb9oqjBUg/KyA2ol0el4GxWlYeWIRFr1gaPxbo
         25mo9tIhEoFTDwzS9oPhfMzYUxKR4R8uFfShekrP363WHH1BhRsGZ7MvCVELkmiVEt/1
         Ps/g==
X-Forwarded-Encrypted: i=1; AJvYcCUQkb9gd/AJxdP5bAlO6pHgt1NQ5nPvNlA3n/+Yg1L3xHtJ5UHTORDXhlbnsLgUhaVLT6/Q5Msu3oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoXDqhIb6N+JBSOoD1aN4ao8KTyJMOPUjnwn+lrERsbdw+zjj
	5UDwVx6wS8jc7ifLf1du01vXKIhazyZF1O0v8tXq2Cy6+NjArEeD
X-Google-Smtp-Source: AGHT+IGVmZEbZ+r1FOTokKTtZjXAiVY0ACg8KVpajvpeGPscpi0cMiFM8y5zMzRMRWkaYh0rTSYyKg==
X-Received: by 2002:a05:6a21:e92:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1dba5620bffmr7458197637.42.1730545778170;
        Sat, 02 Nov 2024 04:09:38 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee5da842absm1945808a12.17.2024.11.02.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:09:37 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:09:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
Message-ID: <20241102110936.GA2176973@rocinante>
References: <20241015090712.112674-1-dlemoal@kernel.org>
 <20241016165930.djlddcgx7uhrpowd@thinkpad>
 <3d586e07-ac13-42cb-988b-eb24a48491f6@kernel.org>
 <327b4c34-89af-49f2-ab78-f13ee85bdbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327b4c34-89af-49f2-ab78-f13ee85bdbce@kernel.org>

Hello,

[...]
> >> I thought of applying it, but then decided to squash it with the offending
> >> patches.
> > 
> > Fine with me. Thanks !
> 
> Just checked the pci/endpoint branch but I do not see this patch squashed there.

If you so happen to check using the Git web interface kernel.org, then
there is some sort of a caching going on that can return old results for
a while before the cache expires.

> Did you push the change ?

Looks like changes are there.

	Krzysztof

