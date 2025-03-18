Return-Path: <linux-pci+bounces-24010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA7A66A67
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195513B7B4D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831071B85D1;
	Tue, 18 Mar 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoVdY2Rf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBE1714B2
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279393; cv=none; b=TAyM9517Xkxt9oU2AxqcreKaCyeBgugAEWHuiWHxqSFODp3MhBsPu6SFT9qxH4aRImqgGUTOE6N5P1V6QpIEnIF5W2EXKcUJo/7nw1hLsEDHU6ViQJZDFat1xtxK3Wjv57tQz796+0ZF+OO4gI6gMv0tZB4IDb8z8m3u6eaWhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279393; c=relaxed/simple;
	bh=gXPm3kcZF3+oDmppQ+334SBVKq7jJ3dFE5LR8yR50tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0hJDDkzw4nHqy5Tk6ZMxb79gvCPf70D7583husv0ZvV08PmA1uUzzxrXqv0IEUS6HRvYyG+sie3m5D5milam58MuhrgPUm7uV+SApbvtqcIk1MgKGgRDQdjxSNCSq4QWM3UZAfC2WFg6tjwzBVWWiRCcXOOBA7p4zSGeWZLOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoVdY2Rf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225d66a4839so63817505ad.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279391; x=1742884191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A12k4qeGrcm4gcl/9bVidfTpbUgQrdSy9MhFzNz4AhA=;
        b=MoVdY2Rf/ND70JowWvSifok15/AOgdHnr2MXM0zMAtpAgqrDk9Dltvpm4knU9Ki/Qf
         3ffymgiQnuP96WR1PYXo4xZUpRaSz8U1hcD9brp4E/tuAXIqaOjETGgSf48+6y7N8yQX
         26XpSVww4s2u7lpoA2Yzg2sDPFFJwlz0jCdRYdOH+XFDeTXkzSxa8xd4BnLS6fbPL50G
         d7kv+fhtCVBvZ3fKqHsr3JiFnWbXZlmQb36elv+qgoCQjGO5Na1j0FlvbbM1jLc+LQD/
         /guYl0MVXju2s/rof0xFFfFEfPtPEpaWC4u+pupR90XVs4dFYbGTM+5q+XT3tE+2pIQ1
         eXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279391; x=1742884191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A12k4qeGrcm4gcl/9bVidfTpbUgQrdSy9MhFzNz4AhA=;
        b=S1BVTQdrXWEVQcNBXo+YJctjRz/kfHkiEUFOglWCMP9WKdqIbFzmigH6laGowa24JD
         iMznzPmFEx4uSzfLqosK7NtXx+mh6j/WJanUI1Nq5dLxd8Ynp2/ygZF93aVmrsZHtMAa
         VN/QnS0SVeRqjXU8pRxcWDtcyYToNDtYB4im8ZpqqQpOIff1GkM1RnFq39zt4gBqCnD1
         0jk6f7j2TjPgSEi/Oat5oZD9IqbZFJpYNjcLuB7fSp8MyzKIM5HRksaaxWzDdr3Fqfsm
         nZe/dpjKBMGaQcsw/YLSpsX1kJuqLMalFmMzDjDO/2FAs8qtFuEUds9pBqhuy3/6vRhr
         VaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGxdzWm9bcNMCKAT6VlxH/Fio99rlzVaqghZ5AFYtPtqeLa3IlRnYgn2ze85c6MTtkPSlegItUXiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFnpVJhDXYprjsiSmqDAtnGzOURcpeVQTbttOO6dHeNog/6bD
	c+VgmAKRmG9xc/nIRycfmtbDoSRDL6rZQZ2MnI07I09MJ37HFdjcQ4Own5W6hMcwQkaQKAbOi30
	=
X-Gm-Gg: ASbGncsdHCxc4vPLK68mJKycoAzwcB+MUOagBInyl6dPiMD3mPD4wRYHaj9lT10Vjhb
	VwPww3gkCU6umqRGHn5r5dU0aS7bdyacJpWHKCDAN+2MDrCHlanqqL2vLjshpXF+v9egUHmkA6P
	p0UGdYxVh/v1A5MO49LKRaqr7g0qJp338oNAR98NOrhQBV32hb2uPWZq2QFZqU2k0Tn6DzfS434
	7bmWqpOu+lcxnlX0yzPP2ZkbCEXPadEMtWSGV4PnAz8Iv+LZfxXFRkgBCOWvKGiSoVrizMp7vXy
	2jexnmOQtfVctzDw43fHM8aGhSXndgFq67ATHKAkpgfbcb5rJpRXMJlq
X-Google-Smtp-Source: AGHT+IEgdGCXL7flzUZEW+pWL5oHbPJl7DOH6hC5BlW+wvEvlQn9XYoZZPYl7q+Ag/0MvIqLu5V9og==
X-Received: by 2002:aa7:8dd8:0:b0:732:706c:c4ff with SMTP id d2e1a72fcca58-737579326a4mr2773991b3a.7.1742279391229;
        Mon, 17 Mar 2025 23:29:51 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c95basm8246235a12.15.2025.03.17.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:29:50 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:59:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Hao <kexin.hao@windriver.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: of_property: Omit 'bus-range' property if no
 secondary bus
Message-ID: <20250318062946.2udvt5uryf6y2jmk@thinkpad>
References: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
 <20250311135229.3329381-3-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311135229.3329381-3-Bo.Sun.CN@windriver.com>

On Tue, Mar 11, 2025 at 09:52:29PM +0800, Bo Sun wrote:
> The previous implementation of of_pci_add_properties() and
> of_pci_prop_bus_range() assumed that a valid secondary bus is always
> present, which can be problematic in cases where no bus numbers are
> assigned for a secondary bus. This patch introduces a check for a valid
> secondary bus and omits the 'bus-range' property if it is not available,
> preventing dereferencing the NULL pointer.
> 

This definitely needs a Fixes tag and should be backported.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

