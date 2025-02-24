Return-Path: <linux-pci+bounces-22250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCEA42B99
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D4D7A1BF7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BBA26618C;
	Mon, 24 Feb 2025 18:36:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099B1C5F27;
	Mon, 24 Feb 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422185; cv=none; b=oXVfi5VrpO06NP4Guq3fc22xZZ242+yXkkAWzKg0vbukLxe+f67xOPJC4cGHV09cMf+3K5BpfHR8w9F3HgaHmY7sH+t7BP5gEseLjhEjBdj57FsV1SRjNlvLpuOP1jgMNcwz+87jvIBZP3KEFn4n852Kb7y4MCt6nzS+dQn5v4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422185; c=relaxed/simple;
	bh=gwd0kHHM6yEt5vGNuet2cFmwY7fgQBCNxAjsE9uoDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1VocN7UZF++z4yc22VPNLouSncjHE0SXXB0TnVB/hjJ+rvFWW6NNvPGxs0toSF3pTJB7OxzLothfaxhBqc+CFHy7lhGoPHrZDaSDBjAZj9BuqRzFa1Hiqwz6TR3df8mdSXE+ID1rr567qX8QjgEKItyQPu2W7BlDJL51ZFdO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220ecbdb4c2so16674285ad.3;
        Mon, 24 Feb 2025 10:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422183; x=1741026983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+iuRvEJQMhX8pBK/9EUfHF9HLzVHhSe33fGhQO8PJQ=;
        b=bE4zPcWmJKboizyPkonldfAlJtWQotrjBapq9SzkCWRhH1UXmoW4t4JUakvSwWERaD
         a8fqYFEUaW17INJdL/DhYHwRq63R4Tn5guv4vz85DQrD+Rbm4PABVpR1UWMXNW8iqsC7
         v/+6cqkDnEOSierDGd2h4p26nzuTiBL5vit20PTNYoc5bmzKw8E9bn8usvvtpRFAFsPr
         +mokK3TkELVgYG3xPqVN7HTuKOOCtShoA6mUAqlGEzx1RLfLgc72zdOyDtfUjBGI5DmF
         ui2+AH1o2dLqRmVJPczNROshvGPPZoyqHmpLwjlQuhHKHPXXTz18ymYl6qShBihwwZ1O
         z7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzEwC02Yo9uCQWr9dklBTIYKuC5gebWpKiP4lClNQ4mi/2mxlIZ5lmXgzytH2pLrkj9nyUVq2yL0h@vger.kernel.org, AJvYcCXQ8FSPBvBBLSXe2DUzTo97dHWN1/Y4aPWUTZTVHCjlJ162RYU4uacDo50umBQp8o8k8HGtRdTSxRjfhWq0wg==@vger.kernel.org, AJvYcCXYa7qHfQwxIYmMKnFN4mlEVOHddHDpJ4rQjfAk0LGGQcpFXjfyzM0na2dHu5FsreHkjjCzdAQWyOAURwcw@vger.kernel.org, AJvYcCXtZhSFwM5ONMqV81xXa7ZYAQdLYA15yUQMOwBDlSnr8WeuLGL4iozDmncz6a7m2c3N9Lg2ONnbEQuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0v7jj9wVu4VI2jfOY23bHQGOsbFEb08t1/HJIWG9mrFL2goq
	GNEP3AV/EjNLd4cKdkDjKYu7fGrRms7eR5/8ONZdOG1P004GEROK
X-Gm-Gg: ASbGncuoINBuyGA0in9irvLUESmVS/bN/vkYzO8VAZYkM4qXRdWwExjFbE5r0QTrMAr
	QS9eCjON2b1AgR9Bl8QhbjNylFYuVdTqlpWuNwvPfOBqAAFdBtHuz3UJ7oDSKEXOYH5snJ/du4P
	uy0VfCho9f1wEhsMAkcByIIyCIOhnH+pq6wAtEyCxviAxWAJkdH8IlRybFlYKRcv2HvvTgT04bW
	qwVm/a81su5LaOr/8v4B34jeQ1PLsUqoEic9G27a26gJcfk8Cf2IXvfknmSxwK5RHeBv/nZkO2b
	muYtp4IvjCtK7KhPfqJI1vfziTYf8cbPeCcRBK/aTBYZTnG7xDJQGB4/6nEC
X-Google-Smtp-Source: AGHT+IEplwsgnmJ40zGdd/jX9QmYaLpnH8VA9Jb9MgTmdt+M/WwD/lXDTq1aQNf0I+xwkJjllFIPBg==
X-Received: by 2002:a17:902:d485:b0:221:87a2:ff9c with SMTP id d9443c01a7336-221a11ab572mr213110675ad.52.1740422182715;
        Mon, 24 Feb 2025 10:36:22 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349226sm184951505ad.24.2025.02.24.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:36:22 -0800 (PST)
Date: Tue, 25 Feb 2025 03:36:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI: qcom-ep: add support for using the EP on
 SAR2130P and SM8450
Message-ID: <20250224183620.GA2064156@rocinante>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250222143657.GA3735810@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222143657.GA3735810@rocinante>

> > Update the incomplete SM8450 support and bring in SAR2130P support for
> > the PCIe1 controller to be used in EP mode.
> 
> Applied to controller/qcom, thank you!

I updated the branch with "Reviewed-by" tags from Mani.

	Krzysztof

