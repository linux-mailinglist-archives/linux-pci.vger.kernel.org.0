Return-Path: <linux-pci+bounces-14502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692B99D5CC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C673286CD0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F81C7287;
	Mon, 14 Oct 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9hQNjy2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D631C331A
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928105; cv=none; b=b4+j2QJd2owafiZYRuwOk9/jcBNr36zDNk5pgPnCbjrGOSTDNmjo0pmM8YDzs6nOfm7LjC7OQz5ptuikuEbPvO9ZI9FXocxGf//X8XSH3UnT88n2I6HZJak6J4dEemqXw6XKlGZiMS86hVo2tabQmr/yp6QKCCmix/ONKL7DpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928105; c=relaxed/simple;
	bh=hkA/UwlKxHuClMD9lIsvdvS3GwQC+C6zQ/fSJ3ps2fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZPPPK7nA1OOKqPsjuzu+2g8N2euacBqln/TBcv9YaDqxDXC4GmaMUby099etqnXNs+Ho7lTZXQClTk6TicUlhn+BWkZi59XjkdPxDEp7n295rrgYKeWj9LgOmBj5bHU3E3N4Sno7+8dYAoiz5UUWCT8Ffw5yDRnj0C5WyQOo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9hQNjy2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-208cf673b8dso47077345ad.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728928103; x=1729532903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZHILu6A3GzL8h1J8DM4pk0STE1eNYqPdJWCjpPQNIQ=;
        b=k9hQNjy2Om9GwxW+QB+n+ha118FUjBJCK7feuJFBHsReSaswflow+XrSxSiQVTbe8X
         cJHWZ0fODV9pnWydkaXjK0YDG9nRL3ycT9KlWEggL56v7s8L8HOozyQbaAIhWbb1eVJV
         NY3jsOZkSu/Duc25ihIhEXODYwhhMdGEd4NP/CC4pdvEwjWv0fnE3kVe5uXgokN/1+FH
         oJGGzAVJZHlUZ7zXTC5iZAtSg50CjbNldt+v1q/FhwzkBzQXBoeFKE2Yz8Ktl2j5+sHe
         hj6YYCAdMJKwQdH6TJeRVa4qoM/PTvwfXpvWAAKkUWVv6PSbM4qkxdR4rHdgJVJNAtms
         oO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928103; x=1729532903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZHILu6A3GzL8h1J8DM4pk0STE1eNYqPdJWCjpPQNIQ=;
        b=h9KDf+u+H+PCA2mEsLP6UXo5hDgQWGniBj/MzHFRfGrT1INeUm30p4vdb8lI1ZoCPK
         FFx8kOTbY8hueC68cF/osVtpN5Rtczf206OfQ+PCa6xJ6LV57J57Xq0ZaPL81r7GZX8s
         KCmCU84iHoPOx0oCowXF5a+BRr4wLAX9LBAGT9d4I28MWxq4sK/077Gb4COmXXHGJpmv
         +DElPsls56khNiCf2ZVRTzwP7H3t9uI8HBh+7uxmDNbeDfGdoZr8afoVHj1XJPqANK0C
         9gsQ29E6mDFlBQJL5oy1NhiznnklqtnSgd149vqDRfvy25ZorPBmWID1Tk5/gt50l5FR
         tl9A==
X-Forwarded-Encrypted: i=1; AJvYcCUx0OaJqyccjBDFugnMDfbdVy1boexlOT+nRtbWPKl4o0LsVGvCle6MEsi1o8TMnqJDb7Lt7P53cHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5HeiWtaaTsDw23k2mLXBtVt3PxGFITiqQHeCZputxDLatSVs
	eMleAXCKXdvX5bB4oSvr0JiJuqzAXt3Qzu1JRavtBxXIAVhJGX6ubJQ2B/Nq1Q==
X-Google-Smtp-Source: AGHT+IFHXuRp20dOBhnprIKSxRxy1eZ0bHqbOKCNaqgV8Jyk5O/y2jlCAO3z1JgoqmcK2fbMcYR0Rw==
X-Received: by 2002:a17:902:c951:b0:20c:f27f:fcc with SMTP id d9443c01a7336-20cf27f11e8mr49200475ad.44.1728928103217;
        Mon, 14 Oct 2024 10:48:23 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c348a1bsm68689275ad.284.2024.10.14.10.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:48:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 23:18:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241014174817.i4yrjozmfbdrm3md@thinkpad>
References: <20241014162607.1247611-1-quic_mrana@quicinc.com>
 <20241014172321.GA612738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014172321.GA612738@bhelgaas>

On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > bridge device. To enable runtime PM of PCIe host bridge device (child
> > device), it is must to enable parent device's runtime PM to avoid seeing
> > the below warning from PM core:
> > 
> > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > with active children
> > 
> > Fix this issue by enabling starfive pcie controller device's runtime PM
> > before calling pci_host_probe() in plda_pcie_host_init().
> > 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I want this in the same series as Krishna's patch to turn on runtime
> PM of host bridges.  That's how I know they need to be applied in
> order.  If they're not in the same series, they're likely to be
> applied out of order.

There is no harm in applying this patch on its own. It fixes a legit issue of
enabling the parent runtime PM before the child as required by the PM core. Rest
of the controller drivers follow the same pattern.

I fail to understand why you want this to be combined with Krishna's patch. That
patch is only a trigger, but even without that patch the issue still exists (not
user visible ofc).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

