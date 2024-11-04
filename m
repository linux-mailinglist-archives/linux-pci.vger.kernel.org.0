Return-Path: <linux-pci+bounces-15977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2B9BB8C8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA908B22954
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A51B392A;
	Mon,  4 Nov 2024 15:20:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BA33985;
	Mon,  4 Nov 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733619; cv=none; b=Q1VC6kmU+iD6I9FZR9OqFEFU9CTwaR4B5ezuMCDd85TnVRVCCYUSAOj/udfczDNTipcspYo1kJ/Uj4ppt8yCqOyoLqqAyQznW4y0h0t58FoOw0uabtkn7zFBfyUWWbFtE8ogjnAC3yJZicamVQ2e8vM9IS7OEDFCAWM6HCOb+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733619; c=relaxed/simple;
	bh=OLyZU5tU0LcN7BuxUAgtRMMP89W/aHVAYfU3F1v/ptM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHdjrvFo1lEvkuw+HYEsfR9LLN0jlv7yBTtj7U6rnNSKMYEN9kwW/zLcCX697tKEquPghTttF4eTYUg7JsPoZOA//pyw8bZ4yciuGMItVPWvMQX4EV7QxO3vj8h1ul7N+u2mNXw/HedIaQIyksXuzzUyxrqPCGBd7zLHXzdV3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb39d97d1so39819565ad.2;
        Mon, 04 Nov 2024 07:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733617; x=1731338417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXakJlT9uMF0pnqKrP0GCUoDzv7wousR11pYk7zv9Co=;
        b=XfDcERhUI9uO+g6JlVnVrhx3RKRQ9kgTHqa59QICqUx87ippmhmTX2CfVAapakQNv/
         t5qM6V7wVLe6MDYrQ+eb1zncATeQyIViX9G41+tDRGTvRCUmmxBU3/SrescX5bPGPdGA
         2oHGgeyYT5ns17xS4yH8PlnbPPNayyAjH3wTSEVowF7AYLw7Lzh4qHYnY+GBOPbbFuc+
         0qtZFnmbWaKKS376zVl/mAOjFo+EElEXQkZ/s14FjpMy073P3wNyUXdq7y8vak0M/jgq
         yiMFUtpKUw+Ocmk1YKw4xRgeaovOg+uXZe9lOUEmEdoTCiA/2kEhF2NwT4/n8KNoiLzu
         wt2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIjob/uc4vHuql203wuSOa/M+BLB+el+ybcd7Ezb+gNmY3tn0B8tDSQhGUXLIczd/q0z8jIKC3GLFzvdk=@vger.kernel.org, AJvYcCWDKxjzVXap9QRA8T7OhsBwVmBKb/VLVAGGjGnj+Heio+iqdlVr6n8l7cNUn4XH9eDBu8y10XkqZdHz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WtPCzsO6pvlKhAKmclFfQxyg7MHh7GHFffUx1ehcNDSgQnY3
	NLm0TItXZ30fnkkWSoFwU8974gXnqG/EF5iCjue+kaPjNMvaxc1i
X-Google-Smtp-Source: AGHT+IFSpLs5pynctX41cG49jOy/TRgnzBUWbXzntToH6HnOeihZiHsr2R6TXjAQzTMkwx+9d3neXA==
X-Received: by 2002:a17:903:182:b0:20b:5b1a:209 with SMTP id d9443c01a7336-210f74f48efmr275371855ad.9.1730733617242;
        Mon, 04 Nov 2024 07:20:17 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057083b8sm61833515ad.100.2024.11.04.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:20:16 -0800 (PST)
Date: Tue, 5 Nov 2024 00:20:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241104152015.GB3388469@rocinante>
References: <20241030103250.83640-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030103250.83640-1-eichest@gmail.com>

Hello,

> The suspend/resume functionality is currently broken on the i.MX6QDL
> platform, as documented in the NXP errata (ERR005723):
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> 
> This patch addresses the issue by sharing most of the suspend/resume
> sequences used by other i.MX devices, while avoiding modifications to
> critical registers that disrupt the PCIe functionality. It targets the
> same problem as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> 
> Unlike the downstream commit, this patch also resets the connected PCIe
> device if possible. Without this reset, certain drivers, such as ath10k
> or iwlwifi, will crash on resume. The device reset is also done by the
> driver on other i.MX platforms, making this patch consistent with
> existing practices.
> 
> Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> PCIe device is connected. Upon resuming, the kernel will hang and
> display an error. Here's an example of the error encountered with the
> ath10k driver:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944

Applied to controller/imx6, thank you!

[01/01] PCI: imx6: Fix suspend/resume support on i.MX6QDL
        https://git.kernel.org/pci/pci/c/1a2a9024f84d

	Krzysztof

