Return-Path: <linux-pci+bounces-23407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8116A5B9BF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB53170FF0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CF221DA1;
	Tue, 11 Mar 2025 07:27:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C92206B1;
	Tue, 11 Mar 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678060; cv=none; b=RcJHJTKankJ182Ds5MLOYcRmPxXHui9fnm3kApFE2mKtz5KVWmhvebUcNQb1w2a3d6qnIUe9dLv9XNFngQH27fUA5U0i75yc/7AHm0FyjCSn+Oo3d9I0YWSsiHXsP5BPwsk/TrV0LhgNQ/5Vnvt7Un2pD+t+oYi5/2YhPnkIhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678060; c=relaxed/simple;
	bh=9lpj/SQtbcBYO7uyqYGorW8/ONntmoTjHBzPYBDq3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyfAtoKkGm4Dx8p7R71beMO2OoYfGShSIByksb2titTF3kLCc4DV0n0YN7NiLBoDrIG0zHsTiVihZVdqXYYFnTWioj9KafSXRueDpHh9JweBTJ9p7fd3383vxUn250VfzAEPUtfEg4d0KVD/OgpjgO80mDgLLHdgoBXNrtnlyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22398e09e39so93677805ad.3;
        Tue, 11 Mar 2025 00:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741678058; x=1742282858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UdKkLSJGsV4gu9l5EP4VTB+jR8nNUuC37NW8oMZ9po=;
        b=oVAJQLtrFejqZJMOBfgaXCvRO7/TBdjXeTBCbD0Lqmnflpw6e9fkobaYDSfTmIIKmO
         3FplafqIcfB7K5r7kXYrA6ugjZX3tSCMFq+tJsue7LO+r0t2eFxvsU0L58xJvIB1ynV+
         cqSUzfCnnVotiRGA7rnl97pnpLps7CKWolj9MzNdYjsjGSTFwdxRVr2BdwD10IVvR2aQ
         su4dImlZ1QqoJ61Xkk24FlCvIFlIU4SwTd/GPV/ExY3yNO6Sz8pnKgCxkEZNRvY1w/V/
         4en5/lau7Ab1J1YrMhimRK/ZZWwcbNPbKJGAYgSD9tXBBpO/GDAcCkrqZ6mImf+6rOPD
         AoPg==
X-Forwarded-Encrypted: i=1; AJvYcCVPx6xg29UcENmEL/f1gqXAJ4XybgEr3JsypKdOPig6TR/eBIswq2YW73GzGRqS7nRz4ry/7iUDuYQ2Ueql@vger.kernel.org, AJvYcCWlw3DvLHKQUiIjEgaz0G6B3CEq/+9FHzBJFMOBo6H6kVUQEFXRl997DeKK9I08t/ukEk2v2JuAy69n@vger.kernel.org, AJvYcCXgKcHM7+ndZWgaBMxpqqpmFdmweESHZN1qUekvT4iIZTAD611qWW5Az7wt+Rorva10SP7bZ7jGxCLr@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLhF1PyR9LWRKOrK3RG+mEXWcFALbJCF9oP7c3wD/RcSNhmTt
	jAJkzmUkujvrYSNjOzkLT28XUs6RhBBccYxa/36Lx1E/W8zWTYhs
X-Gm-Gg: ASbGncuO0/BROirZueT0ZRhxfxlj491NHdgMlSxtTObETYSSgYDHTiunICUXr8Ucpu1
	8Dx1q4A9DEzz0iAdlGpDil2uAOv+O3J8J1Rap5a1Zop6RFQRphFM4ANl+10TI2zQl/U/C+0BWZu
	XySrm5Yi9Db6oiezOHg5ZtxzkEzvnCi9tE19dm8NFFrbz/js9ABzcIcrVAnrsy2sHSoRuPb+xFt
	A3CuE5YdO8BVh6iCNTNON2aasFExKRFQviQGB7tv59vlZAn5TYZGA20wV43Q+cQEaowlCCvyocX
	N0FXHNx+zRETrBJUuj99h9f2sad3kKJDecWhsXGHWYEtxQplhP2UKaWVZUST40troBEzUpzHBuB
	Ork819OgSwrGGTg==
X-Google-Smtp-Source: AGHT+IHR8e37F9xXihhPeMOp3ErI52oDmeUT+ASdWqncNF+UAMKGzfdyXK2pLP0Bl/OTKQ6uYNeKfg==
X-Received: by 2002:a17:902:ccc9:b0:223:2aab:462c with SMTP id d9443c01a7336-22428899f43mr267466135ad.15.1741678058000;
        Tue, 11 Mar 2025 00:27:38 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a8ff3csm90699945ad.161.2025.03.11.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 00:27:37 -0700 (PDT)
Date: Tue, 11 Mar 2025 16:27:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in init_port
Message-ID: <20250311072736.GB277060@rocinante>
References: <20250311072402.1049990-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311072402.1049990-1-thippeswamy.havalige@amd.com>

Hello,

> Fix an incorrect conditional check in xilinx_cpm_pcie_init_port().
> 
> The previous condition mistakenly skipped initialization for all
> versions except CPM5NC_HOST. This is now corrected to ensure that only
> the CPM5NC_HOST is skipped while other versions proceed with
> initialization.

[...]
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
>  
> -	if (variant->version != CPM5NC_HOST)
> +	if (variant->version == CPM5NC_HOST)
>  		return;
>  
>  	if (cpm_pcie_link_up(port))

Ouch!  Nice catch.

I will pull and squash this against the existing code directly on the branch.

Thank you!

	Krzysztof

