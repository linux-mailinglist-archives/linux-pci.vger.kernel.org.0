Return-Path: <linux-pci+bounces-22256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A21A42C9F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084EC1717FE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CC1FCCE0;
	Mon, 24 Feb 2025 19:22:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41161FC7D0;
	Mon, 24 Feb 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424940; cv=none; b=pDG3eu4ll5/I1DNJqZ22sMRUW+SnVjYbUn1WAIjjRhmyrpS52mUzEaIQEfqZlfd3FFOoeohJZiHm2kD4eeJEGGidrreWw4+u0H06UeR+Z+6mmBOVHrV4Plr9yaShDJqM+rT9MFOVB4rKVq5LGjT4VF3mTQdLQeSMgkk8AkaC+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424940; c=relaxed/simple;
	bh=asplSircB2KkPfoRh/3ilOSroPQNAAH7pKA1/tcnHOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXhm0cgSZehbnk+kynrSz0nV9IJl/rdUpNXteMTCyiwb6FZsieE138bpLTIm7hG2iEcFdcIdwb4tmu7s1TZtNEFGklmOTJLfi7oU6pDKTjf4LwOZu8Ag/fFYgrOCs0VNARuN+sm6g8S3jZcrwL6eOVm3n0nq3gbaHm9F/e67tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e989edb6so131255825ad.1;
        Mon, 24 Feb 2025 11:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424938; x=1741029738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lby868p6RW66d7wZAeSh798V7d6U5V3PYrj576BWJWA=;
        b=lH+jv1Nz0+nXFsjIC5YlutK6OyQsQxQbD0EPNZNMNm6fneMz2mede/y9201UzxCcYc
         6aRPhOqa+aUTc7A4G5BXdL/gDKPIgJUtQ79xfIIdt2JMrg/sY+JvnLfq6AHgbHS+swXf
         zBHvkcB4QZ29Yh9JYIi3ty5apa4+Vsx+g2e83c19YJ6YXcWCnEbvT65yLCjc5eSArHHl
         +En4BT7L7LRpex83+uH2vjx7ESa9Tpj0peY1mLjBhpvnygnh8DWKb8gmrCptqmyT8tJ7
         oOd65HKDxnMJHD4fm9ZsNMd07w3o9AWns49ofL13fN70koeh07TBDYsmEyrH9W0Ha5So
         vOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSCk2DZjv7+v/uZp2//kf0vhoMewzqT3WH50YkBNUOiipAOPDB+EMaZ2D+gEEQuGqG8roDUGTzB8Bn@vger.kernel.org, AJvYcCXliCReILPKgULz/SrXyRRc4623lUE/mIJik5uchHKueXf0xi5uCjx3W23P8UK+uhpT3qB3ZkmMSW29@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5ZH34QQopRasUnAIaXMXmK1+LKcC6HRoEE9PL0pET30JMg16
	Xc0KboxpSkYOgEvycFEVyDnx737qz7RgVI/URkBCrRdzw8tOalUa
X-Gm-Gg: ASbGncttydC2wCSW/irX0aG5yuI0kv+3s6G4toDlS4P5ti6Pmfazc/iN1cqM2sbeweT
	wLUqA1phNx+3hwghUdNeq9B2awLiQAXA4Vvv/2NuS6M8fYnp6HkRSCqZ+9ByBK9Uyxs/FVM0wSk
	52MI5GztexI/RhRyg4BHodnrOc7+FGB80JaRKmNcEe75Jj2dG7HvKmXzm2frbuP0Zrm2KYppj0L
	pnjkfAw1WFE4NoIn1r94xKXTIH7aiT0JLlG+mpt5w37rhJVNSEfMg2HrOA+X4QaLb0J+Zdrl9gF
	4VrYJ3mOYnvfAG63UHJfbGq51ANv4ShFVpnm/ZmoyB/LrcWpch/g+KxTnIze
X-Google-Smtp-Source: AGHT+IGW8hzZAZs2veSCvxujXgQK7/b4vuAT5K3Ok0ANy534lraLQTko72fQX1bO4hQEcTr85MZIhw==
X-Received: by 2002:a17:902:c950:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-22307b32c86mr6987075ad.4.1740424938111;
        Mon, 24 Feb 2025 11:22:18 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349226sm185329855ad.24.2025.02.24.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:22:17 -0800 (PST)
Date: Tue, 25 Feb 2025 04:22:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 0/7] Add PCIe support for bcm2712
Message-ID: <20250224192215.GC2064156@rocinante>
References: <20250224083559.47645-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083559.47645-1-svarbanov@suse.de>

Hello,

> Hello, v6 is re-based version of controller/brcmstb branch of pci tree.

Applied to controller/brcmstb, thank you!

> v5 could be found at [1].
[...]

> [1] https://lore.kernel.org/lkml/20250120130119.671119-1-svarbanov@suse.de/

The v5 is now superseded.  Thank you for the fixes!

	Krzysztof

