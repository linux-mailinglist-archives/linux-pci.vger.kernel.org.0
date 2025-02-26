Return-Path: <linux-pci+bounces-22411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA2A456DE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00119188BF23
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313026B095;
	Wed, 26 Feb 2025 07:43:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20ED149C6F;
	Wed, 26 Feb 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555826; cv=none; b=u9cfZ9MnNhqhecbIIGWW61djoP5gGS43lGwSLYkxRai5FVyTFIrx+emtrP8aL46t/dC9Zky9u5j7vVHN9k1rSh2GT721L8T4DdqloQnmqATkm+b3USwDGAXr0fCxHs//abhNta/5OCa44IieGjHzhMfYROUD/4Mydb+5XqJ5F9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555826; c=relaxed/simple;
	bh=scxrKuJXfFYSlw1bcePOaW0ZjBmcKSa/3S5MyD8iHig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwWtm5cOdVRYMka+rxprNov8lLuFDcNdg+rXcuv4DZkJXA46gBhPbYgdkrv5jMblVEFKAhvSZsvzh9YTKSO0J6+QACfJ+YEn1aH9ioDhuizVtmnwz+7irvcG89WSST6BOLJmeCzbULOQ7E5LiLZ0CHLoOAvzikccrxoy/xdt8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f42992f608so10057996a91.0;
        Tue, 25 Feb 2025 23:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740555824; x=1741160624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMO2b2eSfKsMmX2B/oW7p9k0e/YoAhoRkCSVATWEApo=;
        b=C512V0riY8hjl8uEscWQycxPNOnzVaKG7jKyOLKPFLNSwZjWsyO+ir6x+sN1RxTH69
         qpnilsYLMdCBlJKq/7lw1XKDMOoFpWzVp6W/yTtiZUwvivpD4ogZpC8rFVN1j0O8FulE
         z3/Dj2KoT9JX9bv30Vzg4oJtvnZUTK4fh6kMXbFDyrNSs+9UxhGA5OZaa5H6oX+ERMJf
         jEKwErSShlSzz2TnzJhamZeC5KsTN1yP/edGZ+nQqJXYofDiexcNGgYjnJ8LDCLVGS2j
         nl6oUo8xVi784SGlZZFiONpco2xwo/L7OLOHdEUL92d8qJde5u+SaR5urb4nMPh3mIpL
         i2hA==
X-Forwarded-Encrypted: i=1; AJvYcCV+LpPd2qM1LovPB8A4Nn3rdRboilVo/rYc5g5W/aUNfqfnwvz/W4vbwhLn0uObHMdRVL1cANS5VGcj@vger.kernel.org, AJvYcCWWTUSUzAeZxiG4xCuj595wRT9fqPF4B+9uoVUTnJoci6GwJs8sDa+U45NVQm8JrlYuwwPrcNSrHiTQukk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuheEpVRf07lNyQcMftJ9iNrMhbH3aQUtVsexueOPsc3OSEVi
	otiQETy/E4niTqV3NttktQIrKjw9kgFAB644xfmELylqF3vyqVRu
X-Gm-Gg: ASbGnct2iIwYE6ROrcuEyF+YC1rl0sIOjln7M91Kb7zhK4q8b2T1DNlCaTjb1qmwBCK
	ZnZPzq90okN0fSIk+HU13S8XOefF4VgVpbz3N0b1yVQvB5wdoLPPXvuUQ3Ri9HYLd9sXpS1SHu9
	0Wd8k3Q0pYwv1WK949ime+d5g80TbPLgmTE8/rtpQZxcEL86rzCMImZ2DRwqkIZNxO6w7JrVGuu
	U615A7uX3Deb8zAZ3wR81oXYvCVI4B873LUWTQeZJuPOtZzfAQr7nr4xFdkp5NPKokam8o2UYMH
	bqfWowAcGFCv/scbsxN5Ho1GWk373QozGpJVmKt/MUb3RWKXPIRqBywcJ0QJ
X-Google-Smtp-Source: AGHT+IH8o9O/IRRChjpv68CsTUGAik/f6Buv/524angsu2gHqq2fx+IXXYNWpA9gZ7rmaD2ixTTocA==
X-Received: by 2002:a17:90b:4ecf:b0:2ee:f19b:86e5 with SMTP id 98e67ed59e1d1-2fe68ada443mr11754041a91.14.1740555822464;
        Tue, 25 Feb 2025 23:43:42 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe825e9504sm900029a91.31.2025.02.25.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 23:43:41 -0800 (PST)
Date: Wed, 26 Feb 2025 16:43:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, shradha.t@samsung.com,
	cassel@kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
Message-ID: <20250226074339.GE951736@rocinante>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
 <e25e5d68-7fb7-4157-825c-eb973f7e1321@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25e5d68-7fb7-4157-825c-eb973f7e1321@163.com>

Hello,

> Can you submit after this patch? Otherwise, will my patch conflict?
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20250223141848.231232-1-18255117159@163.com/

No worries.  We can resolve conflicts while applying. :)

	Krzysztof

