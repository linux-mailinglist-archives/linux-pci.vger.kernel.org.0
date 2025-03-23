Return-Path: <linux-pci+bounces-24456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DFA6CF0A
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260F81898B11
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D37204864;
	Sun, 23 Mar 2025 11:56:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3C1FFC4C;
	Sun, 23 Mar 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742730966; cv=none; b=W1M6meOqneKU3+9EoJ3Xdn90E3H9+8Nd/oEefTCc8ibbAXKKOBxootY+39oU6uSoOPEyUH07XtugvB5ZTULGpr+4wcikePfhN8F5LRlS2Raj0qS7W43WCAc01XvD9TQYALkRY0zEQVICvkN2j4SKNYS411dSFW7ZxHSjwcBbM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742730966; c=relaxed/simple;
	bh=zaHJZ790y6z9d8LloSV8uGUpKzfsaeNLXw+plMJIaRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdtot6MJkrzoa2RU9chMKR13xSJpPsE8YQuP6CuBRk9A/urvz/a5q8zZZ/QOLocm4Qyk2e7iJuLQsZLH6e3PsI0K48U+hfgTo8wFIMdcF5B9KpMXyibH7qtEB3mVTmS4czsSQ56abgqJYxp2OiOxWbBsOlAN/lh0xq6qd3ZBvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227914acd20so24536355ad.1;
        Sun, 23 Mar 2025 04:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742730965; x=1743335765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iP6s7RJZTq9P1esZphsb8AleCV4Kmq3vN6x3kTIwGs=;
        b=Ebj7uySwrkztCeX8S8RWdKG7ekghDOdf8HTdaGcj76o/ASDV2u/cdgY1LDXIBQPqQd
         4iKtAS3CIXE3qMppk6JvX57UAR5nTr8gLosuD9jIuBd0seLUCDWM+dLehxVtICXVaWCa
         TtmzBaTbOftGrb5/8iI//lxX6ZiThygsEfCi1FXybEdaGKge08g2rNngT3rdICfUGO8U
         vj60J2AB9rZmm4/amai0AoG0GvnzUG5N5wOlmoBQsWLZMhcXyxcrISspM375zFbD6IM9
         lEGdLwZS+v32PVCEGZ41Itp6cggaxOhDm8g8jMrkzGTWIN/eDoeryqI+3FzyAePMG2KD
         Jp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUidUAr95DajjMtOgfG1tvTJoEJAeZ7GNhU5XfUoOcRYEKXWs7IZDVBxBi3UlbCXGv2gHp2kUSN36ky@vger.kernel.org, AJvYcCVDoxV9OfmVJr0Gs1bWhoakRxyrh0qGn4soq1TpuvIeuej5yIBHdhshZnVJrGMYPHtI5eogwMgbVBT7@vger.kernel.org, AJvYcCVWQHaBWYnmaAKO/dMdVv5RD9SxWWSVLsWYvRxftX3MYtn3X/Z89VJ4FvNMFlJ/1NBBf4XZDa6ol7aVgw==@vger.kernel.org, AJvYcCWigPA6jPMTeFDzsJwk7UGEYVr7WLPk9rk3UFAsOLaMi0JrO64qDO/IGfUFhdUoL81v1rXyGRVPtS9T@vger.kernel.org, AJvYcCXia582Jo8P+BwRStxwsR763/oLFHI+lIqTZLlNgq/G5tpdIndWWb2hqbd/pvlX7EbftaketQOWgYmfK50Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+qXreRW8/4udzEs3Nu6xbOEfNX3JsFZUzrXAvlUQ75KIWBzo
	jiXL0ArW9kFAU6gojQb+CiPRiGUwpWmymmQvKoXQ9CWOjBDGL/Mc
X-Gm-Gg: ASbGncscy4+9v571QLoSLwO+jSW5B5oNvN4ThCj9u5jaQJqrDvKHZ0ZBDKUAvi7qS1s
	qMJ542ezEQihAF6C12nuuGfli/wAzLE3b92iMPrkRavZ4IutBPZMkakUZvBE5LagRGSgZCzPYEm
	3VYHfU0lbwucP1F3TYr4zF4rlNCz+WzHA1tvehZszx2febB4KFhlJghduYxNgRjPn9oqJHlmVx2
	eUw0u+m3vT+SRWZJ/Pc53QTl7tDzeytXK4lZVPHQ2zSylVZ+i1qVRHXFJ5AILJqsv/G9/fgqecv
	aq6mEaXIaxAwIdGFrtq0QS6I6dq4Qhof17wwr7zPL1uyci0qoFwuBzWUCLBQS8jQPG59sTcOhyr
	pVoA=
X-Google-Smtp-Source: AGHT+IGFrPrOjm1ltZW+6Dht1zMb++j1BuTfrfYxmMgOcEiQGmIANrOACm+sR9E2VHw4F5IauWW82A==
X-Received: by 2002:a05:6a20:7288:b0:1f0:e2a9:fb2a with SMTP id adf61e73a8af0-1fd085563b1mr18959356637.4.1742730964522;
        Sun, 23 Mar 2025 04:56:04 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a4f585sm5062513a12.73.2025.03.23.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:56:03 -0700 (PDT)
Date: Sun, 23 Mar 2025 20:56:02 +0900
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <20250323115602.GE1902347@rocinante>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
 <20250314083730.GC234496@rocinante>
 <Z9lA31gBjpIRHm6y@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lA31gBjpIRHm6y@apocalypse>

Hello,

[...]
> > Or, something like this over this the function name.  Perhaps exposing
> > error code could be useful to the end user? If so then something like this:
> > 
> >   return dev_err_probe(&pdev->dev, err,
> > 		       "Failed to allocate MSI-X vectors, err=%d\n", err);
> 
> dev_err_probe() should already print the err code, no need to add it.

Ahh...

I did a copy-paste of the code from above purely for illustration, sorry
for the confusion here!

> > Here and other errors where appropriate.
> 
> I've changed dev_err() to dev_err_probe() in cases where the error code
> is not evident (i.e. hardcoded) from the source.

Makes sense.

> Thank you so much for your review!

Pleasure!  Thank you for all the work here!

	Krzysztof

