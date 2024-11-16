Return-Path: <linux-pci+bounces-16989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15309D00B4
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227C5B256F6
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100119992B;
	Sat, 16 Nov 2024 19:36:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5418FC9D;
	Sat, 16 Nov 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785795; cv=none; b=j/PukrozJXixQTfL2GhPE86AwPIyPgR0pcVcqsP4W5kUAg6q8MG6NYZmE6ukhN6kx9BC8MMeInftALWsdoKBBxU9AIOhskb+ahaWDLuqVMIn+Y26RUElKkx6C4N9un1Tfe/Mke+lgt5oY1SrC4wQGgON51XaGSKSG17O8uFm0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785795; c=relaxed/simple;
	bh=lkzI1wGADF/FnD/JFB81Gu0+wPQI69AT19bmSW6+APs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju85bF/OR9j/q+aD7Ci8i2rgxQ7I/7BdbwjZOZ6I0+BNKfwjEjhEbn2jNudq4H4qfnLDnKwTp8jFce4QdQB3R4SIE6N7+49pk0Oat/Xa/fZPTlw/TR2xnj/TNGOjrYW3iYineebmGVxYv3nht+EgpCKqie4Z5e6hZMPD6inWUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21200c749bfso2369045ad.1;
        Sat, 16 Nov 2024 11:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785793; x=1732390593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMBmeOFD+z1cJfWMZUY9U990QGj2e0dotHng27G4k6A=;
        b=PEm4asYYuw2p5S7/SgF1udAevEb6R9AZ96mEqtFhnTVtUv+n/6fWmxuxLZmlNiChN7
         JHzwoG7HwL87z3cgRg2BgEjrIsQAroyH1MpLgf8ZlNlV/fr8dqO1MBapuC0f/NF+moJW
         7Xy1utgWG9RauCtCs/5G9TJBYDjmRaMCwRVkn0f2QWDcthO/sHRS1HvwFToRrDAZRDk5
         4nchGrhLYSUoegcHthB8/IWWLSlNeJJnNjY7iRPr0D34pNUnD2OWtKA5BdfaMxSfa/De
         U55tm671PbW4fqClNG3FTXmlOltE0UQ8iKpUZNw+LdzjLvK2Z2KyhMhJT8gQbPjMaq2+
         YUrw==
X-Forwarded-Encrypted: i=1; AJvYcCWlpwqOkeJzagNXGNZEumRykW0Tfc+MyB2k8BYK0Coj/Oc+e1GLpEUvTNPlZIyZuzH2cyrg3d7hYeA=@vger.kernel.org, AJvYcCWpaDIbcN4k3WiyBSsh3Es9urW3FEyhGGrhOI5R8EI90pr0EeoYHsCa3GtWCOduC+juG8gD0oi616UsnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40cBHEiteUsfUT7OKwYiNkrPPr0M5tpiZHHy7fBZUxws88CB4
	7d2vsg+sFYsZX8nl/kWgNIpV6TAfpJOv+GK+/CcZ0LlaqS1t+XT9
X-Google-Smtp-Source: AGHT+IH2xa4Z859I77fSb2uitgZNB6vfSu/UWkzL79Fv0vxy9lImJjzhsilgaLyM+W7uvphz5WRqcg==
X-Received: by 2002:a17:902:d508:b0:20e:71ee:568e with SMTP id d9443c01a7336-211d0d7163amr96544395ad.13.1731785793046;
        Sat, 16 Nov 2024 11:36:33 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f583a1sm30773665ad.266.2024.11.16.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:32 -0800 (PST)
Date: Sun, 17 Nov 2024 04:36:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: Rename pwrctl to pwrctrl
Message-ID: <20241116193630.GE890334@rocinante>
References: <20241115214428.2061153-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115214428.2061153-1-helgaas@kernel.org>

Hello,

> I'm sorry to propose this, but it seems like ongoing confusion to have
> "pwrctl" and "bwctrl" (different ctl/ctrl suffixes).
> 
> pwrctl was merged for v6.11, so I would propose changing bwctrl to match it
> except that we already have several "ctrl" files in PCI hotplug drivers,
> and in the wider kernel, the "ctrl" filename suffix outnumbers "ctl" by
> about two to one.

For the entire series:

  Acked-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof

