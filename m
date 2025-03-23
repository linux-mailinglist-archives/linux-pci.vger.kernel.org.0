Return-Path: <linux-pci+bounces-24455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4DA6CF01
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1E316F6AD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779411EE03C;
	Sun, 23 Mar 2025 11:49:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165818C900;
	Sun, 23 Mar 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742730589; cv=none; b=qnPxqqpbwYg6IGxfkhAYxolPa5dR8b4WQQj6g4iI/fgp/y25Uc2VRM8LL/9gomjZe0zJ5TwUcg68VflUKSpU+IVZGw5BYHkYJ8ErbOqaO3K3sAtDNwq3dmdm8NMJMl74SEVDuRewu8TZ8aAHMl8nRcJjkcfNeSSLv5i8VYysPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742730589; c=relaxed/simple;
	bh=KSlkPxtkbvnmYg7pCqO91aWbA2j5AsoMlEO1YEPDs0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzTPHdXJlQHpODSqKZHwmD6cciF6k8tqDD1Ma9A6GC5QA9jj3OtZ486lFPYSP/AlzC6QVABjJ8+ETbWm/ikZaMP7Av69bV7ttw4yjTnRPL6bjcI4qeWazfrd/wOd7vmuHGKeLuer4SIWxknxwyeFapBCxpCrRSCRTtNZeT/MaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22435603572so60082155ad.1;
        Sun, 23 Mar 2025 04:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742730587; x=1743335387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmJXFLNkM2XetW7ou46ftOkw1Op0ucyZVdPTRQQOb6Y=;
        b=eMzb1NVf/Vj5WWgKvI44EHzJqusSxmsIU2YU6ANvn7bolo29qLe/WyPiBJY8e8Yc0x
         FjBhzcraunbrUBj4ttiKcmD0Gesn0hUT72Z+vFF4R3KDbMIwPIBTtQ9JCwdUYBp77K+q
         zknFN8AoUegOJbs9L9l2lyw99V2mMt8H43DHDx8kUwDW8kEan4yt63BakVF/u9bkEqrY
         0DPV+gHk/nAvwX4h0w7F8yMroHnU4lY469r6Vwla/ar4u1v2LGykjkJYHs5amNv/e73N
         2RLlbiyVk0YpAxw9zsCyGnR/qiPK+GhPeOuVpesobEIN4ytuh9kRQi2vCVezVzF7YRUA
         +UdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/k9BbTFHhXO7x+viAjFwttwR8ejkEmTQU1bH5uJjSxGqm4tYEpE28x737jRKL6tpUjcahd0Dnh6eX@vger.kernel.org, AJvYcCUMwj4Y6JoNEqqJ5OYmXjVd8VZ97NDkpHTo83+SVswoVcWQU58cw9z+XdvmJcLdNBwRrWLl2bh75xBG@vger.kernel.org, AJvYcCUU5MAGdeXPiDEddXDg7xQxXWoysagmjQszrHZ+lUAJLBW3uXYZFr3Qmb0N5FJsADhftB27HdQ714HPwQ==@vger.kernel.org, AJvYcCWhW/JpahUcG/6oixsp6zm+af3lcQUjG8TxFOzsTLyrA9EpgiL/VSeF/eWkCSJb/Jb/2OaDdyP4DTUPCN8M@vger.kernel.org, AJvYcCWpO9OJcOIS32hzyWAhoIr6r7yZGjyoDaiHqcK1SPj44iOazmN9YwvE4UTsVMhgdtWMFdPTF794Pbcl@vger.kernel.org
X-Gm-Message-State: AOJu0YztZ0FKXxyW4umDl/ktjaT4RebqoeVE/Ofz8e/xqltflMqxqnNR
	a+K/EHLU0lL25cbM0+hxQxPSDMgRFwYY8dyJwz5jz1avwSTfUYVY
X-Gm-Gg: ASbGncuU/6+29MpnOXq0Z0MoPA2qug3VM7Zz5UCdNQ8Duc+JQV0tSHbXivpDAXEkMLu
	yao29yUXgNjTp5BXj+uCy++HpKfYtyy1QDiypt7BigG/sTwpYr0TSHm4uH+4uSiSom40yqP3zCT
	nfmubhQWbl9HDLR/jCbArWuv032QOZj1jQQ6X+5g2ilkmyzcmlEtgqJ20YxbmWmSyhzsqu6qUGI
	vMTs7J6bg36tM+m3Q7jIZXIZdOUXyW8EBQVw4JXZ36xb7ul3OCba3JeB3j1tbleBH+l5y38QmGa
	/twr2cIEiMByoB1oKR9txchvNGO2iJLPRMY0IB4mAuOB1AHWflX0aRrroIXBv5Ks96yR6zBgRs0
	tyyE=
X-Google-Smtp-Source: AGHT+IE4ThMcsy7oxi3rcVpcYm41RZ76CPSZHVHzFr7nfmNqjPHyOOvhsItW38diRfaAUmga7P2CHg==
X-Received: by 2002:a17:903:1aac:b0:220:df73:b639 with SMTP id d9443c01a7336-22780e0b2efmr142097715ad.36.1742730587110;
        Sun, 23 Mar 2025 04:49:47 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f4bccesm50036495ad.102.2025.03.23.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:49:46 -0700 (PDT)
Date: Sun, 23 Mar 2025 20:49:45 +0900
From: Krzysztof Wilczynski <kw@linux.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 08/13] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <20250323114945.GD1902347@rocinante>
References: <cover.1742418429.git.andrea.porta@suse.com>
 <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>

Hello,

Thank you for sending new version.  Appreciated.

> +	case IRQ_TYPE_LEVEL_HIGH:
> +		dev_dbg(&rp1->pdev->dev, "MSIX IACK EN for irq %u\n", hwirq);
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] = true;

[...]
> +		if (!irq) {
> +			dev_err(&pdev->dev, "Failed to create irq mapping\n");
> +			err = -EINVAL;
> +			goto err_unregister_interrupts;
> +		}

A small nitpick: "IRQ" in both of the above.  Not a blocker, though, so
feel free to ignore this feedback.

	Krzysztof

