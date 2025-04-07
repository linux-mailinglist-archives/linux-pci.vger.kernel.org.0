Return-Path: <linux-pci+bounces-25423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D5A7E91C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522A23BA4E6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E62144AD;
	Mon,  7 Apr 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMnClYon"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1E215186
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048272; cv=none; b=eU2kJF0PHzIok9gZAv7o2WXD8JcmJry5AYk/slTgEQpU+/jUqrlI9m2wFwbzrNdhZiy+b8mT4WZKJQ/5FBd3snpR32XNQ180CTVJJfw/NXiR77BQyOnEDso50uArfUf+qwGiX0Fe4lErA/qVXDStcxk4LExv929yLJPxxQ+/244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048272; c=relaxed/simple;
	bh=0zjNM9dFoJpTEvEmQW4onWMxpWkB12U2X0BMSHbeSbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwnP/l095Fl3c7NOfUd9RegqWv+ZoXwbE78NFYq4nvTxdFCjRg4sErIn01M/Z19NgMMXXubUPJfC6JPw69Frz08JzBy6aXYbixH5evZXJ4hqqAYa6QTO90FYlC4h+YzIFLRmqxnUFbsvAAOOqrHSlQy9k6GGo20MXUfrAWv2ohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMnClYon; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22a976f3131so18881075ad.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Apr 2025 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744048270; x=1744653070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VY91Ztk0jKcUdYVunqeI1fUjcT5ASJ+JXFcinKfCuVw=;
        b=zMnClYonMcIg6dTsgkoNqCFlQA710y4aGg1YhKymCGLkcWBNfaCh02mt3bNZ+Gc0Dt
         ZbxGmWBMwuVQcTnImhqlaEnqkD/YyeF9ZX8fV3eUX9/h1f6bMS//HYnReBguZV1Pkk7r
         HGPwvBTfK6ADyG6OXdtitO/m6WyAiCcAFJuo9jzumUZ6eNQlNnlawms/CpjapoSAMwBj
         F0j5tFONa1vFW1p+3Luwe0Z/gv4RjKHOzemtHUpE/j38TL2tkW+Sl+vdshtPpLbqJ+nB
         Bz/stjWM6Ot7xMAOOpmtZuuSObPfGYlEAEWPTlLNxInxKHvZesb6S4d8OdmXHQ9ZFyIs
         LMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744048270; x=1744653070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VY91Ztk0jKcUdYVunqeI1fUjcT5ASJ+JXFcinKfCuVw=;
        b=knwTUd6Iqs32SGfd9RDDODzJDRn0MmeL2iyQfUeN2mSTGRc3NrCHDhpbKY093ndFGP
         fthCO5dJOCw3BnN8uac+XZwUGmB1dsYV/Ao4M0dOBi0lkllZsEEngleqpg+BR0UgpTz/
         MVDmBKRUH9dKV+z2nwKT5Z3eRS6kYduD1NaHqTg98g8Ka+jdNA3ArhTjF1VJrRIc9Gmf
         yEuH6c4zXRQyoIbQN4xyqpNAVmbw7Sy2pf4SufIv0Kot/JXz6uMDgKT5DvaopeCX1+Ei
         evMeerAnJZSWADrAaNYVpkAb9tXAkEAdtRA2iBoNnEcJh7IIMFwkj3N9GBbj/LiU5pCe
         cCRw==
X-Forwarded-Encrypted: i=1; AJvYcCUvDAt6HSlv7HcOw2+djxIboE73mk1zXDapajCQmHCIZ8Aky9RzwnPlU1hpEbR8hp+5xC6Pbpj4k5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOf3FDvdsRl3NP9V/6p9ps+lRF2azU3O2IUQYG843NR75MjUu3
	OCZZEVlgv9X1vJ95BFSsz6v4ZxsR7JQKXnqmNcEl3nmNWwm61X32hgBIN/2fzw==
X-Gm-Gg: ASbGncvkiXHCP4tuMAmCpd7uB/rVHiCkI0p0zBLdMnRmWNhnBf70uCOBM8F2OKhENUC
	n2XxleImR9TLhwQBD/Y0FIhWQ0qNjxWeDC5+326fcKRuhmpYLs0ybzgf14xqtSiIaKMfNyjIF2i
	x5qjDsbb4XxHTpWY1nvQ7GGBbJleS3H5fpQ4fZ/TBpzk/mi99e1zeG0OidqtNN4WyAii03ebFm5
	dNR/zTuQvEO8tk+Li9RMD7DfgckJT4t/S/B7UQmcNPmVOOoFjJbGeqSBQB2M6F2qBqsxp3F1fIy
	pIv+MnnhNxhB/XufOl7YKDMb3h4G2dcEfvjAkCuNs0JiWboIavOKqJIk4KQtWIFWM9s=
X-Google-Smtp-Source: AGHT+IE7m+MVWIOyNIrcTveZ3d0m14foKlW7+98jfMKafcP4qh7P2NiqavTJmiS80pjt1sxX5q7qJg==
X-Received: by 2002:a17:903:1aa7:b0:224:3c6:7865 with SMTP id d9443c01a7336-22a8a85a2c3mr169775595ad.3.1744048270554;
        Mon, 07 Apr 2025 10:51:10 -0700 (PDT)
Received: from thinkpad ([120.56.196.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786608c6sm84002195ad.148.2025.04.07.10.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:51:10 -0700 (PDT)
Date: Mon, 7 Apr 2025 23:21:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, mrana@quicinc.com, 
	yuqiang <quic_qianyu@quicinc.com>
Subject: Re: [PATCH] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Message-ID: <t7urbtpoy26muvqnvebdctm7545pllly44bymimy7wtazcd7gj@mofvna4v5sd3>
References: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>

On Thu, Dec 12, 2024 at 04:19:12PM +0800, Wenbin Yao (Consultant) wrote:
> PORT_LOGIC_LINK_WIDTH field of the PCIE_LINK_WIDTH_SPEED_CONTROL register
> indicates the number of lanes to check for exit from Electrical Idle in
> Polling.Active and L2.Idle. It is used to limit the effective link width to
> ignore broken or unused lanes that detect a receiver to prevent one or more
> bad Receivers or Transmitters from holding up a valid Link from being
> configured.
> 
> In a PCIe link that support muiltiple lanes, setting PORT_LOGIC_LINK_WIDTH
> to 1 will not affect the link width that is actually intended to be used.

Where in the spec it is defined?

> But setting it to a value other than 1 will lead to link training fail if
> one or more lanes are broken.
> 

Which means the link partner is not able to downsize the link during LTSSM?

> Hence, always set PORT_LOGIC_LINK_WIDTH to 1 no matter how many lanes the
> port actually supports to make linking up more robust. Link can still be
> established with one lane at least if other lanes are broken.
> 

This looks like a specific endpoint/controller issue to me. Where exactly did
you see the issue?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

