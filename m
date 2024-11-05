Return-Path: <linux-pci+bounces-16021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575A9BC208
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DEA1C21782
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46FAD51;
	Tue,  5 Nov 2024 00:32:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48987B65C;
	Tue,  5 Nov 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766739; cv=none; b=aUAjZtF0tpcGjoykHawdMlJZgEQCvyiT4Hy2pK2Eo7DW8+ymD6lRElW6OWfyYLIMdalEhwYLbc0PZhrqfIpRKK04asGQA1Q9VWnQjim6aGrsn2kEoE2ecIIQjhQu9iPr+NpqPltXkjPJvfK4YVrGljcghTXBdfaiTgXGvWNb7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766739; c=relaxed/simple;
	bh=BJoeVM64nHvQI9nb+JQ4yzqQafTXnoxlqLEr+k9ifSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsOJQA+yQD/lD/l+uNZ/O659QZoACuEgJsLmgpV7espN0KHNB9noR456gry04e80oyUUBFdOXRXeDz7PFGer8/pQaO4bEj2N29p+Oe/MSTJx8Xmy/KEVPMPPiZaK7ROfPUmUc3wBd+7Gop88KIe0XManyRpdkdaGXxBKExNQ3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so3515757b3a.1;
        Mon, 04 Nov 2024 16:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730766736; x=1731371536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVFKOV2U1tZu5ariNJuZSEYQCGwrXBb6JURzVqRRFIg=;
        b=nABZ2wlwsdwMrwLRF2G8IjYhWxPA743vCBuxVFkzr0c1VroTtTcQeF0KIWyhFJcSlU
         KQOJwKR02I/RY/YOniv4MQe6pLSFdxRFWtp588N97ft3cliKzk1Zfw8bVmobClAbwu0S
         tWHxXl8/2NV6VORs91TjN699icOQmDYTTwzaJu/4ruNxeFZCcFzmcUg9+SnV7Wdrvc9+
         nZUtwsfoO4EPukBEb01KSGsE6Sz4L0ZRtMOm4h+OIAsbEJCLzbz5ygXtM1gz0tsL9HYq
         qhq6VEu79yKAPvlAEBObR2Q+AIjUGu4/u7b3lqHrXvUvkTIz0Z4VX3QFrjkZV6VHah6n
         xXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1CXbMAVM8olXQmryldLOOCCtSuWJaWw/tGmXglKtxxZaIgASYXtXhjUqzJM64EsXKbud5mg7ztEa@vger.kernel.org, AJvYcCWQeF3YI63MbYcAp7G+Fn46OP3Tmg5qtat27e5mn/C/f/+W2CAq4N8CeFC/bfE+Mlbv8E422N25RGVYxcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXc4oag4YpFrEeUM7v0seVDJ7+5xR+JMvdviDP8RUeJZMBkIiF
	SZwT3rTzdYYKHdLNN8xmDLF+l2Bk9KGmt5LZoQWjB6zBEVtMaO6FgGgUA0CO
X-Google-Smtp-Source: AGHT+IFe7Zrh53Gk5JMJVfagTghIwtCaFVjaPXkfpfyJUjZgVj71OYdbph2ie1Xr9Hoazgv2NdD2ow==
X-Received: by 2002:a05:6a00:2e93:b0:71e:41b3:a56b with SMTP id d2e1a72fcca58-720ab4c5d9bmr28160923b3a.24.1730766736559;
        Mon, 04 Nov 2024 16:32:16 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a002d4sm7821587a12.70.2024.11.04.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:32:16 -0800 (PST)
Date: Tue, 5 Nov 2024 09:32:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before PCI client drivers
Message-ID: <20241105003214.GA1614659@rocinante>
References: <20241103203107.GA237624@rocinante>
 <20241105001206.GA1447985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105001206.GA1447985@bhelgaas>

Hello,

> > > This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
> > > are always probed before the PCI client drivers. This series addresses a race
> > > condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
> > > the later one probes last). One such issue was reported for the Qcom X13s
> > > platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
> > > sequencing: request the WLAN enable GPIO as-is")'.
> > > 
> > > Though the issue was fixed with a hack in the pwrseq driver, it was clear that
> > > the issue is applicable to all pwrctl drivers. Hence, this series tries to
> > > address the issue in the PCI/pwrctl integration.
> > 
> > Applied to bwctrl, thank you!
> 
> Should be pci/pwrctl.  bwctrl (bandwidth control) and pwrctl (power
> control) are quite different despite the confusingly similar names.

Correct.  I moved patches to the correct branch.  Sorry about that!

	Krzysztof

