Return-Path: <linux-pci+bounces-25590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EFA82CF2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724DE44077C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116A26FDB1;
	Wed,  9 Apr 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYkQpO8f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B521129A
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217809; cv=none; b=o4/RNvA9yl1IdmUcEn6wyNoPo6cuQWqroTOxhSjnvzVR9G6u3KUBkJM5/bnMA4Nf8Vw1Cl+LNn/DdR2HoLC+q3qmJyuoQj0ujVSYKuSNqE7hqSidNEwXSnkZYaPlp5CLG2+2u1D5FaBC59iI6IX1+fEKO+cndTeyg6E7r39w3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217809; c=relaxed/simple;
	bh=Bqdf1Et9LwlA+0JPynFGPhGeW3rXhOgyuKTlk9gJvKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXSt543HFr77H7EB7mjs/eHnVx35TxSXjFStmguf13huY2F9yz89yNP+GjFOeIuEpn+W8Y9PJPI0ytfs6baUmtv6CQhxJ27HNbk8i9lTjjLmbjBfxff5l4PHktXjr5t4yZlHM8KtQo1i23+7zlu/aHxIQsOO7JFYgjKsAQB3o7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cYkQpO8f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22401f4d35aso82126715ad.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744217806; x=1744822606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+/H0ybkUq7HVu5uBj7V7TDncclF2UN1EMmyx3scUCw=;
        b=cYkQpO8fa3uXJq/wthZ0SNVpl9yM/Iss25zef4xWFjF8MxnKw1KwvjYSeSz2evzwGr
         uXWzznU42360YZkpyUzV/iFw6v8aqWd7iWwt8aUh86U+W4+Klifrdjz3RXzfxUoh6u54
         CRMLrmysltdT56/27tINIV00FdE5uzx6Mvuf+RWnhbJKjc6qSwPMNm9thByAJsX07/Hp
         QIgY1QgtPnFN1hOroUZnBMQZnuio2aBjhMzM899s0nPqLp/heSOGo69ojKrhSlu0zqgV
         sYpLXmKIV0//skFOM7eZc/54kp6DZZDcN5lBM61Gcx6eYC1if+FfTzxvrjKDbmV2ZzB6
         HtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217806; x=1744822606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+/H0ybkUq7HVu5uBj7V7TDncclF2UN1EMmyx3scUCw=;
        b=EXfWVU9pWIp9tDsBCjjfUTF9nL+95+GIt2I4MQsshHwNqi+f8+NJWUYV7tKjWhA88k
         fpQtUeir8n3b+vgnrrbJDFkmzG58pDlqgUwV33HWD2BX2uGzSxF6mkOMJNfBWJE9RgSB
         IZxI2GJgPB2ZdyslcSYWmxkk1CZPnx9Rm+1PW8zTrcqckzMuRCOIgfMtWCO2kf5Z4ABN
         z8IYu0cYhvEsd6MtLmAi9OQPnx5C3tPGkkv8+p+WJFJNZMnLN9DkkBB0IrmrT5ZrJHAp
         YteuFgTVuHpF+XbjhKcjh7pMWVq11ng7oGzp2ZKCqidBu9iyZ1C/Oh2WRhLLjtJ4mj7h
         BYwg==
X-Forwarded-Encrypted: i=1; AJvYcCXTEVoBx/8RgiweCnfe69d0l17S1ByU8JvS1haTeZYuCJK+A+ts5zigkW26jSuRPX8Rs5O8SwXYV6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrA9UytzxHn6EhkH8psCC/aZBTYM6zv6XFiEAjWPoG2ZwsCv1e
	4eTDLxU1YxUdH7YNI5t1XELAb/Fb2aiCs19mqsFGUlm4YrD0EX0BRbob6I1wRw==
X-Gm-Gg: ASbGncspitGGuIgbRi9l60wSARKLGUzxssbh9ZIWylrjaTF9FsjbhwikWXvdZJh4bsq
	4uBTx1tFlCOs81OSy8Ad+/Ef4EFtjt4eJMWD0XiE5DjAFFrOeOvCh3+qK1MwWPfPLd2iHqZAdRE
	FtXHOwYwlU3fDxOiiaKLJ0c+ExQtAZQ58d/a2BNpYJeU6K+u16DosvLYRjjzkjb7CCAvM+eNIyh
	8/R7+w1npnOTO5WPiUCYF6J1J+f3kIfhaD6BY7sMx08tUjLoL79Y+JtLcjM+56bzbUVlySFPVhA
	RoQyUe6kbQ/ESYVwHEZBkyT/Q9RA0SGwtf8UwW3SAZsxCemraBs=
X-Google-Smtp-Source: AGHT+IFz5w1COIo2PYC62wmrQx0adK5Tc3rBe8Psp1oZp/1xQGb6NWLXzX+rUW4TKFX3JOsAMmmtsQ==
X-Received: by 2002:a17:903:1787:b0:224:1220:7f40 with SMTP id d9443c01a7336-22ac298441fmr50556105ad.3.1744217806079;
        Wed, 09 Apr 2025 09:56:46 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cda517sm14384085ad.250.2025.04.09.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:56:45 -0700 (PDT)
Date: Wed, 9 Apr 2025 22:26:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, vigneshr@ti.com, 
	kishon@kernel.org, wojciech.jasko-EXT@continental-corporation.com, 
	thomas.richard@bootlin.com, bwawrzyn@cisco.com, linux-pci@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com, dlemoal@kernel.org
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <itmjxj5kuy7cloeplhwqxyumcx7rrzvdudxilg6fswrtxqcl7l@oa2uvswe2ups>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
 <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
 <20250319103217.aaoxpzk2baqna5vc@thinkpad>
 <Z-vN8_-HJ0K1-1mH@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-vN8_-HJ0K1-1mH@ryzen>

On Tue, Apr 01, 2025 at 01:28:51PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Mar 19, 2025 at 04:02:17PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > While I don't intend to justify dropping pci_epc_deinit_notify() in the
> > > cleanup path, I wanted to check if this should be added to
> > > dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
> > > is different from cdns_pcie_ep_disable()? Please let me know.
> > > 
> > 
> > Reason why it was not added to dw_pcie_ep_deinit() because, deinit_notify() is
> > supposed to be called while performing the resource cleanup with active refclk.
> > 
> > Some plaforms (Tegra, Qcom) depend on refclk from host. So if deinit_notify() is
> > called when there is no refclk, it will crash the endpoint SoC. But since
> > cadence endpoint platforms seem to generate their own refclk, you can call
> > deinit_notify() during deinit phase.
> > 
> > That said, I noticed some issues in the DWC cleanup path while checking the code
> > now. Will submit fixes for them.
> 
> Could you please elaborate quickly what issues you found?
> 

(1)

dw_pcie_ep_deinit()
	-> dw_pcie_ep_cleanup()
		-> dw_pcie_edma_remove()

But dw_pcie_ep_init() is not calling dw_pcie_edma_detect(). It is called by
dw_pcie_ep_init_registers(). So dw_pcie_ep_init() and dw_pcie_ep_deinit() not
symmetrical.

(2)

We are not calling pci_epc_deinit_notify() in non-PREST# supported controller
drivers. I think this could be fixed by moving it inside dw_pcie_ep_cleanup().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

