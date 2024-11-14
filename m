Return-Path: <linux-pci+bounces-16793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E59C90BF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D62A1F23AA8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103918595B;
	Thu, 14 Nov 2024 17:24:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B36F2F3;
	Thu, 14 Nov 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605066; cv=none; b=JFmrYecGKkBCqTinhfVY0LyYTOahX3LE+nrXFlTMOl0iAkJQIzHsUgWs6c4Ry1ej3t5kIKJWEZq/ls5Jn/rDoSMcKsPyxkaD92FV9z5bBogSUHk9lsaa2nsuvLbzZr4ZPppHZKwtBJqcavs1J6pl5frnfMa17jAGf7mQRtV7tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605066; c=relaxed/simple;
	bh=WbvPJ/1CZUfK3NNJ4mz4wNl1sWlz0r7+ODQKpS/WNUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOjIh0CqxHu19T5IE8Fb4tGucr3ov82k3TDykMnNM+IH072MdtLYG2tFdegyRJvs8npM4XDgV41/KiOVpGzGf+ExCzAzkoXB8IeXxWzQTEinqiEqj+ig2APzHnbQnCnfFjZ60cnvxluJiMyJJkM8XyIaU51orKgWlrycHnOsOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e576dbc42so10413115ad.0;
        Thu, 14 Nov 2024 09:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605064; x=1732209864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KfOJtzfwH/T6BnCgNIk5RTMp+CeuzSWNDpYp8Af7B0=;
        b=HsHSAeqdAds16DMwNKeQJS0bWMsmOuEAeXlf2MShTAWXRTvw1iA0iI7iwNLhC66wmH
         WlQ1XA6vkJDV45+0dQ7WRXnBjoDaBt0t/BrYQ6UiuC71pgVGyHinpkhII5k9VK8HKEb5
         IACtAdPW2qAwuSlhfoqomuflYdhcbQTKGO9iQNXO1pdYsfY2vmmGA/Eb/UU1ck1hKBZy
         XWLWlb1octl5L+iyneXxMxVQnbaNxdklt6aiLZaWBXP1zJemuFkripP604Q36uMDN8W8
         kz+VGxwHCBPoJ2/Ds3cTMZueNMSa9QbNpBpX/pD4QwV6DSgNQlY07jKJpl2VcpTmybTn
         FDwg==
X-Forwarded-Encrypted: i=1; AJvYcCV5pFgfpmWWsWD+Kua5WcRJEr4nReROddmdSZXqY2GNUi2ne/ylRBJfZ4My1tZP9A85ctUClDZhgAuP@vger.kernel.org, AJvYcCWkkLmkWTNrQNLKOspI6Un6omLLd8CovW5+RdZ8ipi6vsmGexxdJekHrNW7jC1H0FuqI3VmznlvvrOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBCuhh4WRAzP9lTEZt6yI0zDi+0rfp5DZ5PGHGn0pZPPqwA7l
	QAOTugZ/dPohe90vU7rG6phfOsRdTTpIbU2TEIGyRPBaaRm8RC0/
X-Google-Smtp-Source: AGHT+IHZa97Hmrsw68sqOZYGtSf6kmlJNEEpgylzpOkqT7/MU1vF03ZIjf4UlEa0R6ZwFWAsadnmHw==
X-Received: by 2002:a17:902:c942:b0:20b:5231:cd61 with SMTP id d9443c01a7336-211b662f252mr88839895ad.24.1731605062296;
        Thu, 14 Nov 2024 09:24:22 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024bd2c7sm1585144a91.34.2024.11.14.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:24:21 -0800 (PST)
Date: Fri, 15 Nov 2024 02:24:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Message-ID: <20241114172419.GB1489806@rocinante>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
 <ed723fe1-e243-4a9e-8d1c-f29461d07cb7@kernel.org>
 <20241113175222.eh76hksyj6sptwvo@thinkpad>
 <20241113205900.GA1184086@rocinante>
 <11cae8ab-a46b-47b4-b919-f7021057dc11@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11cae8ab-a46b-47b4-b919-f7021057dc11@kernel.org>

Hello,

> >> Sorry for the late reply. Things got a bit hectic due to company onsite meeting.
> >> I'm going through my queue now.
> > 
> > Thank you, Mani!  I took this over and pulled this series.
> > 
> > You and Bjorn can have a look over the changes, if you have a moment.  That
> > said, at least to me, the changes looked good.
> 
> Thanks. But the kernel test robot already complained about a build failure for
> the rockchip branch.

We did see this in our local testing environment, too.  Albeit, I didn't
get around to moving the commits before bot picked the branch up.

> The series needs to go through the endpoint branch as the .align_addr
> method is only defined in that branch at the moment.

The changes are now together.  Thank you!

	Krzysztof

