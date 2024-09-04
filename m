Return-Path: <linux-pci+bounces-12768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF996C384
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5266CB23B8F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745361DCB34;
	Wed,  4 Sep 2024 16:09:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DE1DC184;
	Wed,  4 Sep 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466178; cv=none; b=E/qLoeyDJz2h83Q5I7BjVjoDXtv5ScNbg6BqeiGHizQJKJ9IXGxvwc0yeoiUCySvkNEXtqV4wtP5o6zHx5v6/ToHuzRvIEL/B6HWaueeLpVxMHs4KP0OsZgWTV4oRI6epvo3f+nvJknPfQ1s20YDwH5YIajISStIYcW+RVph+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466178; c=relaxed/simple;
	bh=jixF364TkbK2Igt3/HGdQuWg6tWz+ZqOQZ4HyGJTdOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPbjz9vU8WBJGo1Of+gW/0ubNhIHNIbDv5O4sVinRU1+hJ2o7JiLr2zad0vHqS0t7eWSa3R6dmWXgjbsUDsQsnNFyDpRv8mXiWUw9YXSjtuRgooM+ymgvIf/tnGSGg2aVil9Y5OuBsa1ZeyUXvlXQ+Aib/cfwhb51NuFkmQRuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so5703149b3a.0;
        Wed, 04 Sep 2024 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466176; x=1726070976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pzehrBLyK49q6wH319bxU19XIUnBWKQncXFMskXW50=;
        b=rJmrPz8zn/Sc8z4e2JWsOnpS+hXhcZqvsy4izgDmKMimL+ikmCd8w5pA4zDj1KMOdI
         kWH4YelL5ofGITeQHbPRAZ3pj5FB4csB3RtcsusWyks/P/9k0KioSIX+S2Ae1I1X4Hvb
         WGRH6+vKD2T5WslWSZJccgIl7IbNfQfs0qoSgzv7/9WHmED5ggeUD8U0M0xMkSRbr28G
         R19KypoaDmkk4VJXidonrWKAnROorGUeKeYe4mfC/BXJEIsc5ThTjL49YjO0WrlylGWs
         kryPfjrrjQtb4/KGsEdzn0TXZddY+/i6lJ8fRUTJG9Nd8W3XklG/e551FbSpX7fmnN1y
         u3uw==
X-Forwarded-Encrypted: i=1; AJvYcCVXbfvqOPGYbGGaz0KFHbw/9e8w3Yxx7/TphxZSEbc1gh81QavT/Lo6pMXI2O/CcudNFevWCTHXD+RKj9kg@vger.kernel.org, AJvYcCVkO5WBxvkJSNbEpnpHgR7kRhIJePk+vyykaRz/0BsVM+OtSwTAKa+T6Vcm3ozuAJ7lZZf/iC7DTisv@vger.kernel.org, AJvYcCX1+ykZzB1zIHsI/NhYsnnF1zkeniwWGExjSudfI0pUc+QnaetAUq7CRJwedusJbP7rSGAImkFeLK23@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6S6PFm8gOf4hT9mvGXxBQVMujMFJ41XW4XuTrSCjBvYtXkbKY
	AACvTyVy7m/DN1/5A4d4lNiFMd7kxZxVmx+qrYgHUY3piTxvbG7v
X-Google-Smtp-Source: AGHT+IHKIH/LeW5L7IscOAYA6oc+2G0n3N4isKudKMrnPIlhauziQA8ZuGIC1BSa01jBMEtVfOpSgA==
X-Received: by 2002:a05:6a21:b8b:b0:1c4:c305:121c with SMTP id adf61e73a8af0-1cecdfde989mr18571625637.42.1725466175866;
        Wed, 04 Sep 2024 09:09:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778587f5csm1767498b3a.121.2024.09.04.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:09:35 -0700 (PDT)
Date: Thu, 5 Sep 2024 01:09:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, joyce.ooi@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
Message-ID: <20240904160933.GG3032973@rocinante>
References: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>

Hello,

> Convert the device tree bindings for the Altera PCIe MSI controller
> from text to YAML.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: altera: msi: Convert to YAML
      https://git.kernel.org/pci/pci/c/f04d277ff328

	Krzysztof

