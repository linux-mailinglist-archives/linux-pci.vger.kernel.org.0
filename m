Return-Path: <linux-pci+bounces-28270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BBAC0AC4
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C8A24073
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5623771C;
	Thu, 22 May 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqlkcg7n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C5223328
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914453; cv=none; b=RFyXhIIoaYW+GZYZRIPd1ZyFfc4RKh5W8kTIKJJu5qHvYze5CmQ4l4IOvJVrCzdTO/dc/cI2a3Dw3ydTFnj1VYmC/7nup5gCpihLgTsh01E9b2Zs+9MHXMVBYByIZin+HWYoetB1Zbbvv3e9esaglb23auk0VYbgIy24b3fNmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914453; c=relaxed/simple;
	bh=DtQkUHQiAtMZoY9LNzs7hqcdhXOPWRoXKiwfHlU2cu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj2q3ceEMc7nmAbtSPHNvgzxfcV8kYk/4PyBLuzKsJULLtjXnBG1GYGA4KSRFZg+jvVFP0kvkHhN6qqtxpYVnObj/NmAoovs0OPNnkawkfuwMe8fGDhldmVw0ae8IJvG3KPowsysDhvvwMLFJ/f3FPZ5AhrpVS0x87fa5ruoIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqlkcg7n; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c035f2afso3414726b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747914452; x=1748519252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJ1gudwiHyu+TUV61FEDK/7QlJCEvUcmgmmYX9winDM=;
        b=qqlkcg7nkAkV+Csuzke1W93Z5DxDzLS4dzKMAuFeNiUvzlPwW+v5vqnmpagddFjtUv
         de+xp5LABTbpKga6iwteixLQqLBP/jKygw4o/X0QI4EhCoh/Ihiyfiza/XInqGT2U24T
         A6wfZTzHPBHqDiejZDDWu0LjoHPpIjFL1sagE7yJiuKWcsL/uvUOX8of5JPcI8y01IsQ
         Ekwm+itSY1rH0c6oTW+p0L6jLrjMbA8gXwHdMB6SZBdH6zBIJRzJiJbMQro0pNjkaAa6
         GKXkiHzZMd0PQwAo4QpDmGo0IIctqoToEZuhYEZuIMCNvDeFJSI64AtwD/lKEeD8p2gA
         2MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747914452; x=1748519252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ1gudwiHyu+TUV61FEDK/7QlJCEvUcmgmmYX9winDM=;
        b=jOrQseu9uSGdTWD482KUxPjtfE8pDneMZbaV6WTZifZzCCjOU0SziihBawQRDGrGvT
         ayhMZVWr7ji3M9Gs7sptsAujX/3LnwDXXIG9KYMO+EBghOiKN7BAtsqmt8zW++JvvCpo
         zXpFvZQAHGVkm3ZyUS9ETBIuahj0Ggk4j/T7glumYX5MuCiIbwXWPocyK9GtxNf0dHwS
         9tVeR0wgAkCVVhtA9EVvD01g1Cza1nAN1rIkSlNZQ5Z5KZM43kwHRtGvvtRUktCtBCu+
         UKmV92Pi3bs+Js7LyYFza4yL4PeKRVxDrZS2Wxzgu2uIrWD+1y56t8amycwjWifmZE3h
         K6xA==
X-Forwarded-Encrypted: i=1; AJvYcCWVbzKhljm7v+Pjxvtpp4A7QlQnkXAy30rq2ZKz+ywUv7qOHJmbtFp92NWbQW3fcjlisJNaQJEqpFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAQBAY4bBFLhD8FC5m2UoWTasBxfI4SiR/ChbaKIHSW9OwzIZ
	CRUNhV5fbcUKunfQVUSfyabzBEsHY5Leu+aUpySDC14i5ySSOvJEpLEhp3gMPoliSg==
X-Gm-Gg: ASbGncu2kf8j3DhQnLru1SyKM0CHLWyvg/8lmtmfw7uKJ/hQgbaZj69vy98iGx0HdgR
	oUchtLrrVdkDwPLVlUjejHlxhl1tIQ032xJLcl93k5kIl0k2lGr+X2DyxZIYMCjOmdLXlJqYmX/
	JegzHuI0IOSXkdpPV8VVaMvYrk4C1GvIHs0Ae/whUiYcm9/YpaUqi8xF+IAx8BjO4wUnOmjQrU6
	3Oger0nS5dKHOLmwdqVU/EwvbexTi2kvg8MYhMlGoBLxAFm6lCRZ+90a/CXB8GGNsxhfRic7lYa
	EoCBsV1O8Tr7BKiGdq9tCR3XFGexl8uzLEdJ8YYv+PI0Px+GUlICfYkdtdhxbQ==
X-Google-Smtp-Source: AGHT+IHC0b/jva12Q7TKdRYGBUhf44wv/UkRVQDXr+TC6tXwIOo1ebhkI3CtBJXlt3OvApFzHql4fA==
X-Received: by 2002:a05:6a21:900c:b0:1f5:790c:947 with SMTP id adf61e73a8af0-216218f7a98mr33151680637.19.1747914451678;
        Thu, 22 May 2025 04:47:31 -0700 (PDT)
Received: from thinkpad ([120.60.130.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6dd83sm11140491a12.18.2025.05.22.04.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:47:31 -0700 (PDT)
Date: Thu, 22 May 2025 17:17:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, kw@linux.com, 
	mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] pci: implement "pci=aer_panic"
Message-ID: <e2iu7w3sn7m4zwo6ork2mbfjcfixo5jn5ydshkefezsgtquvh6@kjdvxgiapbjj>
References: <20250516165518.125495-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>

On Sat, May 17, 2025 at 12:55:14AM +0800, Hans Zhang wrote:
> The following series introduces a new kernel command-line option aer_panic
> to enhance error handling for PCIe Advanced Error Reporting (AER) in
> mission-critical environments. This feature ensures deterministic recover
> from fatal PCIe errors by triggering a controlled kernel panic when device
> recovery fails, avoiding indefinite system hangs.
> 
> Problem Statement
> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
> traditional error recovery mechanisms may leave the system unresponsive
> indefinitely. This is unacceptable for high-availability environment
> requiring prompt recovery via reboot.
> 
> Solution
> The aer_panic option forces a kernel panic on unrecoverable AER errors.
> This bypasses prolonged recovery attempts and ensures immediate reboot.
> 

You should not panic the kernel when a PCI error occurs (even if it is a fatal
one). You should instead try to reset the root complex. For that you need this
series that got merged recently:
https://lore.kernel.org/all/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org

PS: You need to populate the slot_reset callback in your controller driver to
reset the controller in the event of a fatal AER error or link down.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

