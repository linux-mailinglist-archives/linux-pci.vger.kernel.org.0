Return-Path: <linux-pci+bounces-23019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BEA50E8D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C8016672C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B415266576;
	Wed,  5 Mar 2025 22:25:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53225A338;
	Wed,  5 Mar 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213535; cv=none; b=p3ziV2YT/fNu4q9Fo7yjfnDdf55z9u8/xW1XkncDv9i8CatvyZ8CN137uF8a5rhtNOlgAE1JhktEyvCHTKudHciwIMuuBdaSlDZjMvMEc0RveCVSOv4YpIJ8vc6FWFdXK7JZwPh9utt3Ui3vnGjWQvrnj2OjLwNDdBNOngsilfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213535; c=relaxed/simple;
	bh=6VfPRCXY3JratcLwTZFKOWWpWV+HzQxt4hfgb6sELC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id8Z04YltXMgFVDvMgd82XTqtou2567dRbixq8xJ3PAjT/O29yvvnFglsu0PYkdzouozfrMCAlEACr5rxvwH8OzuZ0hadyTModPHEmvGtFNfV5AgvEYCi3COaxWtH9OXXj5PsNe7sQHfjIKbbd+Nwlc/UWYCq5AReYqqQ28GQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso16506685ad.0;
        Wed, 05 Mar 2025 14:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741213533; x=1741818333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxKgW2a8rEuZQeYt6Dm1ggMAWy0PXmzN5s3VXqV3WZ0=;
        b=BRIUCrCZmRw8Dcu/3gjpJzPrH6xfHDJoG2MFaoDBLR+5OhlUj0sSiZLbUN+sLdTWnC
         NKFF46ekAoL/Jv7xneMM4DwX5TQlYIjXRy9vcn7EVa9YR7rVeM7UksBSa1QFsH+hb9vI
         qqGfUUg6ueWDUIUaWDeqMbZUuq0E0NKgBAmplgoJWTOh0tnnqAgNeJb7LpjzSHsRRYKv
         /b+G6C7lNsDtPzEl082NFfb04hnUKAPqVG4WYi4V8Y61CKuvisOd7xm7t8mdRTEL9tZX
         deOTmaPaZK7ejpuwQN3iVycZTVaG9Nb2BwHeG4KlJD1RqxrE00sOMQfADSQPmUTAtb/B
         MiZw==
X-Forwarded-Encrypted: i=1; AJvYcCUN6Ew344IjuNBU38xt1MZcK7/D8a1vZu8MDnb0KCOA2fESBi7+XH5ALRGnnyJNh6J7Qv+wnYjDkdUcNv/S@vger.kernel.org, AJvYcCUZbpiKCoFdSeQ0DoqOMzMsWaNJxDupHAJyhytHTVO0YicB/MpmbO4rCBAlPcJjFClfQ2tVIy3u2wE0@vger.kernel.org, AJvYcCVju2U0Ay6Tqp3WXF634BtSU0/5cYDGb6A9hiZirgTI8i460AxBpT+kTGQJxAOGPf1Lw17HV2mp65uB@vger.kernel.org
X-Gm-Message-State: AOJu0YwptFw2H1J126vD32mVctEa3Ktbk6A80dFRzzE2+4wXYxe4WW8m
	1EiaZzrPdgugYzaEpOJE1VKc7sm1cZS/wuU+X+ZY2C+mF/CVjiHR
X-Gm-Gg: ASbGncsPcq38ljm5fdfiz3BqP9t6KRJzvmo7O7gz3MrBoZbItHWRaSfsETejn/GrpNh
	eqxs2GAynLmoB78qbOjHPRUxOQwdGB/cb9nDa3DAlMXKt3fXJKq77rvUYuC8BUO+1+EUEbOeBu5
	W9FGqZrZfNY9M2VUZFBkIMiuZwGuYAhK9pgFLXo66bP9bn/mpBmE950tMOLrpzC3ruB84HJxeUV
	h5kLUvjWfqCqU69/aQrGN+q/ReAdaKCAwQTPZu7y6vFtdyLXCxoDYAAxmPQNLi7KTKs5Z3jFkcn
	xaoG9n1oapOQQbZxoscA4yfaTAtbIQrGOMeFbWOwoEqrtfHWP/hPhaNP/LrpnpAHfZWHREAnEpd
	VhM4=
X-Google-Smtp-Source: AGHT+IGIsSe6CocLiCdTHiQm6Ag7dRdDMzQRCJMxpJd0bJlXQYYHDjiQpKwsMWDKpj/taTSEaiJ+Wg==
X-Received: by 2002:a17:902:da91:b0:21f:8453:7484 with SMTP id d9443c01a7336-223f1c98290mr77284165ad.30.1741213532724;
        Wed, 05 Mar 2025 14:25:32 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22380bca104sm82923215ad.79.2025.03.05.14.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:25:32 -0800 (PST)
Date: Thu, 6 Mar 2025 07:25:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	matthew.gerlach@altera.com, peter.colberg@altera.com
Subject: Re: [PATCH v8 0/2] Add PCIe Root Port support for Agilex family of
 chips
Message-ID: <20250305222529.GM847772@rocinante>
References: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>

Hello,

> This patch set adds PCIe Root Port support for the Agilex family of FPGA chips.

Applied to controller/altera, thank you!

	Krzysztof

