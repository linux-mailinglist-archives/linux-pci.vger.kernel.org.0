Return-Path: <linux-pci+bounces-12924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF939970332
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A071F221EA
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160F1591EA;
	Sat,  7 Sep 2024 16:46:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A023A1B5;
	Sat,  7 Sep 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727578; cv=none; b=SQGusoCv0E3jCYufvHVFj51AY/LdSKZFzdDZp9J67oGprug2wTonq2Lo/vpDwEgWmGUbptmTeCHhAmrI54XsFNAX57hBpLZMNOKMD8VYJStmJ/y9qSxnOQ3jt1e2m8vov8Y0hGiUHTyY/j5mMnWX9i+pZk5nUBvTGKXM8NSXV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727578; c=relaxed/simple;
	bh=N7W9umCEW55nauczE2H2W3OIyE0ZhBdKCzHfqPh3ptY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbE/3xroSc1/3GmApaVIShN0AKA5qDh50637wIhtD4waRjVIGUq6wUYhVDkCZrJepbTvp6xEpflgl5i9dNRYWIONpr6zgmF8KmdHZZai1QQ0mJ4rLKu6uN5QrPyJpZEZSRNPCYetVw+W9nBIkOt+Yc3vJTG+EodOZlm3owcAg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so12225515ab.0;
        Sat, 07 Sep 2024 09:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725727576; x=1726332376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5R9nTQZu/hUTP42S2EgYrqwUADDe4Pdm/gKm03YwV4=;
        b=Ur/FDuufAEag1CjVfHY/WJKqOa+EAv42nwnwNFRD5DxE5Q7aIUFqY35JPWzabo17++
         qJzLTGb3BGHch+fR/dJApYEKG6fJubS7oWZT5nWGtENE4AbO329mqJ8YIELDgcJns3Eb
         nyq5ty9h7x3QJBdTGcELrMSKAVxhNI/GJ30oXv1mhOB0XlHWLaSZVtim3AV+FsmZTfft
         qn7qRZBmsGkRsGLNXOy4rkQF6D9wThGgnbBsdGE+qolK958Sx2HesNOEpz9DWh4wtMUg
         8I7vXB+QoH4WXRpZVyQK5e2SQA+yNa2GdpLII/+kN8kneB1f3UaRYjNsxtw6SZa/3uYm
         pSCg==
X-Forwarded-Encrypted: i=1; AJvYcCVZbPUOPLVW0obo+e76zTnxn0t+Lx44e6bxRUN9cohBRluDjjzk7znWto6p7LNa6iA7eK1j07HjNuxK@vger.kernel.org, AJvYcCW/6DZ0MZ/vJQJukMDj5aIYaUbo+LDyRA8p9HuKoGlonDPxMHrnnwoM9SzsRk5/9IChB03fSHlpSS4IOm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK20E7/IS50w0YWX6Q7beAZPfK1EWCxvl0Zi2jF7wmmrpQkkBs
	2iD2ISJNoyfyxykNv4bKDHUwN4qRaPuTFF0eIjzitch9jGCBVU71
X-Google-Smtp-Source: AGHT+IHNhW+4AL/vtYy1m5e9sT5r7EuBt4u4EKhoJsDLpUAw8CxbrKpERnJGGfRriLcOhMS1mDwiQg==
X-Received: by 2002:a05:6e02:2141:b0:39f:7020:6a13 with SMTP id e9e14a558f8ab-3a04f08000amr78154825ab.6.1725727575579;
        Sat, 07 Sep 2024 09:46:15 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab14b0sm1193498a12.89.2024.09.07.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 09:46:15 -0700 (PDT)
Date: Sun, 8 Sep 2024 01:46:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: jim2101024@gmail.com, nsaenz@kernel.org, lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next V2] PCI: brmstb: Fix type mismatch for
 num_inbound_wins in brcm_pcie_get_inbound_wins
Message-ID: <20240907164613.GA183432@rocinante>
References: <20240907160926.39556-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907160926.39556-1-riyandhiman14@gmail.com>

Hello,

> Change num_inbound_wins from u8 to int to correctly handle
> potential negative error codes returned by brcm_pcie_get_inbound_wins().
> The u8 type was inappropriate for capturing the function's return value,
> which can include error codes.

I squashed with the current code on the controller/brcmstb branch, see:

  - https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/brcmstb&id=ae6476c6de187bea90c729e3e0188143300fa671

And credited you via the Co-developed-by tag such that you get credit for
fixing this issue.  Thank you, by the way.

There is no Fixes: tag as this code is not yet merged into the mainline.

	Krzysztof

